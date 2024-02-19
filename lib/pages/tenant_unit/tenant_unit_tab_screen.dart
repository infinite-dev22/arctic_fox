import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/pages/tenant_unit/layout/tenant_unit_tab_screen_layout.dart';

class TenantUnitTabScreen extends StatelessWidget {
  final int id;

  const TenantUnitTabScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final PropertyDetailsOptionsController propertyDetailsOptionsController = Get.put(PropertyDetailsOptionsController());
    return BlocProvider<TenantUnitBloc>(
      create: (context) => TenantUnitBloc(),
      child: TenantUnitTabLayoutScreen(
          propertyDetailsOptionsController: propertyDetailsOptionsController,
        id: id,
      ),
    );
  }
}
