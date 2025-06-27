import 'package:flutter/material.dart';

import '../constants/AppConstants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.title, this.icon}) : super(key: key);
  final String title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.09,
      width: size.width * 0.26,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: AppColors.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(title),
          ],
        ),
      ),
    );
  }
}
