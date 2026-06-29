import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:virtual_mentor_app/core/bloc/session_bloc/session_bloc.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import '../storage/secure_storage_helper.dart';
import 'api_constants.dart';

class DioClient {
  final Dio dio;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      ) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'JWT $token';
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

          // FIX: Clone original option configurations cleanly without manual looping
          final options = Options(
            method: opts.method,
            headers:
                opts.headers
                  ..['Authorization'] =
                      'JWT $newToken', // FIX: Unified to "JWT"
            responseType: opts.responseType,
            contentType: opts.contentType,
            validateStatus: opts.validateStatus,
            receiveTimeout: opts.receiveTimeout,
            sendTimeout: opts.sendTimeout,
          );

          try {
            // FIX: Use dio.request directly instead of dio.fetch to cleanly retry requests
            final response = await dio.request(
              opts.path,
              data: opts.data,
              queryParameters: opts.queryParameters,
              options: options,
            );
            return handler.resolve(response);
          } catch (e) {
            if (e is DioException) {
              return handler.reject(e);
            }
            return handler.reject(DioException(requestOptions: opts, error: e));
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
          // ALWAYS active in debug mode; safe to leave as-is
          // if (kDebugMode)
          print(object);
        },
      ),
    ]);
  }

  bool _isUnauthorized(DioException error) => error.response?.statusCode == 401;

  Future<bool> _refreshToken() async {
    final refreshToken = await SecureStorageHelper.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // FIX: Added the mandatory ngrok and json headers to prevent an interstitial 400 landing screen
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      final response = await refreshDio.post(
        '/auth/jwt/refresh/',
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
        sl<SessionBloc>().add(SessionExpired());
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
