import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/bottom_nav_bar/bottom_nav_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/pages/employee/employee_list_screen.dart';
import 'package:smart_rent/pages/home/home_screen.dart';

import 'package:smart_rent/screens/chat/chat_screen.dart';
import 'package:smart_rent/screens/find/find_screen.dart';

import 'package:smart_rent/screens/profile/profile_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final UserController userController = Get.put(UserController(),);

  final TenantController tenantController = Get.put(
    TenantController(),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController;
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavBarController bottomNavBarController = Get.put(
        BottomNavBarController());
    final screens = [
      // HomePage(userController: userController, tenantController:  tenantController,),
      HomeScreen(),
      FindScreen(),
      // AddScreen(),
      EmployeeListScreen(),
      ChatScreen(),
      ProfileScreen(),

    ];
    return Obx(() {
      return Scaffold(
        // extendBody: true,
        backgroundColor: AppTheme.appWidgetColor,
        body: screens[bottomNavBarController.currentIndex.value],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
          child: NavigationBar(
            selectedIndex: bottomNavBarController.currentIndex.value,
            onDestinationSelected: (index) {
              bottomNavBarController.selectedIndex(index);
            },
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            height: 10.h,
            destinations: [
              NavigationDestination(
                icon: Image.asset('assets/general/home2.png'),
                label: 'Home',
                selectedIcon: Image.asset('assets/general/home.png', color: Theme.of(context).primaryColor),
              ),
              NavigationDestination(
                icon: Image.asset('assets/general/signpost.png'),
                label: 'Find',
                selectedIcon: Image.asset('assets/general/signpost.png', color: Theme.of(context).primaryColor),
              ),
              NavigationDestination(
                // icon: Image.asset('assets/home/add.png'),
                icon: Container(
                  width: 10.w,
                  height: 5.h,
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
                label: '',
                // selectedIcon: Image.asset('assets/home/add.png', color: Theme.of(context).primaryColor),
                selectedIcon: Container(
                  width: 7.5.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5.sp),
                    color: AppTheme.primaryColor,

                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 1.h),
                    child: Center(
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                  ),
                ),
              ),
              NavigationDestination(
                icon: Image.asset('assets/general/message-text.png'),
                label: 'Chat',
                selectedIcon: Image.asset('assets/general/message-text.png', color: Theme.of(context).primaryColor),
              ),
              NavigationDestination(
                icon: Image.asset('assets/general/profile.png'),
                label: 'Profile',
                selectedIcon: Image.asset('assets/general/profile.png', color: Theme.of(context).primaryColor),
              ),

            ],

          ),
        ),
      );
    });
  }
}