import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/pages/property/layout/property_details_page_layout.dart';
import 'package:smart_rent/pages/unit/bloc/unit_bloc.dart';

class PropertyDetailsPage extends StatelessWidget {
  final int id;

  const PropertyDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final UnitController unitController = Get.put(UnitController());
    final TenantController tenantController = Get.put(TenantController());
    final PropertyModel propertyModel = PropertyModel();

    return MultiBlocProvider(
      providers: [
        BlocProvider<PropertyBloc>(
          create: (_) => PropertyBloc(),
        ),
        BlocProvider<UnitBloc>(
          create: (_) => UnitBloc(),
        ),
      ],
      child: PropertyDetailsPageLayout(
        unitController: unitController,
        tenantController: tenantController,
        propertyModel: propertyModel,
        id: id,
      ),
    );
  }
}
