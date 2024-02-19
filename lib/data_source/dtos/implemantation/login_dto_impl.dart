import 'package:smart_rent/data_source/models/login_response/login_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/login_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';

class LoginDtoImpl {
  static Future<LoginResponseModel> post(
    String email,
    String password, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    LoginRepo loginRepo = LoginRepoImpl();
    var result = await loginRepo
        .post(email, password)
        .then((loginResponse) => LoginResponseModel.fromJson(loginResponse));

    return result;
  }
}
