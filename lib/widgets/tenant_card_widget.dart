import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/screens/tenant/tenant_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';

class TenantCardWidget extends StatelessWidget {
  final TenantModel tenantModel;
  final TenantController tenantController;
  final int index;
  final VoidCallback editFunction;
  const TenantCardWidget({super.key, required this.tenantController, required this.index, required this.editFunction, required this.tenantModel});

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
              backgroundImage: CachedNetworkImageProvider(tenantController.tenantList[index].documents!.fileUrl.toString()),
              backgroundColor: AppTheme.primaryColor,
            ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Bounceable(
                          child: Image.asset('assets/tenant/delete.png'),
                        onTap: ()async{

                          showDialog(

                              context: context,
                              builder: (BuildContext c) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.sp)
                                  ),
                                  child: Container(
                                    // height: 50.h,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 2.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 1.h,),
                                          Text('Are you sure to delete', style: AppTheme.subText,),
                                          Text('${tenantController.tenantList[index].name}',
                                            style: AppTheme.appTitle3,),

                                          SizedBox(height: 3.h,),

                                          SizedBox(
                                            width: 50.w,
                                            child: AppButton(
                                              title: 'Remove',
                                              color: AppTheme.primaryColor,
                                              function: () async {
                                                // tenantController.deleteTenant(tenantController.tenantList[index].id);
                                              },
                                            ),
                                          ),

                                          SizedBox(height: 3.h,),

                                          SizedBox(
                                            width: 50.w,
                                            child: AppButton(
                                              title: 'Cancel',
                                              color: Colors.black,
                                              function: () async {
                                                Get.back();
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });


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
            Text('View More Info', style: AppTheme.darkBlueText1,),

          ],
        ),
      ),
    );
  }
}
