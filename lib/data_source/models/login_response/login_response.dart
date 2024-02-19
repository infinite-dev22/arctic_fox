// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool? success;
  String? token;
  String? message;

  LoginResponseModel({
    this.success,
    this.token,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    success: json["success"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "message": message,
  };
}
