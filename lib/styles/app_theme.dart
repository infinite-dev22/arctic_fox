import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class AppTheme{


  static const primary = Color(0xFF1467CB); // 183D5D
  static const secondary = Color(0xFFCBE1F3);
  static const shadowColor = Colors.black;
  static const appBgColor = Color(0xFFF2F1F6);

  static const darker = Color(0xFF3E4249);
  static const red = Color(0xFFff4b60);
  static const gray = Color(0xFF68686B);
  static const gray45 = Color(0xFFB5B5B6);

  // static const secondaryColor = Color(0xFFCBE1F3);

  // static const appBgColor = Color(0xFFF2F1F6);
  // static const appBgColor = Color(0xFF1467CB);
  static const textBoxColor = Colors.white;
  static const whiteColor = Colors.white;


  static const primaryColor = Color(0xFF1467CB);
  static const inActiveColor = Colors.grey;
  static const darkerColor = Color(0xFF3E4249);
  static const blueTitleColor1 = Color(0xFF1B3954);
  static const blueTitleColor2 = Color(0xFF3C81BA);
  static const greyTextColor1 = Color(0xFF7B7F9E);
  static const fillColor = Color(0xFFF2F3F3);
  static const greenCardColor = Color(0xFF2DB398);
  static const redCardColor = Color(0xFFE65D4A);
  static const darkGray = Color(0xFF888888);
  static const blackColor1 = Color(0xFF121515);
  static const blackColor2 = Color(0xFF14223B);
  static const foundationColor = Color(0xFF1A1E25);
  static const darkBlueColor = Color(0xFF1A2B49);
  static const gray60Color = Color(0xFF4E4E53);
  static const gray70Color = Color(0xFF232326);
  static const orange1 = Color(0xFFF2994A);
  static const blackGrey = Color(0xff3a4b50ad);
  // static const shadowColor = Colors.black;
  static const greenColor = Colors.green;
  static const purpleColor1 = Colors.deepPurpleAccent;




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

  static TextStyle get descriptionText1 => GoogleFonts.hind(
    color: foundationColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get gray70Text => GoogleFonts.hind(
    color: gray70Color,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get gray70Text2 => GoogleFonts.hind(
    color: gray70Color,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get subTextInter1 => GoogleFonts.inter(
    color: gray60Color,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get darkBlueText1 => GoogleFonts.hind(
    color: darkBlueColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get darkBlueTitle2 => GoogleFonts.hind(
    color: darkBlueColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get darkBlueTitle => GoogleFonts.hind(
    color: darkBlueColor,
    fontSize: 22.5.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get purpleText1 => GoogleFonts.hind(
    color: purpleColor1,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get orangeSubText => GoogleFonts.hind(
    color: orange1,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get subTextBold => GoogleFonts.hind(
    color: blackColor1,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get subTextBold2 => GoogleFonts.hind(
    color: blackColor1,
    fontSize: 15.sp,
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

  static TextStyle get appTitle7 => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle get appTitle1 => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 22.5.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get greenTitle1 => GoogleFonts.hind(
    color: greenColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get greenTitle2 => GoogleFonts.hind(
    color: greenColor,
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get appTitle2 => GoogleFonts.hind(
    color: blueTitleColor1,
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get appTitle3 => GoogleFonts.hind(
    color: blackColor2,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get appTitle4 => GoogleFonts.hind(
    color: blackColor2,
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get appTitle5 => GoogleFonts.hind(
    color: blackColor2,
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get appTitle6 => GoogleFonts.hind(
    color: foundationColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get cardPrice1 => GoogleFonts.hind(
    color: shadowColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );


  static TextStyle get blueSubText => GoogleFonts.hind(
    color: blueTitleColor2,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.w400,
  );


  static TextStyle get subTextBold1 => GoogleFonts.hind(
    color: darkGray,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.w700,
  );


}