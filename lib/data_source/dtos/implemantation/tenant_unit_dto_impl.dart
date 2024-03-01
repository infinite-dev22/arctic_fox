import 'package:smart_rent/data_source/models/tenant_unit/add_tenant_unit_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/tenant_unit_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/tenant_unit_repo.dart';

class TenantUnitDtoImpl {
  static Future<AddTenantUnitResponse> addTenantUnit(
      String token, int tenantId, int unitId, int periodId, DateTime fromDate,
      DateTime toDate, int unitAmount, int currencyId, int agreedAmount, String description, int propertyId, {
        Function()? onSuccess,
        Function()? onError,
      }) async {
    TenantUnitRepo tenantUnitRepo = TenantUnitRepoImpl();
    var result = await tenantUnitRepo
        .addTenantUnit(  token,  tenantId,  unitId,  periodId,  fromDate,
         toDate,  unitAmount,  currencyId,  agreedAmount,  description,  propertyId
    ).then((response) => AddTenantUnitResponse.fromJson(response));

    return result;
  }
}
