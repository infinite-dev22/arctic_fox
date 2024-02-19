import 'package:smart_rent/data_source/models/employee/employee_list_response_model.dart';
import 'package:smart_rent/data_source/models/login_response/login_response.dart';
import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/employee_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/implemantation/login_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/implemantation/user_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/employee_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_repo.dart';

class EmployeeDtoImpl {
  static Future<EmployeeModel> getAllEmployees(
      String token,
      {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    EmployeeRepo employeeRepo = EmployeeRepoImpl();
    var employeeResult = await employeeRepo.getALlEmployees(token).then((employeeResponse) {
      return EmployeeModel.fromJson(employeeResponse);
    });
    return employeeResult;
  }
}
