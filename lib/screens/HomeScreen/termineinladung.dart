// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/models/DashboardResponse.dart';
import 'package:mutschmiede/models/UserResponse.dart';

import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/custombtn.dart';
import '../ProfileScreen/profilescreen.dart';
import '../UserProfile/userprofile.dart';
import '../dashboardscreen.dart';
import '../neueaktion/neueation.dart';

List<String> Title = ["Termineinladung", "Face-2-Face Coaching"];

class TermineinladungScreen extends StatefulWidget {
  const TermineinladungScreen({
    Key? key,
    this.title,
    required this.text,
    required this.subtitle,
    required this.image,
  }) : super(key: key);
  final String? title;
  final String image;
  final String text;
  final String subtitle;
  @override
  State<TermineinladungScreen> createState() => _TermineinladungScreenState();
}

bool isCoachesLoaded = false;
List<FetchUserList> listfetchUserList = [];
DasboardResponse? dasboardResponse;

class _TermineinladungScreenState extends State<TermineinladungScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsersAndNews();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // var title;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.transparentColor,
                              backgroundImage: AssetImage(
                                AppImages.icn_dilogbg,
                              ),
                            ),
                            Positioned(
                              left: size.width * 0.06,
                              top: size.height * 0.04,
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                                scale: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Text(
                          widget.text.toString(),
                          style: AppTextStyle.titleTextStyle
                              .copyWith(color: AppColors.appColors),
                        ),
                      ),
                      SizedBox(height: size.width * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Text(
                          widget.subtitle,
                          // '${DialogText[index]}',
                          style: AppTextStyle.commonTextStyle
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: size.width * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Text(
                          widget.title!,
                          style: AppTextStyle.commonTextStyle
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Text(
                          '${DialogText1[1]}',
                          style: AppTextStyle.commonTextStyle
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomBtn(
                              text: "Zusagen",
                              background: AppColors.btncolor,
                              onPressed: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomBtn(
                              text: "Absagen",
                              background: AppColor.black87Color,
                              onPressed: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                  child: (listfetchUserList.isNotEmpty)
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
                          child: Center(
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
              ),
            ],
          ),
        ));
  }

  void fetchUsersAndNews() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().fetchApiCallDashboard("");
    if (res.statusCode == 200 && res.data != null) {
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
