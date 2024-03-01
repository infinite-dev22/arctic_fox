// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/floor/floor_model.dart';

// UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));
//
// String unitModelToJson(UnitModel data) => json.encode(data.toJson());
//
// class UnitModel extends SmartUnitModel {
//   int id;
//   dynamic createdAt;
//   String createdBy;
//   String sqMeters;
//   String unitNumber;
//   int currencyId;
//   dynamic amount;
//   String unitType;
//   String description;
//   int periodId;
//   int floorId;
//
//   UnitModel({
//     required this.id,
//     required this.createdAt,
//     required this.createdBy,
//     required this.sqMeters,
//     required this.unitNumber,
//     required this.currencyId,
//     required this.amount,
//     required this.unitType,
//     required this.description,
//     required this.periodId,
//     required this.floorId,
//   });
//
//   factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
//     id: json["id"],
//     createdAt: json["created_at"],
//     createdBy: json["created_by"],
//     sqMeters: json["sq_meters"],
//     unitNumber: json["unit_number"],
//     currencyId: json["currency_id"],
//     amount: json["amount"],
//     unitType: json["unit_type"],
//     description: json["description"],
//     periodId: json["period_id"],
//     floorId: json["floor_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "created_at": createdAt,
//     "created_by": createdBy,
//     "sq_meters": sqMeters,
//     "unit_number": unitNumber,
//     "currency_id": currencyId,
//     "amount": amount,
//     "unit_type": unitType,
//     "description": description,
//     "period_id": periodId,
//     "floor_id": floorId,
//   };
//
//   @override
//   int getId() { return id;
//   }
//
//   @override
//   String getUnitNumber() { return unitNumber;
//   }
// }

import 'package:smart_rent/models/general/smart_model.dart';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel extends SmartUnitModel {
  int? id;
  String? unitNumber;
  String? name;
  int? floorId;
  dynamic amount;
  int? unitType;
  int? isAvailable;
  String? description;
  int? periodId;
  int? propertyId;
  FloorModel? floorModel;

  UnitModel({
    required this.id,
    required this.unitNumber,
    required this.name,
    required this.floorId,
    required this.amount,
    required this.unitType,
    required this.isAvailable,
    required this.description,
    required this.periodId,
    required this.propertyId,
    required this.floorModel,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        unitNumber: json["unit_number"],
        name: json["name"],
        floorId: json["floor_id"],
        amount: json["amount"],
        unitType: json["unit_type"],
        isAvailable: json["is_available"],
        description: json["description"],
        periodId: json["period_id"],
        propertyId: json["property_id"],
        floorModel:
            json["floors"] == null ? null : FloorModel.fromJson(json["floors"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_number": unitNumber,
        "name": name,
        "floor_id": floorId,
        "amount": amount,
        "unit_type": unitType,
        "is_available": isAvailable,
        "description": description,
        "period_id": periodId,
        "property_id": propertyId,
        "floors": floorModel?.toJson(),
      };

  @override
  int getId() {
    return id!;
  }

  @override
  String getUnitNumber() {
    return unitNumber!;
  }

  @override
  int getAmount() {
    return amount;
  }

  @override
  int getAvailability() {
    return isAvailable!;
  }

  @override
  String getDescription() {
    return description!;
  }

  @override
  int getFloorId() {
    return floorId!;
  }

  @override
  int getPeriodId() {
    return periodId!;
  }

  @override
  int getPropertyId() {
    return propertyId!;
  }

  @override
  int getUnitType() {
    return unitType!;
  }

  @override
  String getUnitName() {
    return name!;
  }
}
