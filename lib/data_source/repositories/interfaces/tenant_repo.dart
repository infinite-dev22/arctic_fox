import 'package:smart_rent/data_source/models/login_response/login_response.dart';

abstract class TenantRepo {
  Future<dynamic> getALlTenants(String token);
  Future<dynamic> getSingleTenant(String token, int id);

}
