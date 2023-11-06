import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class PropertyCardWidget extends StatelessWidget {
  const PropertyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        // clipBehavior: Clip.antiAlias,
        child: Container(
          height: 25.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp),
                bottomLeft: Radius.circular(15.sp),
                bottomRight: Radius.circular(15.sp)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                  child: Image.asset('assets/property/mall1.jpg',
                    fit: BoxFit.cover,
                    height: 25.h,
                  ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding:  EdgeInsets.only(left: 2.w, top: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Imperial Mall', style: AppTheme.appTitle6,),
                      Text('Entebbe, Uganda', style: AppTheme.subText,),
                      
                      SizedBox(height: 1.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/property/bed.png'),
                              SizedBox(width: 2.w,),
                              Text('40 units', style: AppTheme.descriptionText1,)
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset('assets/property/size.png'),
                              SizedBox(width: 2.w,),
                              Text('673m', style: AppTheme.descriptionText1,)
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Image.asset('assets/property/bed.png'),
                          SizedBox(width: 2.w,),
                          Text('Occupancy - 65%', style: AppTheme.descriptionText1,)
                        ],
                      ),

                      Row(
                        children: [
                          Image.asset('assets/property/bed.png'),
                          SizedBox(width: 2.w,),
                          Text('Available - 15 units (35%', style: AppTheme.descriptionText1,)
                        ],
                      ),

                      Row(
                        children: [
                          Text('UGX 850,000', style: AppTheme.cardPrice1,),
                          Text('/ month', style: AppTheme.subText,),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
