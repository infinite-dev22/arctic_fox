import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class AppTheme{

  static const secondaryColor = Color(0xFFCBE1F3);

  static const appBgColor = Color(0xFFF2F1F6);
  static const textBoxColor = Colors.white;
  static const whiteColor = Colors.white;


  static const primaryColor = Color(0xFF1467CB);
  static const inActiveColor = Colors.grey;
  static const darkerColor = Color(0xFF3E4249);
  static const blueTitleColor1 = Color(0xFF1B3954);
  static const blueTitleColor2 = Color(0xFF3C81BA);
  static const greyTextColor1 = Color(0xFF7B7F9E);
  static const fillColor = Color(0xFFF2F3F3);
  static const darkGray = Color(0xFF888888);
  static const blackColor1 = Color(0xFF121515);
  static const shadowColor = Colors.black;




  static TextStyle get appTitleLarge => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 35.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get appFieldTitle => GoogleFonts.karla(
    color: darkGray,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get subText => GoogleFonts.hind(
    color: greyTextColor1,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get subTextBold => GoogleFonts.hind(
    color: blackColor1,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get buttonText => GoogleFonts.hind(
    color: whiteColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get italicTitle => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static TextStyle get appTitle1 => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 22.5.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get appTitle2 => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get blueSubText => GoogleFonts.hind(
    color: blueTitleColor2,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.w400,
  );


}