import 'package:flutter/material.dart';
import 'package:mutschmiede/screens/noraweber/neuegruppe.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../utils/Utils.dart';
import '../../widgets/custombtn.dart';
import '../UserProfile/userprofile.dart';
import '../neueaktion/neueation.dart';

class ZuruckScreen extends StatelessWidget {
  const ZuruckScreen({Key? key}) : super(key: key);

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
                    MaterialPageRoute(builder: (context) => const NeueGruppe()),
                  );
                },
                child: const Text("Zurück"),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ZuruckScreen()),
                  );
                },
                child: Image.asset(AppImages.icn_editicon),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                height: size.height * 0.13,
                decoration: BoxDecoration(
                  color: AppColors.appColors,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      trailing: Container(
                        padding: const EdgeInsets.only(top: 05),
                        child: Image.asset(AppImages.icn_cal),
                      ),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Daniel Pöttinger",
                          ),
                          Text(
                            "Dienstag, 14:58",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Text(
                        "CALL RINGANA",
                        style:
                            AppTextStyle.tabBarTextStyle.copyWith(fontSize: 14),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: size.width * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.width * 0.03,
                horizontal: size.width * 0.02,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "Hallo an alle,",
                style: AppTextStyle.tabBarTextStyle
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.width * 0.03,
                horizontal: size.width * 0.02,
              ),
              alignment: Alignment.center,
              child: Text(
                AppConstants.txt_zuruck,
                style: AppTextStyle.commonTextStyle,
              ),
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                'Termineinladung',
                style: AppTextStyle.titleTextStyle
                    .copyWith(color: AppColors.appColors),
              ),
            ),
            SizedBox(height: size.width * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                "Montag, 28.02.2022, 14:00-15:00\nCall Ringana",
                style: AppTextStyle.commonTextStyle
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: size.width * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                'Teilnehmer:\nPeter Pöschl, Christian Stolz, Alyssa Andritz,\nChristina Henrich, Sophie Ortmeier',
                style: AppTextStyle.commonTextStyle
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: size.width * 0.05),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                'Ort:\nStubenberggasse 8, 8020 Graz',
                style: AppTextStyle.commonTextStyle
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: size.width * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomBtn(
                    text: "Zusagen",
                    background: AppColors.btncolor,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomBtn(
                    text: "Absagen",
                    background: AppColor.black87Color,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
