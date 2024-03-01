import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/property/floor_model.dart';
import 'package:smart_rent/models/property_options/floor_option_widget_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';

class PropertyDetailsOptionsController extends GetxController {
  var selectedIndex = 100.obs;

  RxList<FloorOptionModel> floorDataList = <FloorOptionModel>[].obs;

  // RxList<RoomOptionModel> roomDataList = <RoomOptionModel>[].obs;
  RxList<UnitModel> roomList = <UnitModel>[].obs;

  var isFloorList = false.obs;
  var isRoomList = false.obs;
  var isUnitLoading = false.obs;

  var floorList = [
    FloorModel(floorName: 'Level 1'),
    FloorModel(floorName: 'Level 2'),
    FloorModel(floorName: 'Level 3'),
  ];

  // var roomList = [
  //   RoomModel(roomNumber: 14, level: 2, amount: 300000, status: 'available'),
  //   RoomModel(roomNumber: 1, level: 5, amount: 100000, status: 'occupied'),
  //   RoomModel(roomNumber: 7, level: 1, amount: 28000, status: 'available'),
  //   RoomModel(roomNumber: 25, level: 6, amount: 59000, status: 'occupied'),
  // ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var options = [
    'Floors',
    'Units',
    'Tenants',
    'Payments',
  ].obs;

  var roomTypeList = ['single', 'double'];

  var periodList = ['Per Month', 'Per Year', 'Per Day'];

  var levelList = ['level 1', 'level 2'];

  var unitList = ['Unit 1', 'Unit 2'];

  var tenantList = ['vincent west', 'jonathan mark', 'ryan jupiter'];

  changeSelectedIndex(index) {
    selectedIndex.value = index;
    print(selectedIndex);
  }

  void addFloorWidget() {
    final textController = TextEditingController();

    floorDataList.add(
      FloorOptionModel(
        textController: textController,
      ),
    );
  }

  void changeAddFloorStatus(bool status) {
    isFloorList.value = status;
    print(isFloorList);
  }

  void changeAddRoomStatus(bool status) {
    isRoomList.value = status;
    print(isRoomList);
  }

  void removeFloorWidget(int index) {
    final floorData = floorDataList[index];
    floorData.textController.dispose();

    floorDataList.removeAt(index);
  }

  List<List<String>> getAllFloorInputData() {
    return floorDataList.map((floorData) {
      return [
        floorData.textController.text,
      ];
    }).toList();
  }

  void updateFloorWidgetValue(int index, int fieldIndex, String newValue) {
    final floorData = floorDataList[index];

    switch (fieldIndex) {
      case 0:
        floorData.textController.text = newValue;
        break;
    }
  }

  void fetchAllPropertyUnits() async {
    isUnitLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('units')
          .select()
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('MY UNITS ARE ${response}');
      print(response.length);
      print(data.length);
      print(data);
      isUnitLoading(false);

      return roomList
          .assignAll(data.map((json) => UnitModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching Units: $error');
      isUnitLoading(false);
    }
  }
}
