import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/login/bloc/login_bloc.dart';

import 'layouts/login_screen_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // userController.listenToChanges();
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginScreenLayout(),
    );
  }
}
