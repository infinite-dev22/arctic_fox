// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  String? id;
  String? userId;
  int? organisationId;
  String? firstName;
  String? lastName;
  int? roleId;

  UserProfileModel({
    this.id,
    this.userId,
    this.organisationId,
    this.firstName,
    this.lastName,
    this.roleId,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    id: json["id"],
    userId: json["user_id"],
    organisationId: json["organisation_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "organisation_id": organisationId,
    "first_name": firstName,
    "last_name": lastName,
    "role_id": roleId,
  };
}
