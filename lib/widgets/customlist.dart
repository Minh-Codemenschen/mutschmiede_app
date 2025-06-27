import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';

class CustomList extends StatelessWidget {
  const CustomList(
      {Key? key, required this.subtitle, this.date, required this.text})
      : super(key: key);

  final String subtitle;
  final String? date;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   padding: const EdgeInsets.only( left: 15),
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     title,
        //     style: AppTextStyle.tabBarTextStyle
        //         .copyWith(color: AppColors.appColors),
        //   ),
        // ),
        Container(
          padding: const EdgeInsets.only(top: 12, left: 15, bottom: 03),
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: AppTextStyle.TextStyleBoldLabelNewsItem,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 02),
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            style: AppTextStyle.TextStyleBoldBlackNewsItem,
          ),
        ),
      ],
    );
  }
}
