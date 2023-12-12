import 'dart:convert';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/payment_card_widget.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class PaymentTabScreen extends StatefulWidget {
  final UnitController unitController;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const PaymentTabScreen(
      {super.key, required this.propertyDetailsOptionsController, required this.unitController});

  @override
  State<PaymentTabScreen> createState() => _PaymentTabScreenState();
}

class _PaymentTabScreenState extends State<PaymentTabScreen> {

  final listSample = [
    {'tenant': 'vincent west', 'unit': '4', 'amount': 50000, 'period': 'month'},
    {
      'tenant': 'jonathan mark',
      'unit': '25',
      'amount': 130000,
      'period': 'weeks'
    },
    {
      'tenant': 'ryan jupiter',
      'unit': '61',
      'amount': 250000,
      'period': 'years'
    },

  ];

  final TenantController tenantController = Get.put(TenantController());

  final TextEditingController paidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();

  final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate3 = Rx<DateTime>(DateTime.now());

  final TextEditingController searchController = TextEditingController();

  late SingleValueDropDownController tenantDropdownCont;


  final Rx<String> fitUnit = Rx<String>('');
  final Rx<int> fitValue = Rx<int>(0);


  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            extendBody: false,
            maxWidth: 90.h,
            color: AppTheme.whiteColor,
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
                color: AppTheme.whiteColor,
                // color: Colors.white,
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

                              Text('Add Payment', style: AppTheme
                                  .darkBlueTitle2,),

