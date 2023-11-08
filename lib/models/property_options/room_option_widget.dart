import 'package:flutter/material.dart';

class RoomOptionModel {

  String levelNumber;
  String roomType;
  String period;
  TextEditingController roomNameController;
  TextEditingController roomNumberController;
  TextEditingController sizeController;
  TextEditingController amountController;
  TextEditingController descriptionController;

  RoomOptionModel({
    required this.roomNameController,
    required this.roomNumberController,
    required this.sizeController,
    required this.amountController,
    required this.descriptionController,
    required this.levelNumber,
    required this.roomType,
    required this.period,
  });
}
