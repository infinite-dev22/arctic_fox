// To parse this JSON data, do
//
//     final logOutResponseModel = logOutResponseModelFromJson(jsonString);

import 'dart:convert';

LogOutResponseModel logOutResponseModelFromJson(String str) =>
    LogOutResponseModel.fromJson(json.decode(str));

String logOutResponseModelToJson(LogOutResponseModel data) =>
    json.encode(data.toJson());

class LogOutResponseModel {
  bool? success;
  String? message;

  LogOutResponseModel({
    this.success,
    this.message,
  });

  factory LogOutResponseModel.fromJson(Map<String, dynamic> json) =>
      LogOutResponseModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
