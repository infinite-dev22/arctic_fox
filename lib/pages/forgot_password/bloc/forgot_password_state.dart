part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordResponseModel? forgotPasswordResponseModel;
  final ForgotPasswordStatus status;
  final bool? isLoading;
  final String? message;

  const ForgotPasswordState(
      {this.forgotPasswordResponseModel,
      this.status = ForgotPasswordStatus.initial,
      this.isLoading,
      this.message});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [forgotPasswordResponseModel, status, isLoading, message];

  ForgotPasswordState copyWith(
      {ForgotPasswordResponseModel? forgotPasswordResponseModel,
      ForgotPasswordStatus? status,
      bool? isLoading,
      String? message}) {
    return ForgotPasswordState(
        forgotPasswordResponseModel:
            forgotPasswordResponseModel ?? this.forgotPasswordResponseModel,
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message);
  }
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
