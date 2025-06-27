// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// import '../constants/AppConstants.dart';
// import '../constants/colors.dart';
// import 'custombtn.dart';
// import 'customlist.dart';
//
// class CustomeSliablesBtn extends StatelessWidget {
//   const CustomeSliablesBtn(
//       {Key? key,
//       this.onPressed,
//       required this.label,
//       required this.label1,
//       required this.title,
//       required this.subtitle,
//       required this.assetName,
//       required this.btntxt,
//       required this.btntxt1,
//       required this.text})
//       : super(key: key);
//   final VoidCallback? onPressed;
//   final String label;
//   final String label1;
//   final String title;
//   final String subtitle;
//   final String assetName;
//   final String btntxt;
//   final String btntxt1;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Slidable(
//       key: const ValueKey(0),
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: doNothing,
//             foregroundColor: AppColor.black87Color,
//             label: label,
//           ),
//           SlidableAction(
//             onPressed: doNothing,
//             foregroundColor: AppColor.black87Color,
//             label: label1,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 08),
//         child: Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(05),
//                     alignment: Alignment.centerLeft,
//                     height: size.height * 0.12,
//                     width: size.width * 0.25,
//                     decoration: BoxDecoration(
//                       color: AppColors.bgColor,
//                       image: DecorationImage(
//                           image: AssetImage(assetName), scale: 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         CustomList(
//                           title: title,
//                           subtitle: subtitle,
//                         ),
//                         Container(
//                             alignment: Alignment.topLeft,
//                             padding: const EdgeInsets.only(left: 15),
//                             child: Text(text)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CustomBtn(
//                     text: btntxt,
//                     background: AppColors.btncolor,
//                     onPressed: onPressed!,
//                   ),
//                   const SizedBox(
//                     width: 05,
//                   ),
//                   CustomBtn(
//                     text: btntxt1,
//                     background: AppColor.black87Color,
//                     onPressed: onPressed!,
//                   ),
//                   const SizedBox(
//                     width: 05,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void doNothing(BuildContext context) {}
