import 'package:smart_rent/data_source/models/login_response/login_response.dart';

abstract class LoginRepo {
  Future<dynamic> post(String email, String password);
}
