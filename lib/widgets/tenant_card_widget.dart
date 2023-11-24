import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/screens/tenant/tenant_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';

class TenantCardWidget extends StatelessWidget {
  final TenantController tenantController;
  final int index;
  final VoidCallback editFunction;
  const TenantCardWidget({super.key, required this.tenantController, required this.index, required this.editFunction});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          CircleAvatar(
              backgroundImage: AssetImage('assets/avatar/rian.jpg'),
              backgroundColor: AppTheme.primaryColor,
            ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Bounceable(
                          child: Image.asset('assets/tenant/delete.png'),
                        onTap: ()async{
                            tenantController.deleteTenant(tenantController.tenantList[index].id);
                        },
                      ),
                      SizedBox(width: 3.w,),
                      Bounceable(
                          child: Image.asset('assets/tenant/edit.png'),
                        onTap: editFunction,
                      ),

                    ],
                  ),
                )
              ],
            ),

            Text(tenantController.tenantList[index].name, style: AppTheme.darkBlueTitle,),
            Bounceable(
              onTap: (){
                Get.to(() => TenantDetailsScreen());
              },
                child: Text('View More Info', style: AppTheme.darkBlueText1,)),

          ],
        ),
      ),
    );
  }
}
