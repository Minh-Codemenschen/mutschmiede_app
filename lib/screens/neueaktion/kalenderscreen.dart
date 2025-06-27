// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../models/calendarmodel.dart';
import '../../network/ApiManager.dart';
import '../../packages/flutter_clean_calandar/flutter_clean_calendar.dart';
import '../../utils/Utils.dart';
import '../HomeScreen/homescreenclone.dart';
import '../dashboardscreen.dart';

class CalendarScrren extends StatefulWidget {
  const CalendarScrren({Key? key}) : super(key: key);

  @override
  State<CalendarScrren> createState() => _CalendarScrrenState();
}

final Map<DateTime, List<CleanCalendarEvent>> _events = {};
late HomeScreenClone homeScreenClone;

@override
void initState() {
  initState();
  homeScreenClone = HomeScreenClone(DashboardScreen.urlImagestatic);
  _handleNewDate(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ),
  );
}

void _handleNewDate(date) {
  log(date);
  log('Date selected: $date');
}

class _CalendarScrrenState extends State<CalendarScrren> {
  DateTime now = DateTime.now();
  List<Responsedata> dataAdd = [];
  // var format =  DateFormat("yyyy-MM-dd").format(now);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCalendar(formatDate(now));
  }

  String formatDate(DateTime date) {
    //2022-08-05
    DateFormat dateFormatformat = DateFormat("yyyy-MM-dd");
    return dateFormatformat.format(date);
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
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                /*leading: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EreignisScreen(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "Eingang",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),*/
                title: Container(
                  alignment: Alignment.center,
                  //padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    "Kalender",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 18),
                  ),
                ),
                /*trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EreignisScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: AppColor.black87Color,
                  ),
                ),*/
              ),
              SizedBox(
                height: size.height * 0.41,
                child: Calendar(
                  // startOnMonday: true,
                  weekDays: const ["M", "D", "M", "D", "F", "S", "S"],
                  events: _events,
                  onDateSelected: (selectedDate) {
                    //log("$selectedDate");
                    fetchCalendar(formatDate(selectedDate));
                    setState(() {});
                  },

                  eventDoneColor: AppColors.appColors,
                  selectedColor: AppColors.appColors,
                  todayColor: AppColors.appColors,
                  eventColor: Colors.grey,
                  isExpanded: true,

                  dayOfWeekStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 13),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                alignment: Alignment.topLeft,
                child: Text(
                  "Terminübersicht",
                  style: AppTextStyle.titleTextStyle,
                ),
              ),
              (dataAdd != null && dataAdd.isNotEmpty)
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Colors.grey),
                      itemCount: dataAdd.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        String date = DateFormat('dd.MM.yyyy').format(
                            DateFormat("MM/dd/yyyy")
                                .parse('${dataAdd[i].dateTime}'));
                        print(date);
                        // String time = DateFormat('hh:ss-hh:kk').format(
                        //     DateFormat("kk:mm:ss")
                        //         .parse('${dataAdd[i].dateTime}'));
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    dataAdd[i].name != null
                                        ? dataAdd[i].name!.toUpperCase()
                                        : "CALL RINGANA",
                                    style: AppTextStyle.titleTextStyle.copyWith(
                                        color: AppColors.appColors,
                                        fontSize: 15),
                                  ),
                                  const Spacer(),
                                  /*IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_outlined,
                                      color: AppColor.black87Color,
                                      size: 20,
                                    ),
                                    padding: const EdgeInsets.all(0),
                                  ),*/
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                dataAdd[i].dateTime == null
                                    ? ""
                                    : '$date | ${dataAdd[i].startTime} - ${dataAdd[i].endTime} ',
                                style: AppTextStyle.callRinganaTextStyle,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                (dataAdd[i].call == null ||
                                        dataAdd[i].call == "null")
                                    ? ""
                                    : callListToString(dataAdd[i].call),
                                style: AppTextStyle.callRinganaDataTextStyle,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Teilnehmer',
                                style: AppTextStyle.callRinganaTextStyle,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                (dataAdd[i].attendees == null ||
                                        dataAdd[i].attendees == "null")
                                    ? ""
                                    : listToString(dataAdd[i].attendees),
                                style: AppTextStyle.callRinganaDataTextStyle,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Ort:',
                                style: AppTextStyle.callRinganaTextStyle,
                              ),
                              Text(
                                dataAdd[i].ort == null
                                    ? ""
                                    : '${dataAdd[i].ort}',
                                style: AppTextStyle.callRinganaDataTextStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : const SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          AppConstants.txt_Noevents,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String listToString(List<Attendees>? list) {
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

  String callListToString(List<Call>? list) {
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

  void fetchCalendar(String date) async {
    dataAdd.clear();
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherNo = await Utility.fetchUserId();
    Response res = await ApiManager().fetchApiCalendar(date, voucherNo);
    log("$res");
    if (res != null && res.statusCode == 200 && res.data != null) {
      List data = res.data;
      if (res.data[0]["event_calendar"]['status'] == "200") {
        if (data[0]['responsedata'] != "null") {
          for (int j = 0;
              j < data[0]["event_calendar"]['responsedata'].length;
              j++) {
            dataAdd.add(Responsedata.fromJson(
                data[0]["event_calendar"]['responsedata'][j]));
          }
        }
      }
      /*if (data[0]['appointment_overview'] != "null") {
        for (int j = 0; j < data[0]['appointment_overview'].length; j++) {
          dataAdd
              .add(Responsedata.fromJson(data[0]['appointment_overview'][j]));
        }
      }*/
      /*for (int i = 0; i < data.length; i++) {
        //dataAdd.add(CalendarModel.fromJson(data[i]));
        for (int j = 0; j < data[0].marketingMeeting!.length; j++) {
          dataAdd.add(MarketingMeeting.fromJson(data[0].marketingMeeting![j]));
        }
      }*/
      log("${dataAdd.length}");
      setState(() {});
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
  }
}
