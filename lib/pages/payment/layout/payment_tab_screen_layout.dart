import 'dart:io';
import 'dart:typed_data';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/unit/specific_tenant_unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/payment_card_widget.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class PaymentTabScreenLayout extends StatefulWidget {
  final UnitController unitController;
  final int id;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const PaymentTabScreenLayout(
      {super.key,
      required this.propertyDetailsOptionsController,
      required this.unitController,
      required this.id});

  @override
  State<PaymentTabScreenLayout> createState() => _PaymentTabScreenLayoutState();
}

class _PaymentTabScreenLayoutState extends State<PaymentTabScreenLayout> {
  File? paymentPic;
  String? paymentImagePath;
  String? paymentImageExtension;
  String? paymentFileName;
  Uint8List? paymentBytes;

  var unitBalance = 0;

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
  final TextEditingController paymentDateController = TextEditingController();

  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();

  final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate3 = Rx<DateTime>(DateTime.now());

  final TextEditingController searchController = TextEditingController();

  late SingleValueDropDownController tenantDropdownCont;
  late SingleValueDropDownController _unitCont;
  late SingleValueDropDownController _tenantUnitScheduleCont;

  final MultiSelectController _controller = MultiSelectController();

  final Rx<DateTime> paymentDate = Rx<DateTime>(DateTime.now());

  final Rx<String> fitUnit = Rx<String>('');
  final Rx<int> fitValue = Rx<int>(0);

  var initialBalance = 0;

  Future<void> _selectPaymentDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: myDateOfBirth.value,
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    // );

    final DateTime? picked = await showDatePickerDialog(
      context: context,
      initialDate: paymentDate.value,
      minDate: DateTime(1900),
      maxDate: DateTime.now(),
    );

