import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/user_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_repo.dart';

class UserDtoImpl {
  static Future<UserResponse> getAll({
    Function()? onSuccess,
    Function()? onError,
  }) async {
    UserRepo userRepo = UserRepoImpl();
    var userResult = await userRepo.getALl().then((userResponse) {
      return UserResponse.fromJson(userResponse);
    });
    return userResult;
  }
}
