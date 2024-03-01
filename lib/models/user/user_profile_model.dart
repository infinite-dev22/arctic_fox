// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  String? id;
  String? userId;
  int? organisationId;
  String? firstName;
  String? lastName;
  int? roleId;
  String? email;
  String? phone;
  String? imagePath;

  UserProfileModel(
      {this.id,
      this.userId,
      this.organisationId,
      this.firstName,
      this.lastName,
      this.roleId,
      this.email,
      this.phone,
      this.imagePath});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        userId: json["user_id"],
        organisationId: json["organisation_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        roleId: json["role_id"],
        email: json["email"],
        phone: json["phone"],
        imagePath: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "organisation_id": organisationId,
        "first_name": firstName,
        "last_name": lastName,
        "role_id": roleId,
        "email": email,
        "phone": phone,
        "image": imagePath,
      };
}
