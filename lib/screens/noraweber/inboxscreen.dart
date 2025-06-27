// ignore_for_file: unnecessary_type_check, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../models/UserResponse.dart';
import '../../models/inboxmodel.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../neueaktion/neueation.dart';
import 'abbrechen.dart';

class InBoxScreen extends StatefulWidget {
  const InBoxScreen({Key? key}) : super(key: key);

  @override
  State<InBoxScreen> createState() => _InBoxScreenState();
}

class _InBoxScreenState extends State<InBoxScreen> {
  List<FetchUserList> listfetchUserList = [];
  bool isCoachesLoaded = false;

  List<Termineinladung> termineinladunglist = [];
  List<Menu> menulist = [];
  List<dynamic> listmessages = [];
  List<F2fCoaches> f2fcoachlist = [];

  @override
  void initState() {
    // TODO: implement initState
    fetchInBoxMsg("");
    // log("message===================================>> $fetchInboxMessageList");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String getTimeFromDateAndTime(String date) {
      DateTime dateTime;
      try {
        dateTime = DateTime.parse(date).toLocal();
        return DateFormat.Hm().format(dateTime).toString(); //5:08 PM
      } catch (e) {
        return date;
      }
    }

    final List msgCounts = [0, 1, 2, 3, 4, 5, 6, 7, 8];
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
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AbbrechenScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Bearbeiten",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
                title: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    "Inbox",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 18),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: Image.asset(AppImages.icn_editicon),
                ),
              ),
              SizedBox(
                  height: size.height,
                  child: ListView.builder(
                    itemCount: listmessages.length &
                        menulist.length &
                        InboxImages.length &
                        f2fcoachlist.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                          color: (msgCounts[index] >= 5)
                              ? AppColor.nearlyWhite
                              : AppColors.appColors,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {},
                                leading: f2fcoachlist[index] is F2fCoaches
                                    ? Container(
                                        height: size.width * 0.21,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              f2fcoachlist[index]
                                                  .urlImage
                                                  .toString(),
                                              scale: 2,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        InboxImages[index],
                                        scale: 1,
                                      ),
                                title: listmessages[index] is Termineinladung
                                    ? Text(
                                        "${menulist[index].menuFieldName1}\n${listmessages[index].name}",
                                      )
                                    : Text("${menulist[index].menuFieldName1}"),
                                subtitle: listmessages[index] is Termineinladung
                                    ? Text(
                                        "${listmessages[index].attendees}"
                                            .replaceAll(
                                                RegExp(r"\p{P}", unicode: true),
                                                ""),
                                      )
                                    : null,
                                trailing: listmessages[index] is Termineinladung
                                    ? Text(
                                        getTimeFromDateAndTime(
                                          "${listmessages[index].dateTime}",
                                        ),
                                      )
                                    : null,
                              ),
                              const Divider(),
                            ],
                          ));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void fetchInBoxMsg(String data) async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherNo = await Utility.fetchUserId();
    Response res = await ApiManager().fetchInboxMessageListAll(data, voucherNo);
    if (res != null && res.statusCode == 200 && res.data != null) {
      Map<String, dynamic> map = res.data[0];
      if (map['message'] != null) {
        if (map['message']['termineinladung'] != null) {
          List<dynamic> listtermineinladung = map['message']['termineinladung'];
          listtermineinladung.forEach((element) {
            termineinladunglist.add(Termineinladung.fromJson(element));
          });
        }

        if (map['message']['f2f_coaches'] != null) {
          List<dynamic> listf2fCoaches = map['message']['f2f_coaches'];
          listf2fCoaches.forEach((element) {
            f2fcoachlist.add(F2fCoaches.fromJson(element));
          });
        }

        if (map['message']['menu'] != null) {
          List<dynamic> listmenu = map['message']['menu'];
          listmenu.forEach((element) {
            menulist.add(Menu.fromJson(element));
          });
        }
        listmessages.addAll(termineinladunglist);
        listmessages.addAll(f2fcoachlist);
        listmessages.addAll(menulist);
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
