// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'AppConstants.dart';
import 'colors.dart';

class AppTextStyle {
  AppTextStyle._();

  // ignore: prefer_const_constructors
  static TextStyle titleTextStyle = TextStyle(
    color: AppColor.black87Color,
    fontSize: 16,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
  );

  // ignore: prefer_const_constructors
  static TextStyle tabBarTextStyle = TextStyle(
      color: AppColor.black87Color,
      fontSize: 17,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.bold);

  // ignore: prefer_const_constructors
  static TextStyle textFieldTextStyle = TextStyle(
    color: AppColor.black87Color,
    // fontWeight: FontWeight.bold
    fontSize: 14,
    fontFamily: 'Raleway',
  );

  // ignore: prefer_const_constructors
  static TextStyle buttonTextTextStyle = TextStyle(
      color: AppColor.black87Color,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
      fontSize: 20);

  static TextStyle scoreTextTextStyle = const TextStyle(
      color: AppColor.black87Color,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
      fontSize: 30);

  static TextStyle commonTextStyle = const TextStyle(
    color: AppColor.black87Color,
    fontSize: 14,
    fontFamily: 'Raleway',
  );

  static TextStyle whiteTextStyle = const TextStyle(
    color: AppColor.textColorWhite,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat',
  );

  static TextStyle callRinganaTextStyle = const TextStyle(
      color: AppColor.blackColor,
      fontSize: 14,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600);
  static TextStyle callRinganaDataTextStyle = const TextStyle(
      color: AppColor.blackColor,
      fontSize: 14,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w400);

  static TextStyle TextStyleRegularLabelNewsItem = const TextStyle(
      color: AppColor.black87Color,
      fontSize: 13,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w500);

  static TextStyle TextStyleBoldLabelNewsItem = TextStyle(
      color: AppColors.appColors,
      fontSize: 15,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600);

  static TextStyle TextStyleBoldBlackNewsItem = const TextStyle(
      color: AppColor.black87Color,
      fontSize: 13,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w800);

  static TextStyle TextStyleBoldBlackNewsItemDetail = const TextStyle(
      color: AppColor.black87Color,
      fontSize: 13,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600);
}
