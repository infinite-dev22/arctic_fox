import 'dart:convert';
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
import 'package:smart_rent/models/property/room_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';


class RoomOptionWidget extends StatefulWidget {
  final UnitController? unitController;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  final UnitModel roomModel;
  final int index;
  const RoomOptionWidget({super.key, required this.roomModel, required this.index, required this.propertyDetailsOptionsController,  this.unitController});

  @override
  State<RoomOptionWidget> createState() => _RoomOptionWidgetState();
}

class _RoomOptionWidgetState extends State<RoomOptionWidget> {

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




  void showRoomEditBottomSheet(BuildContext context, int amount) async {

    final TextEditingController roomNameController = TextEditingController();
    final TextEditingController roomNumberController = TextEditingController();
    final TextEditingController sizeController = TextEditingController();
    final TextEditingController amountController = TextEditingController(text:  amount.toString());
    final TextEditingController descriptionController = TextEditingController();

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
              snap: true,
              snappings: [ 0.9],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Material(
                color: AppTheme.appBgColor,
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
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bounceable(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel', style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17.5.sp,
                                  ),)),

                              Text('Edit Unit', style: AppTheme
                                  .darkBlueTitle2,),

                              Bounceable(
                                  onTap: () async {
                                    Get.back();
                                    Get.snackbar('SUCCESS', 'Unit edited successfully',
                                      titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                                    );
                                  },
                                  child: Text('Update', style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 17.5.sp,
                                  ),)),


                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,
                          vertical: 1.h),
                      child:  SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(
                                  width: 42.5.w,
                                  child: CustomGenericDropdown<String>(
                                    hintText: 'Unit Type',
                                    menuItems: widget.propertyDetailsOptionsController.roomTypeList,
                                    onChanged: (value){

                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: 42.5.w,
                                  child: CustomGenericDropdown<String>(
                                    hintText: 'Level',
                                    menuItems: widget.propertyDetailsOptionsController.levelList,
                                    onChanged: (value){

                                    },
                                  ),
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

                            SizedBox(height: 1.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child:  AuthTextField(
                                    controller: amountController,
                                    hintText: 'Amount',
                                    obscureText: false,
                                    keyBoardType: TextInputType.number,
                                  ),
                                  width: 42.5.w,

                                ),

                                SizedBox(
                                  width: 42.5.w,
                                  child: CustomGenericDropdown<String>(
                                    hintText: 'Per Month',
                                    menuItems: widget.propertyDetailsOptionsController.periodList,
                                    onChanged: (value){

                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 1.h,),

                            AppMaxTextField(
                                controller: descriptionController,
                                hintText: 'Description',
                                obscureText: false,
                              fillColor: AppTheme.textBoxColor,
                            ),

                            SizedBox(height: 1.h,),

                            SizedBox(
                              height: 15.h,
                              width: 90.w,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeWidth: 1,
                                radius: Radius.circular(20.sp),
                                child: _image.path == '' ?
                                Center(child: Bounceable(
                                  onTap: () async {
                                    await pickImage();
                                  },
                                  child: Center(
                                    child: Container(
                                        height: 29.5.h,
                                        width: 77.5.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.sp)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(child: Image.asset(
                                                'assets/general/upload.png')),
                                            SizedBox(width: 3.w,),
                                            Text('Upload Property Pictures', style: AppTheme.subText)
                                          ],
                                        )),
                                  ),
                                ),)
                                    : Center(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 29.5.h,
                                    width: 77.5.w,
                                    decoration: BoxDecoration(
                                      // color: AppTheme.borderColor2,
                                        borderRadius: BorderRadius.circular(20.sp)
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image(image: FileImage(_image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 2.w, top: 2.h),
                                              child: Bounceable(
                                                  onTap: () {
                                                    setState(() {
                                                      _image = File('');
                                                    });
                                                  },
                                                  child: Icon(Icons.cancel, size: 25.sp,
                                                    color: AppTheme.primaryColor,)),
                                            ))
                                      ],
                                    ),),
                                ),
                              ),
                            ),

                            imageError == '' ? Container() : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.5.h),
                              child: Text(imageError, style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.red.shade800,

                              ),),
                            ),

                            SizedBox(height: 2.h,),


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
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${widget.index +1}', style: AppTheme.subTextBold),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unit ${widget.roomModel.unitNumber}', style: AppTheme.subTextBold,),
            Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.roomModel.isAvailable == true ? 'available' : 'occupied', style: TextStyle(
                    color: widget.roomModel.isAvailable == true ? Colors.green : Colors.red,

                  ),),
                )),
          ],
        ),
        subtitle: Text('Level ${widget.roomModel.id}', style: AppTheme.subText,),
        trailing: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text('${amountFormatter.format(widget.roomModel.amount.toString())}/=', style: AppTheme.appTitle3),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(widget.roomModel.status.toString(), style: TextStyle(
                  //   color: widget.roomModel.status.toString() == 'available' ? Colors.green : Colors.red,
                  // ),),
                  // Text(widget.roomModel.)
                  Bounceable(
                      onTap: (){
                        showRoomEditBottomSheet(context, widget.roomModel.amount);
                      }, child: Image.asset('assets/tenant/edit.png', width: 5.w,)),
                  SizedBox(width: 5.w,),
                  Bounceable(
                    onTap: (){
                      widget.unitController!.deleteUnit(widget.roomModel.id);
                    },
                      child: Image.asset('assets/tenant/delete.png', width: 3.5.w,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
