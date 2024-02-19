import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/user_details/bloc/user_details_bloc.dart';
import 'package:smart_rent/pages/user_details/layout/user_details_screen_layout.dart';


class UserDetailsScreen extends StatelessWidget {
  final int id;
  const UserDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailsBloc>(
      create: (context) => UserDetailsBloc(),
      child: UserDetailsScreenLayout(id: id,),
    );
  }
}
