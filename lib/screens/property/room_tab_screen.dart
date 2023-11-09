import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/room_option_widget.dart';

class RoomTabScreen extends StatelessWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  const RoomTabScreen({super.key, required this.propertyDetailsOptionsController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.centerRight,
            child: Bounceable(
              // onTap: widget.function,
              onTap: () {
                if(propertyDetailsOptionsController.floorDataList.isNotEmpty){

                } else {
                  propertyDetailsOptionsController.addFloorWidget();
                }
                Get.bottomSheet(
                  backgroundColor: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.sp),
                          topLeft: Radius.circular(20.sp)
                      )
                  ),
                  Container(
                    height: 42.5.h,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,
                          vertical: 1.h),
                      child: Obx(() {
                        return Column(
                          children: [
                            Bounceable(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Add Room', style: AppTheme.subTextBold,),
                                  Image.asset('assets/general/green_add.png', width: 5.w),
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
                                    itemCount: propertyDetailsOptionsController
                                        .floorDataList
                                        .length,
                                    itemBuilder: (context, index) {
                                      var floorData = propertyDetailsOptionsController
                                          .floorDataList[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 1.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              child: AppTextField(
                                                  controller: floorData
                                                      .textController,
                                                  hintText: 'Floor Name',
                                                  obscureText: false),
                                              width: 70.w,
                                            ),
                                            Bounceable(
                                              child: Image.asset(
                                                  'assets/general/delete.png'),
                                              onTap: () {
                                                propertyDetailsOptionsController
                                                    .removeFloorWidget(
                                                    index);
                                                if(propertyDetailsOptionsController.floorDataList.isEmpty){
                                                  Get.back();
                                                } else {

                                                }
                                              },
                                            ),

                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            propertyDetailsOptionsController
                                .floorDataList
                                .isEmpty
                                ? Container()
                                : Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: AppButton(title: 'Submit',
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Add Room', style: AppTheme.subTextBold,),
                  Image.asset('assets/general/green_add.png', width: 5.w),
                ],
              ),
            ),
          ),


          ListView.builder(
              itemCount: propertyDetailsOptionsController.roomList
                  .length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var roomModel = propertyDetailsOptionsController
                    .roomList[index];
                return RoomOptionWidget(roomModel: roomModel);
              }),
        ],
      ),
    );
  }
}
