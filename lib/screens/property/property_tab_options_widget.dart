import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';

class PropertyTabOptionsWidget extends StatefulWidget {
  const PropertyTabOptionsWidget({super.key});

  @override
  State<PropertyTabOptionsWidget> createState() => _PropertyTabOptionsWidgetState();
}

class _PropertyTabOptionsWidgetState extends State<PropertyTabOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.appBgColor,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
