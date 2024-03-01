abstract class TenantUnitRepo {
  Future<dynamic> getALlTenantUnits(String token, int id);

  Future<dynamic> addTenantUnit(String token, int tenantId, int unitId, int periodId, DateTime fromDate,
       DateTime toDate, int unitAmount, int currencyId, int agreedAmount, String description, int propertyId);

}
