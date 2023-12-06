// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';


// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';


// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';



// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';



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




UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel extends SmartUnitModel{
  int id;
  String unitNumber;
  int floorId;
  dynamic amount;
  int unitType;

  UnitModel({
    required this.id,
    required this.unitNumber,
    required this.floorId,
    required this.amount,
    required this.unitType,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    id: json["id"],
    unitNumber: json["unit_number"],
    floorId: json["floor_id"],
    amount: json["amount"],
    unitType: json["unit_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_number": unitNumber,
    "floor_id": floorId,
    "amount": amount,
    "unit_type": unitType,
  };

  @override
  int getId() { return id;
  }

  @override
  String getUnitNumber() { return unitNumber;
  }
}
