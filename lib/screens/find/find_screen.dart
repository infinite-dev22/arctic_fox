import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';


class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Find Screen', style: AppTheme.appTitle3,))
          ],
        ),
      ),
    );
  }
}
