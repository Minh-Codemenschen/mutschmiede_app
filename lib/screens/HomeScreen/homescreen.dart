/*
// ignore_for_file: non_constant_identifier_names, prefer_is_empty, unnecessary_null_comparison, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/models/DashboardResponse.dart';
import 'package:mutschmiede/models/UserResponse.dart';
import 'package:mutschmiede/models/zusagenmodel.dart';

import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../../network/ApiManager.dart';
import '../../widgets/custombtn.dart';
import '../../widgets/customesliable.dart';
import '../../widgets/customlist.dart';
import '../ProfileScreen/profilescreen.dart';
import '../UserProfile/userprofile.dart';
import '../dashboardscreen.dart';
import '../neueaktion/neueation.dart';
import 'mittagsmenu.dart';
import 'termineinladung.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List Title = ["Termineinladung", "Face-2-Face Coaching"];
  bool isCoachesLoaded = false;
  late List<FetchUserList> listfetchUserList = [];
  late List<AcceptRejectResponse> zusagen = [];
  DasboardResponse? dasboardResponse;
  int index = 0;
  bool accept = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsersandNews();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
            icon: Image.asset(
              AppImages.icn_iconuserhome,
            ),
          ),
          centerTitle: true,
          title: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  DashboardScreen(DashboardScreen.urlImagestatic)),
              );
            },
            child: Image.asset(
              AppImages.icn_Logo,
              fit: BoxFit.cover,
              scale: 1.2,
            ),
          ),
          actions: [
            */
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
            ),*//*

          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(08),
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.icn_mustrfirma,
                          ),
                          fit: BoxFit.cover,
                          scale: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: size.height * 0.15,
                    child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 20),
                      child: Image.asset(
                        AppImages.icn_mustrfirma1,
                        fit: BoxFit.fill,
                        scale: 1,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: 08,
                ),
                child: Text(
                  'News',
                  style: AppTextStyle.tabBarTextStyle,
                ),
              ),
              Visibility(
                  visible: isCoachesLoaded,
                  child: (listfetchUserList != null &&
                          listfetchUserList.length > 0)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dasboardResponse!
                              .news!.termineinladung!.responsedata!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TermineinladungScreen(
                                      text: dasboardResponse!
                                          .news!
                                          .termineinladung!
                                          .responsedata![index]
                                          .attendees![index]
                                          .displayName
                                          .toString(),
                                      title: dasboardResponse!
                                          .news!
                                          .termineinladung!
                                          .responsedata![index]
                                          .name!,
                                      subtitle: dasboardResponse!
                                          .news!
                                          .termineinladung!
                                          .responsedata![index]
                                          .ort!,
                                      image: AssetName[index],
                                    ),
                                  ),
                                );
                              },
                              child: Column(children: [
                                if (isCoachesLoaded &&
                                    (dasboardResponse != null &&
                                        dasboardResponse?.news != null &&
                                        dasboardResponse
                                                ?.news?.termineinladung !=
                                            null &&
                                        dasboardResponse?.news?.termineinladung
                                                ?.responsedata !=
                                            null &&
                                        dasboardResponse!.news!.termineinladung!
                                                .responsedata!.length >
                                            0))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 08),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (isCoachesLoaded &&
                                              (dasboardResponse != null &&
                                                  dasboardResponse?.news !=
                                                      null &&
                                                  dasboardResponse?.news
                                                          ?.termineinladung !=
                                                      null &&
                                                  dasboardResponse!
                                                          .news!
                                                          .termineinladung!
                                                          .responsedata!
                                                          .length >
                                                      0))
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(05),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: size.height * 0.12,
                                                  width: size.width * 0.25,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.bgColor,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            AssetName[index]),
                                                        scale: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomList(
                                                        subtitle:
                                                            dasboardResponse!
                                                                .news!
                                                                .termineinladung!
                                                                .responsedata![
                                                                    0]
                                                                .ort!
                                                                .toString(),
                                                        text: dasboardResponse!
                                                            .news!
                                                            .termineinladung!
                                                            .responsedata![
                                                                index]
                                                            .attendees![index]
                                                            .displayName
                                                            .toString(),
                                                      ),
                                                      Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15),
                                                          child: Text(
                                                            dasboardResponse!
                                                                .news!
                                                                .termineinladung!
                                                                .responsedata![
                                                                    index]
                                                                .name!
                                                                .toString(),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ((dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata !=
                                                          null &&
                                                      dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata![
                                                                  index]
                                                              .accept !=
                                                          null &&
                                                      dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata![
                                                                  index]
                                                              .accept ==
                                                          "0") &&
                                                  (dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata !=
                                                          null &&
                                                      dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata![
                                                                  index]
                                                              .cancel !=
                                                          null &&
                                                      dasboardResponse
                                                              ?.news
                                                              ?.termineinladung
                                                              ?.responsedata![
                                                                  index]
                                                              .cancel ==
                                                          "0"))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CustomBtn(
                                                      text: "Zusagen",
                                                      background:
                                                          AppColors.btncolor,
                                                      onPressed: () {
                                                        setState(() {
                                                          _showMyDialog(
                                                              '${dasboardResponse?.news?.termineinladung?.responsedata![index].postId}',
                                                              false); //from accept
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 05,
                                                    ),
                                                    CustomBtn(
                                                      text: "Anzeigen",
                                                      background:
                                                          AppColor.black87Color,
                                                      onPressed: () {
                                                        setState(() {
                                                          _showMyDialog(
                                                              '${dasboardResponse?.news?.termineinladung?.responsedata![index].postId}',
                                                              true);
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 05,
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 08),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isCoachesLoaded &&
                                            (dasboardResponse != null &&
                                                dasboardResponse?.news !=
                                                    null &&
                                                dasboardResponse?.news
                                                        ?.termineinladung !=
                                                    null &&
                                                dasboardResponse!
                                                        .news!
                                                        .termineinladung!
                                                        .responsedata!
                                                        .length >
                                                    0))
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(05),
                                                alignment: Alignment.centerLeft,
                                                height: size.height * 0.12,
                                                width: size.width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: AppColors.bgColor,
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          AssetName[1]),
                                                      scale: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomList(
                                                      subtitle:
                                                          dasboardResponse!
                                                              .news!
                                                              .f2fCoaches![
                                                                  index]
                                                              .ort!
                                                              .toString(),
                                                      text: dasboardResponse!
                                                          .news!
                                                          .termineinladung!
                                                          .responsedata![0]
                                                          .attendees![1]
                                                          .displayName
                                                          .toString(),
                                                    ),
                                                    Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text(
                                                          dasboardResponse!
                                                              .news!
                                                              .termineinladung!
                                                              .responsedata![
                                                                  index]
                                                              .name!
                                                              .toString(),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        (accept = true)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomBtn(
                                                    text: "Zusagen",
                                                    background:
                                                        AppColors.btncolor,
                                                    onPressed: () {
                                                      setState(() {
                                                        _showMyDialog(
                                                            '${dasboardResponse?.news?.termineinladung?.responsedata![index].postId}',
                                                            false);
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 05,
                                                  ),
                                                  CustomBtn(
                                                    text: "Anzeigen",
                                                    background:
                                                        AppColor.black87Color,
                                                    onPressed: () {
                                                      setState(() {
                                                        _showMyDialog(
                                                            '${dasboardResponse?.news?.termineinladung?.responsedata![index].postId}',
                                                            true);
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 05,
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isCoachesLoaded &&
                                    (dasboardResponse != null &&
                                        dasboardResponse?.news != null &&
                                        dasboardResponse?.news?.menu != null &&
                                        dasboardResponse!.news!.menu!.length >
                                            0))
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MittagsMenu(),
                                        ),
                                      );
                                      // _dialogBuilders();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: CustomeSliable(
                                        text: "Mittagsmenü",
                                        subtitle2: dasboardResponse!
                                            .news!
                                            .menu![index]
                                            .menuItems![index]
                                            .menuFieldName1
                                            .toString(),
                                        subtitle1: "Kürbiscremesuppe",
                                        // dasboardResponse!.news!.menu![index]
                                        //     .menuItems![index].menuFieldName2
                                        //     .toString(),

                                        assetName: AppImages.icn_burger,
                                        subtitle: 'Montag,28.02.2022',
                                      ),
                                    ),
                                  ),
                              ]),
                            );
                          })
                      : Container()),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03, vertical: 08),
                child: Text(
                  'Verfügbare Coaches',
                  style: AppTextStyle.tabBarTextStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                margin: const EdgeInsets.all(08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Visibility(
                  visible: isCoachesLoaded,
                  child: (listfetchUserList != null &&
                          listfetchUserList.length > 0)
                      ? GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5 / 7,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemCount: listfetchUserList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                              listfetchUserList[index]),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: size.width * 0.16,
                                      backgroundColor: Colors.green.shade300,
                                      child: CircleAvatar(
                                        radius: size.width * 0.13,
                                        backgroundImage: NetworkImage(
                                          listfetchUserList[index].avatar!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 03,
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: ListView.builder(
                                          itemBuilder: (ctx, ind) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2),
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Image.network(
                                                  listfetchUserList[index]
                                                      .urlIconLanguage![ind],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: listfetchUserList[index]
                                                      .urlIconLanguage !=
                                                  null
                                              ? listfetchUserList[index]
                                                          .urlIconLanguage!
                                                          .length >
                                                      2
                                                  ? 2
                                                  : listfetchUserList[index]
                                                      .urlIconLanguage!
                                                      .length
                                              : 0,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                        )),
                                  ),
                                ]);
                          })
                      : const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Text(
                            AppConstants.txt_Nocoach,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(String post_id, bool isCancel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Are you sure to continue?',
            style: AppTextStyle.tabBarTextStyle,
          ),
          actions: <Widget>[
            CustomBtn(
              text: "Yes",
              background: AppColors.btncolor,
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  //fetchUsersandNews();
                });
              },
            ),
            CustomBtn(
              text: "No",
              background: AppColor.black87Color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void fetchUsersandNews() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().fetchApiCallDashboard('');
    if (res != null && res.statusCode == 200 && res.data != null) {
      Map<String, dynamic> map = res.data[0];

      dasboardResponse = DasboardResponse.fromJson(map);
      listfetchUserList = dasboardResponse != null
          ? dasboardResponse!.coachesOnline != null
              ? dasboardResponse!.coachesOnline!
              : []
          : [];
      setState(() {});
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }

  void zusagenModel(String post_id, bool isCancel) async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().zusagenDashboard(post_id, isCancel);
    if (res != null && res.statusCode == 200 && res.data != null) {
      Map<String, dynamic> map = res.data[0];

      dasboardResponse = DasboardResponse.fromJson(map);
      listfetchUserList = dasboardResponse != null
          ? dasboardResponse!.coachesOnline != null
              ? dasboardResponse!.coachesOnline!
              : []
          : [];
      setState(() {});
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }
}
*/
