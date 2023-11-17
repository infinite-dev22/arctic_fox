// To parse this JSON data, do
//
//     final floorModel = floorModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

FloorModel floorModelFromJson(String str) => FloorModel.fromJson(json.decode(str));

String floorModelToJson(FloorModel data) => json.encode(data.toJson());

class FloorModel extends SmartModel{
  int id;
  String name;
  // String description;
  // int propertyId;

  FloorModel({
    required this.id,
    required this.name,
    // required this.description,
    // required this.propertyId,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
    id: json["id"],
    name: json["name"],
    // description: json["description"],
    // propertyId: json["property_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    // "description": description,
    // "property_id": propertyId,
  };

  @override
  int getId() { return id;
  }

  @override
  String getName() { return name;
  }
}