    if (picked != null) {
      paymentDate(picked);
      paymentDateController.text =
          '${DateFormat('MM/dd/yyyy').format(paymentDate.value)}';
    }
  }

  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
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
          snappings: [0.9],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, state) {
          return Material(
            elevation: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 7.5.h,
              decoration: BoxDecoration(boxShadow: []),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bounceable(
                        onTap: () {
                          tenantController.tenantId.value == 0;
                          tenantController.unitId.value == 0;
                          selectedDate1.value = DateTime.now();
                          selectedDate2.value = DateTime.now();
                          amountController.clear();
                          paidController.clear();
                          balanceController.clear();
                          initialBalance = 0;
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
                      'Add Payment',
                      style: AppTheme.darkBlueTitle2,
                    ),
                    Obx(() {
                      return tenantController
                              .isPayForMultipleSchedulesLoading.value
                          ? AppLoader(
                              color: AppTheme.primaryColor,
                            )
                          : Bounceable(
                              onTap: () async {
                                // final response = await AppConfig()
                                //     .supaBaseClient
                                //     .from('payment_schedule')
                                //     .select()
                                //     .eq('id', 379)
                                //     .single();
                                // print('Schedule response ==== ${response['balance']}');

                                // print('MY INITIAL BALANCE IS == $initialBalance');
                                // var postedBalance =  initialBalance - int.parse(paidController.text.trim().replaceAll(',', '').toString());
                                // print('MY Posted Balance == $postedBalance');
                                // print('MY Cont options = ${_controller.options}');
                                // print('amount = $amountController');
                                // print('paid = $paidController');
                                // print('balance = $balanceController');

                                await tenantController
                                    .payForMultipleTenantUnitSchedule(
                                  tenantController.tenantId.value,
                                  tenantController.unitId.value,
                                  selectedDate1.value.toIso8601String(),
                                  selectedDate2.value.toIso8601String(),
                                  int.parse(amountController.text
                                      .replaceAll(',', '')
                                      .toString()),
                                  int.parse(paidController.text
                                      .replaceAll(',', '')
                                      .toString()),
                                  int.parse(balanceController.text
                                      .replaceAll(',', '')
                                      .toString()),
                                  userStorage.read('userProfileId'),
                                  userStorage.read('userProfileId'),
                                )
                                    .then((value) {
                                  tenantController.tenantId.value == 0;
                                  tenantController.unitId.value == 0;
                                  selectedDate1.value = DateTime.now();
                                  selectedDate2.value = DateTime.now();
                                  amountController.clear();
                                  paidController.clear();
                                  balanceController.clear();
                                });

                                // await tenantController
                                //     .payForSpecificTenantUnitSchedule(
                                //   tenantController.tenantId.value,
                                //   tenantController.unitId.value,
                                //   selectedDate1.value.toIso8601String(),
                                //   selectedDate2.value.toIso8601String(),
                                //   int.parse(amountController.text),
                                //   int.parse(paidController.text),
                                //   int.parse(balanceController.text),
                                //   'userStorage.read('userProfileId')',
                                //   'userStorage.read('userProfileId')',
                                // );

                                // await tenantController.addTenantPayment(
                                //   tenantController.tenantId.value,
                                //   tenantController.unitId.value,
                                //   selectedDate1.value.toIso8601String(),
                                //   selectedDate2.value.toIso8601String(),
                                //   int.parse(amountController.text),
                                //   int.parse(paidController.text),
                                //   int.parse(balanceController.text),
                                //   'userStorage.read('userProfileId')',
                                //   'userStorage.read('userProfileId')',
                                // );

                                // Get.back();

                                // Get.back();
                                // Get.snackbar('SUCCESS',
                                //   'Payment added to your property',
                                //   titleText: Text('SUCCESS',
                                //     style: AppTheme.greenTitle1,),
                                // );
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 17.5.sp,
                                ),
                              ));
                    }),
                  ],
                ),
              ),
            ),
          );
        },
        builder: (context, state) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Material(
              color: AppTheme.appBgColor,
              // color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),

                          // Obx(() {
                          //   return SearchableTenantDropDown<TenantModel>(
                          //     hintText: 'Tenant',
                          //     menuItems: tenantController.tenantList.value,
                          //     controller: tenantDropdownCont,
                          //     onChanged: (value) {
                          //       print(value.value.id);
                          //       tenantController.setTenantId(
                          //           value.value.id);
                          //       print(
                          //           'MY TEnant is ${tenantController
                          //               .tenantId
                          //               .value}');
                          //       tenantController.getTenantUnits(null).then((
                          //           value) {
                          //         amountController.text =
                          //             tenantController.tenantUnitAmount
                          //                 .toString();
                          //         print(
                          //             'MY Amount Controller sis == ${tenantController
                          //                 .specificTenantUnits.value.first
                          //                 .amount}');
                          //         date1Controller.text =
                          //             tenantController.tenantUnitList.value
                          //                 .first.fromDate;
                          //         date2Controller.text =
                          //             tenantController.tenantUnitList.value
                          //                 .first.toDate;
                          //
                          //         selectedDate1.value = DateTime.parse(
                          //             tenantController.tenantUnitList.value
                          //                 .first.fromDate);
                          //         selectedDate2.value = DateTime.parse(
                          //             tenantController.tenantUnitList.value
                          //                 .first.toDate);
                          //
                          //         print('DATE1 = ${date1Controller.text}');
                          //         print('DATE2 = ${date2Controller.text}');
                          //
                          //         print('RX DATE1 = ${selectedDate1}');
                          //         print('RX DATE2 = ${selectedDate2}');
                          //
                          //         // Define two DateTime objects representing the two dates
                          //         // DateTime date1 = DateTime(2023, 1, 11);
                          //         // DateTime date2 = DateTime(2024, 1, 11);
                          //
                          //         // Calculate the duration between the two dates
                          //         Duration difference = selectedDate2.value
                          //             .difference(selectedDate1.value);
                          //         // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
                          //
                          //         // Extract individual components (days, weeks, months, years) from the duration
                          //         int daysDifference = difference.inDays;
                          //         int weeksDifference = difference.inDays ~/
                          //             7; // 7 days in a week
                          //         int monthsDifference = difference
                          //             .inDays ~/
                          //             30; // Assuming an average of 30 days in a month
                          //         int yearsDifference = difference.inDays ~/
                          //             365; // Assuming an average of 365 days in a year
                          //
                          //         // Determine the best fit unit
                          //         String bestFitUnit;
                          //         int bestFitValue;
                          //
                          //         if (yearsDifference > 0) {
                          //           bestFitValue = yearsDifference;
                          //           bestFitUnit =
                          //           bestFitValue == 1 ? 'year' : 'years';
                          //           fitUnit.value = bestFitUnit;
                          //           fitValue.value = bestFitValue;
                          //         } else if (monthsDifference > 0) {
                          //           bestFitValue = monthsDifference;
                          //           bestFitUnit =
                          //           bestFitValue == 1 ? 'month' : 'months';
                          //           fitUnit.value = bestFitUnit;
                          //           fitValue.value = bestFitValue;
                          //         } else if (weeksDifference > 0) {
                          //           bestFitValue = weeksDifference;
                          //           bestFitUnit =
                          //           bestFitValue == 1 ? 'week' : 'weeks';
                          //           fitUnit.value = bestFitUnit;
                          //           fitValue.value = bestFitValue;
                          //         } else {
                          //           bestFitValue = daysDifference;
                          //           bestFitUnit =
                          //           bestFitValue == 1 ? 'day' : 'days';
                          //           fitUnit.value = bestFitUnit;
                          //           fitValue.value = bestFitValue;
                          //         }
                          //
                          //         print(
                          //             'Best fit difference: $fitValue $fitUnit');
                          //
                          //         amountController.text =
                          //             (int.parse(tenantController
                          //                 .specificTenantUnits.value.first
                          //                 .amount
                          //                 .toString()) * fitValue.value)
                          //                 .toString();
                          //
                          //         print(amountController.text);
                          //       });
                          //     },
                          //   );
                          // }),

                          AuthTextField(
                            controller: paymentDateController,
                            hintText: 'Payment Date',
                            obscureText: false,
                            onTap: () {
                              _selectPaymentDate(context);
                            },
                          ),
                          SizedBox(
                            height: 1.h,
                          ),

                          Obx(() {
                            return SearchableTenantDropDown<TenantModel>(
                              hintText: 'Tenant',
                              menuItems: tenantController.tenantList.value,
                              controller: tenantDropdownCont,
                              onChanged: (value) {
                                print(value.value.id);
                                tenantController.setTenantId(value.value.id);
                                print(
                                    'MY TEnant is ${tenantController.tenantId.value}');
                                tenantController.getTenantUnits(null).then(
                                  (value) {
                                    // tenantController.fetchSpecificTenantsUnitSchedules();
                                    // tenantController.getSpecificTenantUnits(widget.propertyModel.id!);

                                    // amountController.text =
                                    //     tenantController.tenantUnitAmount
                                    //         .toString();
                                    // print(
                                    //     'MY Amount Controller sis == ${tenantController
                                    //         .specificTenantUnits.value.first
                                    //         .amount}');
                                    // date1Controller.text =
                                    //     tenantController.tenantUnitList.value
                                    //         .first.fromDate;
                                    // date2Controller.text =
                                    //     tenantController.tenantUnitList.value
                                    //         .first.toDate;
                                    //
                                    // selectedDate1.value = DateTime.parse(
                                    //     tenantController.tenantUnitList.value
                                    //         .first.fromDate);
                                    // selectedDate2.value = DateTime.parse(
                                    //     tenantController.tenantUnitList.value
                                    //         .first.toDate);
                                    //
                                    // print('DATE1 = ${date1Controller.text}');
                                    // print('DATE2 = ${date2Controller.text}');
                                    //
                                    // print('RX DATE1 = ${selectedDate1}');
                                    // print('RX DATE2 = ${selectedDate2}');
                                    //
                                    // // Define two DateTime objects representing the two dates
                                    // // DateTime date1 = DateTime(2023, 1, 11);
                                    // // DateTime date2 = DateTime(2024, 1, 11);
                                    //
                                    // // Calculate the duration between the two dates
                                    // Duration difference = selectedDate2.value
                                    //     .difference(selectedDate1.value);
                                    // // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
                                    //
                                    // // Extract individual components (days, weeks, months, years) from the duration
                                    // int daysDifference = difference.inDays;
                                    // int weeksDifference = difference.inDays ~/
                                    //     7; // 7 days in a week
                                    // int monthsDifference = difference
                                    //     .inDays ~/
                                    //     30; // Assuming an average of 30 days in a month
                                    // int yearsDifference = difference.inDays ~/
                                    //     365; // Assuming an average of 365 days in a year
                                    //
                                    // // Determine the best fit unit
                                    // String bestFitUnit;
                                    // int bestFitValue;
                                    //
                                    // if (yearsDifference > 0) {
                                    //   bestFitValue = yearsDifference;
                                    //   bestFitUnit =
                                    //   bestFitValue == 1 ? 'year' : 'years';
                                    //   fitUnit.value = bestFitUnit;
                                    //   fitValue.value = bestFitValue;
                                    // } else if (monthsDifference > 0) {
                                    //   bestFitValue = monthsDifference;
                                    //   bestFitUnit =
                                    //   bestFitValue == 1 ? 'month' : 'months';
                                    //   fitUnit.value = bestFitUnit;
                                    //   fitValue.value = bestFitValue;
                                    // } else if (weeksDifference > 0) {
                                    //   bestFitValue = weeksDifference;
                                    //   bestFitUnit =
                                    //   bestFitValue == 1 ? 'week' : 'weeks';
                                    //   fitUnit.value = bestFitUnit;
                                    //   fitValue.value = bestFitValue;
                                    // } else {
                                    //   bestFitValue = daysDifference;
                                    //   bestFitUnit =
                                    //   bestFitValue == 1 ? 'day' : 'days';
                                    //   fitUnit.value = bestFitUnit;
                                    //   fitValue.value = bestFitValue;
                                    // }
                                    //
                                    // print(
                                    //     'Best fit difference: $fitValue $fitUnit');
                                    //
                                    // amountController.text =
                                    //     (int.parse(tenantController
                                    //         .specificTenantUnits.value.first
                                    //         .amount
                                    //         .toString()) * fitValue.value)
                                    //         .toString();
                                    //
                                    // print(amountController.text);
                                  },
                                );
                              },
                            );
                          }),

                          // Obx(() {
                          //   return SearchableUnitDropDown<UnitModel>(
                          //         hintText: tenantController.unitNumber.value
                          //             .isEmpty ? 'Unit' : tenantController
                          //             .unitNumber.value,
                          //     menuItems: tenantController.unitList.value,
                          //     controller: _unitCont,
                          //     onChanged: (value) {
                          //       print(value.value.id);
                          //       tenantController.setUnitId(value.value.id);
                          //             tenantController
                          //                 .setAmountForSpecificTenantUnit(value.value);
                          //             tenantController.fetchSpecificTenantsUnitSchedules().then((value){
                          //               amountController.text =
                          //                   tenantController.tenantUnitAmount
                          //                       .toString();
                          //               print(
                          //                   'MY Amount Controller sis == ${tenantController
                          //                       .specificTenantUnits.value.first
                          //                       .amount}');
                          //               date1Controller.text =
                          //                   tenantController.tenantUnitList.value
                          //                       .first.fromDate;
                          //               date2Controller.text =
                          //                   tenantController.tenantUnitList.value
                          //                       .first.toDate;
                          //
                          //               selectedDate1.value = DateTime.parse(
                          //                   tenantController.tenantUnitList.value
                          //                       .first.fromDate);
                          //               selectedDate2.value = DateTime.parse(
                          //                   tenantController.tenantUnitList.value
                          //                       .first.toDate);
                          //
                          //               print('DATE1 = ${date1Controller.text}');
                          //               print('DATE2 = ${date2Controller.text}');
                          //
                          //               print('RX DATE1 = ${selectedDate1}');
                          //               print('RX DATE2 = ${selectedDate2}');
                          //
                          //               // Define two DateTime objects representing the two dates
                          //               // DateTime date1 = DateTime(2023, 1, 11);
                          //               // DateTime date2 = DateTime(2024, 1, 11);
                          //
                          //               // Calculate the duration between the two dates
                          //               Duration difference = selectedDate2.value
                          //                   .difference(selectedDate1.value);
                          //               // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
                          //
                          //               // Extract individual components (days, weeks, months, years) from the duration
                          //               int daysDifference = difference.inDays;
                          //               int weeksDifference = difference.inDays ~/
                          //                   7; // 7 days in a week
                          //               int monthsDifference = difference
                          //                   .inDays ~/
                          //                   30; // Assuming an average of 30 days in a month
                          //               int yearsDifference = difference.inDays ~/
                          //                   365; // Assuming an average of 365 days in a year
                          //
                          //               // Determine the best fit unit
                          //               String bestFitUnit;
                          //               int bestFitValue;
                          //
                          //               if (yearsDifference > 0) {
                          //                 bestFitValue = yearsDifference;
                          //                 bestFitUnit =
                          //                 bestFitValue == 1 ? 'year' : 'years';
                          //                 fitUnit.value = bestFitUnit;
                          //                 fitValue.value = bestFitValue;
                          //               } else if (monthsDifference > 0) {
                          //                 bestFitValue = monthsDifference;
                          //                 bestFitUnit =
                          //                 bestFitValue == 1 ? 'month' : 'months';
                          //                 fitUnit.value = bestFitUnit;
                          //                 fitValue.value = bestFitValue;
                          //               } else if (weeksDifference > 0) {
                          //                 bestFitValue = weeksDifference;
                          //                 bestFitUnit =
                          //                 bestFitValue == 1 ? 'week' : 'weeks';
                          //                 fitUnit.value = bestFitUnit;
                          //                 fitValue.value = bestFitValue;
                          //               } else {
                          //                 bestFitValue = daysDifference;
                          //                 bestFitUnit =
                          //                 bestFitValue == 1 ? 'day' : 'days';
                          //                 fitUnit.value = bestFitUnit;
                          //                 fitValue.value = bestFitValue;
                          //               }
                          //
                          //               print(
                          //                   'Best fit difference: $fitValue $fitUnit');
                          //
                          //               amountController.text =
                          //                   (int.parse(tenantController
                          //                       .specificTenantUnits.value.first
                          //                       .amount
                          //                       .toString()) * fitValue.value)
                          //                       .toString();
                          //
                          //               print(amountController.text);
                          //             });
                          //             amountController.text = (int.parse(
                          //                 tenantController.tenantUnitAmount
                          //                     .toString()) * fitValue.value)
                          //                 .toString();
                          //
                          //       // tenantController.setUnitAmount(value.value.amount);
                          //       // amountController.text = value.value.amount.toString();
                          //       // discountController.text = value.value.amount.toString();
                          //       print('MY Unit is ${tenantController.unitId.value}');
                          //       print('MY Amount is ${tenantController.unitAmount.value}');
                          //
                          //     },
                          //   );
                          // }),

                          Obx(() {
                            return SearchableSpecificTenantUnitDropDown<
                                SpecificTenantUnitModel>(
                              hintText:
                                  tenantController.unitNumber.value.isEmpty
                                      ? 'Unit'
                                      : tenantController.unitNumber.value,
                              menuItems: tenantController
                                  .specificTenantUnitModelList.value,
                              controller: _unitCont,
                              onChanged: (value) {
                                print(value.value.id);
                                tenantController.setUnitId(value.value.unitId);

                                // print(element.value.id);
                                // tenantController.setSpecificScheduleId(
                                //     value.value.id);
                                // tenantController.setSpecificPaymentAmount(
                                //     value.value.amount);
                                // tenantController.setSpecificPaymentBalance(
                                //     value.value.balance);
                                // tenantController.setSpecificPaymentPaid(
                                //     value.value.paid);
                                //
                                // amountController.text =
                                //     tenantController.specificPaymentBalance
                                //         .value.toString();
                                // paidController.text =
                                //     tenantController.specificPaymentBalance
                                //         .value.toString();
                                // // balanceController.text = int.parse(tenantController.specificPaymentBalance.value.toString()) as String;
                                // print(
                                //     'MY Schedule is ${tenantController
                                //         .specificScheduleId
                                //         .value}');
                                //

                                // tenantController
                                //     .setAmountForSpecificTenantUnit(value.value);
                                tenantController
                                    .fetchSpecificTenantsUnitSchedules()
                                    .then((value) {
                                  amountController.text =
                                      amountFormatter.format(tenantController
                                          .totalScheduleBalance
                                          .toString());
                                  balanceController.text =
                                      amountFormatter.format(tenantController
                                          .totalScheduleBalance
                                          .toString());

                                  // amountController.text =
                                  //     tenantController.tenantUnitAmount
                                  //         .toString();
                                  // print(
                                  //     'MY Amount Controller sis == ${tenantController
                                  //         .specificTenantUnits.value.first
                                  //         .amount}');
                                  // date1Controller.text =
                                  //     tenantController.tenantUnitList.value
                                  //         .first.fromDate;
                                  // date2Controller.text =
                                  //     tenantController.tenantUnitList.value
                                  //         .first.toDate;
                                  //
                                  // selectedDate1.value = DateTime.parse(
                                  //     tenantController.tenantUnitList.value
                                  //         .first.fromDate);
                                  // selectedDate2.value = DateTime.parse(
                                  //     tenantController.tenantUnitList.value
                                  //         .first.toDate);
                                  //
                                  // print('DATE1 = ${date1Controller.text}');
                                  // print('DATE2 = ${date2Controller.text}');
                                  //
                                  // print('RX DATE1 = ${selectedDate1}');
                                  // print('RX DATE2 = ${selectedDate2}');
                                  //
                                  // // Define two DateTime objects representing the two dates
                                  // // DateTime date1 = DateTime(2023, 1, 11);
                                  // // DateTime date2 = DateTime(2024, 1, 11);
                                  //
                                  // // Calculate the duration between the two dates
                                  // Duration difference = selectedDate2.value
                                  //     .difference(selectedDate1.value);
                                  // // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
                                  //
                                  // // Extract individual components (days, weeks, months, years) from the duration
                                  // int daysDifference = difference.inDays;
                                  // int weeksDifference = difference.inDays ~/
                                  //     7; // 7 days in a week
                                  // int monthsDifference = difference
                                  //     .inDays ~/
                                  //     30; // Assuming an average of 30 days in a month
                                  // int yearsDifference = difference.inDays ~/
                                  //     365; // Assuming an average of 365 days in a year
                                  //
                                  // // Determine the best fit unit
                                  // String bestFitUnit;
                                  // int bestFitValue;
                                  //
                                  // if (yearsDifference > 0) {
                                  //   bestFitValue = yearsDifference;
                                  //   bestFitUnit =
                                  //   bestFitValue == 1 ? 'year' : 'years';
                                  //   fitUnit.value = bestFitUnit;
                                  //   fitValue.value = bestFitValue;
                                  // } else if (monthsDifference > 0) {
                                  //   bestFitValue = monthsDifference;
                                  //   bestFitUnit =
                                  //   bestFitValue == 1 ? 'month' : 'months';
                                  //   fitUnit.value = bestFitUnit;
                                  //   fitValue.value = bestFitValue;
                                  // } else if (weeksDifference > 0) {
                                  //   bestFitValue = weeksDifference;
                                  //   bestFitUnit =
                                  //   bestFitValue == 1 ? 'week' : 'weeks';
                                  //   fitUnit.value = bestFitUnit;
                                  //   fitValue.value = bestFitValue;
                                  // } else {
                                  //   bestFitValue = daysDifference;
                                  //   bestFitUnit =
                                  //   bestFitValue == 1 ? 'day' : 'days';
                                  //   fitUnit.value = bestFitUnit;
                                  //   fitValue.value = bestFitValue;
                                  // }
                                  //
                                  // print(
                                  //     'Best fit difference: $fitValue $fitUnit');
                                  //
                                  // amountController.text =
                                  //     (int.parse(tenantController
                                  //         .specificTenantUnits.value.first
                                  //         .amount
                                  //         .toString()) * fitValue.value)
                                  //         .toString();
                                  //
                                  // print(amountController.text);
                                });
                                // amountController.text = (int.parse(
                                //     tenantController.tenantUnitAmount
                                //         .toString()) * fitValue.value)
                                //     .toString();

                                // tenantController.setUnitAmount(value.value.amount);
                                // amountController.text = value.value.amount.toString();
                                // discountController.text = value.value.amount.toString();
                                print(
                                    'MY Unit is ${tenantController.unitId.value}');
                                print(
                                    'MY Amount is ${tenantController.unitAmount.value}');
                              },
                            );
                          }),

                          // Obx(() {
                          //   return SearchableTenantUnitScheduleDropDown<
                          //       TenantUnitScheduleModel>(
                          //     hintText: 'Schedule',
                          //     menuItems: tenantController
                          //         .specificTenantUnitScheduleList.value,
                          //     controller: _tenantUnitScheduleCont,
                          //     onChanged: (value) {
                          //       print(value.value.id);
                          //       tenantController.setSpecificScheduleId(
                          //           value.value.id);
                          //       tenantController.setSpecificPaymentAmount(
                          //           value.value.amount);
                          //       tenantController.setSpecificPaymentBalance(
                          //           value.value.balance);
                          //       tenantController.setSpecificPaymentPaid(
                          //           value.value.paid);
                          //
                          //       amountController.text =
                          //           tenantController.specificPaymentBalance
                          //               .value.toString();
                          //       paidController.text =
                          //           tenantController.specificPaymentBalance
                          //               .value.toString();
                          //       // balanceController.text = int.parse(tenantController.specificPaymentBalance.value.toString()) as String;
                          //       print(
                          //           'MY Schedule is ${tenantController
                          //               .specificScheduleId
                          //               .value}');
                          //     },
                          //   );
                          // }),

                          // Obx(() {
                          //   return tenantController.specificTenantUnitScheduleList.value
                          //       .isEmpty ? Container() : DateTextField2(
                          //     style: TextStyle(color: Colors.transparent),
                          //     onTap: () {
                          //       // _selectDate1(context);
                          //     },
                          //     controller: date1Controller,
                          //     hintText: "From",
                          //     obscureText: false,
                          //     tenantController: tenantController,
                          //   );
                          // }),
                          //
                          // Obx(() {
                          //   return tenantController.specificTenantUnitScheduleList.value
                          //       .isEmpty ? Container() : SizedBox(
                          //     height: 1.h,);
                          // }),
                          //
                          // Obx(() {
                          //   return tenantController.tenantUnitList.value
                          //       .isEmpty ? Container() : DateTextField2(
                          //     style: TextStyle(color: Colors.transparent),
                          //     onTap: () {
                          //       // _selectDate2(context);
                          //     },
                          //     controller: date2Controller,
                          //
                          //     hintText: "To",
                          //     obscureText: false,
                          //     enabled: false,
                          //     tenantController: tenantController,
                          //   );
                          // }),
                          //
                          //
                          //
                          // Obx(() {
                          //   return tenantController.tenantUnitList.value
                          //       .isEmpty ? Container() : SizedBox(
                          //     height: 1.h,);
                          // }),

                          Obx(() {
                            return MultiSelectDropDown(
                              controller: _controller,
                              inputDecoration: BoxDecoration(
                                color: AppTheme.itemBgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clearIcon: Icon(Icons.clear),
                              // showClearIcon: true,
                              hint: 'Select Payment Schedule',
                              hintStyle: TextStyle(
                                color: AppTheme.inActiveColor,
                                fontSize: 16,
                              ),

                              onOptionSelected: (options) {
                                for (var element in options) {
                                  tenantController.schedules
                                      .add(element.value!);
                                  print(
                                      'My SChedules ${tenantController.schedules.value}');
                                  print('My element = $element');
                                  print('My options = $options');

                                  // print(element.value.id);
                                  // tenantController.setSpecificScheduleId(
                                  //     value.value.id);
                                  // tenantController.setSpecificPaymentAmount(
                                  //     value.value.amount);
                                  // tenantController.setSpecificPaymentBalance(
                                  //     value.value.balance);
                                  // tenantController.setSpecificPaymentPaid(
                                  //     value.value.paid);
                                  //
                                  // amountController.text =
                                  //     tenantController.specificPaymentBalance
                                  //         .value.toString();
                                  // paidController.text =
                                  //     tenantController.specificPaymentBalance
                                  //         .value.toString();
                                  // // balanceController.text = int.parse(tenantController.specificPaymentBalance.value.toString()) as String;
                                  // print(
                                  //     'MY Schedule is ${tenantController
                                  //         .specificScheduleId
                                  //         .value}');

                                  // // Convert the list to a set to remove duplicate values
                                  // Set uniqueNumbersSet = tenantController.schedules.toSet();
                                  //
                                  // // Convert the set back to a list if needed
                                  // List uniqueNumbersList = uniqueNumbersSet.toList();
                                  //
                                  // // Print the result
                                  // print('MY UNIQUE List is $uniqueNumbersList');
                                }
                              },
                              options: tenantController
                                  .specificTenantUnitScheduleList.value
                                  .map((schedule) {
                                // initialBalance = schedule.balance!;
                                return ValueItem(
                                  label:
                                      '${DateFormat('dd/MM/yyyy').format(schedule.fromDate!)}-${DateFormat('dd/MM/yyyy').format(schedule.toDate!)} | ${amountFormatter.format(schedule.balance.toString())}',
                                  value: schedule.id,
                                  // '${schedule.units!
                                  //     .unitNumber}|${schedule.balance}'
                                );
                              }).toList(),
                              selectionType: SelectionType.multi,
                              chipConfig: const ChipConfig(
                                wrapType: WrapType.wrap,
                              ),
                              borderColor: Colors.white,
                              optionTextStyle: const TextStyle(fontSize: 16),
                              selectedOptionIcon:
                                  const Icon(Icons.check_circle),
                            );
                          }),

                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: CustomGenericDropdown(
                                    hintText: 'Payment Mode', menuItems: []),
                                width: 40.w,
                              ),
                              SizedBox(
                                  width: 40.w,
                                  child: CustomGenericDropdown(
                                      hintText: 'Credited Account',
                                      menuItems: [])),
                            ],
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          Obx(() {
                            return AmountTextField(
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
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

                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: AuthTextField(
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                  controller: paidController,
                                  hintText: 'Paid',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                  onChanged: (value) {
                                    balanceController.text = (int.parse(
                                                amountController.text
                                                    .trim()
                                                    .toString()
                                                    .replaceAll(',', '')) -
                                            int.parse(
                                                paidController.text.isEmpty
                                                    ? '0'
                                                    : paidController.text
                                                        .trim()
                                                        .replaceAll(',', '')))
                                        .toString()
                                        .replaceAll(',', '');
                                    print(
                                        'MY Balance == ${balanceController.text}');
                                  },
                                ),
                                width: 40.w,
                              ),
                              SizedBox(
                                width: 40.w,
                                child: AuthTextField(
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                  controller: balanceController,
                                  hintText: 'Balance',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 1.h,
                          ),
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
                                    paymentPic = value.file.first;
                                    paymentImagePath = value.file.first!.path;
                                    paymentImageExtension =
                                        value.file.first!.path.split('.').last;
                                    paymentFileName =
                                        value.file.first!.path.split('/').last;
                                  });
                                  paymentBytes =
                                      await paymentPic!.readAsBytes();
                                  print('MY PIC == $paymentPic');
                                  print('MY path == $paymentImagePath');
                                  print('MY bytes == $paymentBytes');
                                  print(
                                      'MY extension == $paymentImageExtension');
                                  print('MY FILE NAME == $paymentFileName');
                                },
                              );
                            },
                            child: Container(
                              width: 90.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                  color: AppTheme.itemBgColor,
                                  borderRadius: BorderRadius.circular(15.sp),
                                  image: DecorationImage(
                                      image: FileImage(paymentPic ?? File('')),
                                      fit: BoxFit.cover)),
                              child: paymentPic == null
                                  ? Center(
                                      child: Text('Upload payment pic'),
                                    )
                                  : null,
                            ),
                          ),

                          // SizedBox(height: 2.h,),
                          //
                          //
                          //
                          //
                          // SizedBox(height: 10.h,),
                          //
                          // AppButton(title: 'Get Unique List', color: Colors.green,
                          //     function: () async{
                          //   // tenantController.testout();
                          //   print(tenantController.specificPaymentAmount);
                          //        tenantController
                          //           .payForMultipleTenantUnitSchedule(
                          //         tenantController.tenantId.value,
                          //         tenantController.unitId.value,
                          //         selectedDate1.value.toIso8601String(),
                          //         selectedDate2.value.toIso8601String(),
                          //         int.parse(amountController.text),
                          //         int.parse(paidController.text),
                          //         int.parse(balanceController.text),
                          //         'userStorage.read('userProfileId')',
                          //         'userStorage.read('userProfileId')',
                          //       );
                          //     },
                          // )

                          // AppButton(
                          //     title: 'Get unit Tenants',
                          //     color: Colors.black,
                          //     function: () async{
                          //       // tenantController.fetchNestedTenantsUnits();
                          //       // await tenantController.fetchNestedTenantsUnits();
                          //       // tenantController.groupAllPropertyTenants();
                          //       // tenantController.getSpecificTenantUnits();
                          //       tenantController.fetchSpecificTenantsUnitSchedules();
                          //
                          //     }),

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
          });
        },
      );
    });

    print(result); // This is the result.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenantDropdownCont = SingleValueDropDownController();
    _unitCont = SingleValueDropDownController();
    _tenantUnitScheduleCont = SingleValueDropDownController();
    selectedDate2.value = DateTime(selectedDate1.value.year,
        selectedDate1.value.month, selectedDate1.value.day);
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
    _unitCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        tenantController.tenantId.value == 0;
        tenantController.unitId.value == 0;
        selectedDate1.value = DateTime.now();
        selectedDate2.value = DateTime.now();
        amountController.clear();
        paidController.clear();
        balanceController.clear();
        initialBalance = 0;
        return true;
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
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

            // AppButton(title: 'Call payments', color: Colors.green,
            //     function: (){
            //   tenantController.callAllTenantsPaymentsFunction();
            //     }),

            Obx(() {
              var groupedData = tenantController.groupAllTenantPayments(
                  tenantController.tenantPaymentList.value,
                  (entry) => entry.unitId);

              return tenantController.isTenantPaymentsLoading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Center(
                        child: Image.asset('assets/auth/logo.png', width: 35.w),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: groupedData.length,
                          itemBuilder: (context, index) {
                            var payment =
                                tenantController.tenantPaymentList[index];

                            return PaymentCardWidget(
                                tenantPaymentModel: payment);
                          }),
                    );
            }),

            // Obx(() {
            //   return tenantController.isTenantPaymentsLoading.value
            //       ? Padding(
            //     padding: EdgeInsets.symmetric(vertical: 15.h),
            //     child: Center(
            //       child: Image.asset('assets/auth/logo.png', width: 35.w),),
            //   )
            //       : Expanded(
            //     child: ListView.builder(
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: tenantController.tenantPaymentList.length,
            //         itemBuilder: (context, index) {
            //           var payment = tenantController.tenantPaymentList[index];
            //
            //           return PaymentCardWidget(tenantPaymentModel: payment);
            //         }),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
