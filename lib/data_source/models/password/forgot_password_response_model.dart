// To parse this JSON data, do
//
//     final forgotPasswordResponseModel = forgotPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponseModel forgotPasswordResponseModelFromJson(String str) =>
    ForgotPasswordResponseModel.fromJson(json.decode(str));

String forgotPasswordResponseModelToJson(ForgotPasswordResponseModel data) =>
    json.encode(data.toJson());

class ForgotPasswordResponseModel {
  String? msg;

  ForgotPasswordResponseModel({
    this.msg,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
