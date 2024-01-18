import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/details_row_widget.dart';

class TenantDetailsTab extends StatelessWidget {
  final TenantModel tenantModel;
  final TenantController tenantController;

  const TenantDetailsTab(
      {super.key, required this.tenantModel, required this.tenantController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.blue
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DetailsRowWidget(title: 'Tenant Type',
              trailing: tenantModel.tenantTypes!.name.toString(),),
            DetailsRowWidget(title: 'Business',
              trailing: tenantModel.businessTypes!.name.toString(),),
            DetailsRowWidget(title: 'Description',
              trailing: tenantModel.description.toString(),),
            DetailsRowWidget(title: 'Nationality',
              trailing: tenantModel.nationalities!.country.toString(),),
            tenantModel.tenantTypeId == 2 ? Container() :
            Text('Personal Details', style: AppTheme.blueAppTitle3,),
            tenantModel.tenantTypeId == 1
                ? DetailsRowWidget(title: 'Email',
              trailing: tenantModel.tenantProfiles!.first.email.toString(),)
                : Container(),
            tenantModel.tenantTypeId == 1
                ? DetailsRowWidget(title: 'DOB',
                trailing: DateFormat('EEE - MMM d - yyy').format(DateTime.parse(
                    tenantModel.tenantProfiles!.first.dateOfBirth!)))
                : Container(),
            tenantModel.tenantTypeId == 1
                ? DetailsRowWidget(title: 'NIN',
              trailing: tenantModel.tenantProfiles!.first.nin.toString(),)
                : Container(),
            tenantModel.tenantTypeId == 1
                ? DetailsRowWidget(title: 'Gender',
              trailing: tenantModel.tenantProfiles!.first.gender.toString(),)
                : Container(),
            tenantModel.tenantTypeId == 1
                ? DetailsRowWidget(title: 'Contact',
              trailing: tenantModel.tenantProfiles!.first.contact.toString(),)
                : Container(),
            tenantModel.tenantTypeId == 1 ? DetailsRowWidget(title: 'Summary',
              trailing: tenantModel.tenantProfiles!.first.description
                  .toString(),) : Container(),

            tenantModel.tenantTypeId == 2 ?
                Column(
                  children: [
                              Text('Contact Details', style: AppTheme.blueAppTitle3,),

                              // DetailsRowWidget(title: 'Email',
                              //   trailing: tenantController.specificTenantProfileContactList.first.email.toString(),),
                              // DetailsRowWidget(title: 'DOB',
                              //     trailing: DateFormat('EEE - MMM d - yyy').format(DateTime.parse(
                              //         tenantModel.tenantProfiles!.first.dateOfBirth!))),
                              // DetailsRowWidget(title: 'NIN',
                              //   trailing: tenantModel.tenantProfiles!.first.nin.toString(),),
                              // DetailsRowWidget(title: 'Gender',
                              //   trailing: tenantModel.tenantProfiles!.first.gender.toString(),),
                              // DetailsRowWidget(title: 'Contact',
                              //   trailing: tenantModel.tenantProfiles!.first.contact.toString(),),
                  ],
                ) : Container(),

            // tenantModel.tenantTypeId == 1 ? Container() :
            // Obx(() {
            //   // var myContact = tenantController.specificTenantProfileContactList.first;
            //   return tenantController.isSpecificTenantProfileContactsLoading.value ? Text('....')  : tenantController.specificTenantProfileContactList.isNotEmpty ? Column(
            //         children: [
            //           Text('Contact Details', style: AppTheme.blueAppTitle3,),
            //           Text(tenantController.specificTenantProfileContactList.first.email.toString()),
            //           DetailsRowWidget(title: 'Email',
            //             trailing: tenantController.specificTenantProfileContactList.first.email.toString(),),
            //           DetailsRowWidget(title: 'DOB',
            //               trailing: DateFormat('EEE - MMM d - yyy').format(DateTime.parse(
            //                   tenantModel.tenantProfiles!.first.dateOfBirth!))),
            //           DetailsRowWidget(title: 'NIN',
            //             trailing: tenantModel.tenantProfiles!.first.nin.toString(),),
            //           DetailsRowWidget(title: 'Gender',
            //             trailing: tenantModel.tenantProfiles!.first.gender.toString(),),
            //           DetailsRowWidget(title: 'Contact',
            //             trailing: tenantModel.tenantProfiles!.first.contact.toString(),),
            //
            //
            //
            //         ],
            //       ) : Text('No Contact Details', style: AppTheme.blueAppTitle3,);
            // }),

            // tenantModel.tenantTypeId == 1
            //     ? DetailsRowWidget(title: 'Email',
            //   trailing: tenantModel.tenantProfiles!.first.email.toString(),)
            //     : Container(),
            // tenantModel.tenantTypeId == 1
            //     ? DetailsRowWidget(title: 'DOB',
            //     trailing: DateFormat('EEE - MMM d - yyy').format(DateTime.parse(
            //         tenantModel.tenantProfiles!.first.dateOfBirth!)))
            //     : Container(),
            // tenantModel.tenantTypeId == 1
            //     ? DetailsRowWidget(title: 'NIN',
            //   trailing: tenantModel.tenantProfiles!.first.nin.toString(),)
            //     : Container(),
            // tenantModel.tenantTypeId == 1
            //     ? DetailsRowWidget(title: 'Gender',
            //   trailing: tenantModel.tenantProfiles!.first.gender.toString(),)
            //     : Container(),
            // tenantModel.tenantTypeId == 1
            //     ? DetailsRowWidget(title: 'Contact',
            //   trailing: tenantModel.tenantProfiles!.first.contact.toString(),)
            //     : Container(),
            // tenantModel.tenantTypeId == 1 ? DetailsRowWidget(title: 'Summary',
            //   trailing: tenantModel.tenantProfiles!.first.description
            //       .toString(),) : Container(),

          ],
        ),
      ),
    );
  }
}
