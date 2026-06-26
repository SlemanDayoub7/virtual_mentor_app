import 'package:dio/dio.dart';
import 'api_error_handler.dart';
import 'api_result.dart';

Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return ApiResult.success(response);
  } on DioException catch (error) {
    print(error);
    return ApiResult.failure(ErrorHandler.handle(error));
  } catch (error) {
    print(error);
    return ApiResult.failure(ErrorHandler.handle(error));
  }
}
