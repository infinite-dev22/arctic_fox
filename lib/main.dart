import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);

  // await Supabase.initialize(
  //   url: 'https://nbgshrovkhwomrmlfwjc.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5iZ3Nocm92a2h3b21ybWxmd2pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk2MDU0ODMsImV4cCI6MjAxNTE4MTQ4M30.laBr5eTUAoTNBjm4oCidyBaoyLCm1LZOPTWkTUjvcts',
  // );

  await Supabase.initialize(
    url: 'https://nsmowxdnkhgxyleexifv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zbW93eGRua2hneHlsZWV4aWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk4ODQ5NDYsImV4cCI6MjAxNTQ2MDk0Nn0.aNrLzAm74sF0aH04qUGyodAqRMDLs-MsLlCGRbKsd-w',
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Rent',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: HomePage(),
          home: InitialScreen(),
        );

      },
    );
  }
}


