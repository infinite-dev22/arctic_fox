// To parse this JSON data, do
//
//     final organisationModel = organisationModelFromJson(jsonString);

import 'dart:convert';

OrganisationModel organisationModelFromJson(String str) => OrganisationModel.fromJson(json.decode(str));

String organisationModelToJson(OrganisationModel data) => json.encode(data.toJson());

class OrganisationModel {
  String name;
  String description;
  int userId;

  OrganisationModel({
    required this.name,
    required this.description,
    required this.userId,
  });

  factory OrganisationModel.fromJson(Map<String, dynamic> json) => OrganisationModel(
    name: json["name"],
    description: json["description"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "user_id": userId,
  };
}
