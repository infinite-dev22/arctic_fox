import 'package:smart_rent/data_source/models/property/add_response_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/property_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/property_repo.dart';

class PropertyDtoImpl {
  static Future<AddPropertyResponseModel> addProperty(
    String token,
    String name,
    String location,
    String sqm,
    String description,
    int propertyTypeId,
    int propertyCategoryId, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    PropertyRepo propertyRepo = PropertyRepoImpl();
    var result = await propertyRepo
        .addProperty(token, name, location, sqm, description, propertyTypeId,
            propertyCategoryId)
        .then((loginResponse) =>
            AddPropertyResponseModel.fromJson(loginResponse));

    return result;
  }
}
