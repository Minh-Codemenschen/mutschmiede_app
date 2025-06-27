import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/AppConstants.dart';
import 'package:mutschmiede/constants/app_text_style.dart';

import '../../constants/colors.dart';
import 'ereignisscreen.dart';
import 'neuenachricht.dart';

class NeueAktion extends StatelessWidget {
  const NeueAktion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.nearlyWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.height * 0.015),
                      height: size.height * 0.94,
                      decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Positioned(
                      right: size.width * 0.025,
                      top: size.height * 0.015,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppImages.icn_iconremove,
                          fit: BoxFit.cover,
                          scale: 1,
                        ),
                      ),
                    ),
                    Positioned(
                        left: size.width * 0.31,
                        top: size.height * 0.20,
                        child: Image.asset(
                          AppImages.icn_dilogbg,
                          fit: BoxFit.cover,
                          scale: 1,
                        )),
                    Positioned(
                      left: size.width * 0.41,
                      top: size.height * 0.26,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NeueNachricht()),
                          );
                        },
                        child: Image.asset(
                          AppImages.icn_nachricht,
                          fit: BoxFit.cover,
                          scale: 1.3,
                        ),
                      ),
                    ),
                    Positioned(
                        left: size.width * 0.36,
                        top: size.height * 0.37,
                        child: Text(
                          "Nachricht\nverfassen",
                          style: AppTextStyle.commonTextStyle.copyWith(
                              color: AppColor.nearlyWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),),
                    Positioned(
                        left: size.width * 0.31,
                        top: size.height * 0.57,
                        child: Image.asset(
                          AppImages.icn_dilogbg,
                          fit: BoxFit.cover,
                          scale: 1,
                        )),
                    Positioned(
                      left: size.width * 0.41,
                      top: size.height * 0.63,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EreignisScreen(),
                            ),
                          );
                        },
                        child: Image.asset(AppImages.icn_termine,
                            fit: BoxFit.cover, scale: 1),
                      ),
                    ),
                    Positioned(
                        left: size.width * 0.30,
                        top: size.height * 0.74,
                        child: Column(
                          children: [
                            Text(
                              "Kalendereintrag",
                              style: AppTextStyle.commonTextStyle.copyWith(
                                  color: AppColor.nearlyWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "vornehmen",
                              style: AppTextStyle.commonTextStyle.copyWith(
                                  color: AppColor.nearlyWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
