import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property/property_controller.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
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

  File? propertyPic;
  String? propertyImagePath;
  String? propertyImageExtension;
  String? propertyFileName;
  Uint8List? propertyBytes;

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
      backgroundColor: AppTheme.whiteColor,
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
              AuthTextField(
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
                    child: AuthTextField(
                      controller: locationController,
                      hintText: 'Location',
                      obscureText: false,
                    ),
                  ),

                  SizedBox(
                    width: 42.5.w,
                    child: AuthTextField(
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
                fillColor: AppTheme.appBgColor,
              ),


              SizedBox(height: 1.h,),

              Bounceable(
                onTap: () {
                  FullPicker(
                    context: context,
                    file: true,
                    image: true,
                    video: true,
                    videoCamera: true,
                    imageCamera: true,
                    voiceRecorder: true,
                    videoCompressor: false,
                    imageCropper: false,
                    multiFile: true,
                    url: true,
                    onError: (int value) {
                      print(" ----  onError ----=$value");
                    },
                    onSelected: (value) async {
                      print(" ----  onSelected ----");

                      setState(() {
                        propertyPic = value.file.first;
                        propertyImagePath = value.file.first!.path;
                        propertyImageExtension = value.file.first!
                            .path
                            .split('.')
                            .last;
                        propertyFileName = value.file.first!
                            .path
                            .split('/')
                            .last;
                      });
                      propertyBytes = await propertyPic!.readAsBytes();
                      print('MY PIC == $propertyPic');
                      print('MY path == $propertyImagePath');
                      print('MY bytes == $propertyBytes');
                      print(
                          'MY extension == $propertyImageExtension');
                      print('MY FILE NAME == $propertyFileName');
                    },
                  );
                },
                child: Container(
                  width: 90.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: AppTheme.appBgColor,
                      borderRadius: BorderRadius.circular(15.sp),
                      image: DecorationImage(
                          image: FileImage(propertyPic ?? File('')),
                          fit: BoxFit.cover)
                  ),
                  child: propertyPic == null ? Center(
                    child: Text('Upload profile pic'),) : null,
                ),
              ),



              SizedBox(height: 3.h,),

              AppButton(
                title: 'Submit',
                color: AppTheme.primaryColor,
                function: () {

                  propertyController.addProperty(
                      titleController.text.trim().toString(),
                      descriptionController.text.trim().toString(),
                      userStorage.read('OrganizationId'),
                      propertyController.propertyTypeId.value,
                      propertyController.categoryId.value,
                      locationController.text.trim().toString(),
                      sqmController.text.trim().toString(),
                    userStorage.read('userProfileId').toString(),
                    userStorage.read('userProfileId').toString(),
                      propertyBytes!,
                      propertyImageExtension!,
                      propertyFileName!
                  // "userStorage.read('userProfileId')",
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
