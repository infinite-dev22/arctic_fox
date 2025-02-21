import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/dashboard/dashboard_page.dart';
import 'package:smart_rent/pages/employee/employee_list_screen.dart';
import 'package:smart_rent/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/pages/root/widgets/bottom_nav_bar.dart';
import 'package:smart_rent/pages/root/widgets/screen.dart';
import 'package:smart_rent/screens/find/find_screen.dart';
import 'package:smart_rent/screens/profile/profile_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        screens: _screens(),
        onFabTap: _buildAddWidget,
      ),
      body: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return _buildRootViewStack();
        },
      ),
    );
  }

  List<Screen> _screens() {
    return [
      const Screen(
        index: 0,
        name: "Home",
        icon: Icons.home,
        widget: DashboardPage(),
      ),
      const Screen(
        index: 1,
        name: "Employees",
        icon: Icons.people,
        widget: EmployeeListScreen(),
      ),
      const Screen(),
      const Screen(
        index: 3,
        name: "Search",
        icon: Icons.search,
        widget: FindScreen(),
      ),
      const Screen(
        index: 4,
        name: "Profile",
        icon: Icons.person,
        widget: ProfileScreen(),
      ),
    ];
  }

  Widget _buildRootViewStack() {
    return IndexedStack(
      index: context.read<NavBarBloc>().state.idSelected,
      children: List.generate(
        _screens().length,
        (index) => _screens()[index].widget ?? Container(),
      ),
    );
  }

  _buildAddWidget() {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Tenant",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.house),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Property",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton.outlined(
                    style: const ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                        AppTheme.inActiveColor,
                      ),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppTheme.inActiveColor,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.bed),
                    iconSize: 45,
                  ),
                  const Text(
                    "Add Floor",
                    style: TextStyle(
                      color: AppTheme.inActiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
