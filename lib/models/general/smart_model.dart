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