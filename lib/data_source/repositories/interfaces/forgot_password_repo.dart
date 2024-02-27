import 'package:smart_rent/data_source/models/login_response/login_response.dart';

abstract class ForgotPasswordRepo {
  Future<dynamic> forgotPasswordSendLink(String email, String token);
}
