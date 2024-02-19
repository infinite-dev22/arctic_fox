import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/employee/bloc/employee_bloc.dart';
import 'package:smart_rent/pages/employee/layout/employee_list_screen_layout.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (_) => EmployeeBloc(),
      child: EmployeeListScreenLayout(),
    );
  }
}
