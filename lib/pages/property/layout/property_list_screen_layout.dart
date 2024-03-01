import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/pages/property/property_details_page.dart';
import 'package:smart_rent/pages/property/widgets/property_list_card_widget.dart';
import 'package:smart_rent/pages/property_categories/bloc/property_category_bloc.dart';
import 'package:smart_rent/pages/property_types/bloc/property_type_bloc.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_search_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class PropertyListScreenLayout extends StatefulWidget {
  const PropertyListScreenLayout({
    super.key,
  });

  @override
  State<PropertyListScreenLayout> createState() =>
      _PropertyListScreenLayoutState();
}

class _PropertyListScreenLayoutState extends State<PropertyListScreenLayout> {
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

  List<String> searchableList = ['Orange', 'Watermelon', 'Banana'];

  int selectedPropertyTypeId = 0;
  int selectedPropertyCategoryId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
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
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
        ),
        children: [],
        onOpen: () {
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
      backgroundColor: AppTheme.appBgColor,
      appBar: AppImageHeader(
        isTitleCentred: true,
        title: 'assets/auth/srw.png',
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/home/location.png',
                      fit: BoxFit.cover, scale: 0.65),
                  Text(
                    'User',
                    style: AppTheme.appTitle1,
                  ),
                ],
              ),
              BlocBuilder<PropertyBloc, PropertyState>(
                builder: (context, state) {
                  return AppSearchTextField(
                    controller: searchController,
                    hintText: 'Search properties, tenants, units',
                    obscureText: false,
                    function: () {
                      // Get.to(() => AddPropertyScreen(),
                      //     transition: Transition.downToUp);
                    },
                    fillColor: AppTheme.itemBgColor,
                    number:
                        state.properties == null ? 0 : state.properties!.length,
                  );
                },
              ),
              BlocBuilder<PropertyBloc, PropertyState>(
                builder: (context, state) {
                  if (state.status == PropertyStatus.initial) {
                    context.read<PropertyBloc>().add(LoadPropertiesEvent());
                  }
                  if (state.status == PropertyStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == PropertyStatus.success ) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.properties!.length,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          var property = state.properties![index];
                          // var availablePercentage= ((propertyModel.propertyUnitModel!.available! / propertyModel.propertyUnitModel!.totalUnits!.toInt()) * 100).ceil();
                          // var occupiedPercentage= ((propertyModel.propertyUnitModel!.occupied! / propertyModel.propertyUnitModel!.totalUnits!.toInt()) * 100).ceil();

                          // // Sample numbers
                          // double available = property.propertyUnitModel!.available!.toDouble();
                          // double occupied = property.propertyUnitModel!.occupied!.toDouble();
                          // double revenue = property.propertyUnitModel!.revenue!.toDouble();
                          //
                          // // Calculate percentage
                          // double availablePercentage = (available / revenue) * 100;
                          // double occupiedPercentage = (occupied / revenue) * 100;
                          //
                          // // Round off to two decimal places
                          // double roundedAvailable = double.parse(availablePercentage.toStringAsFixed(2));
                          // double roundedOccupied = double.parse(occupiedPercentage.toStringAsFixed(2));
                          //
                          // // Print the result
                          // print('The result as a percentage: $roundedAvailable%');
                          // print('The result as a percentage: $roundedOccupied%');

                          return Bounceable(
                              onTap: () {
                                Get.to(() =>
                                    PropertyDetailsPage(id: property.id!));
                              },
                              child: SlideInUp(
                                  child: PropertyListCardWidget(
                                      propertyModel: property, index: index)));
                        });
                  }
                  if (state.status == PropertyStatus.empty) {
                    return const Center(
                      child: Text('No Properties'),
                    );
                  }
                  if (state.status == PropertyStatus.error) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddPropertyBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        extendBody: false,
        maxWidth: 90.h,
        duration: Duration(microseconds: 1),
        minHeight: 90.h,
        elevation: 8,
        cornerRadius: 15.sp,
        snapSpec: const SnapSpec(
          snap: false,
          snappings: [0.9],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, setState) {
          return BlocProvider<PropertyBloc>(
            create: (context) => PropertyBloc(),
            child: Material(
              elevation: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 7.5.h,
                decoration: BoxDecoration(boxShadow: []),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Bounceable(
                          onTap: () {
                            titleController.clear();
                            addressController.clear();
                            descriptionController.clear();
                            locationController.clear();
                            sqmController.clear();
                            propertyPic = File('');
                            selectedPropertyTypeId = 0;
                            selectedPropertyCategoryId = 0;
                            print('Pic = ${propertyPic!.path}');

                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17.5.sp,
                            ),
                          )),
                      Text(
                        'Add Property',
                        style: AppTheme.darkBlueTitle2,
                      ),
                      BlocListener<PropertyBloc, PropertyState>(
                        listener: (context, state) {
                          if (state.status == PropertyStatus.successAdd) {
                            Fluttertoast.showToast(
                                msg: 'Property Added Successfully',
                                backgroundColor: Colors.green,
                                gravity: ToastGravity.TOP);
                            titleController.clear();
                            locationController.clear();
                            descriptionController.clear();
                            sqmController.clear();
                            selectedPropertyTypeId = 0;
                            selectedPropertyCategoryId = 0;
                            propertyPic = File('');
                            print('Pic = ${propertyPic!.path}');
                            Navigator.pop(context);

                          }
                          if (state.status == PropertyStatus.accessDeniedAdd) {
                            Fluttertoast.showToast(
                                msg: state.message.toString(),
                                gravity: ToastGravity.TOP);
                          } if (state.status == PropertyStatus.errorAdd) {
                            Fluttertoast.showToast(
                                msg: state.message.toString(),
                                gravity: ToastGravity.TOP);
                          }
                        },
                        child: BlocBuilder<PropertyBloc, PropertyState>(
                          builder: (context, state) {
                            if (state.isPropertyLoading == true) {
                              return AppLoader();
                            }
                            return Bounceable(
                                onTap: () async {
                                  if (titleController.text.isEmpty ||
                                          locationController.text.isEmpty ||
                                          sqmController.text.isEmpty
                                      // propertyPic == null
                                      ) {
                                    Fluttertoast.showToast(
                                        msg: 'fill in all fields',
                                        gravity: ToastGravity.TOP);
                                  } else if (selectedPropertyTypeId == 0) {
                                    Fluttertoast.showToast(
                                        msg: 'select property type id',
                                        gravity: ToastGravity.TOP);
                                  } else if (selectedPropertyCategoryId == 0) {
                                    Fluttertoast.showToast(
                                        msg: 'select property category id',
                                        gravity: ToastGravity.TOP);
                                  } else {
                                    context
                                        .read<PropertyBloc>()
                                        .add(AddPropertyEvent(
                                          userStorage
                                              .read('accessToken')
                                              .toString(),
                                          titleController.text
                                              .trim()
                                              .toString(),
                                          locationController.text
                                              .trim()
                                              .toString(),
                                          sqmController.text.trim().toString(),
                                          descriptionController.text
                                              .trim()
                                              .toString(),
                                          selectedPropertyTypeId,
                                          selectedPropertyCategoryId,
                                        ));
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 17.5.sp,
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
                selectedPropertyTypeId = 0;
                selectedPropertyCategoryId = 0;
                propertyPic = File('');
                print('Pic = ${propertyPic!.path}');
                return true;
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<PropertyCategoryBloc>(
                      create: (_) => PropertyCategoryBloc()
                        ..add(LoadAllPropertyCategoriesEvent())),
                  BlocProvider<PropertyTypeBloc>(
                      create: (_) =>
                          PropertyTypeBloc()..add(LoadAllPropertyTypesEvent())),
                ],
                child: Material(
                  color: AppTheme.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AuthTextField(
                                controller: titleController,
                                hintText: 'Property title',
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 42.5.w,
                                    child: BlocBuilder<PropertyTypeBloc,
                                        PropertyTypeState>(
                                      builder: (context, state) {
                                        return CustomApiGenericDropdown<
                                            SmartModel>(
                                          hintText: 'Type',
                                          menuItems: state.propertyTypes == null
                                              ? []
                                              : state.propertyTypes!,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedPropertyTypeId =
                                                  value!.getId();
                                            });
                                            print(value!.getId());
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 42.5.w,
                                    child: BlocBuilder<PropertyCategoryBloc,
                                        PropertyCategoryState>(
                                      builder: (context, state) {
                                        return CustomApiGenericDropdown<
                                            SmartModel>(
                                          hintText: 'Category',
                                          menuItems:
                                              state.propertyCategories == null
                                                  ? []
                                                  : state.propertyCategories!,
                                          onChanged: (value) {
                                            print(value!.getId());
                                            setState(() {
                                              selectedPropertyCategoryId =
                                                  value.getId();
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 1.h,
                              ),
                              AppMaxTextField(
                                controller: descriptionController,
                                hintText: 'Description',
                                obscureText: false,
                                fillColor: AppTheme.appWidgetColor,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
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
                                        propertyImageExtension = value
                                            .file.first!.path
                                            .split('.')
                                            .last;
                                        propertyFileName = value
                                            .file.first!.path
                                            .split('/')
                                            .last;
                                      });
                                      propertyBytes =
                                          await propertyPic!.readAsBytes();
                                      print('MY PIC == $propertyPic');
                                      print('MY path == $propertyImagePath');
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
                                      color: AppTheme.appWidgetColor,
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                      image: DecorationImage(
                                          image: FileImage(
                                              propertyPic ?? File('')),
                                          fit: BoxFit.cover)),
                                  child: propertyPic == null ||
                                          propertyPic!.path.isEmpty
                                      ? Center(
                                          child: Text('Upload Property Pic'),
                                        )
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
              ),
            );
          });
        },
      );
    });

    print(result); // This is the result.
  }

// void showAddPropertyBottomSheet(BuildContext context) async {
//   final result = await showSlidingBottomSheet(
//       context,
//       builder: (context) {
//         return SlidingSheetDialog(
//           extendBody: false,
//           maxWidth: 90.h,
//           duration: Duration(microseconds: 1),
//           minHeight: 90.h,
//           elevation: 8,
//           cornerRadius: 15.sp,
//           snapSpec: const SnapSpec(
//             snap: false,
//             snappings: [ 0.9],
//             positioning: SnapPositioning.relativeToAvailableSpace,
//           ),
//           headerBuilder: (context, state) {
//             return Material(
//               elevation: 1,
//               child: Container(
//                 width: MediaQuery
//                     .of(context)
//                     .size
//                     .width,
//                 height: 7.5.h,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                     ]
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 5.w, vertical: 2.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment
//                         .spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment
//                         .center,
//                     children: [
//
//                       Bounceable(
//                           onTap: () {
//                             titleController.clear();
//                             addressController.clear();
//                             descriptionController
//                                 .clear();
//                             locationController.clear();
//                             sqmController.clear();
//                             propertyPic = File('');
//                             print('Pic = ${propertyPic!.path}');
//
//                             Get.back();
//                           },
//                           child: Text(
//                             'Cancel', style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 17.5.sp,
//                           ),)),
//
//                       Text('Add Property', style: AppTheme
//                           .darkBlueTitle2,),
//
//                       Bounceable(
//                           onTap: () async {
//                             if (
//                             titleController.text.isEmpty ||
//                                 locationController.text.isEmpty ||
//                                 sqmController.text.isEmpty ||
//                                 propertyPic == null
//                             ) {
//                               Fluttertoast.showToast(
//                                   msg: 'fill in all fields',
//                                   gravity: ToastGravity.TOP);
//                             } else {
//
//                             }
//                           },
//                           child: Text('Add', style: TextStyle(
//                             color: AppTheme.primaryColor,
//                             fontSize: 17.5.sp,
//                           ),)),
//                     ],
//
//                   ),
//                 ),
//               ),
//             );
//           },
//           builder: (context, state) {
//             return StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//                   return WillPopScope(
//                     onWillPop: () async {
//                       titleController.clear();
//                       addressController.clear();
//                       descriptionController.clear();
//                       locationController.clear();
//                       sqmController.clear();
//                       propertyPic = File('');
//                       print('Pic = ${propertyPic!.path}');
//                       return true;
//                     },
//                     child: Material(
//                       color: AppTheme.whiteColor,
//                       child: Column(
//                         children: [
//
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 5.w,
//                                 vertical: 1.h),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   AuthTextField(
//                                     controller: titleController,
//                                     hintText: 'Property title',
//                                     obscureText: false,
//                                   ),
//
//                                   SizedBox(height: 1.h,),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment
//                                         .spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .center,
//                                     children: [
//
//                                       SizedBox(
//                                         width: 42.5.w,
//                                         child: CustomApiGenericDropdown<
//                                             PropertyTypeModel>(
//                                           hintText: 'Type',
//                                           menuItems: [],
//                                           onChanged: (value) {
//                                             print(value);
//                                           },
//                                         ),
//                                       ),
//
//                                       SizedBox(
//                                         width: 42.5.w,
//                                         child: CustomApiGenericDropdown<
//                                             PropertyCategoryModel>(
//                                           hintText: 'Category',
//                                           menuItems: [],
//                                           onChanged: (value) {
//                                             print(value!.id);
//                                           },
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 1.h,),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment
//                                         .spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 42.5.w,
//                                         child: AuthTextField(
//                                           controller: locationController,
//                                           hintText: 'Location',
//                                           obscureText: false,
//                                         ),
//                                       ),
//
//                                       SizedBox(
//                                         width: 42.5.w,
//                                         child: AuthTextField(
//                                           controller: sqmController,
//                                           hintText: 'sqm',
//                                           obscureText: false,
//                                         ),
//                                       ),
//
//
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 1.h,),
//
//                                   AppMaxTextField(
//                                     controller: descriptionController,
//                                     hintText: 'Description',
//                                     obscureText: false,
//                                     fillColor: AppTheme.appWidgetColor,
//                                   ),
//
//
//                                   SizedBox(height: 1.h,),
//
//                                   Bounceable(
//                                     onTap: () {
//                                       FullPicker(
//                                         prefixName: 'add property',
//                                         context: context,
//                                         image: true,
//                                         imageCamera: kDebugMode,
//                                         imageCropper: true,
//                                         onError: (int value) {
//                                           print(" ----  onError ----=$value");
//                                         },
//                                         onSelected: (value) async {
//                                           print(" ----  onSelected ----");
//
//                                           setState(() {
//                                             propertyPic = value.file.first;
//                                             propertyImagePath =
//                                                 value.file.first!.path;
//                                             propertyImageExtension =
//                                                 value.file.first!
//                                                     .path
//                                                     .split('.')
//                                                     .last;
//                                             propertyFileName =
//                                                 value.file.first!
//                                                     .path
//                                                     .split('/')
//                                                     .last;
//                                           });
//                                           propertyBytes =
//                                           await propertyPic!.readAsBytes();
//                                           print('MY PIC == $propertyPic');
//                                           print(
//                                               'MY path == $propertyImagePath');
//                                           print('MY bytes == $propertyBytes');
//                                           print(
//                                               'MY extension == $propertyImageExtension');
//                                           print(
//                                               'MY FILE NAME == $propertyFileName');
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       width: 50.w,
//                                       height: 30.h,
//                                       decoration: BoxDecoration(
//                                           color: AppTheme.appWidgetColor,
//                                           borderRadius: BorderRadius.circular(
//                                               15.sp),
//                                           image: DecorationImage(
//                                               image: FileImage(
//                                                   propertyPic ?? File('')),
//                                               fit: BoxFit.cover)
//                                       ),
//                                       child: propertyPic == null ||
//                                           propertyPic!.path.isEmpty
//                                           ? Center(
//                                         child: Text('Upload profile pic'),)
//                                           : null,
//                                     ),
//                                   ),
//
//
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           },
//         );
//       }
//   );
//
//   print(result); // This is the result.
// }
}
