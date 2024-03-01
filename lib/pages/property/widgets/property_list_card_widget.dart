import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/data_source/models/property/property_response_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';

class PropertyListCardWidget extends StatelessWidget {
  final Property propertyModel;
  final int index;

  const PropertyListCardWidget(
      {super.key, required this.propertyModel, required this.index});

  @override
  Widget build(BuildContext context) {
    // var availablePercentage= ((propertyModel.propertyUnitModel!.available! / propertyModel.propertyUnitModel!.totalUnits!.toInt()) * 100).ceil();
    // var occupiedPercentage= ((propertyModel.propertyUnitModel!.occupied! / propertyModel.propertyUnitModel!.totalUnits!.toInt()) * 100).ceil();

    // double available = propertyModel.propertyUnitModel!.available!.toDouble();
    // double occupied = propertyModel.propertyUnitModel!.occupied!.toDouble();
    // double revenue = propertyModel.propertyUnitModel!.revenue!.toDouble();
    //
    // // Calculate percentage
    // double availablePercentage = (available / revenue) * 100;
    // double occupiedPercentage = (occupied / revenue) * 100;
    //
    // // Round off to two decimal places
    // double roundedAvailable = double.parse(availablePercentage.toStringAsFixed(2));
    // double roundedOccupied = double.parse(occupiedPercentage.toStringAsFixed(2));
    //
    // // Print the result
    // print('The result as a percentage: $roundedAvailable%');
    // print('The result as a percentage: $roundedOccupied%');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        // clipBehavior: Clip.antiAlias,
        child: Container(
          height: 25.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: AppTheme.itemBgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp),
                bottomLeft: Radius.circular(15.sp),
                bottomRight: Radius.circular(15.sp)),
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
                child: CachedNetworkImage(
                  imageUrl:
                      'https://img.freepik.com/free-photo/modern-country-houses-construction_1385-14.jpg?w=900&t=st=1708264632~exp=1708265232~hmac=cc78e1288b7e9b43dff1d13acace6b0361732bec2181434728fff2f70e44c73d',
                  fit: BoxFit.cover,
                  height: 25.h,
                ),
                //   child: Image.asset('assets/property/mall1.jpg',
                //     fit: BoxFit.cover,
                //     height: 25.h,
                //   ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        propertyModel.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.appTitle6,
                      ),
                      Text(
                        propertyModel.location.toString(),
                        style: AppTheme.subText,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/property/bed.png'),
                              SizedBox(
                                width: 2.w,
                              ),
                              // Text('${propertyModel.propertyUnitModel!.totalUnits.toString()} units', style: AppTheme.descriptionText1,)
                              Text(
                                '0 units',
                                style: AppTheme.descriptionText1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('sqm'),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                propertyModel.squareMeters.toString(),
                                style: AppTheme.descriptionText1,
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/property/bed.png'),
                          SizedBox(
                            width: 2.w,
                          ),
                          Row(
                            children: [
                              Text(
                                'Available - 0 units',
                                style: AppTheme.descriptionText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/property/bed.png'),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Occupied - 0 units',
                            style: AppTheme.descriptionText1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            amountFormatter.format('200000'),
                            style: AppTheme.cardPrice1,
                          ),
                          Text(
                            '/ month',
                            style: AppTheme.subText,
                          ),
                        ],
                      ),
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
