abstract class SmartModel {
  int getId();
  String getName();
}

abstract class SmartTenantTypeModel {
  int getId();
  String getName();
}

abstract class SmartUnitModel {
  int getId();
  String getUnitNumber();
}

abstract class SmartSalutationModel {
  int getId();
  String getName();
}


abstract class SmartFloorModel {
  int getId();
  String getName();
}


abstract class SmartCurrencyModel {
  int getId();
  String getCurrency();
}


abstract class SmartNationalityModel {
  int getId();
  // String getCurrency();
  String getCountry();
  // String getCode();
  // String getSymbol();
}

abstract class SmartPeriodModel {
  int getId();
  String getName();
  int getPeriod();

}

abstract class SmartTenantModel {

  int getId();
  String getName();
  int getTenantTypeId();
  int getNationId();
  String getTenantNo();
  int getBusinessTypeId();
  String getDescription();

}