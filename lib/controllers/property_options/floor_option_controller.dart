import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/models/property_options/floor_option_widget_model.dart';

class FloorOptionsController extends GetxController {
  RxList<FloorOptionModel> floorDataList = <FloorOptionModel>[].obs;

  void addWidget() {
    final textController = TextEditingController();

    floorDataList.add(
      FloorOptionModel(
        textController: textController,
      ),
    );
  }

  void removeWidget(int index) {
    final floorData = floorDataList[index];
    floorData.textController.dispose();

    floorDataList.removeAt(index);
  }

  List<List<String>> getAllInputData() {
    return floorDataList.map((floorData) {
      return [
        floorData.textController.text,

      ];
    }).toList();
  }

  void updateWidgetValue(int index, int fieldIndex, String newValue) {
    final floorData = floorDataList[index];

    switch (fieldIndex) {
      case 0:
        floorData.textController.text = newValue;
        break;

    }
  }


}
