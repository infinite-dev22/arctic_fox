import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  final UserController userController = Get.put(
    UserController(),
  );

  final TenantController tenantController = Get.put(
    TenantController(),
  );

  dynamic selected;
  var heart = false;
  PageController controller = PageController(

  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userController;
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavBarController bottomNavBarController =
        Get.put(BottomNavBarController());
    final screens = [
      // HomePage(userController: userController, tenantController:  tenantController,),
      HomeScreen(),
      // CountryCityListScreen(),
      FindScreen(),
      // AddScreen(),
      EmployeeListScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 0,
      ),
      // extendBody: true, //to make floating action button notch transparent

      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            selectedColor: AppTheme.primaryColor,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            selectedColor: AppTheme.primaryColor,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Users'),
          ),
          BottomBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            selectedColor: AppTheme.primaryColor,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Search'),
          ),
          BottomBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            selectedColor: AppTheme.primaryColor,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Profile'),
          ),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),

      floatingActionButton: CircleAvatar(
        backgroundColor: AppTheme.primaryColor,
        child: Center(
          child: FaIcon(FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: const [
            HomeScreen(),
            EmployeeListScreen(),
            FindScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
