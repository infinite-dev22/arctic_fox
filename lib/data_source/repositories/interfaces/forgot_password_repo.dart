

abstract class ForgotPasswordRepo {
  Future<dynamic> forgotPasswordSendLink(String email, String token);
}
