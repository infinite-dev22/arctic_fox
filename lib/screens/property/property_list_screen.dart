import 'dart:io';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property/property_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/screens/property/add_property_screen.dart';
import 'package:smart_rent/screens/property/property_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_search_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/property_card_widget.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class PropertyListScreen extends StatefulWidget {
  final TenantController tenantController;
  final UnitController unitController;

  const PropertyListScreen(
      {super.key, required this.unitController, required this.tenantController});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {

  final PropertyController propertyController = Get.put(PropertyController());

  final TextEditingController searchController = TextEditingController();

  final _propertyKey = GlobalKey<ExpandableFabState>();

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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    propertyController.fetchAllPropertyTypes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    sqmController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: userStorage.read('roleId') == 4 ? null : ExpandableFab.location,
      floatingActionButton: userStorage.read('roleId') == 4 ? Container() : ExpandableFab(
        key: _propertyKey,
        type: ExpandableFabType.up,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Container(
            width: 14.w,
            height: 10.h,
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
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
        ),
        children: [],
        onOpen: (){
                final state = _propertyKey.currentState;
                if (state != null) {
                  debugPrint('isOpen:${state.isOpen}');
                  state.toggle();
                }
                showAddPropertyBottomSheet(context);
                // Get.to(() => AddPropertyScreen(),
                //     transition: Transition.downToUp);
        },
      ),

      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        isTitleCentred: true,
        title: 'assets/auth/logo.png',
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 5.w),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Image.asset('assets/home/profile.png'),
        //         Text('Profile')
        //       ],
        //     ),
        //   ),
        // ],
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/home/location.png', fit: BoxFit.cover,
                      scale: 0.65),
                  Text(userStorage.read('organisationName').toString(), style: AppTheme.appTitle1,),
                ],
              ),

              Obx(() {
                return AppSearchTextField(
                  controller: searchController,
                  hintText: 'Search properties, tenants, units',
                  obscureText: false,
                  function: () {
                    // Get.to(() => AddPropertyScreen(),
                    //     transition: Transition.downToUp);
                  },
                  fillColor: AppTheme.textBoxColor,
                  number: widget.tenantController.propertyModelList.value
                      .length,

                );
              }),

              Obx(() {
                return widget.tenantController.isPropertyModelListLoading.value
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Center(
                    child: Image.asset('assets/auth/logo.png', width: 35.w),),
                ) : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.tenantController.propertyModelList.length,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      var property = widget.tenantController.propertyModelList[index];
                      return Bounceable(
                          onTap: () {
                            Get.to(() =>
                                PropertyDetailsScreen(
                                  propertyModel: property,
                                  unitController: widget.unitController,
                                  tenantController: widget.tenantController,));
                          },
                          child: SlideInUp(child: PropertyCardWidget(propertyModel: property,)));
                    });
              }),


            ],
          ),
        ),
      ),

    );
  }

  void showAddPropertyBottomSheet(BuildContext context) async {
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
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return WillPopScope(
                      onWillPop: () async {
                        titleController.clear();
                        addressController.clear();
                        descriptionController.clear();
                        locationController.clear();
                        sqmController.clear();
                        propertyPic = File('');
                        print('Pic = ${propertyPic!.path}');
                        return true;
                      },
                      child: Material(
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
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Bounceable(
                                          onTap: () {
                                            titleController.clear();
                                            addressController.clear();
                                            descriptionController
                                                .clear();
                                            locationController.clear();
                                            sqmController.clear();
                                            propertyPic = File('');
                                            print('Pic = ${propertyPic!.path}');

                                            Get.back();
                                          },
                                          child: Text(
                                            'Cancel', style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17.5.sp,
                                          ),)),

                                      Text('Add Property', style: AppTheme
                                          .darkBlueTitle2,),

                                      Obx(() {
                                        return propertyController.isAddPropertyLoading.value ?
                                        AppLoader(color: AppTheme.primaryColor,) :
                                        Bounceable(
                                            onTap: () async {

                                              if(
                                              titleController.text.isEmpty ||
                                                  locationController.text.isEmpty ||
                                                  sqmController.text.isEmpty ||
                                                  propertyPic == null ||
                                                  propertyController.propertyTypeId.value == 0 ||
                                                  propertyController.categoryId.value == 0
                                              ) {
                                                Fluttertoast.showToast(msg: 'fill in all fields', gravity: ToastGravity.TOP);

                                              } else {

                                                propertyController.addProperty(
                                                    titleController.text
                                                        .trim().toString(),
                                                    descriptionController
                                                        .text.trim().toString(),
                                                    userStorage.read(
                                                        'OrganizationId'),
                                                    propertyController
                                                        .propertyTypeId.value,
                                                    propertyController.categoryId
                                                        .value,
                                                    locationController
                                                        .text.trim().toString(),
                                                    sqmController.text
                                                        .trim().toString(),
                                                    userStorage.read(
                                                        'userProfileId')
                                                        .toString(),
                                                    userStorage.read(
                                                        'userProfileId')
                                                        .toString(),
                                                    propertyBytes!,
                                                    propertyImageExtension!,
                                                    propertyFileName!
                                                  // "userStorage.read('userProfileId')",
                                                ).then((value) {
                                                  titleController.clear();
                                                  addressController.clear();
                                                  descriptionController.clear();
                                                  locationController.clear();
                                                  sqmController.clear();
                                                  propertyPic = File('');
                                                  print('Pic = ${propertyPic!.path}');
                                                });

                                              }


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
                                    AuthTextField(
                                      controller: titleController,
                                      hintText: 'Property title',
                                      obscureText: false,
                                    ),

                                    SizedBox(height: 1.h,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [

                                        SizedBox(
                                          width: 42.5.w,
                                          child: Obx(() {
                                            return CustomApiGenericDropdown<
                                                PropertyTypeModel>(
                                              hintText: 'Type',
                                              menuItems: propertyController
                                                  .propertyTypeList.value,
                                              onChanged: (value) {
                                                print(value);
                                                propertyController
                                                    .setPropertyTypeId(
                                                    value!.id);
                                              },
                                            );
                                          }),
                                        ),

                                        SizedBox(
                                          width: 42.5.w,
                                          child: Obx(() {
                                            return CustomApiGenericDropdown<
                                                PropertyCategoryModel>(
                                              hintText: 'Category',
                                              menuItems: propertyController
                                                  .propertyCategoryList.value,
                                              onChanged: (value) {
                                                print(value!.id);
                                                propertyController
                                                    .setCategoryId(value.id);
                                              },
                                            );
                                          }),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 1.h,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
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
                                          prefixName: 'add property',
                                          context: context,
                                          image: true,
                                          imageCamera: kDebugMode,
                                          imageCropper: true,
                                          onError: (int value) {
                                            print(" ----  onError ----=$value");
                                          },
                                          onSelected: (value) async {
                                            print(" ----  onSelected ----");

                                            setState(() {
                                              propertyPic = value.file.first;
                                              propertyImagePath =
                                                  value.file.first!.path;
                                              propertyImageExtension =
                                                  value.file.first!
                                                      .path
                                                      .split('.')
                                                      .last;
                                              propertyFileName =
                                                  value.file.first!
                                                      .path
                                                      .split('/')
                                                      .last;
                                            });
                                            propertyBytes =
                                            await propertyPic!.readAsBytes();
                                            print('MY PIC == $propertyPic');
                                            print(
                                                'MY path == $propertyImagePath');
                                            print('MY bytes == $propertyBytes');
                                            print(
                                                'MY extension == $propertyImageExtension');
                                            print(
                                                'MY FILE NAME == $propertyFileName');
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 50.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: AppTheme.appBgColor,
                                            borderRadius: BorderRadius.circular(
                                                15.sp),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    propertyPic ?? File('')),
                                                fit: BoxFit.cover)
                                        ),
                                        child: propertyPic == null ||
                                            propertyPic!.path.isEmpty
                                            ? Center(
                                          child: Text('Upload profile pic'),)
                                            : null,
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        }
    );

    print(result); // This is the result.
  }


}
