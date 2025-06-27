// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:mutschmiede/screens/loginscreen.dart';
import 'package:mutschmiede/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenNormal extends StatefulWidget {
  const SplashScreenNormal({super.key});
  @override
  State<SplashScreenNormal> createState() => _SplashScreenNormalState();
}

class _SplashScreenNormalState extends State<SplashScreenNormal> {
  late Size size;
  @override
  void initState() {
    super.initState();

    proceedNext();
  }

  void startTimerAndProceed(
    bool isLoggedin,
    String url,
  ) {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    isLoggedin ? SplashScreen(url) : const LoginScreen(),
              ),
            ));
  }

  void proceedNext() async {
    bool isLoggedIn = await _fetchSession();
    if (isLoggedIn) {
      String url = await _fetchCompanyLogoUrl();
      startTimerAndProceed(true, url);
    } else {
      startTimerAndProceed(false, "");
    }
  }

  Future<bool> _fetchSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.IS_LOGGED_IN)) {
      return prefs.getBool(AppConstants.IS_LOGGED_IN) ?? false;
    } else {
      return false;
    }
  }

  Future<String> _fetchCompanyLogoUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.LOGO_URL)) {
      return prefs.getString(AppConstants.LOGO_URL) ?? "";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Image(
              height: 100,
              width: 125,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              image: AssetImage(AppImages.icn_NameLogo),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                AppConstants.txt_incorporationwith,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstants.font_family,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
