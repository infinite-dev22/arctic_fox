import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({Key? key, required this.mobile, this.tablet, required this.desktop}) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 480;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 800 &&
          MediaQuery.of(context).size.width >= 480;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if(size.width >= 800){
      return desktop;

    } else if(size.width >= 480 && tablet != null) {
      return tablet!;

    } else {
      return mobile;
    }

  }
}



// import 'package:flutter/material.dart';
//
// // bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
// // bool isTab(BuildContext context) => MediaQuery.of(context).size.width < desktop && MediaQuery.of(context).size.width >= mobile;
// // bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= desktop;
// //
//
//
// int mobileScreen = 750;
// int desktopScreen = 1100;
//
// class Responsive extends StatelessWidget {
//   final mobile;
//   final tablet;
//   final desktop;
//   Responsive({Key? key, this.mobile, this.tablet, this.desktop, }) : super(key: key);
//
//   static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 750;
//   static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 750;
//   static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (context, constraints){
//           var maxWidth = constraints.maxWidth;
//           if(maxWidth > desktop){
//             return desktop;
//           } else if(maxWidth >= mobileScreen && maxWidth <= desktopScreen){
//             return tablet ?? desktop;
//           } {
//             return mobile ?? desktop;
//           }
//         });
//   }
// }
//