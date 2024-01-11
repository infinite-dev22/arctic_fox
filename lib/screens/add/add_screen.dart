import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/screens/tenant/add_tenant_screen.dart';
import 'package:smart_rent/screens/tenant/update_company_tenant_with%20contact_screen.dart';
import 'package:smart_rent/screens/tenant/update_individual_tenant_screen.dart';
import 'package:smart_rent/screens/users/add_user_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/tenant_card_widget.dart';
import 'package:smart_rent/widgets/user_card_widget.dart';

class AddScreen extends StatefulWidget {

  const AddScreen({super.key,});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final UserController userController = Get.put(UserController(), permanent: true);

  final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.listenToAllUsersInSpecificOrganizationChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        title: 'assets/auth/logo.png',
        isTitleCentred: true,
        leading: Container(),
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 0.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Users', style: AppTheme.appTitle5,),
                        Text('Manage your users', style: AppTheme.subText,),
                      ],
                    ),
                  ),
                  userStorage.read('roleId') == 4 ? Container() : Bounceable(
                    onTap: () {
                      Get.to(() => AddUserScreen(userController: userController,),
                          transition: Transition.downToUp);
                    },
                    child: Container(
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppTheme.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Obx(() {
                return userController.isUserListLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userController.userProfileModelList.length,
                    itemBuilder: (context, index) {
                      var user = userController.userProfileModelList[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: SlideInUp(child: UserCardWidget(
                          userProfileModel: user,
                          userController: userController,
                          index: index,
                          editFunction: () {
                            // if(  tenant.tenantTypeId == 2){
                            //   Get.to(() => UpdateCompanyTenantWithContactScreen(tenantModel: tenant));
                            // } else {
                            //   Get.to(() => UpdateIndividualTenantScreen(tenantModel: tenant));
                            // }
                          },)),
                      );
                    });
              }),

            ],
          ),
        ),
      ),

    );
  }
}
