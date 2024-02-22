import 'package:smart_rent/data_source/models/login_response/login_response.dart';

abstract class PropertyRepo {
  Future<dynamic> getALlProperties(String token);
  Future<dynamic> getSingleProperty(int id, String token);
  Future<dynamic> addProperty(String token, String name, String location, String sqm,
      String description, int propertyTypeId, int propertyCategoryId );
}
