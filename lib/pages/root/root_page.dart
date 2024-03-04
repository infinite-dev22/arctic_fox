import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/dashboard/dashboard_page.dart';
import 'package:smart_rent/pages/employee/employee_list_screen.dart';
import 'package:smart_rent/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/pages/root/widgets/bottom_nav_bar.dart';
import 'package:smart_rent/pages/root/widgets/screen.dart';
import 'package:smart_rent/screens/find/find_screen.dart';
import 'package:smart_rent/screens/profile/profile_screen.dart';

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
}
