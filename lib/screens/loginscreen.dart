// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:in_app_update/in_app_update.dart';
import 'package:mutschmiede/network/ApiManager.dart';
import 'package:mutschmiede/scaneqrcode.dart';
import 'package:mutschmiede/screens/splashscreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../GetVersionApp/get_version_android.dart';
import '../GetVersionApp/get_version_ios.dart';
import '../constants/AppConstants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final codeController = TextEditingController();
  // AppUpdateInfo? _updateInfo;
  int? index;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    //checkSession();
    init();
    super.initState();
    checkVersion(context);
    //checkForUpdate();
  }

  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("xxxx");
    print(packageInfo.version);
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        String iosVersion = await getVersionIos();
        if(packageInfo.version == iosVersion) {
          print('!=');
        } else {
          showAlertForiOS(context);
        }
        break;
      case TargetPlatform.android:
        String androidVersion = await getVersionAd();
        if(packageInfo.version == androidVersion) {
          print('!=');
        } else {
          showAlertForiOS(context);
        }
        break;
      default:
        throw 'Could not launch';
    }
  }

  Future<void> showAlertForiOS(BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Aktualisieren Sie auf die neue Version für ein besseres Erlebnis",
      buttons: [
        DialogButton(
          color: AppColors.btncolor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          height: 44,
          child: const Center(
            // child: Padding(
            //   padding: EdgeInsets.all(8.0),
              child: Text(
                " Überspringen",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        // ),
        DialogButton(
          onPressed: () {
            switch (Theme.of(context).platform) {
              case TargetPlatform.iOS:
                _launchIOS(context);
                break;
              case TargetPlatform.android:
                _launchAndroid(context);
                break;
              default:
                throw 'Could not launch';
            }
          },
          height: 44,
          color: Colors.black,
          child: const Center(
            // child: Padding(
              // padding: EdgeInsets.all(8.0),
              child: Text(
                "Update machen",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            // ),
          ),
        )
      ],
    ).show();
  }

  Future<void> _launchIOS(BuildContext context) async {
    const iosUrl = 'https://apps.apple.com/us/app/mutschmiede-app/id6448183627?uo=4';
    if (await canLaunch(iosUrl)) {
      await launch(iosUrl);
    } else {
      throw 'Could not launch ';
    }
  }

  Future<void> _launchAndroid(BuildContext context) async {
    const androidUrl =
        'https://play.google.com/store/apps/details?id=com.codemenschen.mutschmiede.mutschmiede';

    if (await canLaunch(androidUrl)) {
      await launch(androidUrl);
    } else {
      throw 'Could not launch ';
    }
  }

  _launchAppStore() async {
    const url = 'https://apps.apple.com/us/app/mutschmiede-app/id6448183627';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
    print(deviceToken);
    print("############################################################");

    // listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

      //im gonna have an alertdialog when clicking from push notification
      Alert(
        context: context,
        type: AlertType.success,
        title: title, // title from push notification data
        desc: description, // description from push notifcation data

        buttons: [
          DialogButton(
            onPressed: () {
              _launchAppStore();
            },
            height: 50,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Aktualisieren",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ).show();
    });
  }

  //get device token to use for push notification
  Future getDeviceToken() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
      String? deviceToken = await _firebaseMessage.getToken();
      return deviceToken ?? "";
    } catch (e) {
      print("Error while getting device token: $e");
      return "";
    }
  }

  /*void checkSession() async {
    bool b = await _fetchSession();
    String logoUrl=await _fetchCompanyLogoUrl();
    if (b) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(
              logoUrl
              ),
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: <Widget>[
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image(
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                image: AssetImage(AppImages.icn_NameLogo),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  AppConstants.txt_log_in,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: AppConstants.font_family),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  controller: codeController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.iconColor,
                      size: 20,
                    ),
                    hintText: AppConstants.txt_entercode,
                    hintStyle: const TextStyle(
                        fontSize: 12, fontFamily: AppConstants.font_family),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        top: 18, bottom: 18, left: 10, right: 10),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(18))),
                  child: const Text(
                    AppConstants.txt_login,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontFamily: AppConstants.font_family),
                  ),
                  onPressed: () {
                    loginCall(index, context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(18))),
                  child: const Text(
                    AppConstants.txt_QrCode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontFamily: AppConstants.font_family),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRViewExample(),
                        )).then((value) {
                      //setState(() {
                      // codeController.text = value;
                      // print(codeController.text);
                      // print(value);
                      // loginCall(index, context);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SplashScreen(""),
                      //     ));
                    });
                    // loginCall(index, context);
                  },
                ),
              ),
            ],
          ),
          const Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }

  void loginCall(index, BuildContext context) async {
    String? deviceToken = await getDeviceToken();
    try {
      if (codeController.text.toString().isEmpty) {
        EasyLoading.showToast(AppConstants.txt_plzentercode,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.show(
          status: 'Please Wait!',
          maskType: EasyLoadingMaskType.black,
        );
        Response? res =
            await ApiManager().loginApi(codeController.text.toString(), deviceToken);
        if (res != null && res.data != null) {
          Map map = res.data;
          if (map['status'] != null && map['status'].toString() == "200") {
            setSession(map['responsedata']['url_image'],
                map['responsedata']['company_name'], context);
          } else {
            EasyLoading.showToast(map['message'],
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        } else {
          EasyLoading.showToast(AppConstants.txt_somethingwrong,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
        EasyLoading.dismiss(animation: true);
      }
    } catch (e) {
      print("error >>>>>>>>>> $e");
    }
  }

  void setSession(
    String? logoUrl,
    String? company_name,
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.IS_LOGGED_IN, true);
    prefs.setString(AppConstants.LOGO_URL, logoUrl ?? "");
    prefs.setString(AppConstants.COMPANY_NAME, company_name ?? "");
    prefs.setString(
        AppConstants.VOUCHER_NUMBER, codeController.text.toString());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SplashScreen(
          "",
          // urlimage: ${Responsedata().urlImage},
        ),
      ),
    );
  }
}
