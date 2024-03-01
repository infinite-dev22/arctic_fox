part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUserEvent extends LoginEvent {
  final String email;
  final String password;

  AuthUserEvent(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [email, password];
}
