// ignore_for_file: non_constant_identifier_names, prefer_is_empty, unnecessary_null_comparison, use_build_context_synchronously, must_be_immutable, empty_catches, no_logic_in_create_state, library_private_types_in_public_api, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/models/DashboardResponse.dart';
import 'package:mutschmiede/models/UserResponse.dart';
import 'package:mutschmiede/models/checkcompanystatusmodel.dart';
import 'package:mutschmiede/models/zusagenmodel.dart';
import 'package:mutschmiede/screens/noraweber/letztercoach.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../GetVersionApp/get_version_ios.dart';
import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/Custombtnnewsitem.dart';
import '../../widgets/custombtn.dart';
import '../../widgets/customlist.dart';
import '../ProfileScreen/profilescreen.dart';
import '../dashboardscreen.dart';
import 'NewsItemDetailsScreen.dart';
import 'categorydescriptionscreen.dart';

const defaultPlayerCount = 4;

typedef OnError = void Function(Exception exception);

class HomeScreenClone extends StatefulWidget {
  HomeScreenClone(this.urlimage, {super.key});
  String? urlimage = "";
  String? company_name = "";
  _HomeScreenCloneState? homescreenstate;
  @override
  State<HomeScreenClone> createState() {
    homescreenstate = _HomeScreenCloneState();
    return homescreenstate!;
  }

  void proceproceedToCoachDetailScreenedTo() {
    if (homescreenstate != null) {
      print(homescreenstate);
      homescreenstate?.proceedToCoachDetailScreen();
    }
  }
}

