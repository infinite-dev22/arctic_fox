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
    {'tenant': 'vincent west', 'unit': '4', 'amount': 50000, 'period': 'month'},
    {'tenant': 'jonathan mark', 'unit': '25', 'amount': 130000, 'period': 'week'},
    {'tenant': 'ryan jupiter', 'unit': '61', 'amount': 250000, 'period': 'year'},

  ];

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [


          ListView.builder(
            shrinkWrap: true,
            itemCount: listSample.length,
              itemBuilder: (context, index){
              var payment = listSample[index];

              return Card(
                child: ListTile(
                  title: Text(payment['tenant'].toString()),
                  subtitle: Text('Unit ${payment['unit']}'),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(payment['amount'].toString()),
                      Text(payment['period'].toString())
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
