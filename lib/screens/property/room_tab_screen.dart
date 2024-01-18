import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/currency/currency_model.dart';
import 'package:smart_rent/models/floor/floor_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/unit/unit_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/room_option_widget.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class RoomTabScreen extends StatefulWidget {
  final UnitController unitController;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const RoomTabScreen(
      {super.key, required this.propertyDetailsOptionsController, required this.unitController});

  @override
  State<RoomTabScreen> createState() => _RoomTabScreenState();
}

class _RoomTabScreenState extends State<RoomTabScreen> {


  String imageError = '';

  final ImagePicker _picker = ImagePicker();
  late File _image;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File? img = File(image.path);
      setState(() {
        // newFile = img;
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitNumberController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  // final UnitController unitController = Get.put(UnitController());

  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            extendBody: false,
            maxWidth: 90.h,
            duration: Duration(microseconds: 1),
            minHeight: 90.h,
            elevation: 8,
            cornerRadius: 15.sp,
            snapSpec: const SnapSpec(
              snap: false,
              snappings: [ 0.9],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Material(
                color: AppTheme.whiteColor,
                child: Column(
                  children: [

                    Material(
                      elevation: 1,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 7.5.h,
                        decoration: BoxDecoration(
                            boxShadow: [
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Bounceable(
                                  onTap: () {
                                    roomNameController.clear();
                                    roomNumberController.clear();
                                    sizeController.clear();
                                    amountController.clear();
                                    descriptionController.clear();
                                    unitNumberController.clear();
                                    Get.back();
                                  },
                                  child: Text('Cancel', style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17.5.sp,
                                  ),)),

                              Text('Add Unit', style: AppTheme
                                  .darkBlueTitle2,),

                              Obx(() {
                                return widget.unitController.isAddUnitLoading.value ?
                                AppLoader(color: AppTheme.primaryColor,) :
                                  Bounceable(
                                    onTap: () async {
                                      widget.unitController.addUnit(
                                        widget.unitController.floorId.value,
                                        widget.unitController.currencyId.value,
                                        widget.unitController.unitTypeId.value,
                                        widget.unitController.paymentScheduleId
                                            .value,
                                        sizeController.text.trim(),
                                        userStorage.read('userProfileId'),
                                        int.parse(
                                            roomNumberController.text.trim()
                                                .toString()),
                                        int.parse(amountController.text.trim()
                                            .toString()),
                                        descriptionController.text.trim()
                                            .toString(),
                                      );
                                    },
                                    child: Text('Add', style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 17.5.sp,
                                    ),));
                              }),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,
                          vertical: 1.h),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(
                                  width: 42.5.w,
                                  child: Obx(() {
                                    return CustomApiGenericDropdown<
                                        UnitTypeModel>(
                                      hintText: 'Unit Type',
                                      menuItems: widget.unitController
                                          .unitTypeList.value,
                                      onChanged: (value) {
                                        widget.unitController.setUnitTypeId(
                                            value!.id);
                                      },
                                    );
                                  }),
                                ),

                                SizedBox(
                                  width: 42.5.w,
                                  child: Obx(() {
                                    return CustomApiGenericDropdown<FloorModel>(
                                      hintText: 'Level',
                                      menuItems: widget.unitController.floorList
                                          .value,
                                      onChanged: (value) {
                                        widget.unitController.setFloorId(
                                            value!.id);
                                      },
                                    );
                                  }),
                                ),

                              ],
                            ),

                            SizedBox(height: 1.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: AuthTextField(
                                    controller: roomNameController,
                                    hintText: 'Unit Name',
                                    obscureText: false,
                                    keyBoardType: TextInputType.name,
                                  ),
                                  width: 42.5.w,
                                ),

                                SizedBox(
                                  child: AuthTextField(
                                    controller: roomNumberController,
                                    hintText: 'Unit Number',
                                    obscureText: false,
                                    keyBoardType: TextInputType.number,
                                  ),
                                  width: 42.5.w,
                                ),

                              ],
                            ),

                            SizedBox(height: 1.h,),

                            AuthTextField(
                              controller: sizeController,
                              hintText: 'Square Meters',
                              obscureText: false,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //
                            //     // SizedBox(
                            //     //   width: 42.5.w,
                            //     //   child: AppTextField(
                            //     //     controller: sizeController,
                            //     //     hintText: 'Square Meters',
                            //     //     obscureText: false,
                            //     //   ),
                            //     // ),
                            //
                            //     // SizedBox(
                            //     //   width: 42.5.w,
                            //     //   child: Obx(() {
                            //     //     return CustomApiGenericDropdown<
                            //     //         PaymentScheduleModel>(
                            //     //       hintText: 'Per Month',
                            //     //       menuItems: unitController.paymentList.value,
                            //     //       onChanged: (value) {
                            //     //         unitController.setPaymentScheduleId(value!.id);
                            //     //       },
                            //     //     );
                            //     //   }),
                            //     // ),
                            //
                            //     // SizedBox(
                            //     //   width: 42.5.w,
                            //     //   child: Obx(() {
                            //     //     return CustomPeriodApiGenericDropdown<PaymentScheduleModel>(
                            //     //       hintText: 'Per Month',
                            //     //       menuItems: unitController.paymentList.value,
                            //     //       onChanged: (value) {
                            //     //         unitController.setPaymentScheduleId(value!.id);
                            //     //       },
                            //     //     );
                            //     //   }),
                            //     // ),
                            //
                            //   ],
                            // ),

                            SizedBox(height: 1.h,),

                            Obx(() {
                              return CustomPeriodApiGenericDropdown<
                                  PaymentScheduleModel>(
                                hintText: 'Per Month',
                                menuItems: widget.unitController.paymentList
                                    .value,
                                onChanged: (value) {
                                  widget.unitController.setPaymentScheduleId(
                                      value!.id!);
                                },
                              );
                            }),

                            SizedBox(height: 1.h,),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //
                            //     SizedBox(
                            //       width: 42.5.w,
                            //       child: Obx(() {
                            //         return CustomApiCurrencyDropdown<
                            //             CurrencyModel>(
                            //           hintText: 'Currency',
                            //           menuItems: unitController.currencyList.value,
                            //           onChanged: (value) {
                            //             unitController.setCurrencyId(value!.id);
                            //           },
                            //         );
                            //       }),
                            //     ),
                            //
                            //     SizedBox(
                            //       child: AppTextField(
                            //         controller: amountController,
                            //         hintText: 'Amount',
                            //         obscureText: false,
                            //         keyBoardType: TextInputType.number,
                            //       ),
                            //       width: 42.5.w,
                            //     ),
                            //
                            //
                            //   ],
                            // ),

                            Obx(() {
                              return CustomApiCurrencyDropdown<
                                  CurrencyModel>(
                                hintText: 'Currency',
                                menuItems: widget.unitController.currencyList
                                    .value,
                                onChanged: (value) {
                                  widget.unitController.setCurrencyId(
                                      value!.id);
                                },
                              );
                            }),

                            AuthTextField(
                              controller: amountController,
                              hintText: 'Amount',
                              obscureText: false,
                              keyBoardType: TextInputType.number,
                            ),

                            SizedBox(height: 1.h,),

                            AppMaxTextField(
                              controller: descriptionController,
                              hintText: 'Description',
                              obscureText: false,
                              fillColor: AppTheme.appBgColor,
                            ),

                            // SizedBox(height: 2.h,),
                            //
                            // SizedBox(
                            //   height: 15.h,
                            //   width: 90.w,
                            //   child: DottedBorder(
                            //     borderType: BorderType.RRect,
                            //     strokeWidth: 1,
                            //     radius: Radius.circular(20.sp),
                            //     child: _image.path == '' ?
                            //     Center(child: Bounceable(
                            //       onTap: () async {
                            //         await pickImage();
                            //       },
                            //       child: Center(
                            //         child: Container(
                            //             height: 29.5.h,
                            //             width: 77.5.w,
                            //             decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(
                            //                     20.sp)
                            //             ),
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment
                            //                   .center,
                            //               crossAxisAlignment: CrossAxisAlignment
                            //                   .center,
                            //               children: [
                            //                 Center(child: Image.asset(
                            //                     'assets/general/upload.png')),
                            //                 SizedBox(width: 3.w,),
                            //                 Text('Upload Property Pictures',
                            //                     style: AppTheme.subText)
                            //               ],
                            //             )),
                            //       ),
                            //     ),)
                            //         : Center(
                            //       child: Container(
                            //         clipBehavior: Clip.antiAlias,
                            //         height: 29.5.h,
                            //         width: 77.5.w,
                            //         decoration: BoxDecoration(
                            //           // color: AppTheme.borderColor2,
                            //             borderRadius: BorderRadius.circular(20.sp)
                            //         ),
                            //         child: Stack(
                            //           children: [
                            //             Center(
                            //               child: Image(image: FileImage(_image),
                            //                 fit: BoxFit.cover,
                            //               ),
                            //             ),
                            //             Align(
                            //                 alignment: Alignment.topRight,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       right: 2.w, top: 2.h),
                            //                   child: Bounceable(
                            //                       onTap: () {
                            //                         setState(() {
                            //                           _image = File('');
                            //                         });
                            //                       },
                            //                       child: Icon(
                            //                         Icons.cancel, size: 25.sp,
                            //                         color: AppTheme.primaryColor,)),
                            //                 ))
                            //           ],
                            //         ),),
                            //     ),
                            //   ),
                            // ),
                            //
                            // imageError == '' ? Container() : Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 3.w, vertical: 0.5.h),
                            //   child: Text(imageError, style: TextStyle(
                            //     fontSize: 14.sp,
                            //     color: Colors.red.shade800,
                            //
                            //   ),),
                            // ),

                            SizedBox(height: 1.h,),

                            // AppButton(
                            //   title: 'Add Unit',
                            //   color: AppTheme.primaryColor,
                            //   function: () {
                            //     unitController.addUnit(
                            //         unitController.floorId.value,
                            //         unitController.currencyId.value,
                            //         unitController.unitTypeId.value,
                            //         unitController.paymentScheduleId.value,
                            //         sizeController.text.trim(),
                            //         "userStorage.read('userProfileId')",
                            //         int.parse(roomNumberController.text.trim().toString()),
                            //         int.parse(amountController.text.trim().toString()),
                            //         descriptionController.text.trim().toString(),
                            //     );
                            //   },
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );

    print(result); // This is the result.
  }


  @override
  void initState() {
    // TODO: implement initState
    _image = File('');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomNumberController.dispose();
    roomNameController.dispose();
    sizeController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,


              children: [
                SizedBox(
                  width: 75.w,
                  child: AuthTextField(
                    controller: searchController,
                    hintText: 'Search',
                    obscureText: false,
                  ),
                ),

                Align(alignment: Alignment.centerRight, child: Bounceable(
                  onTap: () {
                    showAsBottomSheet(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppTheme.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(Icons.add, color: Colors.white,),
                      ),
                    ),
                  ),
                )),

                // SizedBox(
                //   width: 30.w,
                //   height: 6.5.h,
                //   child: AppButton(
                //       title: 'Add Unit',
                //       color: AppTheme.primaryColor,
                //       function: () {
                //         showAsBottomSheet(context);
                //       }),
                // ),

              ],
            ),

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: SizedBox(
            //     width: 30.w,
            //     height: 5.h,
            //     child: AppButton(
            //       // onTap: widget.function,
            //       function: () {
            //         if(widget.propertyDetailsOptionsController.roomDataList.isNotEmpty){
            //
            //         } else {
            //
            //         }
            //         Get.bottomSheet(
            //           backgroundColor: Theme
            //               .of(context)
            //               .scaffoldBackgroundColor,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(20.sp),
            //                   topLeft: Radius.circular(20.sp)
            //               )
            //           ),
            //           SizedBox(
            //         height: MediaQuery.of(context).size.height,
            //             child: Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 5.w,
            //                   vertical: 1.h),
            //               child:  SingleChildScrollView(
            //                 child: Column(
            //                     children: [
            //                       Text('Fill In Room Fileds', style: AppTheme.darkBlueText1,),
            //                       SizedBox(height: 1.h,),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //
            //                           SizedBox(
            //                             width: 42.5.w,
            //                             child: CustomGenericDropdown<String>(
            //                               hintText: 'Unit Type',
            //                               menuItems: widget.propertyDetailsOptionsController.roomTypeList,
            //                               onChanged: (value){
            //
            //                               },
            //                             ),
            //                           ),
            //
            //                           SizedBox(
            //                             width: 42.5.w,
            //                             child: CustomGenericDropdown<String>(
            //                               hintText: 'Level',
            //                               menuItems: widget.propertyDetailsOptionsController.levelList,
            //                               onChanged: (value){
            //
            //                               },
            //                             ),
            //                           ),
            //
            //                         ],
            //                       ),
            //
            //
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           SizedBox(
            //                             child: AppTextField(
            //                               controller: roomNameController,
            //                               hintText: 'Unit Name',
            //                               obscureText: false,
            //                             ),
            //                             width: 42.5.w,
            //                           ),
            //
            //                           SizedBox(
            //                             child: AppTextField(
            //                               controller: roomNumberController,
            //                               hintText: 'Unit Number',
            //                               obscureText: false,
            //                             ),
            //                             width: 42.5.w,
            //                           ),
            //
            //                         ],
            //                       ),
            //
            //                       AppTextField(
            //                         controller: sizeController,
            //                         hintText: 'Square Meters',
            //                         obscureText: false,
            //                       ),
            //
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           SizedBox(
            //                             child:  AppTextField(
            //                               controller: sizeController,
            //                               hintText: 'Amount',
            //                               obscureText: false,
            //                             ),
            //                             width: 42.5.w,
            //                           ),
            //
            //                           SizedBox(
            //                             width: 42.5.w,
            //                             child: CustomGenericDropdown<String>(
            //                               hintText: 'Per Month',
            //                               menuItems: widget.propertyDetailsOptionsController.periodList,
            //                               onChanged: (value){
            //
            //                               },
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //
            //                       AppMaxTextField(
            //                           controller: descriptionController,
            //                           hintText: 'Description',
            //                           obscureText: false
            //                       ),
            //
            //                       SizedBox(height: 2.h,),
            //
            //                       SizedBox(
            //                         height: 15.h,
            //                         width: 90.w,
            //                         child: DottedBorder(
            //                           borderType: BorderType.RRect,
            //                           strokeWidth: 1,
            //                           radius: Radius.circular(20.sp),
            //                           child: _image.path == '' ?
            //                           Center(child: Bounceable(
            //                             onTap: () async {
            //                               await pickImage();
            //                             },
            //                             child: Center(
            //                               child: Container(
            //                                   height: 29.5.h,
            //                                   width: 77.5.w,
            //                                   decoration: BoxDecoration(
            //                                       borderRadius: BorderRadius.circular(20.sp)
            //                                   ),
            //                                   child: Row(
            //                                     mainAxisAlignment: MainAxisAlignment.center,
            //                                     crossAxisAlignment: CrossAxisAlignment.center,
            //                                     children: [
            //                                       Center(child: Image.asset(
            //                                           'assets/general/upload.png')),
            //                                       SizedBox(width: 3.w,),
            //                                       Text('Upload Property Pictures', style: AppTheme.subText)
            //                                     ],
            //                                   )),
            //                             ),
            //                           ),)
            //                               : Center(
            //                             child: Container(
            //                               clipBehavior: Clip.antiAlias,
            //                               height: 29.5.h,
            //                               width: 77.5.w,
            //                               decoration: BoxDecoration(
            //                                 // color: AppTheme.borderColor2,
            //                                   borderRadius: BorderRadius.circular(20.sp)
            //                               ),
            //                               child: Stack(
            //                                 children: [
            //                                   Center(
            //                                     child: Image(image: FileImage(_image),
            //                                       fit: BoxFit.cover,
            //                                     ),
            //                                   ),
            //                                   Align(
            //                                       alignment: Alignment.topRight,
            //                                       child: Padding(
            //                                         padding: EdgeInsets.only(
            //                                             right: 2.w, top: 2.h),
            //                                         child: Bounceable(
            //                                             onTap: () {
            //                                               setState(() {
            //                                                 _image = File('');
            //                                               });
            //                                             },
            //                                             child: Icon(Icons.cancel, size: 25.sp,
            //                                               color: AppTheme.primaryColor,)),
            //                                       ))
            //                                 ],
            //                               ),),
            //                           ),
            //                         ),
            //                       ),
            //
            //                       imageError == '' ? Container() : Padding(
            //                         padding: EdgeInsets.symmetric(
            //                             horizontal: 3.w, vertical: 0.5.h),
            //                         child: Text(imageError, style: TextStyle(
            //                           fontSize: 14.sp,
            //                           color: Colors.red.shade800,
            //
            //                         ),),
            //                       ),
            //
            //                       SizedBox(height: 2.h,),
            //
            //                       AppButton(
            //                         title: 'Submit',
            //                         color: AppTheme.primaryColor,
            //                         function: (){
            //                           Get.back();
            //                           Get.snackbar('SUCCESS', 'Room added to your property',
            //                             titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
            //                           );
            //                         },
            //                       ),
            //
            //                     ],
            //                   ),
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //
            //       title: 'Add Unit',
            //       color: Colors.green,
            //
            //     ),
            //   ),
            // ),


            Obx(() {
              return widget.unitController.isUnitLoading.value
                  ? Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Center(
                  child: Image.asset('assets/auth/logo.png', width: 35.w),),
              )
                  : Expanded(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.unitController.roomList
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var roomModel = widget.unitController
                          .roomList[index];
                      return RoomOptionWidget(roomModel: roomModel,
                        index: index,
                        propertyDetailsOptionsController: widget
                            .propertyDetailsOptionsController,
                        unitController: widget.unitController,
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
