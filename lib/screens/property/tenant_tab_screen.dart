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
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class TenantTabScreen extends StatefulWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  const TenantTabScreen({super.key, required this.propertyDetailsOptionsController});

  @override
  State<TenantTabScreen> createState() => _TenantTabScreenState();
}

class _TenantTabScreenState extends State<TenantTabScreen> {

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


  final listSample = [
    {'first': 'vincent', 'last': 'west', 'amount': 50000},
    {'first': 'mark', 'last': 'jonathan', 'amount': 130000},
    {'first': 'ryan', 'last': 'jupiter', 'amount': 45000},
  ];


  final TextEditingController discountController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            elevation: 8,
            cornerRadius: 15.sp,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [ 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Material(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w,
                      vertical: 1.h),
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Fill In Tenant Fileds', style: AppTheme.darkBlueText1,),
                        SizedBox(height: 1.h,),

                        CustomGenericDropdown<String>(
                          hintText: 'Select Tenant',
                          menuItems: widget.propertyDetailsOptionsController.tenantList,
                          onChanged: (value){

                          },
                        ),

                        CustomGenericDropdown<String>(
                          hintText: 'Select Unit',
                          menuItems: widget.propertyDetailsOptionsController.levelList,
                          onChanged: (value){

                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 42.5.w,
                              child: CustomGenericDropdown<String>(
                                hintText: 'From',
                                menuItems: [],
                                onChanged: (value){

                                },
                              ),
                            ),

                            SizedBox(
                              width: 42.5.w,
                              child: CustomGenericDropdown<String>(
                                hintText: 'To',
                                menuItems: [],
                                onChanged: (value){

                                },
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: AppTextField(
                                controller: amountController,
                                hintText: 'Amount',
                                obscureText: false,
                              ),
                              width: 42.5.w,
                            ),

                            SizedBox(
                              child: AppTextField(
                                controller: discountController,
                                hintText: 'Discount',
                                obscureText: false,
                              ),
                              width: 42.5.w,
                            ),

                          ],
                        ),



                        SizedBox(height: 2.h,),

                        AppButton(
                          title: 'Add Tenant',
                          color: AppTheme.primaryColor,
                          function: (){
                            Get.back();
                            Get.snackbar('SUCCESS', 'Tenant added to your property',
                              titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
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
    super.initState();
    _image = File('');
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 3.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              SizedBox(
                width: 50.w,
                child: AppTextField(
                    controller: searchController,
                    hintText: 'Search',
                    obscureText: false,
                ),
              ),

              SizedBox(
                width: 30.w,
                height: 6.5.h,
                child: AppButton(
                    title: 'Add Tenant',
                    color: AppTheme.primaryColor,
                    function: (){
                      showAsBottomSheet(context);
                    }),
              ),

            ],
          ),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listSample.length,
              itemBuilder: (context, index){
              var list = listSample[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Image.asset('assets/avatar/rian.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(list['first'].toString() + ' ' + list['last'].toString()),
                    subtitle: Text('${amountFormatter.format(list['amount'].toString())}/='),
                    trailing: Text('Unit 6'),
                  ),
                ),
              );
          })

        ],
      ),

    );
  }
}
