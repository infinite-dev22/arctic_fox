// To parse this JSON data, do
//
//     final salutationModel = salutationModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

SalutationModel salutationModelFromJson(String str) => SalutationModel.fromJson(json.decode(str));

String salutationModelToJson(SalutationModel data) => json.encode(data.toJson());

class SalutationModel extends SmartModel{
  int id;
  String name;

  SalutationModel({
    required this.id,
    required this.name,
  });

  factory SalutationModel.fromJson(Map<String, dynamic> json) => SalutationModel(
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
