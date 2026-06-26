import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object?> get props => [];
}

class OtpVerifySubmitted extends OtpEvent {
  final String email;
  final String code;
  const OtpVerifySubmitted({required this.email, required this.code});
  @override
  List<Object?> get props => [email, code];
}

class OtpResendRequested extends OtpEvent {
  final String email;
  const OtpResendRequested(this.email);
  @override
  List<Object?> get props => [email];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class OtpState extends Equatable {
  const OtpState();
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpVerified extends OtpState {}

class OtpResent extends OtpState {
  final String message;
  const OtpResent(this.message);
  @override
  List<Object?> get props => [message];
}

class OtpFailure extends OtpState {
  final String message;
  const OtpFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyOtpUseCase _verifyOtp;
  final ResendOtpUseCase _resendOtp;

  OtpBloc(this._verifyOtp, this._resendOtp) : super(OtpInitial()) {
    on<OtpVerifySubmitted>(_onVerify);
    on<OtpResendRequested>(_onResend);
  }

  Future<void> _onVerify(
    OtpVerifySubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());
    final result = await _verifyOtp(email: event.email, code: event.code);
    result.when(
      success: (_) => emit(OtpVerified()),
      failure: (error) => emit(OtpFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onResend(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());
    final result = await _resendOtp(email: event.email);
    result.when(
      success: (msg) => emit(OtpResent(msg)),
      failure: (error) => emit(OtpFailure(error.apiErrorModel.message)),
    );
  }
}
