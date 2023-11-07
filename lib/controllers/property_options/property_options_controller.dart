
import 'package:get/get.dart';

class PropertyOptionsController extends GetxController {

  var selectedIndex = 100.obs;

  var options = [
    'Floors',
    'Rooms',
    'Tenants',
    'Payments',
  ].obs;


  changeSelectedIndex(index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}