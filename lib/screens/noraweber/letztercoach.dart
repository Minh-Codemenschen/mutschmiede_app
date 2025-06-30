// ignore_for_file: no_logic_in_create_state, empty_catches, must_be_immutable, prefer_is_empty, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../models/UserResponse.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/customiconcard.dart';
import '../ProfileScreen/profilescreen.dart';
import '../dashboardscreen.dart';

class LetzterCoach extends StatefulWidget {
  FetchUserList fetchUserList;
  LetzterCoach(this.fetchUserList, {Key? key}) : super(key: key);

  @override
  State<LetzterCoach> createState() {
    print(fetchUserList);
    print("LetzterCoachstate >>>>>");
    return LetzterCoachstate(fetchUserList);
  }
}

class LetzterCoachstate extends State<LetzterCoach> {
  FetchUserList fetchUserList;
  LetzterCoachstate(this.fetchUserList);
  bool isCoachesLoaded = false;
  late List<FetchUserList> listfetchUserList = [];
  late List<FetchUserList> activeStatusList = [];
  late List<FetchUserList> inActiveStatusList = [];
  List<Expertise>? listexpertise = [];
  int? indexSeleted;
  //List<dynamic> llistexpertise=[];
  //String dummyexpertise="[{\"term_id\":96,\"term_name\":\"Angst\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/angst-icon.svg\",\"term_status\":\"1\"},{\"term_id\":87,\"term_name\":\"Beziehung\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/beziehung-icon-1.svg\",\"term_status\":\"1\"},{\"term_id\":117,\"term_name\":\"Covid-19\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/covid-19-icon.svg\",\"term_status\":\"0\"},{\"term_id\":86,\"term_name\":\"Familie\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/familie-icon-1.svg\",\"term_status\":\"1\"},{\"term_id\":101,\"term_name\":\"Geldsorgen\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/geldsorgen-icon.svg\",\"term_status\":\"1\"},{\"term_id\":88,\"term_name\":\"Konflikt\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/konflikt-icon-1.svg\",\"term_status\":\"1\"},{\"term_id\":106,\"term_name\":\"Mobbing\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/mobbing-icon.svg\",\"term_status\":\"1\"},{\"term_id\":93,\"term_name\":\"Pers\\u00f6nlichkeit\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/personlichkeit-icon.svg\",\"term_status\":\"1\"},{\"term_id\":115,\"term_name\":\"Pflege\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/pflege-icon.svg\",\"term_status\":\"0\"},{\"term_id\":111,\"term_name\":\"Schule &amp; Studium\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/schule-studium-icon.svg\",\"term_status\":\"0\"},{\"term_id\":109,\"term_name\":\"Sexualit\\u00e4t\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/sexualitat-icon.svg\",\"term_status\":\"1\"},{\"term_id\":85,\"term_name\":\"Stress\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/icon-stress.svg\",\"term_status\":\"1\"},{\"term_id\":99,\"term_name\":\"Sucht\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/sucht-icon.svg\",\"term_status\":\"0\"},{\"term_id\":108,\"term_name\":\"Trauer\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/trauer-icon.svg\",\"term_status\":\"0\"},{\"term_id\":104,\"term_name\":\"Trennung\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/trennung-icon.svg\",\"term_status\":\"0\"},{\"term_id\":114,\"term_name\":\"Unternehmens - beratung\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/unternehmens-icon.svg\",\"term_status\":\"0\"},{\"term_id\":98,\"term_name\":\"Unterst\\u00fctzung\",\"term_url\":\"https:\\/\\/mutschmiede.com\\/wp-content\\/uploads\\/2022\\/04\\/Unterstutzung-icon.svg\",\"term_status\":\"0\"}]";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsersCall();
    // listfetchUserList.sort((a, b) => (a.displayName ?? "").compareTo(b.displayName ?? ""));
    //llistexpertise=jsonDecode(dummyexpertise);
    try {
      for (Expertise expertise in fetchUserList.expertise!) {
        if (expertise != null && expertise.termUrl != null) {
          listexpertise?.add(expertise);
        }
      }
      //log("$listexpertise");
    } catch (e) {}

