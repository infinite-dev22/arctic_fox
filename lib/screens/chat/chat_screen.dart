import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Chat Screen', style: AppTheme.appTitle3,))
          ],
        ),
      ),
    );
  }
}
