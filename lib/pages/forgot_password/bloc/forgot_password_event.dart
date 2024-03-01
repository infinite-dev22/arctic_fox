part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class SendForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;
  final String token;

  const SendForgotPasswordEvent(this.email, this.token);

  @override
  // TODO: implement props
  List<Object?> get props => [email, token];
}
