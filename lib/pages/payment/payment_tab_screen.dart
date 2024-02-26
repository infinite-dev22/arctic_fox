import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/payment/layout/payment_tab_screen_layout.dart';
import 'package:smart_rent/pages/unit/bloc/unit_bloc.dart';
import 'package:smart_rent/pages/unit/layout/unit_tab_screen_layout.dart';

class PaymentScreen extends StatelessWidget {
  final int id;

  const PaymentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final UnitController unitController = Get.put(UnitController());
    final PropertyDetailsOptionsController propertyDetailsOptionsController = Get
        .put(PropertyDetailsOptionsController());
    return  PaymentTabScreenLayout(
        propertyDetailsOptionsController: propertyDetailsOptionsController,
        unitController: unitController,
        id: id);
  }
}