class _HomeScreenCloneState extends State<HomeScreenClone> {
  bool isCoachesLoaded = false;
  bool isMusic = false;
  late List<FetchUserList> listfetchUserList = [];
  late List<FetchUserList> UserDataFilterList = [];
  late List<Category> fetchUserCategoryList = [];
  late List<AcceptRejectResponse> zusagen = [];
  DasboardResponse? dasboardResponse;
  int? indexSeleted;
  int? userFilterIndex;
  bool accept = false;
  bool isPlayer = false;
  String categoryName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    fetchUsersandNews();
    checkCompanyStatus();
    fetch_CompanyName();
  }

  void checkRegex() {}

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

  // AudioPlayer audio = AudioPlayer();

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
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(08),
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(25),
                    child: SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: widget.urlimage ?? "",
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                  ),
                  /*if (widget.urlimage != null && widget.urlimage!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.06, bottom: size.width * 0.06),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            height: 35,
                            width: 35,
                            imageUrl: widget.urlimage!,
                            errorWidget: (context, url, error) => Container(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.company_name!,
                            style: AppTextStyle.tabBarTextStyle,
                          ),
                        ],
                      ),
                    ),*/
                ],
              ),
              ress?.isexpertshow == true
                  ? Visibility(
                      visible: isCoachesLoaded,
                      child: Column(
                        children: [
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
                            child: (listfetchUserList != null &&
                                    listfetchUserList.length > 0)
                                ? GridView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 5 / 8,
                                            crossAxisSpacing: 6,
                                            crossAxisCount: 2),
                                    itemCount: listfetchUserList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      double screenWidth = MediaQuery.of(context).size.width;
                                      double avatarRadius = screenWidth * 0.13;
                                      double avatarOuterRadius = screenWidth * 0.20;
                                      double iconSize = screenWidth * 0.07; // icon mp3, language
                                      double fontSizeName = screenWidth * 0.028;
                                      double fontSizeInfo = screenWidth * 0.032;
                                      double rowHeight = iconSize + 8;
                                      double borderWidth = screenWidth * 0.012;
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: screenWidth * 0.01),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProfileScreen(listfetchUserList[index]),
                                                ),
                                              );
                                            },
                                            child: (listfetchUserList[index].status! != null && listfetchUserList[index].status! == "1")
                                                ? Container(
                                                    width: avatarOuterRadius * 2,
                                                    height: avatarOuterRadius * 2,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.green.shade300,
                                                        width: borderWidth,
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: avatarOuterRadius - borderWidth,
                                                      backgroundImage: NetworkImage(listfetchUserList[index].avatar!),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: avatarOuterRadius - 2,
                                                    backgroundImage: NetworkImage(listfetchUserList[index].avatar!),
                                                  ),
                                          ),
                                          SizedBox(height: screenWidth * 0.008),
                                          Text(
                                            "${listfetchUserList[index].displayName}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizeName,
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "${listfetchUserList[index].ort}, ${listfetchUserList[index].language?.toUpperCase()}",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w400,
                                                fontSize: fontSizeInfo,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: screenWidth * 0.015),
                                          SizedBox(
                                            height: rowHeight,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: iconSize,
                                                  height: iconSize,
                                                  child: (listfetchUserList[index].mp3 == null ||
                                                          listfetchUserList[index].mp3 == "null")
                                                      ? Image.asset(AppImages.icn_disable)
                                                      : (indexSeleted != null && indexSeleted == index)
                                                          ? InkWell(
                                                              onTap: () {
                                                                indexSeleted = null;
                                                                _init("${listfetchUserList[index].mp3}", false);
                                                                setState(() {});
                                                              },
                                                              child: Image.asset(AppImages.icn_pause),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                indexSeleted = index;
                                                                _init("${listfetchUserList[index].mp3}", true);
                                                                setState(() {});
                                                              },
                                                              child: Image.asset(AppImages.icn_play),
                                                            ),
                                                ),
                                                SizedBox(width: screenWidth * 0.02),
                                                ...?listfetchUserList[index].urlIconLanguage?.take(2).map((iconUrl) => Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                                      child: SizedBox(
                                                        width: iconSize,
                                                        height: iconSize,
                                                        child: Image.network(iconUrl),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
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
                        ],
                      ),
                    )
                  : Visibility(
                      visible: isCoachesLoaded,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: 08),
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
                                child: (listfetchUserList != null &&
                                        listfetchUserList.length > 0)
                                    ? GridView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 5 / 8,
                                                crossAxisSpacing: 6,
                                                crossAxisCount: 2),
                                        itemCount: listfetchUserList.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          double screenWidth = MediaQuery.of(context).size.width;
                                          double avatarRadius = screenWidth * 0.13;
                                          double avatarOuterRadius = screenWidth * 0.16;
                                          double iconSize = screenWidth * 0.09; // icon mp3, language
                                          double fontSizeName = screenWidth * 0.028;
                                          double fontSizeInfo = screenWidth * 0.032;
                                          double rowHeight = iconSize + 8;
                                          double borderWidth = screenWidth * 0.012;
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: screenWidth * 0.01),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProfileScreen(listfetchUserList[index]),
                                                    ),
                                                  );
                                                },
                                                child: (listfetchUserList[index].status! != null && listfetchUserList[index].status! == "1")
                                                    ? Container(
                                                        width: avatarOuterRadius * 2,
                                                        height: avatarOuterRadius * 2,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.green.shade300,
                                                            width: borderWidth,
                                                          ),
                                                        ),
                                                        child: CircleAvatar(
                                                          radius: avatarOuterRadius - borderWidth,
                                                          backgroundImage: NetworkImage(listfetchUserList[index].avatar!),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: avatarOuterRadius - 2,
                                                        backgroundImage: NetworkImage(listfetchUserList[index].avatar!),
                                                      ),
                                              ),
                                              SizedBox(height: screenWidth * 0.008),
                                              Text(
                                                "${listfetchUserList[index].displayName}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: fontSizeName,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${listfetchUserList[index].ort}, ${listfetchUserList[index].language?.toUpperCase()}",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: fontSizeInfo,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: screenWidth * 0.015),
                                              SizedBox(
                                                height: rowHeight,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: iconSize,
                                                      height: iconSize,
                                                      child: (listfetchUserList[index].mp3 == null ||
                                                              listfetchUserList[index].mp3 == "null")
                                                          ? Image.asset(AppImages.icn_disable)
                                                          : (indexSeleted != null && indexSeleted == index)
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    indexSeleted = null;
                                                                    _init("${listfetchUserList[index].mp3}", false);
                                                                    setState(() {});
                                                                  },
                                                                  child: Image.asset(AppImages.icn_pause),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    indexSeleted = index;
                                                                    _init("${listfetchUserList[index].mp3}", true);
                                                                    setState(() {});
                                                                  },
                                                                  child: Image.asset(AppImages.icn_play),
                                                                ),
                                                    ),
                                                    SizedBox(width: screenWidth * 0.02),
                                                    ...?listfetchUserList[index].urlIconLanguage?.take(2).map((iconUrl) => Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                                          child: SizedBox(
                                                            width: iconSize,
                                                            height: iconSize,
                                                            child: Image.network(iconUrl),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
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
                            ],
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                color: Colors.white.withOpacity(0.50),
                              ))
                        ],
                      ),
                    ),
              Visibility(
                visible: UserDataFilterList.isNotEmpty ? true : false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03, vertical: 08),
                          child: Text(
                            categoryName,
                            style: AppTextStyle.tabBarTextStyle,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              categoryName = "";
                              UserDataFilterList.clear();
                              setState(() {});
                            },
                            child: Image.asset(
                              AppImages.icn_undo,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      margin: const EdgeInsets.all(08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (UserDataFilterList != null &&
                              UserDataFilterList.length > 0)
                          ? GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 8,
                                      crossAxisSpacing: 6,
                                      crossAxisCount: 2),
                              itemCount: UserDataFilterList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  ProfileScreen(
                                                      UserDataFilterList[
                                                          index]),
                                            ),
                                          );
                                        },
                                        child: (UserDataFilterList[index]
                                                        .status! !=
                                                    null &&
                                                UserDataFilterList[index]
                                                        .status! ==
                                                    "1")
                                            ? CircleAvatar(
                                                radius: size.width * 0.26,
                                                backgroundColor:
                                                    Colors.green.shade300,
                                                child: CircleAvatar(
                                                  radius: size.width * 0.21,
                                                  backgroundImage: NetworkImage(
                                                    UserDataFilterList[index]
                                                        .avatar!,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: size.width * 0.26,
                                                backgroundImage: NetworkImage(
                                                  UserDataFilterList[index]
                                                      .avatar!,
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 03,
                                      ),
                                      Text(
                                        maxLines: 1,
                                        "${UserDataFilterList[index].displayName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        "${UserDataFilterList[index].ort},${UserDataFilterList[index].language?.toUpperCase()}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (UserDataFilterList[index].mp3 ==
                                                      null ||
                                                  UserDataFilterList[index]
                                                          .mp3 ==
                                                      "null")
                                              ? Image.asset(
                                                  AppImages.icn_disable,
                                                  height: 25,
                                                  width: 25,
                                                )
                                              : (userFilterIndex != null &&
                                                      userFilterIndex == index)
                                                  ? InkWell(
                                                      onTap: () {
                                                        userFilterIndex = null;
                                                        _filterUserInit(
                                                            "${UserDataFilterList[index].mp3}",
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
                                                        userFilterIndex = index;
                                                        _filterUserInit(
                                                            "${UserDataFilterList[index].mp3}",
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 2,
                                                                right: 2),
                                                        child: SizedBox(
                                                            height: 25,
                                                            width: 25,
                                                            child: Image.network(
                                                                UserDataFilterList[
                                                                            index]
                                                                        .urlIconLanguage![
                                                                    ind])));
                                                  },
                                                  itemCount: UserDataFilterList[
                                                                  index]
                                                              .urlIconLanguage !=
                                                          null
                                                      ? UserDataFilterList[
                                                                      index]
                                                                  .urlIconLanguage!
                                                                  .length >
                                                              2
                                                          ? 2
                                                          : UserDataFilterList[
                                                                  index]
                                                              .urlIconLanguage!
                                                              .length
                                                      : 0,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true)),
                                        ],
                                      )),
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
                  ],
                ),
              ),
              ress?.isexpertshow == true
                  ? Visibility(
                      visible: isCoachesLoaded,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03, vertical: 08),
                            child: Text(
                              'Problem erkennen',
                              style: AppTextStyle.tabBarTextStyle.copyWith(
                                fontFamily: 'Raleway',
                              ),
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
                            child: (fetchUserCategoryList != null &&
                                    fetchUserCategoryList.length > 0)
                                ? GridView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            //childAspectRatio: 5 / 9.5,
                                            mainAxisExtent: 190,
                                            crossAxisSpacing: 6,
                                            crossAxisCount: 2),
                                    itemCount: fetchUserCategoryList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      String image =
                                          "${fetchUserCategoryList[index].termIcon}";
                                      image.replaceAll(
                                          RegExp(
                                              '(?<=.\\|)[^@](?=[^@]*?[^@]@)'),
                                          '/');
                                      String descriptionText =
                                          "${fetchUserCategoryList[index].termTitle}";
                                      RegExp exp = RegExp(r"<[^>]*>",
                                          multiLine: true, caseSensitive: true);
                                      String descriptionTerm =
                                          descriptionText.replaceAll(exp, '');
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryDescriptionScreen(
                                                      data:
                                                          fetchUserCategoryList[
                                                              index]),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                          ),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Html(
                                                  data: fetchUserCategoryList[
                                                          index]
                                                      .termName,
                                                  style: {
                                                    '#': Style(
                                                      fontSize: FontSize(12),
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Raleway',
                                                      maxLines: 2,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  },
                                                ),
                                                SvgPicture.network(
                                                  image.toString(),
                                                  height: 35,
                                                  width: 35,
                                                  fit: BoxFit.fill,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  descriptionTerm,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 04,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    categoryName =
                                                        fetchUserCategoryList[
                                                                index]
                                                            .termName!;
                                                    userDataFilterApiCall(
                                                        fetchUserCategoryList[
                                                                index]
                                                            .termId
                                                            .toString());
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            left: 12,
                                                            right: 12,
                                                            bottom: 8),
                                                    child: const Text(
                                                      "EXPERT IN FINDEN",
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      );
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
                        ],
                      ),
                    )
                  : Visibility(
                      visible: isCoachesLoaded,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: 08),
                                child: Text(
                                  'Problem erkennen',
                                  style: AppTextStyle.tabBarTextStyle.copyWith(
                                    fontFamily: 'Raleway',
                                  ),
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
                                child: (fetchUserCategoryList != null &&
                                        fetchUserCategoryList.length > 0)
                                    ? GridView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                //childAspectRatio: 5 / 9.5,
                                                mainAxisExtent: 190,
                                                crossAxisSpacing: 6,
                                                crossAxisCount: 2),
                                        itemCount: fetchUserCategoryList.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          String image =
                                              "${fetchUserCategoryList[index].termIcon}";
                                          image.replaceAll(
                                              RegExp(
                                                  '(?<=.\\|)[^@](?=[^@]*?[^@]@)'),
                                                  '/');
                                          String descriptionText =
                                              "${fetchUserCategoryList[index].termTitle}";
                                          RegExp exp = RegExp(r"<[^>]*>",
                                              multiLine: true,
                                              caseSensitive: true);
                                          String descriptionTerm =
                                              descriptionText.replaceAll(
                                                  exp, '');
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryDescriptionScreen(
                                                          data:
                                                              fetchUserCategoryList[
                                                                  index]),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                              ),
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Html(
                                                      data:
                                                          fetchUserCategoryList[
                                                                  index]
                                                              .termName,
                                                      style: {
                                                        '#': Style(
                                                          fontSize:
                                                              FontSize(12),
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Raleway',
                                                          maxLines: 2,
                                                          textOverflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      },
                                                    ),
                                                    SvgPicture.network(
                                                      image.toString(),
                                                      height: 35,
                                                      width: 35,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      descriptionTerm,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        categoryName =
                                                            fetchUserCategoryList[
                                                                    index]
                                                                .termName!;
                                                        userDataFilterApiCall(
                                                            fetchUserCategoryList[
                                                                    index]
                                                                .termId
                                                                .toString());
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                left: 12,
                                                                right: 12,
                                                                bottom: 8),
                                                        child: const Text(
                                                          "EXPERT IN FINDEN",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 9,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          );
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
                            ],
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                color: Colors.white.withOpacity(0.50),
                              ))
                        ],
                      ),
                    ),
              Visibility(
                  visible: isCoachesLoaded,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      if (showNews())
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03, vertical: 08),
                          child: Text(
                            'News',
                            style: AppTextStyle.tabBarTextStyle,
                          ),
                        ),
                      if (isCoachesLoaded &&
                          (dasboardResponse != null &&
                              dasboardResponse?.news != null &&
                              dasboardResponse?.news?.termineinladung != null &&
                              dasboardResponse
                                      ?.news?.termineinladung?.responsedata !=
                                  null &&
                              dasboardResponse!.news!.termineinladung!
                                      .responsedata!.length >
                                  0))
                        terminalList(
                            size,
                            dasboardResponse!
                                .news!.termineinladung!.responsedata!),
                      if (isCoachesLoaded &&
                          (dasboardResponse != null &&
                              dasboardResponse?.news != null &&
                              dasboardResponse?.news?.f2fCoaches != null &&
                              dasboardResponse!.news!.f2fCoaches!.length > 0))
                        face2facecoachList(
                            size, dasboardResponse!.news!.f2fCoaches!),
                      if (isCoachesLoaded &&
                          (dasboardResponse != null &&
                              dasboardResponse?.news != null &&
                              dasboardResponse?.news?.menu1 != null &&
                              dasboardResponse!.news!.menu1!.length > 0))
                        menuList(size, dasboardResponse!.news!.menu1!),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }

  final AudioPlayer _player = AudioPlayer();
  Future<void> _init(String link, bool isPlay) async {
    try {
      if (isPlay == true) {
        EasyLoading.show(
            maskType: EasyLoadingMaskType.black, status: "please Wait");
        await _player.setAudioSource(AudioSource.uri(Uri.parse(link)));
        EasyLoading.dismiss(animation: true);
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
      EasyLoading.showToast("Fehler beim Abspielen von Audio",
          toastPosition: EasyLoadingToastPosition.bottom);
      print("Error loading audio source: $e");
      _player.pause();
      _player.stop();
      setState(() {
        indexSeleted = null;
      });
    }
  }

  Future<void> _filterUserInit(String link, bool isPlay) async {
    try {
      if (isPlay) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(link)));
        await _player.play();

        _player.playerStateStream.listen((state) {
          print(state);
          if (state.processingState == ProcessingState.completed ||
              state == ProcessingState.idle) {
            setState(() {
              userFilterIndex = null;
            });
          }
        });
      } else {
        _player.pause();
        _player.stop();
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void fetch_CompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.company_name = prefs.getString(AppConstants.COMPANY_NAME) ?? "";
  }

  void proceedToCoachDetailScreen() {
    print("listfetchUserList$listfetchUserList");
    print(listfetchUserList.length);
    print(listfetchUserList[0]);
    if (listfetchUserList != null &&
        listfetchUserList.length > 0 &&
        listfetchUserList[0] != null) {
      print("LetzterCoach  going >>>>>>>>>>>>>>>");
      Navigator.push(
        mainContext,
        MaterialPageRoute(
          builder: (context) => LetzterCoach(listfetchUserList[0]),
        ),
      );
      print("LetzterCoach >>>>>>>>>>>>>>>");
    }
  }

  bool showNews() {
    if (isCoachesLoaded &&
        (dasboardResponse != null &&
            dasboardResponse?.news != null &&
            dasboardResponse?.news?.termineinladung != null &&
            dasboardResponse?.news?.termineinladung?.responsedata != null &&
            dasboardResponse!.news!.termineinladung!.responsedata!.length >
                0)) {
      return true;
    }
    if (isCoachesLoaded &&
        (dasboardResponse != null &&
            dasboardResponse?.news != null &&
            dasboardResponse?.news?.f2fCoaches != null &&
            dasboardResponse!.news!.f2fCoaches!.length > 0)) return true;

    if (isCoachesLoaded &&
        (dasboardResponse != null &&
            dasboardResponse?.news != null &&
            dasboardResponse?.news?.menu1 != null &&
            dasboardResponse!.news!.menu1!.length > 0)) return true;

    return false;
  }

  void _showMyDialog(String post_id, bool isCancel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            AppConstants.LABEL_CONTINUE_MESSAGE,
            style: AppTextStyle.tabBarTextStyle,
          ),
          actions: <Widget>[
            CustomBtn(
              text: AppConstants.LABEL_YES,
              background: AppColors.btncolor,
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  zusagenModel(post_id, isCancel);
                });
              },
            ),
            CustomBtn(
              text: AppConstants.LABEL_NO,
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
    String voucherno = await Utility.fetchUserId();
    Response res = await ApiManager().fetchApiCallDashboard(voucherno);
    print("res >>>> $res");
    if (res != null && res.statusCode == 200 && res.data != null) {
      Map<String, dynamic> map = res.data[0];

      dasboardResponse = DasboardResponse.fromJson(map);
      fetchUserCategoryList = dasboardResponse != null
          ? dasboardResponse!.category != null
              ? dasboardResponse!.category!
              : []
          : [];
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

  void userDataFilterApiCall(String id) async {
    UserDataFilterList.clear();
    print("category id >>$id");
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherno = await Utility.fetchUserId();
    Response res = await ApiManager().categoryListApiCall(id, voucherno);
    if (res != null && res.statusCode == 200 && res.data != null) {
      for (int i = 0; i < res.data["responsedata"].length; i++) {
        UserDataFilterList.add(
            FetchUserList.fromJson(res.data["responsedata"][i]));
      }
      print(UserDataFilterList);
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
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    fetchUsersandNews();
  }

  Widget terminalList(Size size, List<ResponseData> list) {
    DateFormat dateFormatparse = DateFormat("dd/MM/yyyy");
    DateFormat dateFormatformat = DateFormat("EEEE, dd.MM.yyyy", "de-at");
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        String formatted_datetime = "";
        try {
          if (list[index] != null &&
              list[index].date != null &&
              list[index].date!.isNotEmpty) {
            String unformatted_datetime =
                '${list[index].date!},${list[index].startTime!}-${list[index].endTime!}';
            String unformatted_date = unformatted_datetime.split(",")[0];
            String unformatted_fromtotime =
                unformatted_datetime.split(",")[1].trim();
            String formatted_fromtime = DateFormat("HH:mm").format(
                DateFormat("HH:mm")
                    .parse(unformatted_fromtotime.split("-")[0]));
            formatted_datetime =
                '${dateFormatformat.format(dateFormatparse.parse(unformatted_date))}, $formatted_fromtime';
          }
        } catch (e) {}

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewsItemDetailsScreen(list[index], listfetchUserList)),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.015,
                          top: size.height * 0.009,
                          bottom: size.height * 0.009),
                      child: Container(
                        margin: const EdgeInsets.all(05),
                        alignment: Alignment.centerLeft,
                        width: size.width * 0.25,
                        height: size.height * 0.12,
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          image: const DecorationImage(
                              image: AssetImage(AppImages.icn_termine),
                              scale: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 6, bottom: 6),
                        child: Column(
                          children: [
                            CustomList(
                              text: AppConstants.LABEL_CALL.toUpperCase(),
                              subtitle: formatted_datetime,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (dasboardResponse?.news?.termineinladung
                                                ?.responsedata !=
                                            null &&
                                        dasboardResponse?.news?.termineinladung
                                                ?.responsedata![index] !=
                                            null)
                                    ? dasboardResponse!.news!.termineinladung!
                                        .responsedata![index].title!
                                    : "",
                                style:
                                    AppTextStyle.TextStyleRegularLabelNewsItem,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (list[index] != null &&
                                list[index].accept != null &&
                                list[index].accept == "0")
                              Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    CustomBtnNewsItem(
                                      text: AppConstants.LABEL_ACCEPT,
                                      background: AppColors.btncolor,
                                      onPressed: () {
                                        setState(() {
                                          _showMyDialog('${list[index].postId}',
                                              false); //from accept
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomBtnNewsItem(
                                      text: AppConstants.LABEL_CANCEL,
                                      background: AppColor.black87Color,
                                      onPressed: () {
                                        setState(() {
                                          _showMyDialog(
                                              '${list[index].postId}', true);
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget face2facecoachList(Size size, List<F2fCoaches> list) {
    DateFormat dateFormatparse = DateFormat("dd/MM/yyyy");
    DateFormat dateFormatformat = DateFormat("EEEE, dd.MM.yyyy", "de-at");
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        //"23/11/2022, 7:00-17:00",
        String formatted_datetime = "";
        try {
          if (list[index] != null &&
              list[index].date != null &&
              list[index].date!.isNotEmpty) {
            String unformatted_datetime =
                '${list[index].date!},${list[index].startTime!}-${list[index].endTime!}';
            String unformatted_date = unformatted_datetime.split(",")[0];
            String unformatted_fromtotime =
                unformatted_datetime.split(",")[1].trim();
            String formatted_fromtime = DateFormat("HH:mm").format(
                DateFormat("HH:mm")
                    .parse(unformatted_fromtotime.split("-")[0]));
            formatted_datetime =
                '${dateFormatformat.format(dateFormatparse.parse(unformatted_date))}, $formatted_fromtime';
          }
        } catch (e) {}

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewsItemDetailsScreen(list[index], listfetchUserList)),
            );
            // _dialogBuilders();
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.015,
                          top: size.height * 0.009,
                          bottom: size.height * 0.009),
                      child: Container(
                        margin: const EdgeInsets.all(05),
                        alignment: Alignment.centerLeft,
                        width: size.width * 0.25,
                        height: size.height * 0.12,
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          image: const DecorationImage(
                              image: AssetImage(AppImages.icn_donnerstag),
                              scale: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 6, bottom: 6),
                        child: Column(
                          children: [
                            CustomList(
                              text: AppConstants.LABEL_FACE2FACE_CALL
                                  .toUpperCase(),
                              subtitle: /*dateFormatformat.format(dateFormatparse.parse(list[0].dateTime!))*/
                                  formatted_datetime,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                list[index].title != null
                                    ? list[index].title!
                                    : "",
                                style:
                                    AppTextStyle.TextStyleRegularLabelNewsItem,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if ((list[index] != null &&
                                list[index].accept != null &&
                                list[index].accept == "0"))
                              Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    CustomBtnNewsItem(
                                      text: AppConstants.LABEL_ACCEPT,
                                      background: AppColors.btncolor,
                                      onPressed: () {
                                        setState(() {
                                          _showMyDialog('${list[index].postId}',
                                              false); //from accept
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomBtnNewsItem(
                                      text: AppConstants.LABEL_CANCEL,
                                      background: AppColor.black87Color,
                                      onPressed: () {
                                        setState(() {
                                          _showMyDialog(
                                              '${list[index].postId}', true);
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget menuList(Size size, List<Menu1> list) {
    DateFormat dateFormatparse = DateFormat("dd/MM/yyyy");
    DateFormat dateFormatformat = DateFormat("EEEE, dd.MM.yyyy", "de-at");
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsItemDetailsScreen(list, listfetchUserList),
          ),
        );
        // _dialogBuilders();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.015,
                      top: size.height * 0.009,
                      bottom: size.height * 0.009),
                  child: Container(
                    margin: const EdgeInsets.all(05),
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.25,
                    height: size.height * 0.12,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(AppImages.icn_burger1),
                          scale: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 15, bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.LABEL_MENU.toUpperCase() ?? "",
                          style: AppTextStyle.TextStyleBoldLabelNewsItem,
                        ),
                        Text(
                          list[0].dateTime ?? "",
                          style: AppTextStyle.TextStyleBoldBlackNewsItem,
                        ),
                        Text(
                          AppConstants.LABEL_MENU ?? "",
                          style: AppTextStyle.TextStyleRegularLabelNewsItem,
                        ),
                        // CustomList(
                        //   text: AppConstants.LABEL_MENU.toUpperCase(),
                        //   subtitle: dateFormatformat
                        //       .format(dateFormatparse.parse(list[0].dateTime!)),
                        // ),
                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: list[0].menuItems?.length,
                        //   itemBuilder: (context, index) {
                        //     return Container(
                        //       padding: const EdgeInsets.only(left: 15),
                        //       child: Text(
                        //         list[0].menuItems![index].menuFieldName1 != null
                        //             ? list[0].menuItems![index].menuFieldName1!
                        //             : "",
                        //         style:
                        //             AppTextStyle.TextStyleRegularLabelNewsItem,
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
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

  List<String> datas = [];

  /* void selectData() async {
    datas.clear();
    for (int i = 0; i < listfetchUserList.length; i++) {
      if (listfetchUserList.isNotEmpty) {
        if (indexSeleted == listfetchUserList[i].mp3) {
          datas.addAll(listfetchUserList[i].mp3! as Iterable<String>);
        }
      }
    }
    log(datas.length.toString());
    setState(() {});
  }*/
}

enum PopupAction {
  add,
  remove,
}
