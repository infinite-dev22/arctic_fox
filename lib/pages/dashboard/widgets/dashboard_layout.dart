import 'package:flutter/material.dart';
import 'package:smart_rent/pages/dashboard/widgets/occupancy_widget.dart';
import 'package:smart_rent/pages/dashboard/widgets/payments_widget.dart';
import 'package:smart_rent/pages/dashboard/widgets/properties_widget.dart';
import 'package:smart_rent/pages/dashboard/widgets/unpaid_widget.dart';
import 'package:smart_rent/styles/app_theme.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const TitleBarImageHolder(),
          bottom: _buildAppTitle(),
        ),
        body: const TabBarView(
          children: [
            PropertiesWidget(),
            PaymentsWidget(),
            UnpaidWidget(),
            OccupancyWidget(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppTitle() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Column(
        children: [
          const Text(
            "Your properties in your hands",
            style: TextStyle(color: AppTheme.whiteColor),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(color: AppTheme.primaryDarker),
            child: const TabBar(
              indicatorColor: Color(0xFF2D80E3),
              // enableFeedback: true,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 5,
                    color: Color(0xFF2D80E3),
                  ),
                ),
              ),
              tabs: [
                Tab(
                  child: Text(
                    "Properties",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payments",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Unpaid",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Occupancy",
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleBarImageHolder extends StatelessWidget {
  const TitleBarImageHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/auth/title_bar_white.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
