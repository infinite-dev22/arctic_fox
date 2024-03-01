import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:smart_rent/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/pages/tenant/bloc/tenant_bloc.dart';
import 'package:smart_rent/pages/tenant_unit/bloc/tenant_unit_bloc.dart';
import 'package:smart_rent/pages/unit/bloc/unit_bloc.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await GetStorage.init();
  await Supabase.initialize(
    url: 'https://nsmowxdnkhgxyleexifv.supabase.co',
    // anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zbW93eGRua2hneHlsZWV4aWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk4ODQ5NDYsImV4cCI6MjAxNTQ2MDk0Nn0.aNrLzAm74sF0aH04qUGyodAqRMDLs-MsLlCGRbKsd-w',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zbW93eGRua2hneHlsZWV4aWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk4ODQ5NDYsImV4cCI6MjAxNTQ2MDk0Nn0.aNrLzAm74sF0aH04qUGyodAqRMDLs-MsLlCGRbKsd-w',
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyBloc>(
          create: (context) => CurrencyBloc(),
        ),
        BlocProvider<FloorBloc>(
          create: (context) => FloorBloc(),
        ),
        BlocProvider<TenantBloc>(
          create: (context) => TenantBloc(),
        ),
        BlocProvider<UnitBloc>(
          create: (context) => UnitBloc(),
        ),
        BlocProvider<PeriodBloc>(
          create: (context) => PeriodBloc(),
        ),
        BlocProvider<TenantUnitBloc>(
          create: (context) => TenantUnitBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // await Supabase.initialize(
  //   url: 'https://nbgshrovkhwomrmlfwjc.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5iZ3Nocm92a2h3b21ybWxmd2pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk2MDU0ODMsImV4cCI6MjAxNTE4MTQ4M30.laBr5eTUAoTNBjm4oCidyBaoyLCm1LZOPTWkTUjvcts',
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStorage.writeIfNull('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Rent',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: HomePage(),
          home: userStorage.read('isLoggedIn')
              ? BottomNavBarPage()
              : InitialScreen(),
          // home: CountryCityListScreen(),

          // home: const LoginScreen(),

          // home: UserListScreen(),
          // home: ResetPasswordScreen(email: ''),
          // home: VerifyPhoneOtpScreen(phone: '+256785556722'),
        );
      },
    );
  }
}
