import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/constants/app_text_style.dart';
import 'package:mutschmiede/screens/GameScreen/rememeber.dart';
import 'package:mutschmiede/screens/GameScreen/stroop.dart';

import '../../constants/AppConstants.dart';
import '../../models/spielemodel.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/customlist.dart';
import '../HomeScreen/homescreenclone.dart';
import '../dashboardscreen.dart';
import 'HeadCalculation.dart';

class GameListingScreen extends StatefulWidget {
  const GameListingScreen({Key? key}) : super(key: key);

  @override
  State<GameListingScreen> createState() => _GameListingScreenState();
}

class _GameListingScreenState extends State<GameListingScreen> {
  bool isCoachesLoaded = false;
  late HomeScreenClone homeScreenClone;
  @override
  void initState() {
    // TODO: implement initState
    spieleGet();
    homeScreenClone = HomeScreenClone(DashboardScreen.urlImagestatic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          centerTitle: true,
          title: Text(
            "Spiele",
            style: AppTextStyle.tabBarTextStyle,
          ),
        ),
        body: listView(size));
  }

  // listView(BuildContext context, String img, String title, String subTitle,
  //     void Function() onTap) {
  //   return Column(
  //     children: [
  //       Padding(
  //           padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
  //           child: InkWell(
  //             onTap: onTap,
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.only(
  //                             left: MediaQuery.of(context).size.width * 0.015,
  //                             top: MediaQuery.of(context).size.height * 0.009,
  //                             bottom:
  //                                 MediaQuery.of(context).size.height * 0.009),
  //                         child: Container(
  //                           margin: const EdgeInsets.all(05),
  //                           alignment: Alignment.centerLeft,
  //                           width: MediaQuery.of(context).size.width * 0.25,
  //                           height: MediaQuery.of(context).size.height * 0.12,
  //                           decoration: BoxDecoration(
  //                             color: AppColors.bgColor,
  //                             image: DecorationImage(
  //                                 fit: BoxFit.cover,
  //                                 image: AssetImage(img),
  //                                 scale: 1),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(
  //                               left: 5, right: 5, top: 6, bottom: 6),
  //                           child: CustomList(text: title, subtitle: subTitle),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //           // InkWell(
  //           //   onTap: () {
  //           //     Navigator.push(
  //           //       context,
  //           //       MaterialPageRoute(
  //           //           builder: (context) =>
  //           //               HeadCalculation()),
  //           //     );
  //           //   },
  //           //   child:Card(
  //           //     shape:
  //           //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           //     child: Row(
  //           //       // crossAxisAlignment: CrossAxisAlignment.start,
  //           //       children: [
  //           //         Padding(
  //           //           padding: EdgeInsets.only(
  //           //               left: size.width * 0.0010,
  //           //               right: size.width * 0.010,
  //           //               top: size.height * 0.0010,
  //           //               bottom: size.height * 0.0010),
  //           //           child: Container(
  //           //             margin: const EdgeInsets.all(05),
  //           //             alignment: Alignment.centerLeft,
  //           //             width: size.width * 0.11,
  //           //             height: size.height * 0.05,
  //           //             // child: Center(child: Icon(Icons.smart_toy)),
  //           //             decoration: BoxDecoration(
  //           //               color: AppColors.bgColor,
  //           //               image: const DecorationImage(
  //           //                   image: AssetImage(AppImages.icn_mind),fit: BoxFit.cover,
  //           //                   scale: 1),
  //           //               borderRadius: BorderRadius.circular(10),
  //           //             ),
  //           //           ),
  //           //         ),
  //           //         Text('Head Calculation',style: AppTextStyle.titleTextStyle,)
  //           //       ],
  //           //     ),
  //           //   ),
  //           //   /*Card(
  //           //     child: SizedBox(
  //           //       height: 50,
  //           //       child: Padding(
  //           //         padding: const EdgeInsets.all(12.0),
  //           //         child: Row(
  //           //           // mainAxisAlignment: MainAxisAlignment.center,
  //           //           // crossAxisAlignment: CrossAxisAlignment.center,
  //           //           children: [
  //           //             Icon(Icons.smart_toy),
  //           //             SizedBox(width: 20,),
  //           //             Text('Head Calculation',style: AppTextStyle.titleTextStyle,),
  //           //           ],
  //           //         ),
  //           //       ),
  //           //     ),
  //           //   ),*/
  //           // ),
  //           )
  //     ],
  //   );
  // }

  Widget listView(Size size) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listData?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: InkWell(
                        onTap: () {
                          listData[index].gameType == "koperechnen"
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HeadCalculation(),
                                  ),
                                )
                              : listData[index].gameType == "stroop"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Stroop(),
                                      ),
                                    )
                                  : listData[index].gameType == "erinnerungstest"
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Remember(),
                                          ),
                                        )
                                      : null;
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.009,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.009),
                                    child: Container(
                                      margin: const EdgeInsets.all(05),
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      decoration: BoxDecoration(
                                        color: AppColors.bgColor,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                listData[index].image ?? ""),
                                            scale: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 6, bottom: 6),
                                      child: CustomList(
                                          text: listData[index]
                                                  .title
                                                  ?.toUpperCase() ??
                                              "",
                                          subtitle: (listData[index].text ?? "").replaceAll('\\n', '\n')),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<Data> listData = [];

  Future<List<Data>?> spieleGet() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().apiGetSpiele();
    if (res != null && res.data != null) {
      Map map = res.data;
      SpieleModel spieleModel =
          SpieleModel.fromJson(map as Map<String, dynamic>);
      if (spieleModel != null &&
          spieleModel.data != null &&
          spieleModel.data!.isNotEmpty) {
        setState(() {
          listData = spieleModel.data!;
        });
        print("listData >>>>>>>>>> ${listData.toString()}");
        List<Data>? list = spieleModel.data;
        EasyLoading.dismiss(animation: true);
        return list;
      } else {
        return [];
      }
    }

    return [];
  }
}
