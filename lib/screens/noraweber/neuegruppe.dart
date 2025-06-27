import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/app_text_style.dart';

import '../../constants/AppConstants.dart';
import '../../constants/colors.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../neueaktion/neueation.dart';
import '../neueaktion/teilnehmerscreen.dart';
import 'noraweber.dart';

class NeueGruppe extends StatelessWidget {
  const NeueGruppe({Key? key}) : super(key: key);

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TeilnehmerScrren()),
                  );
                },
                child: const Text("Zurück"),
              ),
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  "Neue Gruppe",
                  style: AppTextStyle.buttonTextTextStyle
                      .copyWith(color: AppColors.appColors, fontSize: 18),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NoraWeberScrren()),
                  );
                },
                child: const Text("Erstellen"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: AppColors.appColors,
                        backgroundImage: const AssetImage(
                          AppImages.icn_imagebg,
                        ),
                      ),
                      Positioned(
                        left: size.width * 0.04,
                        top: size.width * 0.05,
                        child: Image.asset(
                          AppImages.icn_imageicon,
                          fit: BoxFit.cover,
                          scale: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          const SizedBox(height: 05),
                          Text(
                            "Gruppenbetreff",
                            style: AppTextStyle.commonTextStyle
                                .copyWith(color: AppColor.textColorGrey),
                          ),
                          const SizedBox(height: 05),
                          const Divider()
                        ],
                      )),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.width * 0.03),
              child: const Text("Teilnehmer"),
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
                          radius: 35,
                          backgroundColor: AppColor.transparentColor,
                          backgroundImage: AssetImage(
                            AppImages.icn_teiline,
                          ),
                        ),
                        Positioned(
                          left: size.width * 0.11,
                          child: Image.asset(
                            AppImages.icn_remove,
                            scale: 03,
                          ),
                        ),
                        Positioned(
                            top: size.width * 0.20,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("${TeilineText[index]} "),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
