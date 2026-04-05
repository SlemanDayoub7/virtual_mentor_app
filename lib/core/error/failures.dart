import 'package:equatable/equatable.dart';

// ─── Base Failure ─────────────────────────────────────────────────────────────
abstract class Failure extends Equatable {
  final String message;
  final int? code;
  final Map<String, List<String>>? fieldErrors;

  const Failure({
    required this.message,
    this.code,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, fieldErrors];
}

// ─── Failure Types ────────────────────────────────────────────────────────────
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.fieldErrors,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.fieldErrors,
    super.code,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
