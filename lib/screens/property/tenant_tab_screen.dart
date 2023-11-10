import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class TenantTabScreen extends StatefulWidget {
  const TenantTabScreen({super.key});

  @override
  State<TenantTabScreen> createState() => _TenantTabScreenState();
}

class _TenantTabScreenState extends State<TenantTabScreen> {

  final listSample = [
    {'first': 'peter', 'last': 'mawanda', 'amount': 50000},
    {'first': 'mark', 'last': 'jonathan', 'amount': 130000},
    {'first': 'ryan', 'last': 'jupiter', 'amount': 45000},
  ];

  final TextEditingController searchController = TextEditingController();

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
              return Container(
                height: 90.h,
                child: Center(
                  child: Material(
                    child: InkWell(
                      onTap: () => Navigator.pop(context, 'This is the result.'),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'This is the content of the sheet',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                    function: (){
                      showAsBottomSheet(context);
                    }),
              ),

            ],
          ),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listSample.length,
              itemBuilder: (context, index){
              var list = listSample[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Image.asset('assets/avatar/rian.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(list['first'].toString() + ' ' + list['last'].toString()),
                    subtitle: Text('${amountFormatter.format(list['amount'].toString())}/='),
                    trailing: Text('Unit 6'),
                  ),
                ),
              );
          })

        ],
      ),

    );
  }
}
