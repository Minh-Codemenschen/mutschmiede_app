// ignore_for_file: must_be_immutable
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:mutschmiede/screens/infoScreen/kooperatiospartner/kooperatiosPartner.dart';
import 'package:mutschmiede/screens/neueaktion/kalenderscreen.dart';
import 'package:mutschmiede/screens/noraweber/video.dart';
import 'package:mutschmiede/screens/noraweber/videotrainer.dart';

import '../constants/colors.dart';
import '../models/checkcompanystatusmodel.dart';
import '../models/videoTrainermodel.dart';
import '../network/ApiManager.dart';
import '../utils/Utils.dart';
import 'GameScreen/GameListingScreen.dart';
import 'HomeScreen/homescreenclone.dart';
import 'infoScreen/infoscreen.dart';

var mainContext;

class DashboardScreen extends StatefulWidget {
  DashboardScreen(this.urlimage, {super.key});
  String? urlimage = "";
  static String? urlImagestatic = "";
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

int currentTab = 0; // to keep track of active tab index

final PageStorageBucket bucket = PageStorageBucket();

class _DashboardScreenState extends State<DashboardScreen> {
  late Widget currentScreen;
  late HomeScreenClone homeScreenClone;
  List<VideoData>? listData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoTrainerModel();
    DashboardScreen.urlImagestatic = widget.urlimage;
    homeScreenClone = HomeScreenClone(widget.urlimage);
    currentScreen = homeScreenClone;
    checkCompanyStatus();
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.appColors,
          child: const Icon(Icons.play_arrow,
              // Icons.phone_android_outlined,
              color: Colors.black,
              size: 32 //26,
              ),
          onPressed: () {
            listData?.length == 1
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerExample(
                            url: listData?[0].videoUrl,
                            name: listData?[0].videoTitle)))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideoTrainer(),
                    ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 08,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreenClone(
                          widget.urlimage,
                        );
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          size: 30,
                          color: currentTab == 0
                              ? AppColor.black87Color
                              : AppColor.textColorGrey,
                        ),
                      ],
                    ),
                  ),
                  ress?.isShowWhistleblower == false
                      ? Container()
                      : MaterialButton(
                          minWidth: 50,
                          onPressed: () {
                            setState(() {
                              currentScreen = KooPeTatIosPartner(
                                status: 0,
                              );
                              currentTab = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppImages.icn_roman,
                                height: 25,
                                color: currentTab == 1
                                    ? AppColor.black87Color
                                    : AppColor.textColorGrey,
                              ),
                            ],
                          ),
                        ),
                  ress?.isShowCalendar == false
                      ? Container()
                      : MaterialButton(
                          minWidth: 50,
                          onPressed: () {
                            setState(() {
                              currentScreen = const CalendarScrren();
                              currentTab = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.solidCalendarCheck,
                                color: currentTab == 2
                                    ? AppColor.black87Color
                                    : AppColor.textColorGrey,
                              )
                              // Image.asset(
                              //   AppImages.icn_roman,
                              //   height: 25,
                              //   color: currentTab == 1
                              //       ? AppColor.black87Color
                              //       : AppColor.textColorGrey,
                              // ),
                            ],
                          ),
                        ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const GameListingScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.psychology,
                          size: 30,
                          color: currentTab == 3
                              ? AppColor.black87Color
                              : AppColor.textColorGrey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = InfoScreen(widget.urlimage);
                        currentTab = 4;
                      });
                    },
                    child: WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            size: 30,
                            color: currentTab == 4
                                ? AppColor.black87Color
                                : AppColor.textColorGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  CheckResponseData? ress;

  Future<CheckResponseData?> checkCompanyStatus() async {
    print('getLogIN');
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().checkCompanyStatusApi(voucherNo);
    if (res != null && res.data != null) {
      Map map = res.data;
      if (map['status'] != null && map['status'].toString() == "200") {
        CheckCompanyStatusModel checkCompanyStatusModel =
            CheckCompanyStatusModel.fromJson(map as Map<String, dynamic>);
        print('checkCompanyStatusModel');
        print(checkCompanyStatusModel);
        if (checkCompanyStatusModel != null) {
          ress = checkCompanyStatusModel.responseData;
          CheckResponseData? list = checkCompanyStatusModel.responseData;
          setState(() {});
          return list;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<List<VideoData>?> videoTrainerModel() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().videoTrainer(voucherNo);
    if (res != null && res.data != null) {
      Map map = res.data;
      VideoTrainerModel videoTrainer =
          VideoTrainerModel.fromJson(map as Map<String, dynamic>);
      if (videoTrainer != null &&
          videoTrainer.data != null &&
          videoTrainer.data!.isNotEmpty) {
        setState(() {
          listData = videoTrainer.data;
        });
        List<VideoData>? list = videoTrainer.data;
        EasyLoading.dismiss(animation: true);
        return list;
      } else {
        return [];
      }
    }

    return [];
  }
}
