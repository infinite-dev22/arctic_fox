import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/tenant_requirement_widget.dart';

class TenantDetailsScreen extends StatefulWidget {
  const TenantDetailsScreen({super.key});

  @override
  State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {

  var myRequirements = [
    TenantRequirementWidget(image: 'assets/general/air.png', requirement: 'Air conditioner'),
    TenantRequirementWidget(image: 'assets/general/wifi.png', requirement: 'Free WiFi'),
    TenantRequirementWidget(image: 'assets/general/car.png', requirement: 'Free parking'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Smart Rent',
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
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
                        backgroundImage: AssetImage('assets/avatar/rian.jpg',),
                        radius: 7.5.w,
                      ),
                      SizedBox(width: 5.w,),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ryan Musk', style: AppTheme.appTitle3,),
                            Text('TENANT PRO', style: AppTheme.subText,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Image.asset('assets/general/call.png'),
                  ),
                )
                
              ],
            ),

            SizedBox(height: 2.h,),
            Text('Requirements', style: AppTheme.appTitle3,),

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

    );
  }
}
