import 'package:smart_rent/data_source/models/login_response/login_response.dart';
import 'package:smart_rent/data_source/models/user_details_response/user_details_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/login_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/implemantation/user_details_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_details_repo.dart';

class UserDetailsDtoImpl {
  static Future<UserDetailsModel> getUserDetails(
      int id,
    {
        Function()? onSuccess,
        Function()? onError,
      }) async {
    UserDetailsRepo userDetailsRepo = UserDetailsRepoImpl();
    var result = await userDetailsRepo
        .getUserDetails(id)
        .then((userDetailsResponse) => UserDetailsModel.fromJson(userDetailsResponse));
    return result;
  }
}
