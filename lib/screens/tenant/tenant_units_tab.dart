import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/screens/tenant/specific_payment_schedule_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';

class TenantUnitsTab extends StatelessWidget {
  final TenantController tenantController;
  const TenantUnitsTab({super.key, required this.tenantController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.red
      ),
      child:
                  Obx(() {
                    var groupedData = tenantController.groupAllPaymentSchedules();
                    return tenantController.isPaymentScheduleLoading.value ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Center(
                        child: Image.asset('assets/auth/logo.png', width: 35.w),),
                    ) : tenantController.propertyUnitScheduleList.value.isEmpty
                        ? Center(child: Text('No Units Attached',style: AppTheme.blueSubText)) :  Wrap(
                      alignment: WrapAlignment.center,

                      children: groupedData.keys.toList().map((unitId) => Bounceable(
                        onTap: (){
                              Get.to(() =>
                                  SpecificPaymentScheduleScreen(
                                      tenantController: tenantController, unitId: int.parse(unitId),));
                        },
                        child: Card(
                          color: AppTheme.primaryColor,
                            child: Padding(
                              padding:  EdgeInsets.all(17.5),
                              child: Text(unitId.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.5.sp),),
                            )),
                      )).toList(),
                    );
                    //     : Expanded(
                    //   child: ListView.builder(
                    //     itemCount: groupedData.length,
                    //       itemBuilder: (context, index) {
                    //         var key = groupedData.keys.toList()[index];
                    //         return Text('Unit $key');
                    //       }),
                    // );
                  }),

    );
  }
}
