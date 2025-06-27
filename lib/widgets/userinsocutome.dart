import 'package:flutter/material.dart';

import '../constants/AppConstants.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2 / 1,
        childAspectRatio: 5 / 1,
      ),
      itemCount: Unser.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  margin: const EdgeInsets.all(08),
                  height: size.height * 0.023,
                  width: size.width * 0.047,
                  decoration: BoxDecoration(
                    color: AppColors.appColors,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  left: 03,
                  top: size.height * 0.011,
                  bottom: 06,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Text(
                        Unser[index],
                        style: AppTextStyle.titleTextStyle
                            .copyWith(color: AppColor.nearlyWhite),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(Unsertitle[index]),
            ),

            // ListTile(
            //   leading: Stack(
            //     children: [
            //       Stack(
            //         children: <Widget>[
            //           Container(
            //             margin: const EdgeInsets.all(08),
            //             height: size.height * 0.023,
            //             width: size.width * 0.047,
            //             decoration: BoxDecoration(
            //               color: AppColors.appColors,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //           ),
            //           Positioned(
            //             left: 03,
            //             top: size.height * 0.011,
            //             child: Container(
            //                 padding: const EdgeInsets.only(left: 10, right: 20),
            //                 child: Text(
            //                   Unser[index],
            //                   style: AppTextStyle.titleTextStyle
            //                       .copyWith(color: AppColor.nearlyWhite),
            //                 )),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            //   title: Text(Unsertitle[index]),
            // )
          ],
        );
      },
    );
  }
}
