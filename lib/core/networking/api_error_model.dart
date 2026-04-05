class ApiErrorModel {
  final dynamic code;
  final String message;
  final Map<String, List<String>>? fieldErrors;

  const ApiErrorModel({
    required this.code,
    required this.message,
    this.fieldErrors,
  });
}
