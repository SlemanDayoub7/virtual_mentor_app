import 'dart:async';
import 'package:dio/dio.dart';
import '../storage/secure_storage_helper.dart';
import 'api_constants.dart';

class DioClient {
  final Dio dio;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.apiBaseUrl,
            connectTimeout: const Duration(seconds: ApiConstants.connectTimeout),
            receiveTimeout: const Duration(seconds: ApiConstants.receiveTimeout),
            sendTimeout: const Duration(seconds: ApiConstants.sendTimeout),
          ),
        ) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final opts = error.requestOptions;

          if (opts.path.contains('tokens-refresh')) {
            return handler.next(error);
          }

          if (!_isUnauthorized(error)) {
            return handler.next(error);
          }

          if (_isRefreshing) {
            await _refreshCompleter?.future;
          } else {
            _isRefreshing = true;
            _refreshCompleter = Completer<void>();

            final success = await _refreshToken();

            _isRefreshing = false;
            _refreshCompleter?.complete();
            _refreshCompleter = null;

            if (!success) {
              return handler.reject(error);
            }
          }

          final newToken = await SecureStorageHelper.getAccessToken();
          if (newToken == null) return handler.reject(error);

          RequestOptions newOpts;

          if (opts.data is FormData) {
            final formData = FormData();
            final oldData = opts.data as FormData;
            for (final entry in oldData.fields) {
              formData.fields.add(MapEntry(entry.key, entry.value));
            }
            for (final file in oldData.files) {
              formData.files.add(MapEntry(file.key, file.value));
            }
            newOpts = opts.copyWith(data: formData);
          } else {
            newOpts = opts;
          }

          try {
            final response = await dio.fetch(
              newOpts..headers['Authorization'] = 'Bearer $newToken',
            );
            return handler.resolve(response);
          } catch (e) {
            return handler.reject(e as DioException);
          }
        },
      ),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (object) {
          // Remove comment below to enable logging in debug mode
          // if (kDebugMode) print(object);
        },
      ),
    ]);
  }

  bool _isUnauthorized(DioException error) => error.response?.statusCode == 401;

  Future<bool> _refreshToken() async {
    final refreshToken = await SecureStorageHelper.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.apiBaseUrl,
          validateStatus: (status) => true,
        ),
      );

      final response = await refreshDio.post(
        '/auth/tokens-refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        await SecureStorageHelper.saveTokens(
          accessToken: response.data['access'],
          refreshToken: response.data['refresh'],
        );
        return true;
      } else if (response.statusCode == 403 ||
          response.statusCode == 401 ||
          response.statusCode == 404) {
        await SecureStorageHelper.clearTokens();
        // TODO: Trigger SessionBloc expired event here via GetIt
        // sl<SessionBloc>().add(SessionExpired());
        return false;
      }

      return false;
    } on DioException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
