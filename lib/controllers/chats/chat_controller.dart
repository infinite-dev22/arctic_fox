import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/chat/chat_model.dart';

class ChatController extends GetxController with StateMixin {
  var chatModelList = <ChatModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllChats();
  }

  Future<void> fetchAllChats() async {
    try {
      // change(null, status: RxStatus.loading());
      final response = await AppConfig().supaBaseClient.from('chats').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);
      chatModelList
          .assignAll(data.map((json) => ChatModel.fromJson(json)).toList());
      if (chatModelList.isNotEmpty) {
        change(chatModelList, status: RxStatus.success());
      } else {
        change(chatModelList, status: RxStatus.empty());
      }
    } catch (error) {
      change(null, status: RxStatus.error());
      print('Error fetching chats: $error');
    }
  }
}
