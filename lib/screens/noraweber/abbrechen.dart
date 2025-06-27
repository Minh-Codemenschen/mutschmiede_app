import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/colors.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../dashboardscreen.dart';
import '../neueaktion/neueation.dart';

class AbbrechenScreen extends StatefulWidget {
  const AbbrechenScreen({Key? key}) : super(key: key);

  @override
  State<AbbrechenScreen> createState() => _AbbrechenScreenState();
}

bool selectingmode = false;
List<Paint> paints = <Paint>[
  Paint(AppImages.icn_cal),
  Paint(
    AppImages.icn_jake,
  ),
  Paint(
    AppImages.icn_man1,
  ),
  Paint(AppImages.icn_burger),
  Paint(
    AppImages.icn_cal,
  ),
  Paint(
    AppImages.icn_face,
  ),
  Paint(
    AppImages.icn_man1,
  ),
  Paint(
    AppImages.icn_cal,
  ),
];

class _AbbrechenScreenState extends State<AbbrechenScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: AppColor.nearlyWhite,
          /*leading: IconButton(
            icon: Image.asset(
              AppImages.icn_iconuserhome,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
              setState(() {
                selectingmode = false;
                for (var p in paints) {
                  p.selected = false;
                }
              });
            },
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
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
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
                        setState(() {
                          selectingmode = false;
                          for (var p in paints) {
                            p.selected = false;
                          }
                        });
                      },
                      child: (selectingmode)
                          ? ((paints[1].selected)
                              ? Text(
                                  "Abbrechen",
                                  style: AppTextStyle.commonTextStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "Loschen",
                                  style: AppTextStyle.commonTextStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ))
                          : null,
                    ),
                    title: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Inbox",
                        style: AppTextStyle.buttonTextTextStyle
                            .copyWith(color: AppColors.appColors, fontSize: 18),
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(AppImages.icn_editicon),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: List.generate(paints.length, (index) {
                        return Column(
                          children: [
                            Divider(
                              color: Colors.blueGrey[100],
                            ),
                            Container(
                                color: (selectingmode)
                                    ? ((paints[index].selected)
                                        ? AppColors.appColors
                                        : AppColor.nearlyWhite)
                                    : null,
                                child: ListTile(
                                  onLongPress: () {
                                    setState(() {
                                      selectingmode = true;
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      if (selectingmode) {
                                        paints[index].selected =
                                            !paints[index].selected;
                                        log(paints[index].selected.toString());
                                      }
                                    });
                                  },
                                  selected: paints[index].selected,
                                  leading: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      width: size.width * 0.2,
                                      height: size.width * 0.6,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.bgColor),
                                            child: (selectingmode)
                                                ? ((paints[index].selected)
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 15,
                                                        color: AppColor
                                                            .black87Color,
                                                      )
                                                    : const Icon(
                                                        Icons.circle_outlined,
                                                        size: 18,
                                                      ))
                                                : null,
                                          ),
                                          Image.asset(
                                            InboxImages[index],
                                            scale: 0.2,
                                            height: 60,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  title: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      InboxTitle[index],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.tabBarTextStyle
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                  subtitle: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      Inboxsub[index],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.commonTextStyle,
                                    ),
                                  ),
                                  trailing: Text(
                                    InboxText[index],
                                    style: AppTextStyle.commonTextStyle,
                                  ),
                                )),
                          ],
                        );
                      }),
                    ),
                  ),
                ]))

        // SingleChildScrollView(
        //   child: Container(
        //     height: 500,
        //     width: double.infinity,
        //     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //
        //
        //         // SizedBox(
        //         //     height: size.height,
        //         //     child: ListView.builder(
        //         //       itemCount: InboxImages.length,
        //         //       scrollDirection: Axis.vertical,
        //         //       itemBuilder: (context, index) {
        //         //         return Container(
        //                     color: msgCount[index] >= 4
        //                         ? AppColor.nearlyWhite
        //                         : AppColors.appColors,
        //         //             child: Column(
        //         //               crossAxisAlignment: CrossAxisAlignment.start,
        //         //               children: [
        //         //                 Stack(
        //         //                   alignment: Alignment.topLeft,
        //         //                   children: [
        //         //                     Padding(
        //         //                       padding: EdgeInsets.symmetric(
        //         //                           horizontal: size.width * 0.02,
        //         //                           vertical: size.height * 0.00),
        //         //                       child: ListTile(
        //         //                         onTap: () {},
        //                                 leading: Image.asset(
        //                                   InboxImages[index],
        //                                   scale: 1.1,
        //                                 ),
        //         //                         title: Text(InboxTitle[index]),
        //         //                         subtitle: Text(Inboxsub[index]),
        //         //                         trailing: Text(InboxText[index]),
        //         //                       ),
        //         //                     ),
        //         //                     Positioned(
        //         //                         left: size.width * 0.0,
        //         //                         top: size.height * 0.02,
        //         //                         child: (msgCount[index] >= 4)
        //         //                             ? Container()
        //         //                             : Padding(
        //         //                                 padding: EdgeInsets.only(
        //         //                                     left: 05,
        //         //                                     top: size.height * 0.02),
        //         //                                 child: Center(
        //         //                                     child: InkWell(
        //         //                                   onTap: () {
        //         //                                     setState(() {
        //         //                                       _value2 = true;
        //         //                                     });
        //         //                                   },
        //                                           child: Container(
        //                                             decoration: BoxDecoration(
        //                                                 shape: BoxShape.circle,
        //                                                 color: AppColors.bgColor),
        //                                             child: value[index]
        //                                                 ? const Icon(
        //                                                     Icons.check,
        //                                                     size: 15.0,
        //                                                     color: AppColor
        //                                                         .textColorGrey,
        //                                                   )
        //         //                                         : Icon(
        //         //                                             Icons
        //         //                                                 .check_box_outline_blank,
        //         //                                             size: 15.0,
        //         //                                             color: AppColors
        //         //                                                 .bgColor),
        //         //                                   ),
        //         //                                 )),
        //         //                               )),
        //         //                   ],
        //         //                 ),

        //         //               ],
        //         //             ));
        //         //       },
        //         //     )),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

class Paint {
  final String? image;
  bool selected = false;
  Paint(this.image);
}
