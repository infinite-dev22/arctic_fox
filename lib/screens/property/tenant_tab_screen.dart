import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/screens/tenant/tenant_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
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
  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController date2Controller = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  final Rx<DateTime> selectedDate1 = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedDate2 = Rx<DateTime>(DateTime.now());

  final TenantController tenantController = Get.put(TenantController());
  final _formKey = GlobalKey<FormState>();

  late SingleValueDropDownController _cnt;

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      selectedDate1(picked);
      date1Controller.text =
      '${selectedDate1.value.day}/${selectedDate1.value.month}/${selectedDate1
          .value.year}';
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
      '${selectedDate2.value.day}/${selectedDate2.value.month}/${selectedDate2
          .value.year}';
    }
  }


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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text('Fill In Tenant Fileds', style: AppTheme
                              .darkBlueText1,),
                          SizedBox(height: 1.h,),

                          Obx(() {
                            return CustomApiGenericTenantModelDropdown(
                              hintText: 'Select Tenant',
                              menuItems: tenantController.tenantList.value,
                              onChanged: (value) {
                                tenantController.setTenantId(value!.id);
                              },
                            );
                          }),


                          Obx(() {
                            return SearchableTenantDropDown(
                              hintText: 'Search More Tenants',
                              menuItems: tenantController.tenantList.value,
                              controller: _cnt,
                            );
                          }),

                          Obx(() {
                            return CustomApiUnitDropdown(
                              hintText: 'Select Unit',
                              menuItems: tenantController.unitList.value,
                              onChanged: (value) {
                                tenantController.setUnitId(value!.id);
                              },
                            );
                          }),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 42.5.w,
                                child: AppTextField(
                                  onTap: () {
                                    _selectDate1(context);
                                  },
                                  controller: date1Controller,
                                  hintText: "From",
                                  obscureText: false,
                                ),
                              ),
                              SizedBox(
                                width: 42.5.w,
                                child: AppTextField(
                                  onTap: () {
                                    _selectDate2(context);
                                  },
                                  controller: date2Controller,
                                  hintText: "To",
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 1.h,),

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
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                tenantController.addTenantToUnit(
                                  tenantController.tenantId.value,
                                  "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                                  tenantController.unitId.value,
                                  selectedDate1.value,
                                  selectedDate2.value,
                                  int.parse(amountController.text.toString()),
                                  int.parse(discountController.text.toString()),
                                );
                              } else {

                              }
                            },
                          ),

                        ],
                      ),
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
    _cnt = SingleValueDropDownController();
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
                        child: Image.asset('assets/avatar/rian.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(list['first'].toString() + ' ' +
                          list['last'].toString(), style: AppTheme.appTitle3,),
                      subtitle: Text('${amountFormatter.format(
                          list['amount'].toString())}/=',
                        style: AppTheme.greenTitle2,),
                      trailing: Text('Unit $index', style: AppTheme.subText,),
                    ),
                  ),
                );
              })

        ],
      ),

    );
  }
}
