import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/data_source/models/currency/currency_model.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/models/period/period_model.dart';
import 'package:smart_rent/data_source/models/unit/unit_type_model.dart';
import 'package:smart_rent/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/pages/unit/bloc/unit_bloc.dart';
import 'package:smart_rent/pages/unit/widgets/unit_card_widget.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class UnitTabScreenLayout extends StatefulWidget {
  final UnitController unitController;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  final int id;

  const UnitTabScreenLayout({
    super.key,
    required this.propertyDetailsOptionsController,
    required this.unitController,
    required this.id,
  });

  @override
  State<UnitTabScreenLayout> createState() => _UnitTabScreenLayoutState();
}

class _UnitTabScreenLayoutState extends State<UnitTabScreenLayout> {
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
        headerBuilder: (context, state) {
          return BlocProvider<UnitBloc>(
            create: (context) => UnitBloc(),
            child: Material(
              elevation: 1,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                            selectedFloorId == 0;
                            selectedCurrency == 0;
                            selectedUnitTypeId == 0;
                            selectedDurationId == 0;
                            sizeController.clear();
                            roomNumberController.clear();
                            amountController.clear();
                            descriptionController.clear();
                            roomNameController.clear();
                            unitNumberController.clear();
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
                        'Add Unit',
                        style: AppTheme.darkBlueTitle2,
                      ),
                      BlocListener<UnitBloc, UnitState>(
                        listener: (context, state) {
                          if (state.status == UnitStatus.successAdd) {
                            Fluttertoast.showToast(
                                msg: 'Unit Added Successfully',
                                backgroundColor: Colors.green,
                                gravity: ToastGravity.TOP);
                            selectedFloorId == 0;
                            selectedCurrency == 0;
                            selectedUnitTypeId == 0;
                            selectedDurationId == 0;
                            sizeController.clear();
                            roomNumberController.clear();
                            amountController.clear();
                            descriptionController.clear();
                            roomNameController.clear();
                            unitNumberController.clear();
                            Navigator.pop(context);
                          }
                          if (state.status == UnitStatus.accessDeniedAdd) {
                            Fluttertoast.showToast(
                                msg: state.message.toString(),
                                gravity: ToastGravity.TOP);
                          }
                          if (state.status == UnitStatus.errorAdd) {
                            Fluttertoast.showToast(
                                msg: state.message.toString(),
                                gravity: ToastGravity.TOP);
                          }
                        },
                        child: BlocBuilder<UnitBloc, UnitState>(
                          builder: (context, state) {
                            if (state.isLoading == true) {
                              return AppLoader(color: AppTheme.primaryColor,);
                            }
                            return Bounceable(
                                onTap: () async {
                                  print('MY Amount = ${int.parse(amountController.text.trim().toString().replaceAll(',', ''))}');
                                  context.read<UnitBloc>().add(AddUnitEvent(
                                    userStorage.read('accessToken').toString(),
                                      selectedUnitTypeId,
                                      selectedFloorId,
                                      roomNameController.text.trim().toString(),
                                      sizeController.text.trim().toString(),
                                      selectedDurationId,
                                      selectedCurrency,
                                      int.parse(amountController.text.trim().toString().replaceAll(',', '')),
                                      descriptionController.text.trim().toString(),
                                      widget.id,
                                  ));

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
          return MultiBlocProvider(
            providers: [
              BlocProvider<UnitBloc>(
                create: (context) => UnitBloc(),
              ),
              BlocProvider<FloorBloc>(
                create: (context) => FloorBloc(),
              ),
              BlocProvider<CurrencyBloc>(
                create: (context) => CurrencyBloc(),
              ),
              BlocProvider<PeriodBloc>(
                create: (context) => PeriodBloc(),
              ),
            ],
            child: Material(
              color: AppTheme.appBgColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 42.5.w,
                                child: BlocBuilder<UnitBloc, UnitState>(
                                  builder: (context, state) {
                                    if (state.status == UnitStatus.initial) {
                                      context
                                          .read<UnitBloc>()
                                          .add(LoadUnitTypesEvent());
                                    }
                                    return CustomApiGenericDropdown<
                                        UnitTypeModel>(
                                      hintText: 'Unit Type',
                                      menuItems: state.unitTypes == null
                                          ? []
                                          : state.unitTypes!,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedUnitTypeId = value!.id!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 42.5.w,
                                child: BlocBuilder<FloorBloc, FloorState>(
                                  builder: (context, state) {
                                    if (state.status == FloorStatus.initial) {
                                      context
                                          .read<FloorBloc>()
                                          .add(LoadAllFloorsEvent(widget.id));
                                    }
                                    return CustomApiGenericDropdown<FloorModel>(
                                      hintText: 'Floor',
                                      menuItems: state.floors == null
                                          ? []
                                          : state.floors!,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedFloorId = value!.id!;
                                        });
                                        print('My floor ${selectedFloorId}');
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: AuthTextField(
                                  controller: roomNameController,
                                  hintText: 'Unit Name',
                                  obscureText: false,
                                  keyBoardType: TextInputType.name,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16)
                                  ],
                                ),
                                width: 42.5.w,
                              ),
                              SizedBox(
                                child: AuthTextField(
                                  controller: roomNumberController,
                                  hintText: 'Unit Name/Number',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                ),
                                width: 42.5.w,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          AuthTextField(
                            controller: sizeController,
                            hintText: 'Square Meters',
                            obscureText: false,
                            keyBoardType: TextInputType.number,
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

                          SizedBox(
                            height: 1.h,
                          ),

                          BlocBuilder<PeriodBloc, PeriodState>(
                            builder: (context, state) {
                              if (state.status == PeriodStatus.initial) {
                                context
                                    .read<PeriodBloc>()
                                    .add(LoadAllPeriodsEvent());
                              }
                              return CustomApiGenericDropdown<PeriodModel>(
                                hintText: 'Period',
                                menuItems:
                                state.periods == null ? [] : state.periods!,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDurationId = value!.id!;
                                  });
                                },
                              );
                            },
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

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

                          BlocBuilder<CurrencyBloc, CurrencyState>(
                            builder: (context, state) {
                              if (state.status == CurrencyStatus.initial) {
                                context
                                    .read<CurrencyBloc>()
                                    .add(LoadAllCurrenciesEvent());
                              }
                              return CustomApiGenericDropdown<CurrencyModel>(
                                hintText: 'Currency',
                                menuItems: state.currencies == null
                                    ? []
                                    : state.currencies!,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCurrency = value!.id!;
                                  });
                                },
                              );
                            },
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          AuthTextField(
                            controller: amountController,
                            hintText: 'Amount',
                            obscureText: false,
                            keyBoardType: TextInputType.number,
                            inputFormatters: [
                              ThousandsFormatter(),
                            ],
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          AppMaxTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            fillColor: AppTheme.itemBgColor,
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

                          SizedBox(
                            height: 1.h,
                          ),

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
            ),
          );
        },
      );
    });

    print(result); // This is the result.
  }

  int selectedUnitTypeId = 0;
  int selectedFloorId = 0;
  int selectedDurationId = 0;
  int selectedCurrency = 0;

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
    return WillPopScope(
      onWillPop: () async {
        widget.unitController.floorId.value == 0;
        widget.unitController.currencyId.value == 0;
        widget.unitController.unitTypeId.value == 0;
        widget.unitController.paymentScheduleId.value == 0;
        sizeController.clear();
        roomNumberController.clear();
        amountController.clear();
        descriptionController.clear();
        roomNameController.clear();
        unitNumberController.clear();

        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UnitBloc>(
            create: (context) => UnitBloc(),
          ),
        ],
        child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
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

                  Align(
                      alignment: Alignment.centerRight,
                      child: Bounceable(
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
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
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

              BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  if (state.status == UnitStatus.initial) {
                    context
                        .read<UnitBloc>()
                        .add(LoadAllUnitsEvent(widget.id));
                  }
                  if (state.status == UnitStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == UnitStatus.success) {
                    return Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.units!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var roomModel = state.units![index];
                            return UnitCardWidget(
                              roomModel: roomModel,
                              index: index,
                              propertyDetailsOptionsController:
                              widget.propertyDetailsOptionsController,
                              unitController: widget.unitController,
                            );
                          }),
                    );
                  }
                  if (state.status == UnitStatus.empty) {
                    return const Center(
                      child: Text('No Units'),
                    );
                  }
                  if (state.status == UnitStatus.error) {
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
}
