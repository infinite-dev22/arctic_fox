import 'package:get/get.dart';

class BottomNavBarController extends GetxController {

  var currentIndex = 0.obs;

  selectedIndex(int index){
    currentIndex.value =  index;
  }

}