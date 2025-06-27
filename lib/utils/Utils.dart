// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/AppConstants.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../screens/loginscreen.dart';
import '../widgets/custombtn.dart';

class Utility {
  static Future<String> fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.VOUCHER_NUMBER) ?? "";
  }

  static void showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            AppConstants.LABEL_LOGOUT_MESSAGE,
            style: AppTextStyle.tabBarTextStyle,
          ),
          actions: <Widget>[
            CustomBtn(
              text: AppConstants.LABEL_YES,
              background: AppColors.btncolor,
              onPressed: () {
                clearSession(context);
              },
            ),
            CustomBtn(
              text: AppConstants.LABEL_NO,
              background: AppColor.black87Color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void clearSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false);
  }
}
