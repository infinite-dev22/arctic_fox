import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class FloorTabScreen extends StatelessWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const FloorTabScreen(
      {super.key, required this.propertyDetailsOptionsController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 30.w,
                height: 5.h,
                child: AppButton(
                  // onTap: widget.function,
                  function: () {
                    if (propertyDetailsOptionsController
                        .floorDataList.isNotEmpty) {
                    } else {
                      propertyDetailsOptionsController.addFloorWidget();
                    }
                    Get.bottomSheet(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.sp),
                              topLeft: Radius.circular(20.sp))),
                      Container(
                        height: 42.5.h,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: Obx(() {
                            return Column(
                              children: [
                                Bounceable(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Add Floor',
                                        style: AppTheme.subTextBold,
                                      ),
                                      Image.asset(
                                          'assets/general/green_add.png',
                                          width: 5.w),
                                    ],
                                  ),
                                  onTap: () {
                                    propertyDetailsOptionsController
                                        .addFloorWidget();
                                  },
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ListView.builder(
                                        padding: EdgeInsets.only(top: 2.h),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            propertyDetailsOptionsController
                                                .floorDataList.length,
                                        itemBuilder: (context, index) {
                                          var floorData =
                                              propertyDetailsOptionsController
                                                  .floorDataList[index];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 1.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  child: AuthTextField(
                                                      controller: floorData
                                                          .textController,
                                                      hintText: 'Floor Name',
                                                      obscureText: false),
                                                  width: 70.w,
                                                ),
                                                Bounceable(
                                                  child: Image.asset(
                                                      'assets/general/edit.png'),
                                                  onTap: () {
                                                    propertyDetailsOptionsController
                                                        .removeFloorWidget(
                                                            index);
                                                    if (propertyDetailsOptionsController
                                                        .floorDataList
                                                        .isEmpty) {
                                                      Get.back();
                                                    } else {}
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                propertyDetailsOptionsController
                                        .floorDataList.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: AppButton(
                                            title: 'Submit',
                                            color: AppTheme.primaryColor,
                                            function: () {
                                              Get.back();
                                            }),
                                      ),
                              ],
                            );
                          }),
                        ),
                      ),
                    );
                  },
                  title: 'Add Floor',
                  color: Colors.green,
                ),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: propertyDetailsOptionsController.floorList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var floorModel =
                      propertyDetailsOptionsController.floorList[index];
                  return Text(floorModel.floorName + '$index');
                }),
          ],
        ),
      ),
    );
  }
}
