// To parse this JSON data, do
//
//     final paymentScheduleModel = paymentScheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

PaymentScheduleModel paymentScheduleModelFromJson(String str) => PaymentScheduleModel.fromJson(json.decode(str));

String paymentScheduleModelToJson(PaymentScheduleModel data) => json.encode(data.toJson());

class PaymentScheduleModel extends SmartPeriodModel{
  int id;
  String name;
  int period;

  PaymentScheduleModel({
    required this.id,
    required this.name,
    required this.period,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) => PaymentScheduleModel(
    id: json["id"],
    name: json["name"],
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "period": period,
  };

  @override
  int getId() { return id;
  }

  @override
  String getName() { return name;
  }

  @override
  int getPeriod() { return period;
  }

}
