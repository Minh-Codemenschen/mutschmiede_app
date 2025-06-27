// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomBtnNewsItem extends StatelessWidget {
  const CustomBtnNewsItem(
      {Key? key, required this.text, required this.onPressed, this.background})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color? background;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 25, right: 25), backgroundColor: background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(color: AppColor.nearlyWhite, fontSize: 13),
        ),
        child: Text(text),
      ),
    );
  }
}
