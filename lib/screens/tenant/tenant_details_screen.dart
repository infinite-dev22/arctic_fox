import 'package:easy_data_table/easy_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/screens/tenant/all_payment_schedule_screen.dart';
import 'package:smart_rent/screens/tenant/specific_payment_schedule_screen.dart';
import 'package:smart_rent/models/tenant/property_tenant_schedule.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/tenant_requirement_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class TenantDetailsScreen extends StatefulWidget {
  final TenantController tenantController;

  // final int? tenantUnitId;
  final int? tenantId;

  const TenantDetailsScreen(
      {super.key, required this.tenantController, this.tenantId,});

  @override
  State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {

  final TenantController mytenantController = Get.put(TenantController());

  var myRequirements = [
    TenantRequirementWidget(
        image: 'assets/general/air.png', requirement: 'Air conditioner'),
    TenantRequirementWidget(
        image: 'assets/general/wifi.png', requirement: 'Free WiFi'),
    TenantRequirementWidget(
        image: 'assets/general/car.png', requirement: 'Free parking'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mytenantController.fetchAllPaymentSchedules(widget.tenantUnitId.toString());
    mytenantController.fetchAllPaymentSchedules(widget.tenantId!.toInt());
    mytenantController.getSpecificTenantDetails(widget.tenantId!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        title: 'assets/auth/logo.png',
        isTitleCentred: true,
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/avatar/rian.jpg',),
                          radius: 7.5.w,
                        ),
                        SizedBox(width: 5.w,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.tenantController.specificTenantName.value, style: AppTheme.appTitle3,),
                              Text('TENANT PRO', style: AppTheme.subText,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Bounceable(
                    onTap: () async {
                      final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: '0785556722'
                      );
                      if (await canLaunchUrl(phoneUri)) {
                        await launchUrl(phoneUri);
                      } else {
                        print('Cannot make Call');
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Image.asset('assets/general/call.png'),
                      ),
                    ),
                  )

                ],
              ),

              // SizedBox(height: 2.h,),
              // Text('Requirements', style: AppTheme.appTitle3,),
              //
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20.sp),
              //   child: Container(
              //     clipBehavior: Clip.antiAlias,
              //     height: 25.h,
              //     width: 90.w,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20.sp),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.6),
              //           spreadRadius: 5,
              //           blurRadius: 7,
              //           offset: Offset(0, 3), // changes position of shadow
              //         ),
              //       ],
              //     ),
              //     child: GoogleMapsWidget(
              //       mapType: MapType.terrain,
              //       sourceMarkerIconInfo: MarkerIconInfo(
              //         infoWindowTitle: 'Ryan Musk',
              //         onTapInfoWindow: (_) {
              //           print("Tapped on source info window");
              //         },
              //         assetPath: "assets/home/location.png",
              //       ),
              //       apiKey: 'AIzaSyCsl_5sdhkwJrPqgYMeYGvyMKyytrLfMG0',
              //       sourceLatLng: LatLng(
              //           0.31224095925812473, 32.5845170394287),
              //       destinationLatLng: LatLng(0, 0),
              //       zoomControlsEnabled: false,
              //       zoomGesturesEnabled: true,
              //       // destinationLatLng:  LatLng(0.31471590184881015, 32.584398366412834),
              //
              //     ),
              //   ),
              // ),

              // SizedBox(height: 2.h,),
              // Text('Description', style: AppTheme.appTitle3,),
              // ReadMoreText(
              //   'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact.',
              //   trimLines: 6,
              //   colorClickableText: AppTheme.primaryColor,
              //   trimMode: TrimMode.Line,
              //   trimCollapsedText: 'Read more',
              //   trimExpandedText: 'Show less',
              //   style: AppTheme.descriptionText1,
              //   moreStyle: AppTheme.descriptionText1,
              // ),


              SizedBox(height: 2.h,),
              Text('Tenant Unit(s) Schedule(s)', style: AppTheme.appTitle3,),

              Obx(() {
                var groupedData = widget.tenantController.groupAllPaymentSchedules();
                return widget.tenantController.isPaymentScheduleLoading.value ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Center(
                    child: Image.asset('assets/auth/logo.png', width: 35.w),),
                ) : widget.tenantController.propertyUnitScheduleList.value.isEmpty
                    ? Center(child: Text('No Units Attached')) :  Wrap(
                  alignment: WrapAlignment.center,

                  children: groupedData.keys.toList().map((unitId) => Bounceable(
                    onTap: (){
                          Get.to(() =>
                              SpecificPaymentScheduleScreen(
                                  tenantController: widget.tenantController, unitId: int.parse(unitId),));
                    },
                    child: Card(
                      color: AppTheme.primaryColor,
                        child: Padding(
                          padding:  EdgeInsets.all(17.5),
                          child: Text(unitId.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.5.sp),),
                        )),
                  )).toList(),
                );
                //     : Expanded(
                //   child: ListView.builder(
                //     itemCount: groupedData.length,
                //       itemBuilder: (context, index) {
                //         var key = groupedData.keys.toList()[index];
                //         return Text('Unit $key');
                //       }),
                // );
              }),

              SizedBox(height: 2.h,),

              AppButton(
                title: 'View All Payment Schedules',
                color: Colors.black,
                function: () async {
                  Get.to(() =>
                     AllPaymentScheduleScreen(tenantController: widget.tenantController, tenantId: widget.tenantId!));
  },
              ),


              SizedBox(height: 2.h,),
              AppButton(
                title: 'Contact',
                color: AppTheme.primaryColor,
                function: () async {
                  final Uri phoneUri = Uri(
                      scheme: 'tel',
                      path: '0785556722'
                  );
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  } else {
                    print('Cannot make Call');
                  }
                },
              ),


              // GridView.builder(
              //   // padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   itemCount: myRequirements.length,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //     itemBuilder: (context, index){
              //     var requirement = myRequirements[index];
              //     return TenantRequirementWidget(image: requirement.image, requirement: requirement.requirement);
              //     },
              // ),
              //
              // Wrap(
              //   direction: Axis.horizontal,
              //   spacing: 40.w,
              //   // spacing: 20.w,
              //   alignment: WrapAlignment.spaceBetween,
              //   children: [
              //
              //   ],
              // ),

            ],
          ),
        ),
      ),

    );
  }
}
