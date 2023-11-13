import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/bottom_nav_bar/bottom_nav_controller.dart';
import 'package:smart_rent/screens/add/add_screen.dart';
import 'package:smart_rent/screens/chat/chat_screen.dart';
import 'package:smart_rent/screens/find/find_screen.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
import 'package:smart_rent/screens/profile/profile_screen.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBarController bottomNavBarController = Get.put(
        BottomNavBarController());
    final screens = [
      HomePage(),
      FindScreen(),
      AddScreen(),
      ChatScreen(),
      ProfileScreen(),

    ];
    return Obx(() {
      return Scaffold(
        // extendBody: true,
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
                icon: Image.asset('assets/home/add.png'),
                label: '',
                selectedIcon: Image.asset('assets/home/add.png', color: Theme.of(context).primaryColor),
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