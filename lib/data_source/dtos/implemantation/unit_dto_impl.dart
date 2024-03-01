import 'package:smart_rent/data_source/models/floor/add_floor_response_model.dart';
import 'package:smart_rent/data_source/models/unit/add_unit_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/floor_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/implemantation/unit_repo_impl.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/unit_repo.dart';

class UnitDtoImpl {
  static Future<AddUnitResponse> addUnitToProperty(
      String token, int unitTypeId, int floorId, String name, String sqm,
      int periodId, int currencyId, int initialAmount, String description, int propertyId, {
        Function()? onSuccess,
        Function()? onError,
      }) async {
    UnitRepo unitRepo = UnitRepoImpl();
    var result = await unitRepo
        .addUnitToProperty(token, unitTypeId, floorId, name, sqm, periodId, currencyId, initialAmount,
      description, propertyId
    ).then((response) => AddUnitResponse.fromJson(response));

    return result;
  }
}
