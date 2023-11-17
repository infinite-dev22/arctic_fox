// To parse this JSON data, do
//
//     final paymentScheduleModel = paymentScheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

PaymentScheduleModel paymentScheduleModelFromJson(String str) => PaymentScheduleModel.fromJson(json.decode(str));

String paymentScheduleModelToJson(PaymentScheduleModel data) => json.encode(data.toJson());

class PaymentScheduleModel extends SmartModel{
  int id;
  String name;

  PaymentScheduleModel({
    required this.id,
    required this.name,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) => PaymentScheduleModel(
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
