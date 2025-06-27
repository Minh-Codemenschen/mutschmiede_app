// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/AppConstants.dart';
import '../../models/DashboardResponse.dart';
import '../../utils/Utils.dart';
import '../dashboardscreen.dart';

class CategoryDescriptionScreen extends StatefulWidget {
  Category? data;
  CategoryDescriptionScreen({Key? key, this.data}) : super(key: key);

  @override
  State<CategoryDescriptionScreen> createState() =>
      _CategoryDescriptionScreenState();
}

class _CategoryDescriptionScreenState extends State<CategoryDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    String image = "${widget.data?.termIcon}";
    image.replaceAll(RegExp('(?<=.\\|)[^@](?=[^@]*?[^@]@)'), '/');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(DashboardScreen.urlImagestatic)),
            );
          },
          child: Image.asset(
            AppImages.icn_Logo,
            fit: BoxFit.cover,
            scale: 1.2,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Utility.showLogoutDialog(context);
            },
          )
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  )),
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade300,
                child: SvgPicture.network(
                  image.toString(),
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.data?.termName}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Html(
                data: widget.data?.termDescription,
                style: {
                  '#': Style(
                    fontSize: FontSize(16),
                    margin: Margins.only(left: 6, right: 6),
                    fontWeight: FontWeight.w500,
                    maxLines: 150,
                    fontFamily: 'Raleway',
                    textOverflow: TextOverflow.ellipsis,
                  ),
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
