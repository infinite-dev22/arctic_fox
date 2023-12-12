import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/complaints/complaints_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/screens/property/property_list_screen.dart';
import 'package:smart_rent/screens/tenant/tenant_list_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/complaints_widget.dart';
import 'package:smart_rent/widgets/home_card_widget1.dart';
import 'package:smart_rent/widgets/home_card_widget2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ComplaintsController complaintsController = Get.put(
        ComplaintsController());
    final TenantController tenantController = Get.put(
        TenantController(),);
    final UnitController unitController = Get.put(UnitController(), permanent: true);
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppHeader(
        title: 'Dashboard',
        leading: Container(),
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text('Welcome, Bimal', style: AppTheme.appTitle5,),

              SizedBox(height: 2.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeCardWidget1(
                    color: AppTheme.greenCardColor, total: 8,
                    title: 'Total Property',
                    function: () {
                      Get.to(() => PropertyListScreen(unitController: unitController, tenantController: tenantController,),
                          transition: Transition.zoom);
                    },),
                  Obx(() {
                    return HomeCardWidget1(
                      color: AppTheme.redCardColor,
                      total: tenantController.tenantList.value.length,
                      title: 'Total Tenants',
                      function: () {
                        Get.to(() =>
                            TenantListScreen(
                              tenantController: tenantController,),
                            transition: Transition.zoom);
                      },);
                  }),
                ],
              ),

              SizedBox(height: 2.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeCardWidget2(image: 'assets/home/wallet.png',
                    title: 'Payment Received',
                    number: 25001,
                    function: () {},
                    isAmount: true,),
                  HomeCardWidget2(image: 'assets/home/eye.png',
                    title: 'Total Views',
                    number: 1500055,
                    function: () {},
                    isAmount: false,),
                ],
              ),

              SizedBox(height: 2.h,),

              ComplaintsWidget(
                complaintsController: complaintsController,
              ),

            ],
          ),
        ),
      ),

    );
  }


}
