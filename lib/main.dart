import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';

void main() async{
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);
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


