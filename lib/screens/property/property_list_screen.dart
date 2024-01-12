import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/screens/property/add_property_screen.dart';
import 'package:smart_rent/screens/property/property_details_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_search_textfield.dart';
import 'package:smart_rent/widgets/property_card_widget.dart';

class PropertyListScreen extends StatefulWidget {
  final TenantController tenantController;
  final UnitController unitController;

  const PropertyListScreen(
      {super.key, required this.unitController, required this.tenantController});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {

  final TextEditingController searchController = TextEditingController();

  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: userStorage.read('roleId') == 4 ? null : ExpandableFab.location,
      floatingActionButton: userStorage.read('roleId') == 4 ? Container() : ExpandableFab(
        type: ExpandableFabType.up,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Container(
            width: 10.w,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: AppTheme.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.menu, color: Colors.white,),
              ),
            ),
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Container(
            width: 10.w,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: AppTheme.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.remove, color: Colors.white,),
              ),
            ),
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,

        ),
        children: [
          FloatingActionButton.extended(

            splashColor: Colors.transparent,
            elevation: 0.0,
            heroTag: null,
            label: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Add Property', style: AppTheme.subTextBold2)

                  ],
                ),
              ),
            ),

            onPressed: () {},
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
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
                  Image.asset('assets/home/location.png', fit: BoxFit.cover,
                      scale: 0.65),
                  Text(userStorage.read('organisationName').toString(), style: AppTheme.appTitle1,),
                ],
              ),

              Obx(() {
                return AppSearchTextField(
                  controller: searchController,
                  hintText: 'Search properties, tenants, units',
                  obscureText: false,
                  function: () {
                    // Get.to(() => AddPropertyScreen(),
                    //     transition: Transition.downToUp);
                  },
                  fillColor: AppTheme.textBoxColor,
                  number: widget.tenantController.propertyModelList.value
                      .length,

                );
              }),

              Obx(() {
                return widget.tenantController.isPropertyModelListLoading.value
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Center(
                    child: Image.asset('assets/auth/logo.png', width: 35.w),),
                ) : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.tenantController.propertyModelList.length,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      var property = widget.tenantController.propertyModelList[index];
                      return Bounceable(
                          onTap: () {
                            Get.to(() =>
                                PropertyDetailsScreen(
                                  propertyModel: property,
                                  unitController: widget.unitController,
                                  tenantController: widget.tenantController,));
                          },
                          child: SlideInUp(child: PropertyCardWidget(propertyModel: property,)));
                    });
              }),


            ],
          ),
        ),
      ),

    );
  }
}
