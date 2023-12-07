import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class PaymentTabScreen extends StatefulWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  const PaymentTabScreen({super.key, required this.propertyDetailsOptionsController});

  @override
  State<PaymentTabScreen> createState() => _PaymentTabScreenState();
}

class _PaymentTabScreenState extends State<PaymentTabScreen> {

  final listSample = [
    {'tenant': 'vincent west', 'unit': '4', 'amount': 50000, 'period': 'month'},
    {'tenant': 'jonathan mark', 'unit': '25', 'amount': 130000, 'period': 'weeks'},
    {'tenant': 'ryan jupiter', 'unit': '61', 'amount': 250000, 'period': 'years'},

  ];

  final TextEditingController paidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  void showAsBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            color: AppTheme.appBgColor,
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
                color: AppTheme.appBgColor,
                child: Column(
                  children: [

                    Material(
                      elevation: 10,
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
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
                                    fontSize: 20.sp,
                                  ),)),

                              Text('Fill In Payment Fields', style: AppTheme
                                  .darkBlueTitle2,),

                              Bounceable(
                                  onTap: ()async{
                                    Get.back();
                                    Get.snackbar('SUCCESS', 'Payment added to your property',
                                      titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                                    );
                                  },
                                  child: Text('Add', style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 20.sp,
                                  ),)),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,
                          vertical: 1.h),
                      child:  SingleChildScrollView(
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

                            CustomGenericDropdown<String>(
                              hintText: 'Select Unit',
                              menuItems: widget.propertyDetailsOptionsController.unitList,
                              onChanged: (value){

                              },
                            ),

                            SizedBox(height: 1.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 42.5.w,
                                  child: CustomGenericDropdown<String>(
                                    hintText: 'From',
                                    menuItems: [],
                                    onChanged: (value){

                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: 42.5.w,
                                  child: CustomGenericDropdown<String>(
                                    hintText: 'To',
                                    menuItems: [],
                                    onChanged: (value){

                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 1.h,),

                            AppTextField(
                              controller: paidController,
                              hintText: 'Paid',
                              obscureText: false,
                            ),

                            SizedBox(height: 1.h,),

                            AppTextField(
                              controller: balanceController,
                              hintText: 'Balance',
                              obscureText: false,
                            ),



                            SizedBox(height: 1.h,),

                            // AppButton(
                            //   title: 'Add Payment',
                            //   color: AppTheme.primaryColor,
                            //   function: (){
                            //     Get.back();
                            //     Get.snackbar('SUCCESS', 'Payment added to your property',
                            //       titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                            //     );
                            //   },
                            // ),

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
                width: 50.w,
                child: AppTextField(
                  controller: searchController,
                  hintText: 'Search',
                  obscureText: false,
                ),
              ),

              SizedBox(
                width: 32.5.w,
                height: 6.5.h,
                child: AppButton(
                    title: 'Add Payment',
                    color: AppTheme.primaryColor,
                    function: (){
                      showAsBottomSheet(context);
                    }),
              ),

            ],
          ),

          ListView.builder(
            shrinkWrap: true,
            itemCount: listSample.length,
              itemBuilder: (context, index){
              var payment = listSample[index];

              return Card(
                child: ListTile(
                  title: Text(payment['tenant'].toString(), style: AppTheme.appTitle3,),
                  subtitle: Text('Unit ${payment['unit']}', style: AppTheme.subText,),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${amountFormatter.format(payment['amount'].toString())}/=', style: AppTheme.greenTitle1,),
                      Text('for ${index+1} ${payment['period'].toString()}')
                    ],
                  ),
                ),
              );
          }),


        ],
      ),
    );
  }
}
