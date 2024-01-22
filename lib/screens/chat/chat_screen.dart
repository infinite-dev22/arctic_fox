import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/chats/chat_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Chat Screen', style: AppTheme.appTitle3,)),

            // chatController.obx((state) {
            //   return Expanded(
            //     child: ListView.builder(
            //       itemCount: chatController.chatModelList.length,
            //         itemBuilder: (context, index){
            //           var chat = chatController.chatModelList[index];
            //       return Text(chat.message.toString());
            //     }),
            //   );
            // },
            //   onEmpty: Text('Empty Chats'),
            //   onError: (error){
            //   return Text('big error');
            //   },
            //   onLoading: CircularProgressIndicator(),
            // )

          ],
        ),
      ),
    );
  }
}


// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.whiteColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Center(child: Text('Chat Screen', style: AppTheme.appTitle3,))
//           ],
//         ),
//       ),
//     );
//   }
// }
