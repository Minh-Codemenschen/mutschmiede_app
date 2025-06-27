// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:mutschmiede/utils/Utils.dart';

import '../../constants/app_text_style.dart';
import '../../models/profilemodel.dart';
import '../../network/ApiManager.dart';
import '../ProfileScreen/meinprofil.dart';
import '../neueaktion/neueation.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isCoachesLoaded = false;
  ProfileResponse? profileResponse;
  String? _profileImage;
  List<Areas> areaList = [];
  @override
  void initState() {
    super.initState();
    profileModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            AppImages.icn_iconuserhome,
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          AppImages.icn_Logo,
          fit: BoxFit.cover,
          scale: 1.2,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Utility.showLogoutDialog(context);
            },
          )
          /*IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NeueAktion()),
              );
            },
            icon: Image.asset(
              AppImages.icn_iconplushome,
            ),
          ),*/
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: Visibility(
          visible: isCoachesLoaded,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                      title: Container(
                        //padding: EdgeInsets.only(right: size.width * 0.19),
                        alignment: Alignment.center,
                        child: Text(
                          "Mein Profil",
                          style: AppTextStyle.buttonTextTextStyle.copyWith(
                              color: AppColors.appColors,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*leading: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MeinProfil()),
                          );
                        },
                        child: Text(
                          "",
                          style: AppTextStyle.titleTextStyle
                              .copyWith(fontSize: 15),
                        ),
                      ),*/
                  ),
                  (_profileImage == null)
                      ? CircleAvatar(
                          radius: 55,
                          backgroundColor: AppColors.appColors,
                          backgroundImage: NetworkImage(
                              profileResponse?.responsedata?.urlImage ?? ""),
                        )
                      : CircleAvatar(
                          radius: 55,
                          backgroundColor: AppColors.appColors,
                          child: Image.asset(
                            AppImages.icn_imageicon,
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lena Hacker",
                    style: AppTextStyle.buttonTextTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.10,
                    width: size.width * 0.89,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      color: AppColors.bgColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Geschlecht:',
                                  style: AppTextStyle.commonTextStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '\n${profileResponse?.responsedata?.gender ?? ""}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              )),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'Abteilung:',
                                style: AppTextStyle.commonTextStyle
                                    .copyWith(fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '\n${profileResponse?.responsedata?.department ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Standort:',
                                  style: AppTextStyle.commonTextStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '\n${profileResponse?.responsedata?.location ?? ""}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04, vertical: 05),
                    alignment: Alignment.centerLeft,
                    child:
                        Text('Über mich:', style: AppTextStyle.titleTextStyle),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      profileResponse?.responsedata?.aboutMe ?? "",
                      style: AppTextStyle.commonTextStyle,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Meine Problemfelder",
                      style: AppTextStyle.titleTextStyle,
                    ),
                    subtitle: Text(
                      "(Nur für Coaches sichtbar)",
                      style: AppTextStyle.commonTextStyle,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.centerLeft,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 7 / 12,
                                crossAxisSpacing: 15,
                                crossAxisCount: 4),
                        shrinkWrap: true,
                        itemCount: areaList.length,
                        itemBuilder: (context, index) {
                          String image = "${areaList[index].termUrl}";

                          image.replaceAll(
                              RegExp('(?<=.\\|)[^@](?=[^@]*?[^@]@)'), '/');

                          return Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  (areaList[index] != null &&
                                          areaList[index].termStatus == "1")
                                      ? CircleAvatar(
                                          radius: 50.5,
                                          backgroundColor: AppColors.appColors,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50.5,
                                          backgroundColor: Colors.grey.shade200,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                          )),
                                  SvgPicture.network(
                                    image.toString(),
                                  ),
                                ],
                              ),
                              Text(
                                areaList[index].termName ?? "",
                                style: AppTextStyle.commonTextStyle,
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
            ),
          )),
    );
  }

  void profileModel() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherno = await Utility.fetchUserId();
    Response res = await ApiManager().mainProfile(voucherno);
    if (res.statusCode == 200) {
      if (res.data != null && res.data['status'] == "200") {
        Map<String, dynamic> map = res.data;
        profileResponse = ProfileResponse.fromJson(map);
        print("$profileResponse");
        print("$map");

        if (profileResponse != null &&
            profileResponse?.responsedata != null &&
            profileResponse?.responsedata?.areas != null) {
          for (Areas area in profileResponse!.responsedata!.areas!) {
            if (area.termUrl != null) {
              areaList.add(area);
            }
          }
        }
        setState(() {});
      } else {
        EasyLoading.showToast(AppConstants.txt_somethingwrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }
}
