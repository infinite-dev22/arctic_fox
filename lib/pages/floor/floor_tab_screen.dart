import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/floor/layout/floor_tab_screen_layout.dart';

class FloorTabListScreen extends StatelessWidget {
  final int id;

  const FloorTabListScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FloorTabScreenLayout(
        id: id,
      );
  }
}
