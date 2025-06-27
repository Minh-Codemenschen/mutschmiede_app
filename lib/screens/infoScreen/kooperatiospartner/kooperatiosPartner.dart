import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/screens/dashboardscreen.dart';
import 'package:mutschmiede/screens/infoScreen/kooperatiospartner/KoopetatIosmessege.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/AppConstants.dart';
import '../../../constants/colors.dart';
import '../../../models/whistleprogram.dart';
import '../../../network/ApiManager.dart';
import '../../../utils/Utils.dart';
import '../../HomeScreen/homescreenclone.dart';

class KooPeTatIosPartner extends StatefulWidget {
  int status;
  KooPeTatIosPartner({Key? key, required this.status}) : super(key: key);

  @override
  State<KooPeTatIosPartner> createState() => _KooPeTatIosPartnerState();
}

class _KooPeTatIosPartnerState extends State<KooPeTatIosPartner> {
  late HomeScreenClone homeScreenClone;
  bool isCoachesLoaded = false;
  String? introTitle,
      introText,
      introTextBottom,
      introPhoneNumber,
      introTextOnFormBottom,
      whistleblowerUrl,
      introPhoneTextButton,
      introHeader;
  WhistleProgram? whistleProgram;
  @override
  void initState() {
    // TODO: implement initState
    whistlePartnerProgram();
    homeScreenClone = HomeScreenClone(DashboardScreen.urlImagestatic);
    super.initState();
  }

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
      body: introHeader != null
          ? SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.status == 1
                            ? InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppImages.icn_undo,
                                  height: 30,
                                  width: 30,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: size.width / 2,
                          child: Text(introHeader.toString(),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.tabBarTextStyle.copyWith(
                                  color: AppColors.appColors, fontSize: 20, fontWeight: FontWeight.w800)),
                        ),
                        IconButton(
                          onPressed: () {
                            _launchInBrowser(
                                Uri.parse(whistleblowerUrl.toString()));
                          },
                          icon: const Icon(
                            Icons.info,
                            color: AppColor.black87Color,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    Text(introTitle ?? '',
                        style: AppTextStyle.tabBarTextStyle.copyWith(
                            fontSize: 18,
                            color: AppColor.black87Color,
                            letterSpacing: 1.5
                            // style: AppTextStyle.buttonTextTextStyle
                            //     .copyWith(color: AppColor.black87Color, fontSize: 17
                            )),
                    SizedBox(
                      height: size.height * 0.02,
                      width: size.width,
                    ),
                    Text(introText.toString(),
                        maxLines: 10,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.tabBarTextStyle.copyWith(
                          fontSize: 14,
                          color: AppColor.black87Color.withOpacity(0.70),
                          fontWeight: FontWeight.w700,
                          // style: AppTextStyle.buttonTextTextStyle
                          //     .copyWith(color: AppColor.black87Color, fontSize: 17
                        )),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    //   width: size.width,
                    // ),
                    // Text(
                    //     "Mithilfe des Whistlekeeper-Programms konnen Unternehmen auf die Einhaltung von Compliance-Anforderungen aufmerksam gemacht werden.",
                    //     maxLines: 5,
                    //     style: AppTextStyle.tabBarTextStyle.copyWith(
                    //       fontSize: 14,
                    //       color: AppColor.black87Color.withOpacity(0.70),
                    //       fontWeight: FontWeight.w700,
                    //       // style: AppTextStyle.buttonTextTextStyle
                    //       //     .copyWith(color: AppColor.black87Color, fontSize: 17
                    //     )),
                    SizedBox(
                      height: size.height * 0.03,
                      width: size.width,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async{
                            print("tel:$introPhoneNumber");
                            if (introPhoneNumber != null &&
                                introPhoneNumber != "" &&
                                introPhoneNumber != "6855") {
                              var result = await launchUrl(Uri.parse("tel:$introPhoneNumber"));
                              if (result) {
                                sendMessage();
                              } else {
                                print("Error");
                              }
                            } else {
                              EasyLoading.showToast(AppConstants.Phone_Number,
                                  toastPosition: EasyLoadingToastPosition.bottom);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.icn_call,
                                height: 120,
                                width: 120,
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                  introPhoneTextButton.toString(),
                                  style: AppTextStyle.tabBarTextStyle.copyWith(
                                    fontSize: 13,
                                    color:
                                        AppColor.black87Color.withOpacity(0.50),
                                    fontWeight: FontWeight.w700,
                                    // style: AppTextStyle.buttonTextTextStyle
                                    //     .copyWith(color: AppColor.black87Color, fontSize: 17
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          hoverColor: AppColor.textColorGrey,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Koopetatiosmessege(
                                      introTextBottom: introTextOnFormBottom!,
                                      introPhoneNumber: introPhoneNumber!,
                                      introPhoneTextButton: introPhoneTextButton ?? 'Jetzt anrufen'),
                                ));
                          },
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  AppImages.icn_mail1,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Jetzt Formular\nausfullen",
                                  style: AppTextStyle.tabBarTextStyle.copyWith(
                                    fontSize: 13,
                                    color:
                                        AppColor.black87Color.withOpacity(0.50),
                                    fontWeight: FontWeight.w700,
                                    // style: AppTextStyle.buttonTextTextStyle
                                    //     .copyWith(color: AppColor.black87Color, fontSize: 17
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(introTextBottom.toString(),
                          maxLines: 5,
                          style: AppTextStyle.tabBarTextStyle.copyWith(
                            fontSize: 12,
                            color: AppColor.black87Color.withOpacity(0.50),
                            fontWeight: FontWeight.w700,
                            // style: AppTextStyle.buttonTextTextStyle
                            //     .copyWith(color: AppColor.black87Color, fontSize: 17
                          )),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  whistlePartnerProgram() async {
    print("whistlePartnerProgram >>>>>>>>>>>");
    isCoachesLoaded = false;
    dio.Response? res = await ApiManager().whistleKeeperProgram();
    print("res >>>>>>>>>>> $res");
    if (res != null && res.statusCode == 200) {
      print(res.data);
      Map map = res.data;
      print(map);
      WhistleProgram whistleProgram =
          WhistleProgram.fromJson(map as Map<String, dynamic>);
      setState(() {
        introTitle = whistleProgram.introTitle ?? '';
        introHeader = whistleProgram.introHeader ?? '';
        print(introTitle);
        introTextBottom = whistleProgram.introTextBottom ?? '';
        print(introTextBottom);
        introText = whistleProgram.introText ?? '';
        print(introText);
        introPhoneNumber = whistleProgram.introPhonenumber ?? '';
        print(introPhoneNumber);
        introTextOnFormBottom = whistleProgram.introTextOnFormBottom ?? '';
        print(introTextOnFormBottom);
        whistleblowerUrl = whistleProgram.whistleblowerUrl ?? '';
        introPhoneTextButton = whistleProgram.introPhoneTextButton ?? 'Jetzt anrufen';
        print(whistleblowerUrl);
      });
      var list = whistleProgram.introTitle;
      return list;
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    setState(() {
      isCoachesLoaded = true;
    });
  }

  void sendMessage() async {
    try {
      if (introPhoneNumber.toString().isEmpty) {
        EasyLoading.showToast(AppConstants.txt_plzentercode,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        // EasyLoading.show(
        //   status: 'Please Wait!',
        //   maskType: EasyLoadingMaskType.black,
        // );
        String? voucherNo = await Utility.fetchUserId();
        print('******************** parameters');
        Response? res = await ApiManager().callPhoneNumber(
          int.parse(voucherNo),
          int.parse(introPhoneNumber ?? ""),
          1,
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

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
