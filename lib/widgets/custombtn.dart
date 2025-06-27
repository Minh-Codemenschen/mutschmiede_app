import 'package:flutter/material.dart';
import 'package:mutschmiede/constants/app_text_style.dart';

import '../constants/colors.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {Key? key, required this.text, required this.onPressed, this.background})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color? background;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(color: AppColor.nearlyWhite),
      ),
      child: Text(text,
          style: AppTextStyle.buttonTextTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.nearlyWhite,
              fontSize: 19)),
    );
  }
}
