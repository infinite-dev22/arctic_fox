import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/user/bloc/user_bloc.dart';
import 'package:smart_rent/pages/user/layout/user_screen_layout.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(),
      child: const UserListScreenLayout(),
    );
  }
}
