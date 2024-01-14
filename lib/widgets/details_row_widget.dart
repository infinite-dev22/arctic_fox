import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';

class DetailsRowWidget extends StatelessWidget {
  final String title;
  final String trailing;
  const DetailsRowWidget({super.key, required this.title,  required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(title, style: AppTheme.appTitle3,),
      trailing: Card(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(trailing.toString(), style: AppTheme.blueSubText,),
      )),
    );
  }
}
