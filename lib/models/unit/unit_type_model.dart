// To parse this JSON data, do
//
//     final unitTypeModel = unitTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

UnitTypeModel unitTypeModelFromJson(String str) => UnitTypeModel.fromJson(json.decode(str));

String unitTypeModelToJson(UnitTypeModel data) => json.encode(data.toJson());

class UnitTypeModel extends SmartModel{
  int id;
  String name;

  UnitTypeModel({
    required this.id,
    required this.name,
  });

  factory UnitTypeModel.fromJson(Map<String, dynamic> json) => UnitTypeModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  int getId() { return id;
  }

  @override
  String getName() { return name;
  }
}
