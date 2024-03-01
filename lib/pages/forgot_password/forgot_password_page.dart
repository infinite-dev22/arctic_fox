import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:smart_rent/pages/forgot_password/layout/forgot_password_screen_layout.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: ForgotPasswordScreenLayout(),
    );
  }
}
