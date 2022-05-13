import 'package:flutter/material.dart';

var kWhiteColor = Colors.white;
var kBlackColor = Colors.black;
var bold = FontWeight.bold;
var kBlueColor = Color(0xff035AA6);
var kFacebookColor = Color(0xff3B5998);

class AppColors {
  static const background = Color(0xFFFAFAFA);
  static const lightGrey = Color(0xffEBECF0);
  static const secondary = Color(0xFFFFDE69);
  static const whiteColor = Color(0xffffffff);
  static const blackColor = Colors.black87;
}

const kPrimaryColor = Color(0xFF6061FA);
const kBackgroundColor = Color(0xFFFFFFFF);
const kErrorColor = Color(0xFFFE5350);

class Config {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}