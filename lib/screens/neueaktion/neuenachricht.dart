import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/screens/HomeScreen/termineinladung.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../models/userlistmodel.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../noraweber/inboxscreen.dart';
import 'neueation.dart';

class NeueNachricht extends StatefulWidget {
  const NeueNachricht({Key? key}) : super(key: key);

  @override
  State<NeueNachricht> createState() => _NeueNachrichtState();
}

class _NeueNachrichtState extends State<NeueNachricht> {
  TextEditingController controller = TextEditingController();
  UserListModel? userModelList;
  List<GroupUser>? groupUser = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onItemChanged('');
    userList();
    log("${userModelList?.allUser} ");
    log("$groupUser ");
  }

  String query = '';
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
      body: Visibility(
          visible: isCoachesLoaded,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Container(
                      padding: EdgeInsets.only(left: size.height * 0.05),
                      alignment: Alignment.center,
                      child: Text(
                        "Neue Nachricht",
                        style: AppTextStyle.buttonTextTextStyle
                            .copyWith(color: AppColors.appColors, fontSize: 18),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InBoxScreen()),
                          );
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColor.black87Color,
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: controller,
                      // onChanged: onItemChanged,
                      decoration: InputDecoration(
                        hintText: "Suchen",
                        hintStyle: AppTextStyle.commonTextStyle,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColor.black87Color,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.appColors),
                            borderRadius: BorderRadius.circular(15)),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.appColors,
                        backgroundImage: const AssetImage(
                          AppImages.icn_imagebg,
                        ),
                      ),
                      Positioned(
                        left: size.width * 0.02,
                        top: size.height * 0.01,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.group,
                              color: AppColor.black87Color,
                            )),
                      ),
                    ],
                  ),
                  title: const Text("Neue Gruppe"),
                ),
                const SizedBox(
                  height: 05,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Häufig kontaktiert",
                    style: AppTextStyle.tabBarTextStyle,
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: groupUser!.length,
                //     scrollDirection: Axis.vertical,
                //     itemBuilder: (context, index) {
                //       log("=====>${groupUser?[index].userOnGroup?[index].displayName} ");
                //       return Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Divider(),
                //           ListTile(
                //             leading: CircleAvatar(
                //               radius: 30,
                //               backgroundColor: AppColors.appColors,
                //               backgroundImage: NetworkImage(
                //                   "${groupUser?[index].userOnGroup?[index].avatar}",
                //                   scale: 2),
                //             ),
                //             title: Text(
                //                 "${groupUser?[index].userOnGroup?[index].displayName} "),
                //             subtitle: Text(
                //                 "${groupUser?[index].userOnGroup?[index].positionInCompany} "),
                //           )
                //         ],
                //       );
                //     },
                //   ),
                // ),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userModelList?.allUser?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return StickyHeader(
                          header: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 02),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${userModelList?.allUser?[index].displayName.toString().substring(0, 1).toUpperCase()}',
                              style: AppTextStyle.buttonTextTextStyle
                                  .copyWith(fontSize: 17),
                            ),
                          ),
                          content: Column(
                            children: List<int>.generate(
                                    2,
                                    // userModelList!.allUser!.length ,
                                    (index) => index)
                                .map((item) => ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.appColors,
                                        backgroundImage: NetworkImage(
                                            "${userModelList?.allUser?[index].avatar}",
                                            scale: 2),
                                      ),
                                      title: Text(
                                          "${userModelList?.allUser?[index].displayName.toString()} "),
                                      subtitle: Text(
                                          "${userModelList?.allUser?[index].position.toString()} "),
                                    ))
                                .toList(),
                          ),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     ListTile(
                          //       leading: CircleAvatar(
                          //         radius: 30,
                          //         backgroundColor: AppColors.appColors,
                          //         backgroundImage: NetworkImage(
                          //             "${userModelList?.allUser?[index].avatar}",
                          //             scale: 2),
                          //       ),
                          //       title: Text(
                          //           "${userModelList?.allUser?[index].displayName.toString()} "),
                          //       subtitle: Text(
                          //           "${userModelList?.allUser?[index].position.toString()} "),
                          //     )
                          //   ],
                          // ),
                        );
                      },
                    )),
              ],
            ),
          )),
    );
  }

  // List<UserOnGroup> newDataList = [];
  // onItemChanged(String value) {
  //   setState(() {
  //     newDataList = userOnGroup!
  //         .where((string) => string.displayName
  //             .toString()
  //             .toLowerCase()
  //             .contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  void userList() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().usersList();
    if (res.statusCode == 200 && res.data != null) {
      Map<String, dynamic> map = res.data;
      userModelList = UserListModel.fromJson(map);
      if (userModelList != null &&
          userModelList?.allUser != null &&
          userModelList?.groupUser != null) {
        // for (GroupUser area in userModelList!.groupUser!) {
        //   if (area.groupSubject != null) {
        //     groupUser?.add(area);
        //   }
        // }
      }
      setState(() {});
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }
}
