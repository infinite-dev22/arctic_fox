import 'package:smart_rent/data_source/models/login_response/login_response.dart';

abstract class UserDetailsRepo {
  Future<dynamic> getUserDetails(int id);
}
