import 'package:flutter/material.dart';

import '../constants/AppConstants.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import 'customlist.dart';

class CustomeSliable extends StatelessWidget {
  const CustomeSliable(
      {Key? key,
      this.onPressed,
      this.label,
      this.label1,
      required this.subtitle,
      required this.assetName,
      this.text,
      required this.subtitle1,
      required this.subtitle2})
      : super(key: key);
  final VoidCallback? onPressed;
  final String? label;
  final String? label1;

  final String subtitle;
  final String subtitle1;
  final String subtitle2;
  final String? assetName;
  final String? text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 08),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(05),
                  alignment: Alignment.centerLeft,
                  height: size.height * 0.12,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    image: DecorationImage(
                        image: AssetImage(assetName!), scale: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomList(
                          text: text!,
                          subtitle: subtitle,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subtitle1,
                            style: AppTextStyle.commonTextStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black87Color),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 05),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subtitle2,
                            style: AppTextStyle.commonTextStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black87Color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
