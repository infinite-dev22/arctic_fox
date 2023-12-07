import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property/property_controller.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sqmController = TextEditingController();

  var typeList = [
    'single',
    'double'
  ];

  var categoryList = [
    'flat',
    'bungalow'
  ];

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

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  final PropertyController propertyController = Get.put(PropertyController());

  @override
  void initState() {
    // TODO: implement initState
    _image = File('');
    super.initState();
    propertyController.fetchAllPropertyTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: AppImageHeader(
        title: 'assets/auth/logo.png',
        isTitleCentred: true,
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Add Property', style: AppTheme.appTitle5,),
              AppTextField(
                controller: titleController,
                hintText: 'Property title',
                obscureText: false,
              ),

              SizedBox(height: 1.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 42.5.w,
                    child: Obx(() {
                      return CustomApiGenericDropdown<PropertyTypeModel>(
                        hintText: 'Type',
                        menuItems: propertyController.propertyTypeList.value,
                        onChanged: (value) {
                          print(value);
                          propertyController.setPropertyTypeId(value!.id);
                        },
                      );
                    }),
                  ),

                  SizedBox(
                    width: 42.5.w,
                    child: Obx(() {
                      return CustomApiGenericDropdown<PropertyCategoryModel>(
                        hintText: 'Category',
                        menuItems: propertyController.propertyCategoryList.value,
                        onChanged: (value) {
                          print(value!.id);
                          propertyController.setCategoryId(value.id);
                        },
                      );
                    }),
                  ),

                ],
              ),

              SizedBox(height: 1.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 42.5.w,
                    child: AppTextField(
                      controller: locationController,
                      hintText: 'Location',
                      obscureText: false,
                    ),
                  ),

                  SizedBox(
                    width: 42.5.w,
                    child: AppTextField(
                      controller: sqmController,
                      hintText: 'sqm',
                      obscureText: false,
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
              //                 borderRadius: BorderRadius.circular(20.sp)
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
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
              //                       child: Icon(Icons.cancel, size: 25.sp,
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

              SizedBox(height: 3.h,),

              AppButton(
                title: 'Submit',
                color: AppTheme.primaryColor,
                function: () {

                  propertyController.addProperty(
                      titleController.text.trim().toString(),
                      descriptionController.text.trim().toString(),
                      12,
                      propertyController.propertyTypeId.value,
                      propertyController.categoryId.value,
                      locationController.text.trim().toString(),
                      sqmController.text.trim().toString(),
                    "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                  "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                  );
                },
              ),


            ],
          ),
        ),
      ),

    );
  }
}
