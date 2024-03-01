import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(
                child: Text(
              'Profile Screen',
              style: AppTheme.appTitle3,
            ))
          ],
        ),
      ),
    );
  }
}
