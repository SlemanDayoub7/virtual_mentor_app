import 'api_error_handler.dart';

class ApiResult<T> {
  final T? data;
  final ErrorHandler? error;

  const ApiResult._({this.data, this.error});

  factory ApiResult.success(T data) => ApiResult._(data: data);
  factory ApiResult.failure(ErrorHandler error) => ApiResult._(error: error);

  bool get isSuccess => data != null && error == null;
  bool get isFailure => error != null;

  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorHandler error) failure,
  }) {
    if (isSuccess) return success(data as T);
    return failure(error!);
  }
}
