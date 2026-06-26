import 'package:virtual_mentor_app/core/domain/entities/api_response.dart';

class ApiResponseModel extends ApiResponse {
  const ApiResponseModel({required super.detail});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(detail: json['detail'] as String);
  }
}
