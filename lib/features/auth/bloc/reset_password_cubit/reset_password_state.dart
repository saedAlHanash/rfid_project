part of 'reset_password_cubit.dart';

class ResetPasswordInitial extends AbstractState<bool> {
  @override
  final ResetPasswordRequest request;

  const ResetPasswordInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.request,
  });

  factory ResetPasswordInitial.initial() {
    return ResetPasswordInitial(result: false, request: ResetPasswordRequest());
  }

  @override
  List<Object> get props => [statuses, result, error];

  bool get canSend =>
      !request.code.isBlank &&
      !request.password.isBlank &&
      !request.passwordConfirmation.isBlank &&
      request.password == request.passwordConfirmation;

  ResetPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    ResetPasswordRequest? request,
  }) {
    return ResetPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
