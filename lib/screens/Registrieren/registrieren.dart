import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/app_text_style.dart';

import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../splashscreen.dart';

class Registrieren extends StatefulWidget {
  const Registrieren({Key? key}) : super(key: key);

  @override
  State<Registrieren> createState() => _RegistrierenState();
}

class _RegistrierenState extends State<Registrieren> {
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: const Image(
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                image: AssetImage(AppImages.icn_NameLogo),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              AppConstants.txt_Registrieren,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: AppConstants.font_family),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                //
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: AppConstants.txt_Vorname,
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
              ),
              Expanded(
                flex: 1,
                //
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: AppConstants.txt_Nachname,
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: AppConstants.txt_Email,
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: AppConstants.txt_Passwort,
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: AppConstants.txt_bestatigen,
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Checkbox(
                  focusColor: AppColors.appColors,
                  activeColor: AppColor.nearlyWhite,
                  autofocus: true,
                  hoverColor: AppColor.nearlyWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(04)),
                  checkColor: AppColors.appColors,
                  value: valuesecond,
                  onChanged: (bool? value) {
                    setState(() {
                      valuesecond = value!;
                    });
                  }),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    AppConstants.txt_reg,
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(18)),
              ),
              child: const Text(
                AppConstants.txt_Registrieren,
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
                    builder: (context) => SplashScreen(
                      "",
                      // urlimage: '${Responsedata().urlImage}',
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "Sie haben schon keinen Account",
              style: AppTextStyle.commonTextStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: size.height * 0.02,
            ),
            child: Text(
              "Jetzt Einloggen",
              style: AppTextStyle.titleTextStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ]));
  }
}
