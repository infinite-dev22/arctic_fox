import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Add Screen', style: AppTheme.appTitle3,))
          ],
        ),
      ),
    );
  }
}
