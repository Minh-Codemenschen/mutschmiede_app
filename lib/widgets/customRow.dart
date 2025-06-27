// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constants/AppConstants.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade300,
                child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    AppImages.icn_michaeldammEZ,
                  ),
                )),
            SizedBox(
              height: size.width * 0.02,
            ),
            Image.asset(
              AppImages.icn_icons,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade300,
                child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    AppImages.icn_juricakoletic,
                  ),
                )),
            SizedBox(
              height: size.width * 0.02,
            ),
            Row(
              children: [
                Image.asset(
                  AppImages.icn_icons,
                ),
                Image.asset(
                  AppImages.icn_icon,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade300,
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(
                  AppImages.icn_benparkerym,
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            Image.asset(
              AppImages.icn_icons,
            ),
          ],
        )
      ],
    );
  }
}
