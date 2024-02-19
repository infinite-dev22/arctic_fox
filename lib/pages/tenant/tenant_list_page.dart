import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/pages/tenant/bloc/tenant_bloc.dart';
import 'package:smart_rent/pages/tenant/layout/tenant_list_screen_layout.dart';

class TenantListPage extends StatelessWidget {
  const TenantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TenantController tenantController = Get.put(TenantController());
    return BlocProvider<TenantBloc>(
      create: (context) => TenantBloc(),
      child: TenantListScreenLayout(
        tenantController: tenantController,
      ),
    );
  }
}
