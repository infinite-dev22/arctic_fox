import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';

class PaymentTabScreen extends StatefulWidget {
  const PaymentTabScreen({super.key});

  @override
  State<PaymentTabScreen> createState() => _PaymentTabScreenState();
}

class _PaymentTabScreenState extends State<PaymentTabScreen> {

  final listSample = [
    {'tenant': 'peter mawanda', 'unit': '4', 'amount': 50000, 'period': 'month'},
    {'tenant': 'jonathan mark', 'unit': '25', 'amount': 130000, 'period': 'week'},
    {'tenant': 'ryan jupiter', 'unit': '61', 'amount': 250000, 'period': 'year'},

  ];

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: DataTable(
        showBottomBorder: true,
        headingTextStyle: AppTheme.appTitle3,
        columnSpacing: 5.w,
        columns: [
          DataColumn(label: Text('Tenant')),
          DataColumn(label: Text('Unit')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Period')),
        ],
        rows: listSample.map((e) {
          return DataRow
            (cells: [
            DataCell(Text(e['tenant'].toString())),
            DataCell(Text(e['unit'].toString())),
            DataCell(Text('${amountFormatter.format(e['amount'].toString())}/=')),
            DataCell(Text(e['period'].toString())),
          ]);
        }).toList(),
      ),
    );
  }
}
