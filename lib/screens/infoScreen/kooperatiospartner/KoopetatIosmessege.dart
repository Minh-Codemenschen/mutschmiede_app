import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutschmiede/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/AppConstants.dart';
import '../../../constants/app_text_style.dart';
import '../../../network/ApiManager.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../dashboardscreen.dart';
import 'dart:io';

class Koopetatiosmessege extends StatefulWidget {
  String introTextBottom, introPhoneNumber, introPhoneTextButton;
  Koopetatiosmessege(
      {Key? key,
      required this.introTextBottom,
      required this.introPhoneNumber,
      required this.introPhoneTextButton})
      : super(key: key);

  @override
  State<Koopetatiosmessege> createState() => _KoopetatiosmessegeState();
}

class _KoopetatiosmessegeState extends State<Koopetatiosmessege> {
  TextEditingController firma = TextEditingController();
  TextEditingController ihre = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senderName = TextEditingController();
  String? imagePath;
  String? displayName;
  bool checkImage = false;
  String? mitarbeiterin;
  String? externer;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(DashboardScreen.urlImagestatic)),
            );
          },
          child: Image.asset(
            AppImages.icn_Logo,
            fit: BoxFit.cover,
            scale: 1.2,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Utility.showLogoutDialog(context);
            },
          )
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            AppImages.icn_undo,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const Spacer(),
                        Text("Whistle to us",
                            style: AppTextStyle.tabBarTextStyle.copyWith(
                                color: AppColors.appColors, fontSize: 17)),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    TextField(
                      style: const TextStyle(color: AppColor.textColorGrey),
                      cursorColor: AppColor.textColorGrey,
                      decoration: InputDecoration(
                          hintText: "Firma", //"Gmail",
                          filled: true,
                          fillColor: AppColor.textColorWhite,
                          isDense: false,
                          hintStyle: TextStyle(
                              color: AppColor.textColorGrey.withOpacity(0.70)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10))),
                      controller: firma,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.textColorWhite,
                        elevation: 0,
                      ),
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            setState(() {
                              displayName = country.name;
                              print(displayName);
                            });
                            print('Select country: ${country.displayName}');
                          },
                          countryListTheme: CountryListThemeData(
                            padding: const EdgeInsets.all(20),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20),
                                ),
                              ),
                            ),
                            searchTextStyle: const TextStyle(
                              color: AppColor.black87Color,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: size.height / 15,
                        child: Row(
                          children: [
                            displayName != null
                                ? SizedBox(
                                    width: size.width / 1.5,
                                    child: Text(displayName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColor.textColorGrey,
                                        )),
                                  )
                                : Text('Land',
                                    style: TextStyle(
                                        color: AppColor.textColorGrey
                                            .withOpacity(0.70))),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColor.black87Color),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    TextField(
                      style: const TextStyle(color: AppColor.textColorGrey),
                      cursorColor: AppColor.textColorGrey,
                      decoration: InputDecoration(
                          hintText: "Gmail",
                          filled: true,
                          fillColor: AppColor.textColorWhite,
                          isDense: false,
                          hintStyle: TextStyle(
                              color: AppColor.textColorGrey.withOpacity(0.70)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10))),
                      controller: email,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    TextField(
                      style: const TextStyle(color: AppColor.textColorGrey),
                      cursorColor: AppColor.textColorGrey,
                      decoration: InputDecoration(
                          hintText: "Name",
                          filled: true,
                          fillColor: AppColor.textColorWhite,
                          isDense: false,
                          hintStyle: TextStyle(
                              color: AppColor.textColorGrey.withOpacity(0.70)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10))),
                      controller: senderName,
                    ),
                    // TextField(
                    //   style: const TextStyle(color: AppColor.textColorGrey),
                    //   cursorColor: AppColor.textColorGrey,
                    //   decoration: InputDecoration(
                    //       hintText: "Land", //"Gmail",
                    //       filled: true,
                    //       fillColor: AppColor.textColorWhite,
                    //       isDense: false,
                    //       suffixIcon: const Icon(
                    //           Icons.keyboard_arrow_down_rounded,
                    //           color: AppColor.black87Color),
                    //       hintStyle: TextStyle(
                    //           color: AppColor.textColorGrey.withOpacity(0.70)),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //               color:
                    //                   AppColor.textColorGrey.withOpacity(0.20)),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //               color:
                    //                   AppColor.textColorGrey.withOpacity(0.20)),
                    //           borderRadius: BorderRadius.circular(10))),
                    //   controller: land,
                    // ),

                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    TextField(
                      minLines: 10,
                      maxLines: null,
                      style: const TextStyle(color: AppColor.textColorGrey),
                      cursorColor: AppColor.textColorGrey,
                      decoration: InputDecoration(
                          hintText: "Ihr Hinweis ...",
                          filled: true,
                          fillColor: AppColor.textColorWhite,
                          isDense: false,
                          suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColor.textColorBlack),
                          hintStyle: TextStyle(
                              color: AppColor.textColorGrey.withOpacity(0.70)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColor.textColorGrey.withOpacity(0.20)),
                              borderRadius: BorderRadius.circular(10))),
                      controller: ihre,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(12.0)), // Border radius
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset('assets/angst.png'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text("Foto auswählen"),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 10,),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        // Your image widget
                        Visibility(
                          child: checkImage
                              ? Image.file(
                            File(imagePath ?? ""),
                            width: 80,
                            height: 80,
                          )
                              : const SizedBox(),
                        ),
                        Visibility(
                          //visible: imagePath.isNotEmpty,
                          child: Positioned(
                            top: 5,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  imagePath = "";
                                  checkImage = false;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    MyCheckbox(
                      text: "MitarbeiterIn",
                      initialValue: false,
                      onChanged: (bool newValue) {
                        newValue ? mitarbeiterin = "mitarbeiterin" : "";
                      },
                    ),
                    const SizedBox(height: 15,),
                    const Divider(),
                    const SizedBox(height: 15,),
                    MyCheckbox(
                      text: "Externer",
                      initialValue: false,
                      onChanged: (bool newValue) {
                        newValue ? externer = "externer" : "";
                      },
                    ),
                     const SizedBox(height: 20,),
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     style: OutlinedButton.styleFrom(
                    //       elevation: 0,
                    //       backgroundColor:
                    //           AppColor.textColorGrey.withOpacity(0.30),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20)),
                    //     ),
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       height: size.height * 0.055,
                    //       width: size.width,
                    //       child: Text("datel auswahlen".toUpperCase(),
                    //           style: AppTextStyle.tabBarTextStyle.copyWith(
                    //               fontSize: 15,
                    //               color:
                    //                   AppColor.black87Color.withOpacity(0.70))),
                    //     )),
                    // SizedBox(
                    //   height: size.height * 0.015,
                    //   width: size.width,
                    // ),
                    ElevatedButton(
                        onPressed: () {
                          print("send message >>>");
                          sendMessage();
                          print("send message success >>>>>>>");
                        },
                        style: OutlinedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 0.055,
                          width: size.width,
                          child: Text("senden".toUpperCase(),
                              style: AppTextStyle.tabBarTextStyle.copyWith(
                                  fontSize: 15,
                                  color:
                                      AppColor.black87Color.withOpacity(0.70))),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    Text(widget.introTextBottom,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.tabBarTextStyle.copyWith(
                          fontSize: 11.5,
                          color: AppColor.black87Color.withOpacity(0.50),
                          fontWeight: FontWeight.w700,
                          // style: AppTextStyle.buttonTextTextStyle
                          //     .copyWith(color: AppColor.black87Color, fontSize: 17
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    Text("Doch lieber telefonisch ..?",
                        maxLines: 5,
                        style: AppTextStyle.tabBarTextStyle.copyWith(
                          letterSpacing: 1,
                          fontSize: 14,
                          color: AppColor.blackColor,
                          // style: AppTextStyle.buttonTextTextStyle
                          //     .copyWith(color: AppColor.black87Color, fontSize: 17
                        )),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            try {
                              launchUrl(
                                  Uri.parse("tel:${widget.introPhoneNumber}"));
                            } catch (e) {}
                          },
                          child: Image.asset(
                            AppImages.icn_call,
                            height: 190,
                            width: 190,
                          ),
                        ),
                        Column(
                          children: [
                            /*Text(widget.introPhoneNumber,
                                style: AppTextStyle.tabBarTextStyle.copyWith(
                                  fontSize: 11.5,
                                  color:
                                      AppColor.black87Color.withOpacity(0.80),
                                  fontWeight: FontWeight.w700,
                                  // style: AppTextStyle.buttonTextTextStyle
                                  //     .copyWith(color: AppColor.black87Color, fontSize: 17
                                )),
                            SizedBox(
                              height: size.height * 0.02,
                            ),*/
                            ElevatedButton(
                                onPressed: () {
                                  try {
                                    launchUrl(Uri.parse(
                                        "tel:${widget.introPhoneNumber}"));
                                  } catch (e) {}
                                },
                                style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.blackColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.040,
                                  child: Text(widget.introPhoneTextButton,
                                      style: AppTextStyle.tabBarTextStyle
                                          .copyWith(
                                              fontSize: 11.5,
                                              color: AppColor.textColorWhite)),
                                )),
                          ],
                        )
                      ],
                    ),
                  ]))),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        checkImage = true;
      });
    } else {
      print("Error");
    }
  }

  void sendMessage() async {
    try {
      if (firma.text.toString().isEmpty &&
          displayName.toString().isEmpty &&
          ihre.text.toString().isEmpty &&
          email.text.toString().isEmpty &&
          senderName.text.toString().isEmpty) {
        EasyLoading.showToast(AppConstants.txt_plzentercode,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.show(
          status: 'Please Wait!',
          maskType: EasyLoadingMaskType.black,
        );
        File file = File(imagePath.toString());
        String voucherNo = await Utility.fetchUserId();
        print('******************** parameters');
        // print(voucherNo);
        // print(firma.text.toString());
        // print(displayName.toString());
        // print(email.text.toString());
        // print(senderName.text.toString());
        // print(ihre.text.toString());
        // print('******************** parameters');
        Response? res = await ApiManager().Sendmail(
            voucherNo,
            firma.text.toString(),
            displayName.toString(),
            email.text.toString(),
            senderName.text.toString(),
            ihre.text.toString(),
            file,
            mitarbeiterin.toString(),
            externer.toString(),
        );
        if (res != null) {
          Map map = res.data;
          if (map['status'] != null && map['status'].toString() == "200") {
            print(map['message']);
            EasyLoading.showToast(map['message'],
                toastPosition: EasyLoadingToastPosition.bottom);
            Navigator.pop(context);
          } else {
            EasyLoading.showToast(map['message'],
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
