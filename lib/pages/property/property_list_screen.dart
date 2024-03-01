import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/pages/property/layout/property_list_screen_layout.dart';

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PropertyBloc>(
      create: (_) => PropertyBloc(),
      child: PropertyListScreenLayout(),
    );
  }
}
