import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/utils/app_prefs.dart';

class BottomNavBarController extends GetxController {

  var currentIndex = 0.obs;
  var userFirstname = ''.obs;

  selectedIndex(int index){
    currentIndex.value =  index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }


  Future<void> getUserData() async {


    try{

      final response = await AppConfig().supaBaseClient.from('user_profiles').select().eq('user_id', userStorage.read('userId')).execute();
      print('MY SPECIFIC RESPONSE IS ${response.data[0]['first_name']}');

      userFirstname.value = response.data[0]['first_name'];



    }catch(error){
      print(error);
    }
    
  }

}