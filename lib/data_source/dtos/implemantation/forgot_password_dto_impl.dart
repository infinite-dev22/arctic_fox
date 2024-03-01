import 'package:smart_rent/data_source/models/password/forgot_password_response_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/forgot_password_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/forgot_password_repo.dart';

class ForgotPasswordDtoImpl {
  static Future<ForgotPasswordResponseModel> sendForgotPasswordLink(
    String email,
    String token, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    ForgotPasswordRepo forgotPasswordRepo = ForgotPasswordRepoImpl();
    var result = await forgotPasswordRepo
        .forgotPasswordSendLink(email, token)
        .then((forgotResponse) =>
            ForgotPasswordResponseModel.fromJson(forgotResponse));

    return result;
  }
}
