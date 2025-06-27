// // ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, must_be_immutable
//
// import 'dart:convert';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:mutschmiede/utils/Utils.dart';
//
// import '../../constants/AppConstants.dart';
//
// class KooperationPartnerLogos extends StatefulWidget {
//   KooperationPartnerLogos(this.urlImages, {super.key});
//   String? urlImages;
//   @override
//   State<KooperationPartnerLogos> createState() =>
//       _KooperationPartnerLogosState();
// }
//
// class _KooperationPartnerLogosState extends State<KooperationPartnerLogos> {
//   List<String>? listImages = [];
//   @override
//   void initState() {
//     super.initState();
//     if (widget.urlImages != null && widget.urlImages?.isNotEmpty == true) {
//       var imagesList = json.decode(widget.urlImages ?? "");
//       if (imagesList is List) {
//         for (dynamic image in imagesList) {
//           listImages?.add(image.toString());
//         }
//       }
//     }
//   }
//
//   bool isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 3,
//         /*leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const UserProfile()),
//             );
//           },
//           icon: Image.asset(
//             AppImages.icn_iconuserhome,
//           ),
//         ),*/
//         centerTitle: true,
//         title: Image.asset(
//           AppImages.icn_Logo,
//           fit: BoxFit.cover,
//           scale: 1.2,
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.logout,
//               color: AppColors.primaryColor,
//             ),
//             onPressed: () {
//               Utility.showLogoutDialog(context);
//             },
//           )
//           /*IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const NeueAktion()),
//               );
//             },
//             icon: Image.asset(
//               AppImages.icn_iconplushome,
//             ),
//           ),*/
//         ],
//       ),
//       backgroundColor: Colors.grey.shade200,
//       body: Container(
//           alignment: Alignment.topCenter,
//           padding: const EdgeInsets.all(10),
//           margin: const EdgeInsets.all(09),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: (listImages?.length ?? 0) != 0
//               ? GridView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       mainAxisExtent: 190,
//                       crossAxisSpacing: 6,
//                       crossAxisCount: 2,
//                     mainAxisSpacing: 6
//                   ),
//                   itemCount: listImages?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     return CachedNetworkImage(
//                       imageUrl: listImages?[index] ?? "",
//                       errorWidget: (context, url, error) => Image.asset(
//                         AppImages.icn_error,
//                         width: size.width * 0.25,
//                         height: size.width * 0.25,
//                       ),
//                         width: size.width * 0.25, height: size.width * 0.25,
//                     );
//                   },
//                 )
//               : const Center(
//                 child: Text(
//                   AppConstants.txt_NoPartners,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                   ),
//                 ),
//               )),
//     );
//   }
// }

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/AppConstants.dart';
import '../../../constants/app_text_style.dart';
import '../../../models/aktuelles.dart';
import '../../../network/ApiManager.dart';
import '../../../utils/Utils.dart';

class KooPerationsPartner extends StatefulWidget {
  const KooPerationsPartner({Key? key}) : super(key: key);

  @override
  State<KooPerationsPartner> createState() => _KooPerationsPartnerState();
}

class _KooPerationsPartnerState extends State<KooPerationsPartner> {
  List<Responsedata>? listResponse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          automaticallyImplyLeading: false,
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
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: FutureBuilder<List<Responsedata>?>(
              future: getAktuellesModel(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Etwas ist schief gelaufen!!"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: size.height * 0.16, bottom: size.height * 0.18),
                      child: const CircularProgressIndicator());
                }
                Responsedata? responseData =
                    (snapshot.data as List<Responsedata?>?)![0];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      if ((responseData != null &&
                          responseData.kooperatiospartner != null &&
                          responseData.kooperatiospartner!.list!.isNotEmpty))
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                AppImages.icn_undo,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Kooperations Partner',
                              style: AppTextStyle.tabBarTextStyle,
                            ),
                            const Spacer(),
                          ],
                        ),
                      if (responseData != null &&
                          responseData.kooperatiospartner != null &&
                          responseData.kooperatiospartner?.list != null)
                        kooperatiosPartnerList(
                            size, responseData.kooperatiospartner!),
                    ],
                  ),
                );
              }),
        ));
  }

  Future<List<Responsedata>?> getAktuellesModel() async {
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().aktuelLes(voucherNo);
    if (res != null && res.data != null) {
      Map map = res.data;
      if (map['status'] != null && map['status'].toString() == "200") {
        AktuellesModel aktuellesModel =
            AktuellesModel.fromJson(map as Map<String, dynamic>);
        if (aktuellesModel != null &&
            aktuellesModel.responsedata != null &&
            aktuellesModel.responsedata!.isNotEmpty) {
          listResponse = aktuellesModel.responsedata;
          List<Responsedata>? list = aktuellesModel.responsedata;
          return list;
        } else {
          return [];
        }
      } else {
        return [];
      }
    }
    return [];
  }
}

Widget kooperatiosPartnerList(
    Size size, Kooperatiospartner? kooperatiospartner) {
  List<String>? listImages = [];
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: kooperatiospartner?.list?.length,
    itemBuilder: (context, index) {
      Kooperatiospartner? partner = kooperatiospartner;
      if (partner?.list?[index].images != null &&
          partner?.list?[index].images?.isNotEmpty == true) {
        var imagesList = json.decode(partner?.list?[index].images ?? "");
        if (imagesList is List) {
          for (dynamic image in imagesList) {
            listImages.add(image.toString());
          }
        }
      }
      if (partner != null) {
        return Column(
          children: [
            InkWell(
              onTap: () async {
                if (partner.list?[index].partnerLink != null &&
                    partner.list?[index].partnerLink != '' &&
                    partner.list?[index].partnerLink != 'null') {
                  await launchUrl(
                      Uri.parse(partner.list?[index].partnerLink ?? ''),mode: LaunchMode.externalApplication);
                }

                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KooPeTatIosPartner(
                        status: 1,
                      ),
                    ));*/
              },
              child: Card(
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(08),
                          alignment: Alignment.centerLeft,
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          child: CachedNetworkImage(
                            imageUrl: listImages[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  scale: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 10, top: 15, right: 25),
                                child: Text(
                                  partner.list![index].title
                                      .toString()
                                      .toUpperCase(),
                                  style: AppTextStyle.tabBarTextStyle.copyWith(
                                      fontSize: 15, color: AppColors.appColors),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 05, right: 15),
                                child: Text(
                                  partner.list![index].description.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle
                                      .TextStyleRegularLabelNewsItem,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      } else {
        return Container(
          height: 0,
        );
      }
    },
  );
}
