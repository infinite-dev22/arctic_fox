import 'package:smart_rent/data_source/models/logout/logout_response_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/logout_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/logout_repo.dart';

class LogoutDtoImpl {
  static Future<LogOutResponseModel> logout(
    String token, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    LogOutRepo logOutRepo = LogoutRepoImpl();
    var result = await logOutRepo
        .logout(token)
        .then((logoutResponse) => LogOutResponseModel.fromJson(logoutResponse));

    return result;
  }
}
