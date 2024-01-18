import 'dart:convert';
import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/schedule/tenant_unit_schedule.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/screens/tenant/tenant_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_loader.dart';
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
  // File? tenantImage;
  PlatformFile? tenantFile;
  PlatformFile? tenantFile1;

  pickAddTenantFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      var tempFile = File(file.path);
      setState(() {
        tenantFile = result.files.first;
        tempFile = file;
      });

      print(tenantFile!.path);
      print(tenantFile!.name);
      print(tempFile.path);
    } else {
      // User canceled the picker
    }
  }

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
  final Rx<DateTime> selectedDate3 = Rx<DateTime>(DateTime.now());

  final TenantController tenantController = Get.put(TenantController());
  final _formKey = GlobalKey<FormState>();

  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController _unitCont;

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

      if (tenantController.paymentScheduleId.value == 1) {
        var myDays = dailyController.text.isEmpty
            ? 1 * 1
            : int.tryParse(dailyController.text)! * 1;

        if (dailyController.text.toString() == '0') {
          Fluttertoast.showToast(
              msg: 'Enter Right Day', gravity: ToastGravity.TOP);
        } else {
          print('MY myDays are == ${dailyController.text.toString()}');
          print('Count myDays ' + myDays.toString());
          selectedDate2.value = DateTime(selectedDate1.value.year,
              selectedDate1.value.month, selectedDate1.value.day + myDays);
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(
              selectedDate1.value.year, selectedDate1.value.month,
              selectedDate1.value.day + myDays))}';
          print('my seelected date ${selectedDate2.value}');
          print('my date date ${date2Controller.text}');
        }
      } else if (tenantController.paymentScheduleId.value == 2) {
        var myWeeks = weeklyController.text.isEmpty
            ? 1 * 7
            : int.tryParse(weeklyController.text)! * 7;

        if (weeklyController.text.toString() == '0') {
          Fluttertoast.showToast(
              msg: 'Enter Right week', gravity: ToastGravity.TOP);
        } else {
          print('MY WEEKs are == ${weeklyController.text.toString()}');
          print('Count Weeks ' + myWeeks.toString());
          selectedDate2.value = (DateTime(selectedDate1.value.year,
              selectedDate1.value.month, selectedDate1.value.day + myWeeks));
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(
              selectedDate1.value.year, selectedDate1.value.month,
              selectedDate1.value.day + myWeeks))}';
        }
      } else if (tenantController.paymentScheduleId.value == 3) {
        var myMonths = monthlyController.text.isEmpty
            ? 1 * 1
            : int.tryParse(monthlyController.text)! * 1;

        if (monthlyController.text.toString() == '0') {
          Fluttertoast.showToast(
              msg: 'Enter Right Month', gravity: ToastGravity.TOP);
        } else {
          print('MY myMonths are == ${monthlyController.text.toString()}');
          print('Count myMonths ' + myMonths.toString());
          selectedDate2.value = (DateTime(selectedDate1.value.year,
              selectedDate1.value.month + myMonths, selectedDate1.value.day));
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(
              selectedDate1.value.year, selectedDate1.value.month + myMonths,
              selectedDate1.value.day))}';
        }
      } else if (tenantController.paymentScheduleId.value == 4) {
        var myYears = yearlyController.text.isEmpty
            ? 1 * 1
            : int.tryParse(yearlyController.text)! * 1;

        if (yearlyController.text.toString() == '0') {
          Fluttertoast.showToast(
              msg: 'Enter Right years', gravity: ToastGravity.TOP);
        } else {
          print('MY myYears are == ${yearlyController.text.toString()}');
          print('Count myYears ' + myYears.toString());
          selectedDate2.value = DateTime(selectedDate1.value.year + myYears,
              selectedDate1.value.month, selectedDate1.value.day);
          date2Controller.text =
          '${DateFormat('MM/dd/yyyy').format(DateTime(
              selectedDate1.value.year + myYears, selectedDate1.value.month,
              selectedDate1.value.day))}';
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
        builder: (context, state) {
          return Material(
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
                    decoration: BoxDecoration(boxShadow: []),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bounceable(
                              onTap: () {
                                descriptionController.clear();
                                dailyController.clear();
                                weeklyController.clear();
                                monthlyController.clear();
                                yearlyController.clear();
                                lumpSumController.clear();
                                amountController.clear();
                                discountController.clear();
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
                            'Add Tenant',
                            style: AppTheme.darkBlueTitle2,
                          ),
                          Obx(() {
                            return tenantController.isAddTenantToUnitLoading.value ?
                            AppLoader(color: AppTheme.primaryColor,) :
                              Bounceable(
                                onTap: () async {
                                  if (tenantController.paymentScheduleId
                                      .value ==
                                      3) {
                                    List<Map<String, dynamic>>
                                    divideAmountMonthly(DateTime startDate,
                                        DateTime endDate,
                                        int totalAmount) {
                                      final dividedAmounts =
                                      <Map<String, dynamic>>[];

                                      final monthsInPeriod = endDate.month -
                                          startDate.month +
                                          12 * (endDate.year - startDate.year);

                                      // final amountPerMonth = totalAmount / monthsInPeriod;

                                      for (int i = 0; i < monthsInPeriod; i++) {
                                        final currentDate = DateTime(
                                            startDate.year,
                                            startDate.month + i,
                                            startDate.day);
                                        // Define the end date of the next period
                                        final toDate = DateTime(
                                            currentDate.year,
                                            currentDate.month + 1,
                                            currentDate
                                                .day); // Next period is 30 days

                                        // final currentAmount = (i == monthsInPeriod - 1) ? totalAmount - (amountPerMonth * i) : amountPerMonth;

                                        // final mDividedAmount = {
                                        //   'from_date': currentDate.toIso8601String(),
                                        //   'to_date': toDate.toIso8601String(),
                                        //   'amount': totalAmount,
                                        // };

                                        final mDividedAmount = {
                                          "amount": totalAmount,
                                          "paid": 0,
                                          "balance": totalAmount,
                                          "unit_id": tenantController
                                              .specificUnitId
                                              .value,
                                          "from_date": currentDate
                                              .toIso8601String(),
                                          "to_date": toDate.toIso8601String(),
                                          "date_posted": DateTime.now()
                                              .toIso8601String(),
                                          "tenant_id": tenantController.tenantId
                                              .value,
                                          "created_by": userStorage.read(
                                              'userProfileId'),
                                          "updated_by": userStorage.read(
                                              'userProfileId'),
                                        };

                                        dividedAmounts.add(mDividedAmount);
                                        // print(dividedAmounts);
                                      }

                                      return dividedAmounts;
                                    }

                                    final dividedAmounts = divideAmountMonthly(
                                        selectedDate1.value,
                                        selectedDate2.value,
                                        int.parse(
                                            discountController.text
                                                .toString()));

                                    print(
                                        'Monthly Divided Amounts: $dividedAmounts');
                                    print(
                                        'Monthly Divided Amounts: ${dividedAmounts
                                            .length}');

                                    await tenantController.addTenantToUnit(
                                        tenantController.tenantId.value,
                                        userStorage.read('userProfileId'),
                                        tenantController.specificUnitId.value,
                                        selectedDate1.value.toString(),
                                        selectedDate2.value.toString(),
                                        // date2Controller.text.trim().toString(),
                                        int.parse(
                                            amountController.text.toString()),
                                        int.parse(
                                            discountController.text.toString()),
                                        dividedAmounts
                                    ).then((value) async {
                                      // tenantController.tenantId.value == 0;
                                      // tenantController.unitId.value == 0;
                                      // selectedDate2.value =
                                      //     DateTime(selectedDate1.value.year,
                                      //         selectedDate1.value.month,
                                      //         selectedDate1.value.day);
                                      // dailyController.clear();
                                      // weeklyController.clear();
                                      // monthlyController.clear();
                                      // yearlyController.clear();
                                    });


                                    // tenantController.addPaymentSchedule(
                                    //   tenantController.tenantId.value,
                                    //   tenantController.unitId.value,
                                    //   selectedDate1.value.toString(),
                                    //   selectedDate2.value.toString(),
                                    //   int.parse(
                                    //       discountController.text.toString()),
                                    //   0,
                                    //   int.parse(
                                    //       discountController.text.toString()),
                                    //   'userStorage.read('userProfileId')',
                                    //   'userStorage.read('userProfileId')',
                                    // );

                                    // tenantController.addPaymentSchedule(
                                    //   tenantController.tenantId.value,
                                    //   "userStorage.read('userProfileId')",
                                    //   tenantController.unitId.value,
                                    //   selectedDate1.value.toString(),
                                    //   selectedDate2.value.toString(),
                                    //   // date2Controller.text.trim().toString(),
                                    //   int.parse(amountController.text.toString()),
                                    //   int.parse(discountController.text.toString()),
                                    // );

                                    // final startDate = DateTime.now();
                                    // final endDate = startDate.add(Duration(days: 180));
                                    //
                                    // final amount = 6000.0;
                                    //
                                    // List<Map<String, dynamic>> divideAmountMonthly(DateTime startDate, DateTime endDate, double totalAmount) {
                                    //   final dividedAmounts = <Map<String, dynamic>>[];
                                    //
                                    //
                                    //   final monthsInPeriod = endDate.month - startDate.month + 12 * (endDate.year - startDate.year);
                                    //
                                    //
                                    //   final amountPerMonth = totalAmount / monthsInPeriod;
                                    //
                                    //
                                    //   for (int i = 0; i < monthsInPeriod; i++) {
                                    //
                                    //
                                    //     final currentDate = DateTime(startDate.year, startDate.month + i, startDate.day);
                                    //     // Define the end date of the next period
                                    //     final toDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day); // Next period is 30 days
                                    //
                                    //     final currentAmount = (i == monthsInPeriod - 1) ? totalAmount - (amountPerMonth * i) : amountPerMonth;
                                    //
                                    //     final mDividedAmount = {
                                    //       'from_date': currentDate.toIso8601String(),
                                    //       'to_date': toDate.toIso8601String(),
                                    //       'amount': currentAmount,
                                    //     };
                                    //
                                    //     dividedAmounts.add(mDividedAmount);
                                    //     // print(dividedAmounts);
                                    //   }
                                    //
                                    //   return dividedAmounts;
                                    // }
                                    //
                                    //
                                    // final dividedAmounts = divideAmountMonthly(startDate, endDate, amount);
                                    //
                                    //
                                    // print('Divided Amounts: $dividedAmounts');
                                  } else if (tenantController
                                      .paymentScheduleId.value ==
                                      1) {
                                    // List<Map<String, dynamic>> divideAmountMonthly(DateTime startDate, DateTime endDate, double totalAmount) {
                                    //   final dividedAmounts = <Map<String, dynamic>>[];
                                    //
                                    //
                                    //   // final daysInPeriod = endDate.day - startDate.day + int.parse(dailyController.text.toString()) * (endDate.month - startDate.month);
                                    //   //
                                    //   // print('These days $daysInPeriod');
                                    //   // print('end day $daysInPeriod');
                                    //   // print('start day $daysInPeriod');
                                    //   // // print('start day $daysInPeriod');
                                    //
                                    //   // final amountPerMonth = totalAmount / daysInPeriod;
                                    //
                                    //
                                    //
                                    //
                                    //   for (int i = 0; i < int.parse(amountController.text); i++) {
                                    //
                                    //
                                    //     final currentDate = DateTime(startDate.year, startDate.month, startDate.day + i);
                                    //     // Define the end date of the next period
                                    //     final toDate = DateTime(currentDate.year, currentDate.month, currentDate.day + 1); // Next period is 30 days
                                    //
                                    //     // final currentAmount = (i == daysInPeriod - 1) ? totalAmount - (amountPerMonth * i) : amountPerMonth;
                                    //
                                    //     final mDividedAmount = {
                                    //       'from_date': currentDate.toIso8601String(),
                                    //       'to_date': toDate.toIso8601String(),
                                    //       'amount': totalAmount,
                                    //     };
                                    //
                                    //     dividedAmounts.add(mDividedAmount);
                                    //     // print(dividedAmounts);
                                    //   }
                                    //
                                    //   return dividedAmounts;
                                    // }
                                    //
                                    //
                                    // final dividedAmounts = divideAmountMonthly(
                                    //     selectedDate1.value,
                                    //     selectedDate2.value,
                                    //     double.parse(discountController.text.toString()));
                                    //
                                    //
                                    // print('Daily Divided Amounts: $dividedAmounts');
                                    //
                                  } else if (tenantController
                                      .paymentScheduleId.value ==
                                      2) {
                                    //
                                    // List<Map<String, dynamic>> divideAmountMonthly(DateTime startDate, DateTime endDate, double totalAmount) {
                                    //   final dividedAmounts = <Map<String, dynamic>>[];
                                    //
                                    //
                                    //   final weeksInPeriod = endDate.day - startDate.day + 30 * (endDate.month - startDate.month);
                                    //
                                    //
                                    //   // final amountPerMonth = totalAmount / daysInPeriod;
                                    //
                                    //
                                    //   for (int i = 0; i < weeksInPeriod; i++) {
                                    //
                                    //
                                    //     final currentDate = DateTime(startDate.year, startDate.month, startDate.day + i);
                                    //     // Define the end date of the next period
                                    //     final toDate = DateTime(currentDate.year, currentDate.month, currentDate.day + 1); // Next period is 30 days
                                    //
                                    //     // final currentAmount = (i == daysInPeriod - 1) ? totalAmount - (amountPerMonth * i) : amountPerMonth;
                                    //
                                    //     final mDividedAmount = {
                                    //       'from_date': currentDate.toIso8601String(),
                                    //       'to_date': toDate.toIso8601String(),
                                    //       'amount': totalAmount,
                                    //     };
                                    //
                                    //     dividedAmounts.add(mDividedAmount);
                                    //     // print(dividedAmounts);
                                    //   }
                                    //
                                    //   return dividedAmounts;
                                    // }
                                    //
                                    //
                                    // final dividedAmounts = divideAmountMonthly(
                                    //     selectedDate1.value,
                                    //     selectedDate2.value,
                                    //     double.parse(discountController.text.toString()));
                                    //
                                    //
                                    // print('Daily Divided Amounts: $dividedAmounts');
                                  } else {}

                                  // if (_formKey.currentState!.validate()) {
                                  //   // print(selectedDate1.value.toString().runtimeType);
                                  //   // print(date2Controller.text.trim().runtimeType);
                                  //   // print('1st date ${selectedDate3.value}');
                                  //   // print('2nd date ${DateTime.parse(date2Controller.text)}');
                                  //
                                  //   tenantController.addTenantToUnit(
                                  //     tenantController.tenantId.value,
                                  //     "userStorage.read('userProfileId')",
                                  //     tenantController.unitId.value,
                                  //     selectedDate1.value.toString(),
                                  //     selectedDate2.value.toString(),
                                  //     // date2Controller.text.trim().toString(),
                                  //     int.parse(amountController.text.toString()),
                                  //     int.parse(discountController.text.toString()),
                                  //   );
                                  //
                                  //
                                  // } else {
                                  //
                                  // }
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                print(value.value.id);
                                tenantController.setTenantId(value.value.id);
                                print(
                                    'MY TEnant is ${tenantController.tenantId
                                        .value}');
                              },
                            );
                          }),

                          // Obx(() {
                          //   return SearchableUnitDropDown<UnitModel>(
                          //     hintText: 'Unit',
                          //     menuItems: tenantController.unitList.value,
                          //     controller: _unitCont,
                          //     onChanged: (value) {
                          //       print(value.value.id);
                          //       tenantController.setUnitId(value.value.id);
                          //       tenantController
                          //           .setUnitAmount(value.value.amount);
                          //       amountController.text =
                          //           value.value.amount.toString();
                          //       discountController.text =
                          //           value.value.amount.toString();
                          //       print(
                          //           'MY Unit is ${tenantController.unitId
                          //               .value}');
                          //       print(
                          //           'MY Amount is ${tenantController.unitAmount
                          //               .value}');
                          //     },
                          //   );
                          // }),


                          Obx(() {
                            return SearchableUnitDropDown<UnitModel>(
                              hintText: 'Unit',
                              menuItems: tenantController.specificUnitList
                                  .value,
                              controller: _unitCont,
                              onChanged: (value) {
                                print(value.value.id);
                                tenantController.setSpecificUnitId(
                                    value.value.id);
                                tenantController
                                    .setUnitAmount(value.value.amount);
                                amountController.text =
                                    value.value.amount.toString();
                                discountController.text =
                                    value.value.amount.toString();
                                print(
                                    'MY Unit is ${tenantController
                                        .specificUnitId
                                        .value}');
                                print(
                                    'MY Amount is ${tenantController.unitAmount
                                        .value}');
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
                                  return CustomPeriodApiGenericDropdown<
                                      PaymentScheduleModel>(
                                    hintText: 'Per Month',
                                    menuItems:
                                    tenantController.paymentList.value,
                                    onChanged: (value) {
                                      tenantController
                                          .setPaymentScheduleId(value!.id!);

                                      if (tenantController
                                          .paymentScheduleId.value ==
                                          1) {
                                        var myDays =
                                        dailyController.text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            dailyController.text)! *
                                            1;

                                        if (dailyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right Day',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myDays are == ${dailyController
                                                  .text.toString()}');
                                          print('Count myDays ' +
                                              myDays.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day + myDays);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month,
                                                  selectedDate1.value.day +
                                                      myDays))}';
                                          print(
                                              'my seelected date ${selectedDate2
                                                  .value}');
                                          print(
                                              'my date date ${date2Controller
                                                  .text}');
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          2) {
                                        var myWeeks = weeklyController
                                            .text.isEmpty
                                            ? 1 * 7
                                            : int.tryParse(
                                            weeklyController.text)! *
                                            7;

                                        if (weeklyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right week',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY WEEKs are == ${weeklyController
                                                  .text.toString()}');
                                          print('Count Weeks ' +
                                              myWeeks.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day +
                                                  myWeeks);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month,
                                                  selectedDate1.value.day +
                                                      myWeeks))}';
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          3) {
                                        var myMonths = monthlyController
                                            .text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            monthlyController.text)! *
                                            1;

                                        if (monthlyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right Month',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myMonths are == ${monthlyController
                                                  .text.toString()}');
                                          print('Count myMonths ' +
                                              myMonths.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month +
                                                  myMonths,
                                              selectedDate1.value.day);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month +
                                                      myMonths,
                                                  selectedDate1.value.day))}';
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          4) {
                                        var myYears = yearlyController
                                            .text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            yearlyController.text)! *
                                            1;

                                        if (yearlyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right years',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myYears are == ${yearlyController
                                                  .text.toString()}');
                                          print('Count myYears ' +
                                              myYears.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year +
                                                  myYears,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value
                                                  .year + myYears, selectedDate1
                                                  .value.month, selectedDate1
                                                  .value.day))}';
                                        }
                                      } else {
                                        // date2Controller.text = '${DateFormat('E, d MMM yyyy').format(DateTime(selectedDate1.value.year, selectedDate1.value.month, selectedDate1.value.day))}';
                                      }
                                    },
                                  );
                                }),
                              ),
                              tenantController.paymentScheduleId.value == 10
                                  ? SizedBox(
                                child: Obx(() {
                                  return AuthTextField(
                                    controller: tenantController
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
                              )
                                  : Container(),
                              SizedBox(
                                child: Obx(() {
                                  return AuthTextField(
                                    controller: tenantController
                                        .paymentScheduleId.value ==
                                        1
                                        ? dailyController
                                        : tenantController
                                        .paymentScheduleId.value ==
                                        2
                                        ? weeklyController
                                        : tenantController.paymentScheduleId
                                        .value ==
                                        3
                                        ? monthlyController
                                        : tenantController
                                        .paymentScheduleId
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
                                        : tenantController.paymentScheduleId
                                        .value ==
                                        3
                                        ? 'Enter No. Of Months'
                                        : tenantController
                                        .paymentScheduleId
                                        .value ==
                                        4
                                        ? 'Enter No. Of Years'
                                        : 'Specific Period',
                                    obscureText: false,
                                    keyBoardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (tenantController
                                          .paymentScheduleId.value ==
                                          1) {
                                        var myDays =
                                        dailyController.text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            dailyController.text)! *
                                            1;

                                        if (dailyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right Day',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myDays are == ${dailyController
                                                  .text.toString()}');
                                          print('Count myDays ' +
                                              myDays.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day + myDays);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month,
                                                  selectedDate1.value.day +
                                                      myDays))}';
                                          print(
                                              'my seelected date ${selectedDate2
                                                  .value}');
                                          print(
                                              'my date date ${date2Controller
                                                  .text}');
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          2) {
                                        var myWeeks = weeklyController
                                            .text.isEmpty
                                            ? 1 * 7
                                            : int.tryParse(
                                            weeklyController.text)! *
                                            7;

                                        if (weeklyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right week',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY WEEKs are == ${weeklyController
                                                  .text.toString()}');
                                          print('Count Weeks ' +
                                              myWeeks.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day +
                                                  myWeeks);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month,
                                                  selectedDate1.value.day +
                                                      myWeeks))}';
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          3) {
                                        var myMonths = monthlyController
                                            .text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            monthlyController.text)! *
                                            1;

                                        if (monthlyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right Month',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myMonths are == ${monthlyController
                                                  .text.toString()}');
                                          print('Count myMonths ' +
                                              myMonths.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year,
                                              selectedDate1.value.month +
                                                  myMonths,
                                              selectedDate1.value.day);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value.year,
                                                  selectedDate1.value.month +
                                                      myMonths,
                                                  selectedDate1.value.day))}';
                                        }
                                      } else if (tenantController
                                          .paymentScheduleId.value ==
                                          4) {
                                        var myYears = yearlyController
                                            .text.isEmpty
                                            ? 1 * 1
                                            : int.tryParse(
                                            yearlyController.text)! *
                                            1;

                                        if (yearlyController.text.toString() ==
                                            '0') {
                                          Fluttertoast.showToast(
                                              msg: 'Enter Right years',
                                              gravity: ToastGravity.TOP);
                                        } else {
                                          print(
                                              'MY myYears are == ${yearlyController
                                                  .text.toString()}');
                                          print('Count myYears ' +
                                              myYears.toString());
                                          selectedDate2.value = DateTime(
                                              selectedDate1.value.year +
                                                  myYears,
                                              selectedDate1.value.month,
                                              selectedDate1.value.day);
                                          date2Controller.text =
                                          '${DateFormat('MM/dd/yyyy').format(
                                              DateTime(selectedDate1.value
                                                  .year + myYears, selectedDate1
                                                  .value.month, selectedDate1
                                                  .value.day))}';
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
                          SizedBox(
                            height: 1.h,
                          ),

                          // Text('From', style: AppTheme.appFieldTitle,),
                          //
                          // AuthTextField(
                          //   onTap: () {
                          //     _selectDate1(context);
                          //   },
                          //   controller: date1Controller,
                          //   hintText: "From",
                          //   obscureText: false,
                          // ),

                          DateTextField(
                            style: TextStyle(color: Colors.transparent),
                            onTap: () {
                              _selectDate1(context);
                            },
                            controller: date1Controller,
                            hintText: "From",
                            obscureText: false,
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          DateTextField(
                            style: TextStyle(color: Colors.transparent),
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
                                child: AuthTextField(
                                  controller: amountController,
                                  hintText: 'Amount',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,
                                  enabled: false,
                                ),
                                width: 42.5.w,
                              ),
                              SizedBox(
                                child: AuthTextField(
                                  controller: discountController,
                                  hintText: 'Discounted Amount',
                                  obscureText: false,
                                  keyBoardType: TextInputType.number,

                                ),
                                width: 42.5.w,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          DescriptionTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            keyBoardType: TextInputType.text,
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
                          //         "userStorage.read('userProfileId')",
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

                          Bounceable(
                            onTap: () {
                              pickAddTenantFile();
                            },
                            child: Container(
                                height: 15.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: AppTheme.appBgColor,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Icon(Icons.upload_file),
                                        Text(
                                          'Upload File',
                                          style: TextStyle(
                                            color: AppTheme.inActiveColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),

                          // AppButton(
                          //     title: 'Get only free rooms',
                          //     color: AppTheme.primaryColor,
                          //     function: () async{
                          //       // tenantController.fetchOnlyAvailableUnits();
                          //       await AppConfig().supaBaseClient.from('units').update(
                          //           {
                          //             "is_available" : 0,
                          //           }
                          //       ).eq('id', tenantController.specificUnitId.value);
                          //     },
                          // ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
    _unitCont = SingleValueDropDownController();
    selectedDate2.value = DateTime(selectedDate1.value.year,
        selectedDate1.value.month, selectedDate1.value.day);
    date1Controller = TextEditingController(
        text: '${DateFormat('MM/dd/yyyy').format(selectedDate1.value)}');

    if (tenantController.paymentScheduleId.value == 1) {
      var myDays = dailyController.text.isEmpty
          ? 1 * 1
          : int.tryParse(dailyController.text)! * 1;

      if (dailyController.text.toString() == '0') {
        Fluttertoast.showToast(
            msg: 'Enter Right Day', gravity: ToastGravity.TOP);
      } else {
        print('MY myDays are == ${dailyController.text.toString()}');
        print('Count myDays ' + myDays.toString());
        selectedDate2.value = DateTime(selectedDate1.value.year,
            selectedDate1.value.month, selectedDate1.value.day + myDays);
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(
            selectedDate1.value.year, selectedDate1.value.month,
            selectedDate1.value.day + myDays))}';
        print('my seelected date ${selectedDate2.value}');
        print('my date date ${date2Controller.text}');
      }
    } else if (tenantController.paymentScheduleId.value == 2) {
      int myWeeks = weeklyController.text.isEmpty
          ? 1 * 7
          : int.tryParse(weeklyController.text)! * 7;

      if (weeklyController.text.toString() == '0') {
        Fluttertoast.showToast(
            msg: 'Enter Right week', gravity: ToastGravity.TOP);
      } else {
        print('MY WEEKs are == ${weeklyController.text.toString()}');
        print('Count Weeks ' + myWeeks.toString());
        selectedDate2.value = DateTime(selectedDate1.value.year,
            selectedDate1.value.month, selectedDate1.value.day + myWeeks);
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(
            selectedDate1.value.year, selectedDate1.value.month,
            selectedDate1.value.day + myWeeks))}';
      }
    } else if (tenantController.paymentScheduleId.value == 3) {
      var myMonths = monthlyController.text.isEmpty
          ? 1 * 1
          : int.tryParse(monthlyController.text)! * 1;

      if (monthlyController.text.toString() == '0') {
        Fluttertoast.showToast(
            msg: 'Enter Right Month', gravity: ToastGravity.TOP);
      } else {
        print('MY myMonths are == ${monthlyController.text.toString()}');
        print('Count myMonths ' + myMonths.toString());
        selectedDate2.value = DateTime(selectedDate1.value.year,
            selectedDate1.value.month + myMonths, selectedDate1.value.day);
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(
            selectedDate1.value.year, selectedDate1.value.month + myMonths,
            selectedDate1.value.day))}';
      }
    } else if (tenantController.paymentScheduleId.value == 4) {
      var myYears = yearlyController.text.isEmpty
          ? 1 * 1
          : int.tryParse(yearlyController.text)! * 1;

      if (yearlyController.text.toString() == '0') {
        Fluttertoast.showToast(
            msg: 'Enter Right years', gravity: ToastGravity.TOP);
      } else {
        print('MY myYears are == ${yearlyController.text.toString()}');
        print('Count myYears ' + myYears.toString());
        selectedDate2.value = DateTime(selectedDate1.value.year + myYears,
            selectedDate1.value.month, selectedDate1.value.day);
        date2Controller.text =
        '${DateFormat('MM/dd/yyyy').format(DateTime(
            selectedDate1.value.year + myYears, selectedDate1.value.month,
            selectedDate1.value.day))}';
      }
    } else {
      date2Controller.text =
      '${DateFormat('MM/dd/yyyy').format(DateTime(
          selectedDate1.value.year, selectedDate1.value.month,
          selectedDate1.value.day + 1))}';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cnt.dispose();
    _unitCont.dispose();
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
                ),
              ),

              // SizedBox(
              //   width: 30.w,
              //   height: 6.5.h,
              //   child: AppButton(
              //       title: 'Add Tenant',
              //       color: AppTheme.primaryColor,
              //       function: () {
              //         showAsBottomSheet(context);
              //       }),
              // ),
            ],
          ),

          Obx(() {
            var groupedData = tenantController.groupAllPropertyTenants();
            return tenantController.isPropertyTenantLoading.value
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Center(
                child: Image.asset('assets/auth/logo.png', width: 35.w),),
            )
                : Expanded(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // itemCount: tenantController.propertyTenantList.length,
                  itemCount: groupedData.length,
                  itemBuilder: (context, index) {
                    var key = groupedData.keys.toList()[index];
                    var value = groupedData[key];

                    // var tenant = tenantController.propertyTenantList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            print('MY KEY ${key.runtimeType}');
                            print('MY Value $value');
                            // Get.to(() => TenantDetailsScreen(tenantController: tenantController, tenantId: int.parse(key),),
                            //     transition: Transition.rightToLeftWithFade);
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.sp),
                            child: Image.asset(
                              'assets/avatar/rian.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            'Tenant $key',
                            style: AppTheme.appTitle3,
                          ),
                          // subtitle: Text(
                          //   '${amountFormatter.format(
                          //       tenant.amount.toString())}/=',
                          //   style: AppTheme.greenTitle2,
                          // ),
                          // trailing: Text(
                          //   'Unit ${tenant.unitId}',
                          //   style: AppTheme.subText,
                          // ),
                        ),
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}
