import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/home/bloc/home_bloc.dart';
import 'package:smart_rent/pages/home/layouts/home_screen_layout.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/pages/tenant/bloc/tenant_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
      ),
      BlocProvider<PropertyBloc>(create: (_) => PropertyBloc()),
      BlocProvider<TenantBloc>(create: (_) => TenantBloc()),
      BlocProvider<FloorBloc>(create: (_) => FloorBloc()),
    ], child: const HomeScreenLayout());
  }
}
