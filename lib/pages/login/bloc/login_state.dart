part of 'login_bloc.dart';

enum LoginStatus { initial, success, loading, accessDenied, error }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;

  bool get isSuccess => this == LoginStatus.success;

  bool get isLoading => this == LoginStatus.loading;

  bool get isError => this == LoginStatus.error;
}

class LoginState extends Equatable {
  final String? email;
  final String? password;
  final bool? isLoading;
  final LoginStatus status;
  final String? message;

  const LoginState({
    this.email = "",
    this.password = "",
    this.isLoading = false,
    this.status = LoginStatus.initial,
    this.message = "",
  });

  @override
  List<Object?> get props => [email, password, isLoading, status, message];

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {}

class LoginLoading extends LoginState {}
