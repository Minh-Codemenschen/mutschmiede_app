// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../models/aktuelles.dart';
import '../../utils/Utils.dart';
import '../dashboardscreen.dart';

class InfoDeteles extends StatefulWidget {
  List<Responsedata>? listresponse;
  String? company_name = "";
  bool isMenu = false;
  InfoDeteles(this.title, this.image, this.date, this.description,
      this.urlImage, this.listresponse, this.isMenu,
      {super.key});

  String? title;
  String? image;
  String? date;
  String? description;
  String? urlImage;
  @override
  State<InfoDeteles> createState() => _InfoDetelesState(listresponse, isMenu);
}

class _InfoDetelesState extends State<InfoDeteles> {
  List<Responsedata>? listresponse;
  _InfoDetelesState(this.listresponse, this.isMenu);
  DateFormat dateFormatparse = DateFormat("dd/MM/yyyy");
  DateFormat dateFormatformat = DateFormat("EEEE, dd.MM.yyyy", "de-at");
  bool isMenu = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_CompanyName();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      imageUrl: widget.urlImage ?? "",
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
            SizedBox(
              //height: size.height * 0.45,
              child: FutureBuilder<List<Responsedata>?>(
                  future: getAktuellesModel(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Etwas ist schief gelaufen!!"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: size.height * 0.16,
                              bottom: size.height * 0.18),
                          child: CircularProgressIndicator());
                    }
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: 08,
                          ),
                          child: Text(
                            'Aktuelles',
                            style: AppTextStyle.tabBarTextStyle,
                          ),
                        ),
                        if (!isMenu)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close)),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        const CircleAvatar(
                                          radius: 60,
                                          backgroundColor:
                                              AppColor.transparentColor,
                                          backgroundImage: AssetImage(
                                            AppImages.icn_dilogbg,
                                          ),
                                        ),
                                        Image.network(
                                          widget.image!,
                                          fit: BoxFit.cover,
                                          scale: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.035),
                                    child: Text(
                                      widget.title!.toUpperCase(),
                                      style: AppTextStyle.titleTextStyle
                                          .copyWith(color: AppColors.appColors),
                                    ),
                                  ),
                                  SizedBox(height: size.width * 0.02),
                                  if (widget.title!.toLowerCase() ==
                                          AppConstants.LABEL_MENU1
                                              .toLowerCase() ||
                                      widget.title!.toLowerCase() ==
                                          AppConstants.LABEL_MENU.toLowerCase())
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.021),
                                      child: Text(
                                        widget.date!,
                                        style: AppTextStyle.commonTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  SizedBox(height: size.width * 0.02),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.035),
                                    child: Text(
                                      widget.description!,
                                      style: AppTextStyle.commonTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(height: size.width * 0.05),
                                  SizedBox(
                                    height: size.width * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (isMenu) menuListing(size, listresponse![0].menu!),
                        if ((listresponse != null &&
                                listresponse!.length > 0 &&
                                listresponse![0].companyBuilding != null)
                            // listresponse?[0].companyBuilding?.location?.is > 0
                            //     listresponse![0].companyBuilding!.length > 0 &&
                            //     listresponse![0].companyBuilding![0].images !=
                            //         null)
                          &&
                            (listresponse != null &&
                                listresponse!.length > 0 &&
                                listresponse![0].companyBuilding != null))
                        // &&
                        //         listresponse![0].companyBuilding!.length > 0 &&
                        //         listresponse![0].companyBuilding![0].location !=
                        //             null &&
                        //         listresponse![0]
                        //             .companyBuilding![0]
                        //             .location!
                        //             .isNotEmpty))
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03, vertical: 10),
                            child: Text(
                              'Unser Firmengebäude',
                              style: AppTextStyle.tabBarTextStyle,
                            ),
                          ),
                        //Flexible(child: Container()),
                        if ((listresponse != null &&
                                listresponse!.length > 0 &&
                                listresponse![0].companyBuilding != null) ||
                            (listresponse != null &&
                                listresponse!.isNotEmpty &&
                                listresponse![0].companyBuilding != null &&
                                listresponse![0].companyBuilding?.location?[0].order !=
                                    null ))
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02, vertical: 08),
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.fitWidth,
                                    imageUrl: (listresponse != null &&
                                            listresponse!.length > 0 &&
                                            listresponse![0].companyBuilding !=
                                                null &&
                                            listresponse![0]
                                                    .companyBuilding!.location
                                                    !.length >
                                                0 &&
                                            listresponse![0]
                                                    .companyBuilding!
                                                    .images !=
                                                null)
                                        ? listresponse![0]
                                            .companyBuilding!
                                            .images!
                                        : "",
                                    errorWidget: (context, url, error) =>
                                        Container(),
                                  ),
                                  /*ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [

                                  ],
                                ),*/
                                  SizedBox(
                                    height: size.height * 0.008,
                                  ),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0.3,
                                      childAspectRatio: 6 / 1,
                                    ),
                                    itemCount: (listresponse != null &&
                                            listresponse!.length > 0 &&
                                            listresponse![0].companyBuilding !=
                                                null &&
                                            listresponse![0]
                                                    .companyBuilding!.location
                                                    !.length >
                                                0 &&
                                            listresponse![0]
                                                    .companyBuilding!
                                                    .location !=
                                                null &&
                                            listresponse![0]
                                                .companyBuilding!
                                                .location!
                                                .isNotEmpty)
                                        ? listresponse![0]
                                            .companyBuilding!
                                            .location!
                                            .length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      Location? location = listresponse![0]
                                          .companyBuilding!
                                          .location![index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.015),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: size.height * 0.026,
                                              width: size.height * 0.026,
                                              decoration: BoxDecoration(
                                                color: AppColors.appColors,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  location.order ?? "",
                                                  style: AppTextStyle
                                                      .titleTextStyle
                                                      .copyWith(
                                                          color: AppColor
                                                              .nearlyWhite,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8),
                                                child: Text(
                                                  location.name ?? "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                              constraints: BoxConstraints(
                                                  maxWidth: size.width * 0.35),
                                            ),

                                            // ListTile(
                                            //   leading: Stack(
                                            //     children: [
                                            //       Stack(
                                            //         children: <Widget>[
                                            //           Container(
                                            //             margin: const EdgeInsets.all(08),
                                            //             height: size.height * 0.023,
                                            //             width: size.width * 0.047,
                                            //             decoration: BoxDecoration(
                                            //               color: AppColors.appColors,
                                            //               borderRadius: BorderRadius.circular(20),
                                            //             ),
                                            //           ),
                                            //           Positioned(
                                            //             left: 03,
                                            //             top: size.height * 0.011,
                                            //             child: Container(
                                            //                 padding: const EdgeInsets.only(left: 10, right: 20),
                                            //                 child: Text(
                                            //                   Unser[index],
                                            //                   style: AppTextStyle.titleTextStyle
                                            //                       .copyWith(color: AppColor.nearlyWhite),
                                            //                 )),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ],
                                            //   ),
                                            //   title: Text(Unsertitle[index]),
                                            // )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.004,
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        if (listresponse != null &&
                            listresponse!.isNotEmpty &&
                            listresponse![0].contact != null)
                          contact(size, listresponse![0].contact),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void fetch_CompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.company_name = prefs.getString(AppConstants.COMPANY_NAME) ?? "";
    setState(() {});
  }

  Future<List<Responsedata>?> getAktuellesModel() async {
    // EasyLoading.show(
    //   status: 'Please Wait!',
    //   maskType: EasyLoadingMaskType.black,
    // );
    return listresponse;
  }

  Widget menuListing(Size size, Menu list) {
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
              SizedBox(
                child: Text(
                  widget.title.toString(),
                  //AppConstants.LABEL_MENU.toUpperCase(),
                  style: AppTextStyle.TextStyleBoldLabelNewsItem.copyWith(
                      color: AppColors.appColors, fontSize: 17.5),
                ),
              ),
              SizedBox(height: size.width * 0.010),
              Text(
                dateFormatformat
                    .format(dateFormatparse.parse(widget.date.toString())),
                style: AppTextStyle.TextStyleBoldBlackNewsItem.copyWith(),
              ),
              Row(
                children: [
                  Text(
                    widget.title.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),

                  ),
                  Text(
                    '€ ${widget.description ?? ""}',
                    style: AppTextStyle.TextStyleBoldBlackNewsItemDetail,
                  ),
                ],
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

  Widget contact(Size size, Contact? contact) {
    return Column(
      children: [
        if (contact != null)
          contact.isShow == false
              ? const SizedBox()
              : Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04, vertical: 08),
                  child: Text(
                    'Wichtige Ansprechpartner',
                    style: AppTextStyle.tabBarTextStyle,
                  ),
                ),
        if (contact != null)
          contact.isShow == false
              ? const SizedBox()
              : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(09),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5 / 4.5, crossAxisCount: 2),
                      itemCount: contact.list?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return infoItem(
                            size,
                            contact.list?[index].contactTitle,
                            contact.list?[index].contactText,
                            contact.list?[index].contactIcon,
                            "");
                      }),
                ),
      ],
    );
  }

  Widget infoItem(
      Size size, String? title, String? txt, String? url, String? type) {
    return Column(children: [
      Container(
        width: size.width * 0.30,
        height: size.width * 0.30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEFEFEF),
        ),
        child: SizedBox(
          width: size.width * 0.20,
          height: size.width * 0.20,
          child: Image.network(
            url ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 03,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 05),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title ?? "",
            style: const TextStyle(
                fontSize: 12, fontFamily: AppConstants.font_family),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 05),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            txt ?? "",
            style: const TextStyle(
                fontSize: 12, fontFamily: AppConstants.font_family),
          ),
        ),
      ),
    ]);
  }

  // Widget infoItem(int index, Size size, String text, String? txt) {
  //   return InkWell(
  //     onTap: () async {
  //       try {
  //         launchUrl(
  //             Uri.parse("tel:${txt}"));
  //       } catch (e) {}
  //     },
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
  //       Container(
  //         width: size.width * 0.30,
  //         height: size.width * 0.30,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Color(0xFFEFEFEF),
  //         ),
  //         child: SizedBox(
  //           width: size.width * 0.20,
  //           height: size.width * 0.20,
  //           child: Image.asset(
  //             InfoImages[index],
  //           ),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 03,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 05),
  //         child: Container(
  //           alignment: Alignment.center,
  //           child: Text(
  //             InfoTitle[index],
  //             style:
  //             TextStyle(fontSize: 12, fontFamily: AppConstants.font_family),
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 05),
  //         child: Container(
  //           alignment: Alignment.center,
  //           child: Text(
  //             txt ?? "",
  //             style:
  //             TextStyle(fontSize: 12, fontFamily: AppConstants.font_family),
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }
}
