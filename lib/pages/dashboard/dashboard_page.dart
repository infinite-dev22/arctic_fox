import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:smart_rent/pages/dashboard/widgets/dashboard_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return const DashboardLayout();
      },
      listener: (context, state) {},
    );
  }
}
