import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'api_error_model.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorised = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const int apiLogicError = 422;

  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return const ApiErrorModel(
            code: ResponseCode.noContent, message: ApiErrors.noContent);
      case DataSource.badRequest:
        return const ApiErrorModel(
            code: ResponseCode.badRequest, message: ApiErrors.badRequestError);
      case DataSource.forbidden:
        return const ApiErrorModel(
            code: ResponseCode.forbidden, message: ApiErrors.forbiddenError);
      case DataSource.unauthorised:
        return const ApiErrorModel(
            code: ResponseCode.unauthorised,
            message: ApiErrors.unauthorizedError);
      case DataSource.notFound:
        return const ApiErrorModel(
            code: ResponseCode.notFound, message: ApiErrors.notFoundError);
      case DataSource.internalServerError:
        return const ApiErrorModel(
            code: ResponseCode.internalServerError,
            message: ApiErrors.internalServerError);
      case DataSource.connectTimeout:
        return const ApiErrorModel(
            code: ResponseCode.connectTimeout, message: ApiErrors.timeoutError);
      case DataSource.cancel:
        return const ApiErrorModel(
            code: ResponseCode.cancel, message: ApiErrors.defaultError);
      case DataSource.receiveTimeout:
        return const ApiErrorModel(
            code: ResponseCode.receiveTimeout, message: ApiErrors.timeoutError);
      case DataSource.sendTimeout:
        return const ApiErrorModel(
            code: ResponseCode.sendTimeout, message: ApiErrors.timeoutError);
      case DataSource.cacheError:
        return const ApiErrorModel(
            code: ResponseCode.cacheError, message: ApiErrors.cacheError);
      case DataSource.noInternetConnection:
        return const ApiErrorModel(
            code: ResponseCode.noInternetConnection,
            message: ApiErrors.noInternetError);
      case DataSource.defaultError:
        return const ApiErrorModel(
            code: ResponseCode.defaultError, message: ApiErrors.defaultError);
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }
}

ApiErrorModel _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      if (error.response != null) {
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          return _parseBackendError(data);
        }

        if (data is String) {
          final lowerData = data.toLowerCase();
          final looksLikeHtml =
              lowerData.contains('<html') || lowerData.contains('<!doctype html');

          if (looksLikeHtml) {
            return ApiErrorModel(
              code: error.response?.statusCode ?? ResponseCode.internalServerError,
              message: ApiErrors.internalServerError,
            );
          }

          return ApiErrorModel(
            code: error.response?.statusCode ?? ResponseCode.defaultError,
            message: data.isNotEmpty ? data : ApiErrors.defaultError,
          );
        }

        return ApiErrorModel(
          code: error.response?.statusCode ?? ResponseCode.defaultError,
          message: ApiErrors.defaultError,
        );
      }
      return DataSource.defaultError.getFailure();
  }
}

ApiErrorModel _parseBackendError(Map<String, dynamic> data) {
  Map<String, List<String>>? fieldErrors;

  if (data['errors'] != null && data['errors'] is Map<String, dynamic>) {
    fieldErrors = {};
    final errorsMap = data['errors'] as Map<String, dynamic>;
    errorsMap.forEach((key, value) {
      if (value is List) {
        final messages = value
            .whereType<Map>()
            .map((e) => e['message']?.toString() ?? '')
            .toList();
        if (messages.isNotEmpty) fieldErrors![key] = messages;
      }
    });
  }

  String generalMessage;
  if (fieldErrors != null && fieldErrors.isNotEmpty) {
    generalMessage = fieldErrors.values.expand((list) => list).join('\n');
  } else {
    generalMessage = data['message']?.toString() ?? ApiErrors.defaultError;
  }

  return ApiErrorModel(
    code: data['code'],
    message: generalMessage,
    fieldErrors: fieldErrors,
  );
}
