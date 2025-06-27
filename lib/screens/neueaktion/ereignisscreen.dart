import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../packages/flutter_clean_calandar/clean_calendar_event.dart';
import '../../packages/flutter_clean_calandar/flutter_clean_calendar.dart';
import '../../utils/Utils.dart';
import 'teilnehmerscreen.dart';

class EreignisScreen extends StatefulWidget {
  const EreignisScreen({Key? key}) : super(key: key);

  @override
  State<EreignisScreen> createState() => _EreignisScreenState();
}

final Map<DateTime, List<CleanCalendarEvent>> _events = {
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [],
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
      [],
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3):
      [],
};

@override
void initState() {
  initState();

  _handleNewDate(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ),
  );
}

void _handleNewDate(date) {
  log('Date selected: $date');
}

class _EreignisScreenState extends State<EreignisScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppImages.icn_iconuserhome,
          ),
        ),
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
            onPressed: () {},
            icon: Image.asset(
              AppImages.icn_iconplushome,
            ),
          ),*/
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Abbrechen",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
                title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Ereignis",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 18),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Erstellen",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle:
                          AppTextStyle.textFieldTextStyle, //,hint text style
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Ort",
                      labelStyle:
                          AppTextStyle.textFieldTextStyle, //,hint text style
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Beginn"),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: size.width * 0.2),
                      child: const Text("17.03.2022"),
                    ),
                    const Text("14:00"),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: AppColor.black87Color,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Ende"),
                    Text("15:00"),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: size.height * 0.35,
                  child: Stack(
                    children: [
                      Calendar(
                        // startOnMonday: true,
                        weekDays: const ["M", "D", "M", "D", "F", "S", "S"],
                        events: _events,
                        // isExpandable: true,
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
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: AppColor.black87Color,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TeilnehmerScrren()),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Teilnehmer hinzufugen"),
                      Icon(
                        Icons.add_circle,
                        color: AppColors.appColors,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: AppColor.black87Color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Anhang hinzufügen…",
                      labelStyle:
                          AppTextStyle.textFieldTextStyle, //,hint text style
                    )),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notizen",
                  style: AppTextStyle.commonTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