                              Bounceable(
                                  onTap: () async {
                                    await tenantController.addTenantPayment(
                                      tenantController.tenantId.value,
                                      tenantController.unitId.value,
                                      selectedDate1.value.toIso8601String(),
                                      selectedDate2.value.toIso8601String(),
                                      int.parse(amountController.text),
                                      int.parse(paidController.text),
                                      int.parse(balanceController.text),
                                      'f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5',
                                      'f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5',
                                    );

                                    // Get.back();

                                    // Get.back();
                                    // Get.snackbar('SUCCESS',
                                    //   'Payment added to your property',
                                    //   titleText: Text('SUCCESS',
                                    //     style: AppTheme.greenTitle1,),
                                    // );
                                  },
                                  child: Text('Add', style: TextStyle(
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Bounceable(
                              //               onTap: (){
                              //                 Get.back();
                              //               },
                              //               child: Text('Cancel', style: TextStyle(
                              //                 color: Colors.red,
                              //               ),)),
                              //
                              // Text('Fill In Payment Fileds', style: AppTheme.darkBlueText1,),
                              //           Bounceable(
                              //               onTap: ()async{
                              //                   Get.back();
                              //                   Get.snackbar('SUCCESS', 'Payment added to your property',
                              //                   titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                              //                 );
                              //               },
                              //               child: Text('Add', style: TextStyle(
                              //                   color: AppTheme.primaryColor
                              //               ),)),
                              //         ],
                              //       ),
                              SizedBox(height: 1.h,),


                              Obx(() {
                                return SearchableTenantDropDown<TenantModel>(
                                  hintText: 'Tenant',
                                  menuItems: tenantController.tenantList.value,
                                  controller: tenantDropdownCont,
                                  onChanged: (value) {
                                    print(value.value.id);
                                    tenantController.setTenantId(
                                        value.value.id);
                                    print(
                                        'MY TEnant is ${tenantController
                                            .tenantId
                                            .value}');
                                    tenantController.getTenantUnits(null).then((
                                        value) {
                                      amountController.text =
                                          tenantController.tenantUnitAmount
                                              .toString();
                                      print(
                                          'MY Amount Controller sis == ${tenantController
                                              .specificTenantUnits.value.first
                                              .amount}');
                                      date1Controller.text =
                                          tenantController.tenantUnitList.value
                                              .first.fromDate;
                                      date2Controller.text =
                                          tenantController.tenantUnitList.value
                                              .first.toDate;

                                      selectedDate1.value = DateTime.parse(
                                          tenantController.tenantUnitList.value
                                              .first.fromDate);
                                      selectedDate2.value = DateTime.parse(
                                          tenantController.tenantUnitList.value
                                              .first.toDate);

                                      print('DATE1 = ${date1Controller.text}');
                                      print('DATE2 = ${date2Controller.text}');

                                      print('RX DATE1 = ${selectedDate1}');
                                      print('RX DATE2 = ${selectedDate2}');

                                      // Define two DateTime objects representing the two dates
                                      // DateTime date1 = DateTime(2023, 1, 11);
                                      // DateTime date2 = DateTime(2024, 1, 11);

                                      // Calculate the duration between the two dates
                                      Duration difference = selectedDate2.value
                                          .difference(selectedDate1.value);
                                      // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));

                                      // Extract individual components (days, weeks, months, years) from the duration
                                      int daysDifference = difference.inDays;
                                      int weeksDifference = difference.inDays ~/
                                          7; // 7 days in a week
                                      int monthsDifference = difference
                                          .inDays ~/
                                          30; // Assuming an average of 30 days in a month
                                      int yearsDifference = difference.inDays ~/
                                          365; // Assuming an average of 365 days in a year

                                      // Determine the best fit unit
                                      String bestFitUnit;
                                      int bestFitValue;

                                      if (yearsDifference > 0) {
                                        bestFitValue = yearsDifference;
                                        bestFitUnit =
                                        bestFitValue == 1 ? 'year' : 'years';
                                        fitUnit.value = bestFitUnit;
                                        fitValue.value = bestFitValue;
                                      } else if (monthsDifference > 0) {
                                        bestFitValue = monthsDifference;
                                        bestFitUnit =
                                        bestFitValue == 1 ? 'month' : 'months';
                                        fitUnit.value = bestFitUnit;
                                        fitValue.value = bestFitValue;
                                      } else if (weeksDifference > 0) {
                                        bestFitValue = weeksDifference;
                                        bestFitUnit =
                                        bestFitValue == 1 ? 'week' : 'weeks';
                                        fitUnit.value = bestFitUnit;
                                        fitValue.value = bestFitValue;
                                      } else {
                                        bestFitValue = daysDifference;
                                        bestFitUnit =
                                        bestFitValue == 1 ? 'day' : 'days';
                                        fitUnit.value = bestFitUnit;
                                        fitValue.value = bestFitValue;
                                      }

                                      print(
                                          'Best fit difference: $fitValue $fitUnit');

                                      amountController.text =
                                          (int.parse(tenantController
                                              .specificTenantUnits.value.first
                                              .amount
                                              .toString()) * fitValue.value)
                                              .toString();

                                      print(amountController.text);
                                    });
                                  },
                                );
                              }),

                              Obx(() {
                                return CustomApiUnitDropdown(
                                  hintText: tenantController.unitNumber.value
                                      .isEmpty ? 'Unit' : tenantController
                                      .unitNumber.value,
                                  menuItems: tenantController
                                      .specificTenantUnits
                                      .value,
                                  onChanged: (value) {
                                    tenantController.setUnitId(value!.id);
                                    tenantController
                                        .setAmountForSpecificTenantUnit(value);
                                    amountController.text = (int.parse(
                                        tenantController.tenantUnitAmount
                                            .toString()) * fitValue.value)
                                        .toString();
                                  },

                                );
                              }),

                              // SizedBox(height: 1.h,),

                              Obx(() {
                                return tenantController.tenantUnitList.value
                                    .isEmpty ? Container() : DateTextField2(
                                  style: TextStyle(color: Colors.transparent),
                                  onTap: () {
                                    // _selectDate1(context);
                                  },
                                  controller: date1Controller,
                                  hintText: "From",
                                  obscureText: false,
                                  tenantController: tenantController,
                                );
                              }),

                              Obx(() {
                                return tenantController.tenantUnitList.value
                                    .isEmpty ? Container() : SizedBox(
                                  height: 1.h,);
                              }),

                              Obx(() {
                                return tenantController.tenantUnitList.value
                                    .isEmpty ? Container() : DateTextField2(
                                  style: TextStyle(color: Colors.transparent),
                                  onTap: () {
                                    // _selectDate2(context);
                                  },
                                  controller: date2Controller,

                                  hintText: "To",
                                  obscureText: false,
                                  enabled: false,
                                  tenantController: tenantController,
                                );
                              }),

                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              //
                              //
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     SizedBox(
                              //       width: 42.5.w,
                              //       child: CustomGenericDropdown<String>(
                              //         hintText: 'From',
                              //         menuItems: [],
                              //         onChanged: (value) {
                              //
                              //         },
                              //       ),
                              //     ),
                              //
                              //     SizedBox(
                              //       width: 42.5.w,
                              //       child: CustomGenericDropdown<String>(
                              //         hintText: 'To',
                              //         menuItems: [],
                              //         onChanged: (value) {
                              //
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Obx(() {
                                return tenantController.tenantUnitList.value
                                    .isEmpty ? Container() : SizedBox(
                                  height: 1.h,);
                              }),

                              Obx(() {
                                return AmountTextField(
                                  controller: amountController,
                                  hintText: 'Amount',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                  enabled: false,
                                  suffix: fitValue.value == 0
                                      ? ''
                                      : '$fitValue $fitUnit',
                                );
                              }),

                              SizedBox(height: 1.h,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  SizedBox(
                                    child: AuthTextField(
                                      controller: paidController,
                                      hintText: 'Paid',
                                      obscureText: false,
                                      keyBoardType: TextInputType.number,
                                      onChanged: (value) {
                                        var myPaid = int.parse(value);
                                        print(myPaid);
                                        balanceController.text =
                                            (int.parse(amountController.text) -
                                                myPaid)
                                                .toString();
                                        print('MY Balance == ${balanceController
                                            .text}');
                                      },
                                    ),
                                    width: 40.w,
                                  ),


                                  SizedBox(
                                    width: 40.w,
                                    child: AuthTextField(
                                      controller: balanceController,
                                      hintText: 'Balance',
                                      obscureText: false,
                                      keyBoardType: TextInputType.number,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),

                              // AuthTextField(
                              //   controller: paidController,
                              //   hintText: 'Paid',
                              //   obscureText: false,
                              //   keyBoardType: TextInputType.number,
                              //   onChanged: (value) {
                              //     var myPaid = int.parse(value);
                              //     print(myPaid);
                              //     balanceController.text =
                              //         (int.parse(amountController.text) - myPaid)
                              //             .toString();
                              //     print('MY Balance == ${balanceController}');
                              //   },
                              // ),
                              //
                              //
                              // SizedBox(height: 1.h,),
                              //
                              // AuthTextField(
                              //   controller: balanceController,
                              //   hintText: 'Balance',
                              //   obscureText: false,
                              //   keyBoardType: TextInputType.number,
                              //   enabled: false,
                              // ),


                              // SizedBox(height: 1.h,),
                              //
                              // AppButton(
                              //   title: 'Add Payment',
                              //   color: AppTheme.primaryColor,
                              //   function: () async {
                              //     //
                              //     // // Define two DateTime objects representing the two dates
                              //     // // DateTime date1 = DateTime(2023, 1, 11);
                              //     // // DateTime date2 = DateTime(2024, 1, 11);
                              //     //
                              //     // // Calculate the duration between the two dates
                              //     // Duration difference = selectedDate2.value.difference(selectedDate1.value);
                              //     // // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
                              //     //
                              //     // // Extract individual components (days, weeks, months, years) from the duration
                              //     // int daysDifference = difference.inDays;
                              //     // int weeksDifference = difference.inDays ~/ 7; // 7 days in a week
                              //     // int monthsDifference = difference.inDays ~/ 30; // Assuming an average of 30 days in a month
                              //     // int yearsDifference = difference.inDays ~/ 365; // Assuming an average of 365 days in a year
                              //     //
                              //     // // Determine the best fit unit
                              //     // String bestFitUnit;
                              //     // int bestFitValue;
                              //     //
                              //     // if (yearsDifference > 0) {
                              //     //   bestFitUnit = 'year';
                              //     //   bestFitValue = yearsDifference;
                              //     // } else if (monthsDifference > 0) {
                              //     //   bestFitUnit = 'month';
                              //     //   bestFitValue = monthsDifference;
                              //     // } else if (weeksDifference > 0) {
                              //     //   bestFitUnit = 'week';
                              //     //   bestFitValue = weeksDifference;
                              //     // } else {
                              //     //   bestFitUnit = 'day';
                              //     //   bestFitValue = daysDifference;
                              //     // }
                              //     //
                              //     // print('Best fit difference: $bestFitValue $bestFitUnit(s)');
                              //     // // print(date1Controller.text);
                              //     // // tenantController.getTenantUnits(null);
                              //   },
                              // ),


                              //
                              // Obx(() {
                              //   return tenantController.isTenantUnitListLoading
                              //       .value
                              //       ? Center(child: CircularProgressIndicator(),)
                              //       : ListView.builder(
                              //       itemCount: tenantController.tenantUnitList
                              //           .length,
                              //       shrinkWrap: true,
                              //       itemBuilder: (context, index) {
                              //         var unit = tenantController
                              //             .tenantUnitList[index];
                              //         return Card(
                              //             child: Text(unit.amount.toString()));
                              //       });
                              // }),

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
    super.initState();
    tenantDropdownCont = SingleValueDropDownController();
    selectedDate2.value = DateTime(
        selectedDate1.value.year, selectedDate1.value.month,
        selectedDate1.value.day);
    // date1Controller  = TextEditingController(text: '${DateFormat('MM/dd/yyyy').format(selectedDate1.value)}');
    // date2Controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    paidController.dispose();
    amountController.dispose();
    balanceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
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
                  child: Image.asset(
                    'assets/home/add.png', color: AppTheme.primaryColor,))),

              // SizedBox(
              //   width: 32.5.w,
              //   height: 6.5.h,
              //   child: AppButton(
              //       title: 'Add Payment',
              //       color: AppTheme.primaryColor,
              //       function: () {
              //         showAsBottomSheet(context);
              //       }),
              // ),

            ],
          ),

          // isLoading: tenantController.isTenantUnitListLoading.value,
          // appIcon:  Image.asset('assets/auth/logo.png'),


          Obx(() {
            return tenantController.isTenantPaymentsLoading.value
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Center(
                child: Image.asset('assets/auth/logo.png', width: 35.w),),
            )
                : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tenantController.tenantPaymentList.length,
                itemBuilder: (context, index) {
                  var payment = tenantController.tenantPaymentList[index];

                  return PaymentCardWidget(tenantPaymentModel: payment);

                });
          }),


        ],
      ),
    );
  }
}