    //listexpertise=json.decode(dummyexpertise);
    //listexpertise=fetchUserList.expertise;
  }

  @override
  void dispose() {
    try {
      try {
        _player.pause();
        _player.stop();
      } catch (e) {}
      _player.dispose();
    } catch (e) {}
    super.dispose();
  }

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
          child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: false).pop();
                        // Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 0.03,
                          horizontal: size.width * 0.2),
                      alignment: Alignment.center,
                      child: Text(
                        "Letzter Coach",
                        style: AppTextStyle.buttonTextTextStyle
                            .copyWith(color: AppColors.appColors, fontSize: 17),
                      ),
                    ),
                  ],
                ),
                /*CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.green.shade300,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: fetchUserList.avatar == null
                        ? const AssetImage(
                            AppImages.icn_benparkerym,
                          ) as ImageProvider
                        : NetworkImage(
                            '${fetchUserList.avatar}',
                          ),
                  ),
                ),*/
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
                  child: Text(
                      fetchUserList.avatar == null
                          ? ""
                          : "${fetchUserList.displayName}",
                      style: AppTextStyle.buttonTextTextStyle),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                      fetchUserList.ort == null &&
                              fetchUserList.language == null
                          ? ""
                          : '${fetchUserList.ort},${fetchUserList.language?.toUpperCase()}',
                      style: AppTextStyle.commonTextStyle),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        print("tel:${fetchUserList.phoneNumbnerDisplay ?? ''}");
                        print("12333");
                        try {
                          //FlutterPhoneDirectCaller.callNumber(fetchUserList.phoneNumbner!);
                          if (fetchUserList.phoneNumbnerDisplay != null &&
                              fetchUserList.phoneNumbnerDisplay != "" &&
                              fetchUserList.phoneNumbnerDisplay != "6855") {
                            await launchUrl(Uri.parse(
                                "tel:${fetchUserList.phoneNumbnerDisplay ?? ''}"));
                          } else {
                            EasyLoading.showToast(AppConstants.Phone_Number,
                                toastPosition: EasyLoadingToastPosition.bottom);
                          }
                        } catch (e) {
                          EasyLoading.showToast(AppConstants.Phone_Number,
                              toastPosition: EasyLoadingToastPosition.bottom);
                        }
                      },
                      child: const CustomCard(
                        title: 'Anrufen',
                        icon: Icons.phone,
                      ),
                    ),
                    /*InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoraWeberScrren()),
                        );
                      },
                      child: const CustomCard(
                        title: 'Nachricht',
                        icon: Icons.email,
                      ),
                    ),*/
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CustomCard(
                        title: 'Mehr Infos',
                        icon: Icons.info,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.width * 0.03),
                  /*child: Text(
                    "Montag, 28.02.2022\nAusgehender Anruf, 30 Minuten",
                    style: AppTextStyle.commonTextStyle.copyWith(fontSize: 15),
                  ),*/
                )
              ],
            ),
          ),
          if (listfetchUserList != null && listfetchUserList.length > 0)
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.01, horizontal: size.width * 0.05),
              child: Text(
                'Weitere Coaches',
                style: AppTextStyle.titleTextStyle,
              ),
            ),
          if (listfetchUserList != null && listfetchUserList.length > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5 / 8,
                      crossAxisSpacing: 6,
                      crossAxisCount: 2),
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
                                  builder: (context) =>
                                      ProfileScreen(listfetchUserList[index]),
                                ),
                              );
                            },
                            child: /*CircleAvatar(
                                          radius: size.width * 0.16,
                                          backgroundColor:
                                              Colors.green.shade300,
                                          child: CircleAvatar(
                                            radius: size.width * 0.13,
                                            backgroundImage: NetworkImage(
                                              listfetchUserList[index].avatar!,
                                            ),
                                          ),
                                        ),*/
                                listfetchUserList[index].profileStatus == "1"
                                    ? CircleAvatar(
                                        radius: size.width * 0.25,
                                        backgroundColor: Colors.green.shade300,
                                        child: CircleAvatar(
                                          radius: size.width * 0.19,
                                          backgroundImage: NetworkImage(
                                            listfetchUserList[index].avatar!,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: size.width * 0.25,
                                        backgroundImage: NetworkImage(
                                          listfetchUserList[index].avatar!,
                                        ),
                                      ),
                          ),
                          const SizedBox(
                            height: 03,
                          ),
                          Text(
                            maxLines: 1,
                            "${listfetchUserList[index].displayName}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "${listfetchUserList[index].ort},${listfetchUserList[index].language_choices?.toUpperCase()}",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                          Flexible(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (listfetchUserList[index].mp3 == null ||
                                      listfetchUserList[index].mp3 == "null")
                                  ? Image.asset(
                                      AppImages.icn_disable,
                                      height: 25,
                                      width: 25,
                                    )
                                  : (indexSeleted != null &&
                                          indexSeleted == index)
                                      ? InkWell(
                                          onTap: () {
                                            indexSeleted = null;
                                            _init(
                                                "${listfetchUserList[index].mp3}",
                                                false);
                                            setState(() {});
                                          },
                                          child: Image.asset(
                                            AppImages.icn_pause,
                                            height: 25,
                                            width: 25,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            indexSeleted = index;
                                            _init(
                                                "${listfetchUserList[index].mp3}",
                                                true);
                                            setState(() {});
                                          },
                                          child: Image.asset(
                                            AppImages.icn_play,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: ListView.builder(
                                      itemBuilder: (ctx, ind) {
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, right: 2),
                                            child: SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: Image.network(
                                                    listfetchUserList[index]
                                                            .urlIconLanguage![
                                                        ind])));
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
                                      shrinkWrap: true)),
                            ],
                          )),
                        ]);
                  }),
              /*child: ListView.builder(
                shrinkWrap: true,
                itemCount: listfetchUserList.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ProfileScreen(listfetchUserList[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          listfetchUserList[index]),
                                    ),
                                  );
                                },
                                child: listfetchUserList[index].profileStatus ==
                                        "1"
                                    ? CircleAvatar(
                                        radius: size.width * 0.12,
                                        backgroundColor: Colors.green.shade300,
                                        child: CircleAvatar(
                                          radius: size.width * 0.085,
                                          backgroundImage: NetworkImage(
                                            listfetchUserList[index].avatar!,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: size.width * 0.12,
                                        backgroundImage: NetworkImage(
                                          listfetchUserList[index].avatar!,
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listfetchUserList[index]
                                                .displayName!
                                                .length >
                                            25
                                        ? listfetchUserList[index]
                                            .displayName!
                                            .substring(0, 25)
                                        : listfetchUserList[index].displayName!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      "Experte für\n${(listfetchUserList[index].expertise != null && listfetchUserList[index].expertise!.isNotEmpty) ? listfetchUserList[index].expertise![0].termName : ""}"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 05,
                            ),
                            IconButton(
                              onPressed: () async {
                                try {
                                  launchUrl(Uri.parse(
                                      "tel:${listfetchUserList[index].telNumberApp!}"));
                                  //FlutterPhoneDirectCaller.callNumber();
                                } catch (e) {}
                              },
                              icon: const Icon(
                                Icons.call,
                                color: AppColor.black87Color,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      listfetchUserList[index],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.info,
                                color: AppColor.black87Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),*/
            ),
          if (listexpertise != null && listexpertise!.length > 0)
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.01, horizontal: size.width * 0.05),
              child: Text(
                'Problemfelder',
                style: AppTextStyle.titleTextStyle,
              ),
            ),
          if (listexpertise != null && listexpertise!.length > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 6,
                    crossAxisSpacing: 00,
                    mainAxisSpacing: 0,
                    crossAxisCount: 4),
                itemCount: listexpertise?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      (listexpertise![index].termStatus != null &&
                              listexpertise![index].termStatus == "1")
                          ? CircleAvatar(
                              radius: size.width * 0.09,
                              backgroundColor: AppColors.appColors,
                              child: CircleAvatar(
                                radius: size.width * 0.080,
                                backgroundColor: Colors.grey.shade200,
                                child: SvgPicture.network(
                                  listexpertise![index].termUrl!,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: size.width * 0.09,
                              backgroundColor: Colors.grey.shade200,
                              child: CircleAvatar(
                                radius: size.width * 0.080,
                                backgroundColor: Colors.grey.shade200,
                                child: SvgPicture.network(
                                  listexpertise![index].termUrl!,
                                ),
                              )),
                      Container(
                        padding: const EdgeInsets.only(top: 05),
                        alignment: Alignment.center,
                        child: Text(
                          "${listexpertise![index].termName} ",
                          style: AppTextStyle.commonTextStyle
                              .copyWith(fontSize: 12.5),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
        ],
      )),
    );
  }

  void fetchUsersCall() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().fetchusersListAll();
    if (res != null && res.statusCode == 200 && res.data != null) {
      List<dynamic> list = res.data;
      for (var element in list) {
        listfetchUserList.add(FetchUserList.fromJson(element));
      }
      listfetchUserList
          .sort((a, b) => (a.displayName ?? "").compareTo(b.displayName ?? ""));
      activeStatusList
          .addAll(listfetchUserList.where((element) => element.status == '1'));
      activeStatusList
          .sort((a, b) => (a.displayName ?? "").compareTo(b.displayName ?? ""));
      inActiveStatusList.addAll(
          listfetchUserList.where((element) => element.status == 'null'));
      inActiveStatusList
          .sort((a, b) => (a.displayName ?? "").compareTo(b.displayName ?? ""));
      listfetchUserList.clear();
      listfetchUserList.addAll(activeStatusList + inActiveStatusList);
      setState(() {});
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }

  final AudioPlayer _player = AudioPlayer();
  Future<void> _init(String link, bool isPlay) async {
    try {
      if (isPlay) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(link)));
        await _player.play();

        _player.playerStateStream.listen((state) {
          print(state);
          if (state.processingState == ProcessingState.completed ||
              state == ProcessingState.idle) {
            setState(() {
              indexSeleted = null;
            });
          }
        });
      } else {
        _player.pause();
        _player.stop();
      }
    } catch (e) {
      print("Error loading audio source: $e");
      EasyLoading.showToast("Fehler beim Abspielen von Audio",
          toastPosition: EasyLoadingToastPosition.bottom);
      _player.pause();
      _player.stop();
      setState(() {
        indexSeleted = null;
      });
    }
  }
}
