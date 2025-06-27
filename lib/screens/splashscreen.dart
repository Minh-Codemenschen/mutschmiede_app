// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LoginResonse.dart';
import '../network/ApiManager.dart';
import '../utils/Utils.dart';
import 'dashboardscreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(this.urlimage, {super.key});
  String? urlimage = "";
  String? company_name = "";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size size;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(
                  widget.urlimage,
                ),
              ),
            ));
    fetcSession();
    fetch_CompanyName();
  }

  void fetcSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.urlimage = prefs.getString(AppConstants.LOGO_URL);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              height: 100,
              width: 125,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              image: AssetImage(AppImages.icn_NameLogo),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                AppConstants.txt_incorporationwith,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstants.font_family,
                ),
              ),
            ),
            (widget.urlimage != null && widget.urlimage!.isNotEmpty)
                ? /*Image(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    image: NetworkImage(
                        // "https://mutschmiede.com/wp-content/uploads/2022/11/14563c8091150387b8b477bd5b05403d_-1.png"
                        widget.urlimage!
                        // AppImages.icn_branddummy,
                        ),
                  )*/
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 35, right: 35),
                    child: CachedNetworkImage(
                      imageUrl: widget.urlimage!,
                      errorWidget: (context, url, error) => Container(),
                    ),
                  )
                /*CachedNetworkImage(
              imageUrl: widget.urlimage!,
              imageBuilder: (context, imageProvider) => Image(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                image: NetworkImage(
                  // "https://mutschmiede.com/wp-content/uploads/2022/11/14563c8091150387b8b477bd5b05403d_-1.png"
                    widget.urlimage!
                  // AppImages.icn_branddummy,
                ),
              ),
              errorWidget: (context, url, error) => Container(),
            )*/
                : Container(),
          ],
        ),
      ),
    );
  }

  void fetch_CompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.company_name = prefs.getString(AppConstants.COMPANY_NAME) ?? "";
    setState(() {});
  }

  dynamic login;
  String? is_show_whistleblower, is_show_calendar;

  Future<Responsedata?> getLoginResponse() async {
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().aktuelLes(voucherNo);
    if (res != null && res.data != null) {
      Map map = res.data;
      if (map['status'] != null && map['status'].toString() == "200") {
        LoginRespons loginRespons =
            LoginRespons.fromJson(map as Map<String, dynamic>);
        print('loginRespons');
        print(loginRespons);
        if (loginRespons != null && loginRespons.responsedata != null) {
          is_show_whistleblower =
              loginRespons.responsedata?.is_show_whistleblower;
          is_show_calendar = loginRespons.responsedata?.is_show_calendar;
          login = loginRespons.responsedata;
          return login;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
    return null;
  }
}
