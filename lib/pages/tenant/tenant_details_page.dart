import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/pages/tenant/layout/tenant_details_screen_layout.dart';

class TenantDetailsPage extends StatelessWidget {
  final int id;
  const TenantDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final TenantController tenantController = Get.put(TenantController());
    return TenantDetailsScreenLayout(
        tenantController: tenantController,
        tenantId: id,
    );
  }
}
