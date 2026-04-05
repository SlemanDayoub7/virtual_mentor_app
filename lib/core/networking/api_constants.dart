class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.virtualmentor.com';
  static const String apiVersion = '/api/v1';
  static const String apiBaseUrl = '$baseUrl$apiVersion';

  // Timeouts
  static const int connectTimeout = 30; // seconds
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;
}

class ApiErrors {
  ApiErrors._();

  static const String noContent = 'No content';
  static const String badRequestError = 'Bad request error';
  static const String unauthorizedError = 'Unauthorized error';
  static const String forbiddenError = 'Forbidden error';
  static const String internalServerError = 'Internal server error';
  static const String notFoundError = 'Not found error';
  static const String timeoutError = 'Timeout error';
  static const String defaultError = 'Something went wrong';
  static const String cacheError = 'Cache error';
  static const String noInternetError = 'No internet connection';
}
