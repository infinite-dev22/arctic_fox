import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/property_details_widget.dart';

class PropertyDetailsTabScreen extends StatelessWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  final PropertyModel propertyModel;
  const PropertyDetailsTabScreen({super.key, required this.propertyDetailsOptionsController, required this.propertyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 6.h,),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(propertyModel.name.toString(), style: AppTheme.appTitle1,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PropertyDetailsWidget(detail: propertyModel.location.toString(),
                    icon: 'assets/general/location.png',),
                  PropertyDetailsWidget(
                    detail: ' units', icon: 'assets/property/bed.png',),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PropertyDetailsWidget(
                    detail: '',),
                  PropertyDetailsWidget(
                    detail: propertyModel.squareMeters.toString(), icon: 'assets/property/size.png',),
                ],
              ),

            ],
          )

        ],
      ),
    );
  }
}
