import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/screens/property/add_property_screen.dart';
import 'package:smart_rent/screens/property/property_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_search_textfield.dart';
import 'package:smart_rent/widgets/property_card_widget.dart';

class PropertyListScreen extends StatefulWidget {
  final TenantController tenantController;
  final UnitController unitController;
  const PropertyListScreen({super.key, required this.unitController, required this.tenantController});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        isTitleCentred: true,
        leading: Text(''),
          title: 'assets/auth/logo.png',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/home/profile.png'),
                Text('Profile')
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/home/location.png', fit: BoxFit.cover,scale: 0.65),
                  Text('JK Holdings', style: AppTheme.appTitle1,),
                ],
              ),

              AppSearchTextField(
                  controller: searchController,
                  hintText: 'Search properties, tenants, units',
                  obscureText: false,
                function: (){
                    Get.to(() => AddPropertyScreen(), transition: Transition.downToUp);
                },
                fillColor: AppTheme.textBoxColor,

              ),

              ListView.builder(
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                  return Bounceable(
                    onTap: (){

                      Get.to(() => PropertyDetailsScreen(unitController: widget.unitController, tenantController: widget.tenantController,));
                    },
                      child: SlideInUp(child: PropertyCardWidget()));
              }),


            ],
          ),
        ),
      ),

    );
  }
}
