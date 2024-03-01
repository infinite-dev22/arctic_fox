import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/screens/test/bloc/country_city_bloc.dart';
import 'package:smart_rent/screens/test/layout/country_state_list_screen_layout.dart';

class CountryCityListScreen extends StatelessWidget {
  const CountryCityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CountryCityBloc>(
        create: (context) => CountryCityBloc(),
      ),
      BlocProvider<PropertyBloc>(
        create: (context) => PropertyBloc()..add(LoadPropertiesEvent()),
      ),
    ], child: CountryCityListScreenLayout());
  }
}
