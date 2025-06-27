// ignore_for_file: no_logic_in_create_state, must_be_immutable, empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/models/UserResponse.dart';
import 'package:mutschmiede/screens/dashboardscreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/customiconcard.dart';
import '../noraweber/letztercoach.dart';
import '../noraweber/noraweber.dart';

class ProfileScreen extends StatefulWidget {
  FetchUserList fetchUserList;
  ProfileScreen(this.fetchUserList, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(fetchUserList);
}

class _ProfileScreenState extends State<ProfileScreen> {
  FetchUserList fetchUserList;
  _ProfileScreenState(this.fetchUserList);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        /*leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          },
          icon: Image.asset(
            AppImages.icn_iconuserhome,
          ),
        ),*/
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ListTile(
                title: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    "Mehr über mich",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 17),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.black87Color,
                  ),
                ),
              ),
              ((widget.fetchUserList.profileStatus != null &&
                          widget.fetchUserList.profileStatus == "1") ||
                      (widget.fetchUserList.status != null &&
                          widget.fetchUserList.status == "1"))
                  ? CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.green.shade300,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          fetchUserList.avatar!,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        fetchUserList.avatar!,
                      ),
                    ),
              Container(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                alignment: Alignment.center,
                child: Text(fetchUserList.displayName!,
                    style: AppTextStyle.buttonTextTextStyle),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                    '${fetchUserList.ort},${fetchUserList.language?.toUpperCase()}',
                    style: AppTextStyle.commonTextStyle),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (fetchUserList.phoneNumbnerDisplay != null &&
                          fetchUserList.phoneNumbnerDisplay != "" &&
                          fetchUserList.phoneNumbnerDisplay != "6855") {
                        var result = await launchUrl(Uri.parse("tel:${fetchUserList.phoneNumbnerDisplay}"));
                        if (result) {
                          DateTime callInitiatedTime = DateTime.now();
                          sendMessage();
                        } else {
                          EasyLoading.dismiss();
                        }
                      }
                      else {
                        EasyLoading.showToast(AppConstants.Phone_Number,
                            toastPosition: EasyLoadingToastPosition.bottom);
                      }
                    },
                    child: const CustomCard(
                      title: 'Anrufen',
                      icon: Icons.phone,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: AppConstants.mailTo,
                          query: encodeQueryParameters(<String, String>{
                            'subject': AppConstants.subject,
                          }),
                        );
                        launchUrl(emailLaunchUri);
                      },
                      child:  const CustomCard(
                        title: AppConstants.nachricht,
                        icon: Icons.email,
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LetzterCoach(fetchUserList),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.09,
                          width: size.width * 0.26,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: AppColors.bgColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (isSelected == false)
                                    ? InkWell(
                                        onTap: () {
                                          _init("${fetchUserList.mp3}", false);
                                          setState(() {
                                            isSelected = true;
                                          });
                                        },
                                        child: Image.asset(
                                          AppImages.icn_pause,
                                          height: 25,
                                          width: 25,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          _init("${fetchUserList.mp3}", true);
                                          setState(() {
                                            isSelected = false;
                                          });
                                        },
                                        child: Image.asset(
                                          AppImages.icn_play,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                const Text(AppConstants.sprachprobe)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.79,
                child: Card(
                  color: AppColors.bgColor,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 3.5),
                        alignment: Alignment.centerLeft,
                        child: const Text("Diese Sprachen\nspreche ich:"),
                      ),
                      const Spacer(),
                      ListView.builder(
                        itemBuilder: (ctx, ind) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.network(
                                fetchUserList.urlIconLanguage![ind],
                              ),
                            ),
                          );
                        },
                        itemCount: fetchUserList.urlIconLanguage != null
                            ? fetchUserList.urlIconLanguage!.length
                            : 0,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Html(
                      data: (fetchUserList.shortIntro != null &&
                              fetchUserList.shortIntro!.isNotEmpty)
                          ? fetchUserList.shortIntro!
                          : "",
                    ),
                    Text(
                      AppConstants.meine,
                      style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(
                          color: AppColors.appColors, fontSize: 20),
                    ),
                    Html(
                      data: (fetchUserList.intro != null &&
                              fetchUserList.intro!.isNotEmpty)
                          ? fetchUserList.intro
                          : "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isSelected = true;
  final AudioPlayer _player = AudioPlayer();
  Future<void> _init(String link, bool isPlay) async {
    try {
      if (isPlay == true) {
        EasyLoading.show(
            maskType: EasyLoadingMaskType.black, status: "please Wait");
        await _player.setAudioSource(AudioSource.uri(Uri.parse(link)));
        EasyLoading.dismiss(animation: true);
        _player.play();

        _player.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.ready ||
              state == ProcessingState.idle) {}
        });
      } else {
        _player.pause();
        _player.stop();
        setState(() {
          isSelected = true;
        });
      }
    } catch (e) {
      EasyLoading.showToast("Fehler beim Abspielen von Audio",
          toastPosition: EasyLoadingToastPosition.bottom);
      _player.pause();
      _player.stop();
      setState(() {
        isSelected = true;
      });
    }
  }

  void sendMessage() async {
    try {
      if (fetchUserList.phoneNumbnerDisplay.toString().isEmpty) {
        EasyLoading.showToast(AppConstants.txt_plzentercode,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        String? voucherNo = await Utility.fetchUserId();
        print('******************** parameters');
        Response? res = await ApiManager().callPhoneNumber(
          int.parse(voucherNo),
          int.parse(fetchUserList.phoneNumbnerDisplay ?? ""),
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
