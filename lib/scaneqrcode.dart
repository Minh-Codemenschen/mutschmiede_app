import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/screens/splashscreen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/AppConstants.dart';
import 'network/ApiManager.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  String code = "";
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              AppImages.icn_undo,
              height: 40,
              width: 40,
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            AppImages.icn_Logo,
            fit: BoxFit.cover,
            scale: 1.2,
          ),
        ),
        body: _buildQrView(context)
        // Column(
        //   children: <Widget>[
        //     Expanded(flex: 4, child: _buildQrView(context)),
        //     Expanded(
        //       flex: 1,
        //       child: FittedBox(
        //         fit: BoxFit.contain,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: <Widget>[
        //             if (result != null)
        //               Text('Data: ${result!.code}')
        //             else
        //               const Text('Scan a code'),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 270.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.appColors,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 8,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      code = scanData.code!;
      controller.dispose();
      if (isNumeric(code ?? "")) {
        print(code.length);
        if (code.length == 8) {
          print(code);
          loginCall(context);
        }
      }
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s) != null;
  }

  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }

  void loginCall(BuildContext context) async {
    String deviceToken = await getDeviceToken();
    try {
      if (code.isEmpty && code != "") {
        EasyLoading.showToast(AppConstants.txt_plzentercode,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.show(
          status: 'Please Wait!',
          maskType: EasyLoadingMaskType.black,
        );
        Response? res = await ApiManager().loginApi(code, deviceToken);
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
    prefs.setString(AppConstants.VOUCHER_NUMBER, code);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SplashScreen(
          logoUrl ?? "",
          // urlimage: ${Responsedata().urlImage},
        ),
      ),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
