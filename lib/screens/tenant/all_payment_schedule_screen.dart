import 'package:amount_formatter/amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_text_header.dart';

class AllPaymentScheduleScreen extends StatefulWidget {
  final TenantController tenantController;
  final int tenantId;
  const AllPaymentScheduleScreen({super.key, required this.tenantController, required this.tenantId,});

  @override
  State<AllPaymentScheduleScreen> createState() => _AllPaymentScheduleScreenState();
}

class _AllPaymentScheduleScreenState extends State<AllPaymentScheduleScreen> {

  final AmountFormatter amountFormatter = AmountFormatter(separator: ',');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.tenantController.fetchAllPaymentSchedules(widget.tenantId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppTextHeader(
        title: 'All Payment Schedules',
        isTitleCentred: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return widget.tenantController.isTenantUnitListLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          // constrained: false,
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              showBottomBorder: true,
                              headingTextStyle: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.5.sp),
                              columnSpacing: 5.w,
                              columns: [
                                DataColumn(label: Text('Period')),
                                DataColumn(label: Text('Amount')),
                                DataColumn(label: Text('Paid')),
                                DataColumn(label: Text('Balance')),
                                // DataColumn(label: Text('Tenant ID')),
                                DataColumn(label: Text('Unit ID')),
                              ],
                              rows: widget.tenantController
                                  .propertyUnitScheduleList.value
                                  .map((schedule) {
                                return DataRow(
                                    // color: (livePointsController.livePointsModel.indexOf(user)+1) <= 3 ?
                                    //   MaterialStateColor.resolveWith((states) => Colors.green) : null,
                                    cells: [
                                      DataCell(Text(
                                          '${schedule.fromDate} to ${schedule.toDate}')),
                                      DataCell(
                                          Text(amountFormatter.format(schedule.amount.toString()))),
                                      DataCell(Text(amountFormatter.format(schedule.paid.toString()))),
                                      DataCell(
                                          Text(amountFormatter.format(schedule.balance.toString()))),
                                      // DataCell(
                                      //     Text(schedule.tenantId.toString())),
                                      DataCell(
                                          Text(schedule.unitId.toString())),
                                    ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
