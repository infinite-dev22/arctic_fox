import 'dart:convert';
import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/screens/tenant/tenant_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/custom_accordion.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class TenantTabScreen extends StatefulWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const TenantTabScreen(
      {super.key, required this.propertyDetailsOptionsController});

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
  late TextEditingController date1Controller;
  final TextEditingController date2Controller = TextEditingController();

  final TextEditingController dailyController = TextEditingController();
  final TextEditingController weeklyController = TextEditingController();
  final TextEditingController monthlyController = TextEditingController();
  final TextEditingController yearlyController = TextEditingController();
  final TextEditingController lumpSumController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());

  final TenantController tenantController = Get.put(TenantController());
  final _formKey = GlobalKey<FormState>();

  late SingleValueDropDownController _cnt;

  Future<void> _selectDate1(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate1.value,
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2101),
    // );

    final DateTime? picked = await showDatePickerDialog(
        context: context,
        initialDate: selectedDate1.value,
        minDate: DateTime(2000),
        maxDate: DateTime(2101),
    );

    if (picked != null) {
      selectedDate1(picked);
      date1Controller.text =
          '${DateFormat('MM/dd/yyyy').format(selectedDate1.value)}';
      // date2Controller.text =
      //     '${DateFormat('E, d MMM yyyy').format(selectedDate1.value.add(Duration(days: 30)))}';

      if(tenantController.paymentScheduleId.value == 1) {

        var myDays = int.parse(dailyController.text) * 1;

        if(dailyController.text.toString() == '0'){
          Fluttertoast.showToast(msg: 'Enter Right Day');
        } else {
          print('MY myDays are == ${dailyController.text.toString()}');
          print('Count myDays ' + myDays.toString());
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
        }


      } else if(tenantController.paymentScheduleId.value ==2) {
        var myWeeks = int.parse(weeklyController.text) * 7;

        if(weeklyController.text.toString() == '0'){
          Fluttertoast.showToast(msg: 'Enter Right week');
        } else {
          print('MY WEEKs are == ${weeklyController.text.toString()}');
          print('Count Weeks ' + myWeeks.toString());
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
        }


      } else if(tenantController.paymentScheduleId.value ==3) {

        var myMonths = int.parse(monthlyController.text) * 1;

        if(monthlyController.text.toString() == '0'){
          Fluttertoast.showToast(msg: 'Enter Right Month');
        } else {
          print('MY myMonths are == ${monthlyController.text.toString()}');
          print('Count myMonths ' + myMonths.toString());
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
        }

      } else if(tenantController.paymentScheduleId.value ==4) {

        var myYears = int.parse(yearlyController.text) * 1;

        if(yearlyController.text.toString() == '0'){
          Fluttertoast.showToast(msg: 'Enter Right years');
        } else {
          print('MY myYears are == ${yearlyController.text.toString()}');
          print('Count myYears ' + myYears.toString());
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
        }


      } else {

        // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';

      }



    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate1.value) {
      selectedDate2(picked);
      date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(selectedDate2.value)}';
    }
  }

  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        minHeight: 90.h,
        elevation: 8,
        cornerRadius: 15.sp,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Material(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Bounceable(
                          onTap: (){
                            Get.back();
                          },
                            child: Text('Cancel', style: TextStyle(
                              color: Colors.red,
                            ),)),

                          Text(
                            'Fill In Tenant Fileds',
                            style: AppTheme.darkBlueText1,
                          ),

                        Bounceable(
                          onTap: ()async{
                            if (_formKey.currentState!.validate()) {
                              tenantController.addTenantToUnit(
                                tenantController.tenantId.value,
                                "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                                tenantController.unitId.value,
                                selectedDate1.value.toString(),
                                date2Controller.text.trim().toString(),
                                int.parse(amountController.text.toString()),
                                int.parse(discountController.text.toString()),
                              );
                            } else {}
                          },
                            child: Text('Add', style: TextStyle(
                              color: AppTheme.primaryColor
                            ),)),
                        ],
                      ),

                      SizedBox(
                        height: 1.h,
                      ),
                      //
                      // Obx(() {
                      //   return CustomApiGenericTenantModelDropdown(
                      //     hintText: 'Select Tenant',
                      //     menuItems: tenantController.tenantList.value,
                      //     onChanged: (value) {
                      //       tenantController.setTenantId(value!.id);
                      //     },
                      //   );
                      // }),

                      Obx(() {
                        return SearchableTenantDropDown<TenantModel>(
                          hintText: 'Tenant',
                          menuItems: tenantController.tenantList.value,
                          controller: _cnt,
                              onChanged: (value) {
                            print(value);
                                // tenantController.setTenantId(value!.id);
                              },
                        );
                      }),

                      Obx(() {
                        return CustomApiUnitDropdown(
                          hintText: 'Unit',
                          menuItems: tenantController.unitList.value,
                          onChanged: (value) {
                            tenantController.setUnitId(value!.id);
                          },
                        );
                      }),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox(
                            width: 42.5.w,
                            child: Obx(() {
                              return CustomPeriodApiGenericDropdown<PaymentScheduleModel>(
                                hintText: 'Per Month',
                                menuItems: tenantController.paymentList.value,
                                onChanged: (value) {
                                  tenantController.setPaymentScheduleId(value!.id);


                                  if(tenantController.paymentScheduleId.value == 1) {

                                    var myDays = int.parse(dailyController.text) * 1;

                                    if(dailyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right Day');
                                    } else {
                                      print('MY myDays are == ${dailyController.text.toString()}');
                                      print('Count myDays ' + myDays.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
                                    }


                                  } else if(tenantController.paymentScheduleId.value ==2) {
                                    var myWeeks = int.parse(weeklyController.text) * 7;

                                    if(weeklyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right week');
                                    } else {
                                      print('MY WEEKs are == ${weeklyController.text.toString()}');
                                      print('Count Weeks ' + myWeeks.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
                                    }


                                  } else if(tenantController.paymentScheduleId.value ==3) {

                                    var myMonths = int.parse(monthlyController.text) * 1;

                                    if(monthlyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right Month');
                                    } else {
                                      print('MY myMonths are == ${monthlyController.text.toString()}');
                                      print('Count myMonths ' + myMonths.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
                                    }

                                  } else if(tenantController.paymentScheduleId.value ==4) {

                                    var myYears = int.parse(yearlyController.text) * 1;

                                    if(yearlyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right years');
                                    } else {
                                      print('MY myYears are == ${yearlyController.text.toString()}');
                                      print('Count myYears ' + myYears.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
                                    }


                                  } else {

                                    // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';

                                  }

                                },
                              );
                            }),
                          ),

                          tenantController
                              .paymentScheduleId
                              .value ==
                              10
                              ? SizedBox(
                            child: Obx(() {
                              return AppTextField(
                                controller:  tenantController
                                    .paymentScheduleId
                                    .value ==
                                    10
                                    ? lumpSumController
                                    : TextEditingController(
                                    text: null),
                                hintText: 'Enter LumpSum',
                                obscureText: false,
                              );
                            }),
                            width: 42.5.w,
                          ) : Container(),

                          SizedBox(
                            child: Obx(() {
                              return AppTextField(
                                controller: tenantController
                                            .paymentScheduleId.value ==
                                        1
                                    ? dailyController
                                    : tenantController
                                                .paymentScheduleId.value ==
                                            2
                                        ? weeklyController
                                        : tenantController
                                                    .paymentScheduleId.value ==
                                                3
                                            ? monthlyController
                                            : tenantController.paymentScheduleId
                                                        .value ==
                                                    4
                                                ? yearlyController
                                               : TextEditingController(
                                                        text: null),
                                hintText: tenantController
                                            .paymentScheduleId.value ==
                                        1
                                    ? 'Enter No. Of Days'
                                    : tenantController
                                                .paymentScheduleId.value ==
                                            2
                                        ? 'Enter No. Of Weeks'
                                        : tenantController
                                                    .paymentScheduleId.value ==
                                                3
                                            ? 'Enter No. Of Months'
                                           : tenantController
                                                            .paymentScheduleId
                                                            .value ==
                                                        4
                                                    ? 'Enter No. Of Years'
                                                    : 'Specific Period',
                                obscureText: false,
                                onChanged: (value){

                                  if(tenantController.paymentScheduleId.value == 1) {

                                    var myDays = int.parse(dailyController.text) * 1;

                                    if(dailyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right Day');
                                    } else {
                                      print('MY myDays are == ${dailyController.text.toString()}');
                                      print('Count myDays ' + myDays.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
                                    }


                                  } else if(tenantController.paymentScheduleId.value ==2) {
                                    var myWeeks = int.parse(weeklyController.text) * 7;

                                    if(weeklyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right week');
                                    } else {
                                      print('MY WEEKs are == ${weeklyController.text.toString()}');
                                      print('Count Weeks ' + myWeeks.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
                                    }


                                  } else if(tenantController.paymentScheduleId.value ==3) {

                                    var myMonths = int.parse(monthlyController.text) * 1;

                                    if(monthlyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right Month');
                                    } else {
                                      print('MY myMonths are == ${monthlyController.text.toString()}');
                                      print('Count myMonths ' + myMonths.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
                                    }

                                  } else if(tenantController.paymentScheduleId.value ==4) {

                                    var myYears = int.parse(yearlyController.text) * 1;

                                    if(yearlyController.text.toString() == '0'){
                                      Fluttertoast.showToast(msg: 'Enter Right years');
                                    } else {
                                      print('MY myYears are == ${yearlyController.text.toString()}');
                                      print('Count myYears ' + myYears.toString());
                                      date2Controller.text =
                                      '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
                                    }


                                  } else {

                                    // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';

                                  }

                                },
                              );
                            }),
                            width: 42.5.w,
                          ),
                        ],
                      ),

                      AppTextField(
                        title: 'From',
                        onTap: () {
                          _selectDate1(context);
                        },
                        controller: date1Controller,
                        hintText: "From",
                        obscureText: false,
                      ),
                      AppTextField(
                        title: 'To',
                        onTap: () {
                          _selectDate2(context);
                        },
                        controller: date2Controller,

                        hintText: "To",
                        obscureText: false,
                        enabled: false,
                      ),

                      SizedBox(
                        height: 1.h,
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

                      SizedBox(
                        height: 2.h,
                      ),

                      // AppButton(
                      //   title: 'Add Tenant',
                      //   color: AppTheme.primaryColor,
                      //   function: () {
                      //     if (_formKey.currentState!.validate()) {
                      //       tenantController.addTenantToUnit(
                      //         tenantController.tenantId.value,
                      //         "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                      //         tenantController.unitId.value,
                      //         selectedDate1.value.toString(),
                      //         date2Controller.text.trim().toString(),
                      //         int.parse(amountController.text.toString()),
                      //         int.parse(discountController.text.toString()),
                      //       );
                      //     } else {}
                      //   },
                      // ),

                      // DateAccordion(dateController: date1Controller),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

    print(result); // This is the result.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = File('');
    _cnt = SingleValueDropDownController();
    date1Controller  = TextEditingController(text: '${DateFormat('MM/dd/yyyy').format(selectedDate1.value)}');

    if(tenantController.paymentScheduleId.value == 1) {

      var myDays = int.parse(dailyController.text) * 1;

      if(dailyController.text.toString() == '0'){
        Fluttertoast.showToast(msg: 'Enter Right Day');
      } else {
        print('MY myDays are == ${dailyController.text.toString()}');
        print('Count myDays ' + myDays.toString());
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myDays))}';
      }


    } else if(tenantController.paymentScheduleId.value ==2) {
      int myWeeks = int.parse(weeklyController.text) * 7;

      if(weeklyController.text.toString() == '0'){
        Fluttertoast.showToast(msg: 'Enter Right week');
      } else {
        print('MY WEEKs are == ${weeklyController.text.toString()}');
        print('Count Weeks ' + myWeeks.toString());
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day + myWeeks))}';
      }


    } else if(tenantController.paymentScheduleId.value ==3) {

      var myMonths = int.parse(monthlyController.text) * 1;

      if(monthlyController.text.toString() == '0'){
        Fluttertoast.showToast(msg: 'Enter Right Month');
      } else {
        print('MY myMonths are == ${monthlyController.text.toString()}');
        print('Count myMonths ' + myMonths.toString());
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month + myMonths, selectedDate1.value.day))}';
      }

    } else if(tenantController.paymentScheduleId.value ==4) {

      var myYears = int.parse(yearlyController.text) * 1;

      if(yearlyController.text.toString() == '0'){
        Fluttertoast.showToast(msg: 'Enter Right years');
      } else {
        print('MY myYears are == ${yearlyController.text.toString()}');
        print('Count myYears ' + myYears.toString());
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year + myYears, selectedDate1.value.month, selectedDate1.value.day))}';
      }


    } else {

      date2Controller.text = '${DateFormat('MM/dd/yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day+1))}';

    }


    // if(tenantController.paymentScheduleId.value == 1) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day+1))}';
    //
    //
    // } else if(tenantController.paymentScheduleId.value ==2) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day+7))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==3) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month+1, selectedDate1.value.day))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==4) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day+14))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==5) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month+2, selectedDate1.value.day))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==6) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month+3, selectedDate1.value.day+14))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==7) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month+6, selectedDate1.value.day))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==8) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month+9, selectedDate1.value.day))}';
    //
    // } else if(tenantController.paymentScheduleId.value ==9) {
    //   date2Controller.text =
    //   '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year+1, selectedDate1.value.month, selectedDate1.value.day))}';
    //
    // }  else {
    //
    //   date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
    //
    // }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
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
                    function: () {
                      showAsBottomSheet(context);
                    }),
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listSample.length,
              itemBuilder: (context, index) {
                var list = listSample[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(() => TenantDetailsScreen(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Image.asset(
                          'assets/avatar/rian.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        list['first'].toString() +
                            ' ' +
                            list['last'].toString(),
                        style: AppTheme.appTitle3,
                      ),
                      subtitle: Text(
                        '${amountFormatter.format(list['amount'].toString())}/=',
                        style: AppTheme.greenTitle2,
                      ),
                      trailing: Text(
                        'Unit $index',
                        style: AppTheme.subText,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
