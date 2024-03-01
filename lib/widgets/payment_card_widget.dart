import 'package:flutter/material.dart';
import 'package:smart_rent/models/payment/tenant_payment_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';

class PaymentCardWidget extends StatelessWidget {
  final TenantPaymentModel tenantPaymentModel;

  const PaymentCardWidget({super.key, required this.tenantPaymentModel});

  @override
  Widget build(BuildContext context) {
    // final Rx<String> cardFitUnit = Rx<String>('');
    // final Rx<int> cardFitValue = Rx<int>(0);
    //
    // print('RX DATE1 = ${tenantPaymentModel.fromDate}');
    // print('RX DATE2 = ${tenantPaymentModel.toDate}');
    //
    // // Define two DateTime objects representing the two dates
    // // DateTime date1 = DateTime(2023, 1, 11);
    // // DateTime date2 = DateTime(2024, 1, 11);
    //
    // // Calculate the duration between the two dates
    // Duration difference = DateTime.parse(tenantPaymentModel.toDate)
    //     .difference(DateTime.parse(tenantPaymentModel.fromDate));
    // // Duration difference = DateTime.parse(date1Controller.text).difference(DateTime.parse(date2Controller.text));
    //
    // // Extract individual components (days, weeks, months, years) from the duration
    // int daysDifference = difference.inDays;
    // int weeksDifference = difference.inDays ~/
    //     7; // 7 days in a week
    // int monthsDifference = difference.inDays ~/
    //     30; // Assuming an average of 30 days in a month
    // int yearsDifference = difference.inDays ~/
    //     365; // Assuming an average of 365 days in a year
    //
    // // Determine the best fit unit
    // String cBestFitUnit;
    // int cBestFitValue;
    //
    // if (yearsDifference > 0) {
    //   cBestFitValue = yearsDifference;
    //   cBestFitUnit = cBestFitValue == 1 ? 'year' : 'years';
    //   cardFitUnit.value = cBestFitUnit;
    //   cardFitValue.value = cBestFitValue;
    // } else if (monthsDifference > 0) {
    //   cBestFitValue = monthsDifference;
    //   cBestFitUnit = cBestFitValue == 1 ? 'month' : 'months';
    //   cardFitUnit.value = cBestFitUnit;
    //   cardFitValue.value = cBestFitValue;
    // } else if (weeksDifference > 0) {
    //   cBestFitValue = weeksDifference;
    //   cBestFitUnit = cBestFitValue == 1 ? 'week' : 'weeks';
    //   cardFitUnit.value = cBestFitUnit;
    //   cardFitValue.value = cBestFitValue;
    // } else {
    //   cBestFitValue = daysDifference;
    //   cBestFitUnit = cBestFitValue == 1 ? 'day' : 'days';
    //   cardFitUnit.value = cBestFitUnit;
    //   cardFitValue.value = cBestFitValue;
    // }
    //
    //
    // print(
    //     'Best fit difference: $cardFitValue $cardFitUnit(s)');

    return Card(
      child: ListTile(
        title: Text(
          '${tenantPaymentModel.tenantModel?.name}',
          style: AppTheme.appTitle3,
        ),
        subtitle: Text(
          'Unit ${tenantPaymentModel.unitModel?.unitNumber.toString()}',
          style: AppTheme.subText,
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${amountFormatter.format(tenantPaymentModel.amount.toString())}/=',
              style: AppTheme.greenTitle1,
            ),
            // Text('for ${cardFitValue.value} ${cardFitUnit.toString()}')
          ],
        ),
      ),
    );
  }
}
