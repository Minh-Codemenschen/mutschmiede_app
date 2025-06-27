import 'package:flutter/material.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../utils/Utils.dart';
import '../UserProfile/userprofile.dart';
import '../neueaktion/neueation.dart';
import 'neuegruppe.dart';

class NoraWeberScrren extends StatelessWidget {
  const NoraWeberScrren({Key? key}) : super(key: key);

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
        height: size.height * 0.84,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NeueGruppe()),
                    );
                  },
                  child: Text(
                    "Zurück",
                    style: AppTextStyle.commonTextStyle,
                  ),
                ),
                title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Nora Weber",
                    style: AppTextStyle.buttonTextTextStyle
                        .copyWith(color: AppColors.appColors, fontSize: 18),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserProfile()),
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                      color: AppColor.black87Color,
                    ))),
            const Divider(),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          TextFormField(
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Hier Nachricht eingeben …"),
                            keyboardType: TextInputType.text,
                          ),
                          Positioned(
                              right: size.width * 0.02,
                              bottom: size.height * 0.01,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    AppImages.icn_imagebg,
                                    scale: 3,
                                  ))),
                          Positioned(
                              right: size.width * 0.035,
                              bottom: size.height * 0.02,
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: AppColor.nearlyWhite,
                              )),
                        ],
                      ))),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
