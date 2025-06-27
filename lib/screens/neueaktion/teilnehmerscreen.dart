import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/colors.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../dashboardscreen.dart';
import 'neueation.dart';

class TeilnehmerScrren extends StatefulWidget {
  const TeilnehmerScrren({Key? key}) : super(key: key);

  @override
  State<TeilnehmerScrren> createState() => _TeilnehmerScrrenState();
}

class _TeilnehmerScrrenState extends State<TeilnehmerScrren> {
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Teilnehmer",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 18),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Weiter",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.appColors,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Suchen",
                      hintStyle: AppTextStyle.commonTextStyle,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColor.black87Color,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.appColors),
                          borderRadius: BorderRadius.circular(15)),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.19,
                child: ListView.builder(
                  itemCount: TeilineText.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 05, right: 05),
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColor.transparentColor,
                            backgroundImage: AssetImage(
                              AppImages.icn_teiline,
                            ),
                          ),
                          Positioned(
                            left: size.width * 0.12,
                            child: Image.asset(
                              AppImages.icn_remove,
                              scale: 03,
                            ),
                          ),
                          Positioned(
                              top: size.width * 0.25,
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("${TeilineText[index]} "),
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: TeilineTextlist.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 05,
                            ),
                            child: Text(
                              "${TeilineTextlist[index]}",
                              style: AppTextStyle.titleTextStyle,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Image.asset(
                              AppImages.icn_teiline,
                              scale: 1,
                            ),
                            title: Text("${Teilinesublist[index]}"),
                            subtitle: Text("${Teilinetitlelist[index]} "),
                          ),
                          ListTile(
                            leading: Image.asset(
                              AppImages.icn_teiline,
                              scale: 1,
                            ),
                            title: Text("${Teilinesublist1[index]}"),
                            subtitle: Text("${Teilinetitlelist1[index]} "),
                          )
                        ],
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
