// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable, empty_catches, file_names, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/models/DashboardResponse.dart';
import 'package:mutschmiede/models/UserResponse.dart';

import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/Custombtnnewsitem.dart';
import '../../widgets/custombtn.dart';
import '../ProfileScreen/profilescreen.dart';
import '../dashboardscreen.dart';

class NewsItemDetailsScreen extends StatefulWidget {
  dynamic objectNewsItem;
  List<FetchUserList> objectCoachesOnline;
  NewsItemDetailsScreen(this.objectNewsItem, this.objectCoachesOnline,
      {super.key});
  @override
  State<NewsItemDetailsScreen> createState() => _NewsItemDetailsScreenState();
}

class _NewsItemDetailsScreenState extends State<NewsItemDetailsScreen> {
  DateFormat dateFormatparse = DateFormat("dd/MM/yyyy");
  DateFormat dateFormatformat = DateFormat("EEEE, dd.MM.yyyy", "de-at");
  int? indexSeleted;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.objectNewsItem != null &&
                  widget.objectNewsItem is ResponseData)
                callDetails(size, widget.objectNewsItem as ResponseData),
              if (widget.objectNewsItem != null &&
                  widget.objectNewsItem is F2fCoaches)
                face2faceCoaches(size, widget.objectNewsItem as F2fCoaches),
              if (widget.objectNewsItem != null &&
                  widget.objectNewsItem is List<Menu1>)
                menuListing(size, widget.objectNewsItem as List<Menu1>),
              /*Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                margin: const EdgeInsets.all(08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Visibility(
                  visible: widget.objectCoachesOnline.isNotEmpty,
                  child: (widget.objectCoachesOnline.isNotEmpty)
                      ? GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5 / 7,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemCount: widget.objectCoachesOnline.length,
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
                                              widget
                                                  .objectCoachesOnline[index]),
                                        ),
                                      );
                                    },
                                    */ /*child: CircleAvatar(
                                      radius: size.width * 0.16,
                                      backgroundColor: Colors.green.shade300,
                                      child: CircleAvatar(
                                        radius: size.width * 0.13,
                                        backgroundImage: NetworkImage(
                                          widget.objectCoachesOnline[index]
                                              .avatar!,
                                        ),
                                      ),
                                    ),*/ /*
                                    child: (widget.objectCoachesOnline[index]
                                                    .avatar! !=
                                                null &&
                                            widget.objectCoachesOnline[index]
                                                    .avatar! ==
                                                "1")
                                        ? CircleAvatar(
                                            radius: 55,
                                            backgroundColor:
                                                Colors.green.shade300,
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                widget
                                                    .objectCoachesOnline[index]
                                                    .avatar!,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              widget.objectCoachesOnline[index]
                                                  .avatar!,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 03,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: ListView.builder(
                                              itemBuilder: (ctx, ind) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2, right: 2),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Image.network(
                                                      widget
                                                          .objectCoachesOnline[
                                                              index]
                                                          .urlIconLanguage![ind],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: widget
                                                          .objectCoachesOnline[
                                                              index]
                                                          .urlIconLanguage !=
                                                      null
                                                  ? widget
                                                              .objectCoachesOnline[
                                                                  index]
                                                              .urlIconLanguage!
                                                              .length >
                                                          2
                                                      ? 2
                                                      : widget
                                                          .objectCoachesOnline[
                                                              index]
                                                          .urlIconLanguage!
                                                          .length
                                                  : 0,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                            )),
                                      ],
                                    ),
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
              ),*/
              Visibility(
                visible: widget.objectCoachesOnline.isNotEmpty,
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
                      child: (widget.objectCoachesOnline != null &&
                              widget.objectCoachesOnline.isEmpty)
                          ? GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 8,
                                      crossAxisSpacing: 6,
                                      crossAxisCount: 2),
                              itemCount: widget.objectCoachesOnline.length,
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
                                                  ProfileScreen(widget
                                                          .objectCoachesOnline[
                                                      index]),
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
                                            (widget.objectCoachesOnline[index]
                                                            .status! !=
                                                        null &&
                                                    widget
                                                            .objectCoachesOnline[
                                                                index]
                                                            .status! ==
                                                        "1")
                                                ? CircleAvatar(
                                                    radius: size.width * 0.26,
                                                    backgroundColor:
                                                        Colors.green.shade300,
                                                    child: CircleAvatar(
                                                      radius: size.width * 0.21,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        widget
                                                            .objectCoachesOnline[
                                                                index]
                                                            .avatar!,
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: size.width * 0.25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      widget
                                                          .objectCoachesOnline[
                                                              index]
                                                          .avatar!,
                                                    ),
                                                  ),
                                      ),
                                      const SizedBox(
                                        height: 03,
                                      ),
                                      Text(
                                        maxLines: 1,
                                        "${widget.objectCoachesOnline[index].displayName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        "${widget.objectCoachesOnline[index].ort}, ${widget.objectCoachesOnline[index].language}",
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
                                          (widget.objectCoachesOnline[index]
                                                          .mp3 ==
                                                      null ||
                                                  widget
                                                          .objectCoachesOnline[
                                                              index]
                                                          .mp3 ==
                                                      "null")
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
                                                            "${widget.objectCoachesOnline[index].mp3}",
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
                                                            "${widget.objectCoachesOnline[index].mp3}",
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
                                                            child: Image.network(widget
                                                                .objectCoachesOnline[
                                                                    index]
                                                                .urlIconLanguage![ind])));
                                                  },
                                                  itemCount: widget
                                                              .objectCoachesOnline[
                                                                  index]
                                                              .urlIconLanguage !=
                                                          null
                                                      ? widget
                                                                  .objectCoachesOnline[
                                                                      index]
                                                                  .urlIconLanguage!
                                                                  .length >
                                                              2
                                                          ? 2
                                                          : widget
                                                              .objectCoachesOnline[
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
            ],
          ),
        ));
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

  void _showMyDialog(
      String post_id, bool isCancel, BuildContext mainContext) async {
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
                  zusagenModel(post_id, isCancel, mainContext);
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

  Widget callDetails(Size size, ResponseData responsedata) {
    String formattedDateTime = "";
    try {
      if (responsedata.date != null && responsedata.date!.isNotEmpty) {
        String unformatted_datetime =
            '${responsedata.date!},${responsedata.startTime!}-${responsedata.endTime!}';
        String unformatted_date = unformatted_datetime.split(",")[0];
        String unformatted_fromtotime =
            unformatted_datetime.split(",")[1].trim();
        String formatted_fromtime = DateFormat("HH:mm").format(
            DateFormat("HH:mm").parse(unformatted_fromtotime.split("-")[0]));
        String formatted_totime = DateFormat("HH:mm").format(
            DateFormat("HH:mm").parse(unformatted_fromtotime.split("-")[1]));
        formattedDateTime =
            '${dateFormatformat.format(dateFormatparse.parse(unformatted_date))}, $formatted_fromtime-$formatted_totime';
      }
    } catch (e) {}
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.030),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 6,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.040),
                    child: CircleAvatar(
                      radius: size.width * 0.16,
                      backgroundColor: AppColor.transparentColor,
                      backgroundImage: const AssetImage(
                        AppImages.icn_dilogbg,
                      ),
                      child: Image.asset(
                        AppImages.icn_termine,
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.015),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_CALL,
                  style: AppTextStyle.TextStyleBoldLabelNewsItem.copyWith(
                      color: AppColors.appColors, fontSize: 17.5),
                ),
              ),
              SizedBox(height: size.width * 0.03),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  formattedDateTime,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              SizedBox(height: size.width * 0.005),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  responsedata.title ?? "",
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(height: size.width * 0.025),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_ATTENDEES,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  listToString(responsedata.participant),
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(height: size.width * 0.025),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_LOCATION,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  responsedata.location ?? "",
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
              Visibility(
                  visible: ((responsedata.accept != null &&
                          responsedata.accept ==
                              "0") /*&&
                      (responsedata.cancel != null &&
                          responsedata.cancel == "0")*/
                      ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 05),
                        child: Row(
                          children: [
                            CustomBtnNewsItem(
                              text: AppConstants.LABEL_ACCEPT,
                              background: AppColors.btncolor,
                              onPressed: () {
                                setState(() {
                                  _showMyDialog('${responsedata.postId}', false,
                                      context); //from accept
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
                                      '${responsedata.postId}', true, context);
                                });
                              },
                            ),
                            const SizedBox(
                              width: 05,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.07,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  String listToString(List<Participant>? list) {
    var result = "";
    if (list != null && list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        if (i == 0) {
          result += '${list[i].name}';
        } else {
          result += ", " '${list[i].name}';
        }
      }
    }
    return result;
  }

  Widget face2faceCoaches(Size size, F2fCoaches f2fCoaches) {
    String formattedDateTime = "";
    try {
      if (f2fCoaches.date != null && f2fCoaches.date!.isNotEmpty) {
        String unformatted_datetime =
            '${f2fCoaches.date!},${f2fCoaches.startTime!}-${f2fCoaches.endTime!}';
        String unformatted_date = unformatted_datetime.split(",")[0];
        String unformatted_fromtotime =
            unformatted_datetime.split(",")[1].trim();
        String formatted_fromtime = DateFormat("HH:mm").format(
            DateFormat("HH:mm").parse(unformatted_fromtotime.split("-")[0]));
        String formatted_totime = DateFormat("HH:mm").format(
            DateFormat("HH:mm").parse(unformatted_fromtotime.split("-")[1]));
        formattedDateTime =
            '${dateFormatformat.format(dateFormatparse.parse(unformatted_date))}, $formatted_fromtime-$formatted_totime';
      }
    } catch (e) {}
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.030),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 6,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.040),
                    child: CircleAvatar(
                      radius: size.width * 0.16,
                      backgroundColor: AppColor.transparentColor,
                      backgroundImage: const AssetImage(
                        AppImages.icn_dilogbg,
                      ),
                      child: Image.asset(
                        AppImages.icn_face,
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.015),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_FACE2FACE_CALL,
                  style: AppTextStyle.TextStyleBoldLabelNewsItem.copyWith(
                      color: AppColors.appColors, fontSize: 17.5),
                ),
              ),
              SizedBox(height: size.width * 0.03),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  formattedDateTime,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              SizedBox(height: size.width * 0.005),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  f2fCoaches.personal ?? "",
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(height: size.width * 0.025),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_LOCATION,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  f2fCoaches.location ?? "",
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(height: size.width * 0.025),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_MESSAGE,
                  // '${DialogText[index]}',
                  style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text(
                  f2fCoaches.personal ?? "", //TODO change it
                  style: AppTextStyle.TextStyleRegularLabelNewsItem,
                ),
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
              Visibility(
                  visible: ((f2fCoaches.accept != null &&
                          f2fCoaches.accept ==
                              "0") /*&&
                      (f2fCoaches.cancel != null && f2fCoaches.cancel == "0")*/
                      ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 05),
                        child: Row(
                          children: [
                            CustomBtnNewsItem(
                              text: AppConstants.LABEL_ACCEPT,
                              background: AppColors.btncolor,
                              onPressed: () {
                                setState(() {
                                  _showMyDialog('${f2fCoaches.postId}', false,
                                      context); //from accept
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
                                      '${f2fCoaches.postId}', true, context);
                                });
                              },
                            ),
                            const SizedBox(
                              width: 05,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.07,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuListing(Size size, List<Menu1> list) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.030),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 6,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.040),
                    child: CircleAvatar(
                      radius: size.width * 0.16,
                      backgroundColor: AppColor.transparentColor,
                      backgroundImage: const AssetImage(
                        AppImages.icn_dilogbg,
                      ),
                      child: Image.asset(
                        AppImages.icn_burger,
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.015),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  AppConstants.LABEL_MENU.toUpperCase(),
                  style: AppTextStyle.TextStyleBoldLabelNewsItem.copyWith(
                      color: AppColors.appColors, fontSize: 17.5),
                ),
              ),
              SizedBox(height: size.width * 0.010),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Colors.grey),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          child: Text(list[index].dateTime!, style: AppTextStyle.TextStyleBoldBlackNewsItem
                                  .copyWith(),),
                          // child: Text(
                          //   dateFormatformat.format(
                          //       dateFormatparse.parse(list[index].dateTime!)),
                          //   // '${DialogText[index]}',
                          //   style: AppTextStyle.TextStyleBoldBlackNewsItem
                          //       .copyWith(),
                          // ),
                        ),
                        SizedBox(height: size.width * 0.005),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list[index].menuItems?.length ?? 0,
                          itemBuilder: (context, ind) {
                            return Row(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: size.height * 0.01),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list[index]
                                            .menuItems![ind]
                                            .menuFieldName1 ??
                                        /*list[index]
                                            .menuItems![ind]
                                            .menuFieldName2!*/
                                        "",
                                    style: AppTextStyle
                                        .TextStyleRegularLabelNewsItem,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: size.height * 0.01),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '€ ${list[index].menuItems![ind].menuFieldValue1 ?? ""}',
                                    style: AppTextStyle
                                        .TextStyleBoldBlackNewsItemDetail,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void zusagenModel(
      String post_id, bool isCancel, BuildContext mainContext) async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    Response res = await ApiManager().zusagenDashboard(post_id, isCancel);
    if (res.statusCode == 200 && res.data != null) {
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    Navigator.of(mainContext).pop();
  }
}
