// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel extends SmartUnitModel{
  int id;
  String unitNumber;

  UnitModel({
    required this.id,
    required this.unitNumber,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    id: json["id"],
    unitNumber: json["unit_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_number": unitNumber,
  };

  @override
  int getId() { return id;
  }

  @override
  String getUnitNumber() { return unitNumber;
  }
}
