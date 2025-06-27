import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../utils/Utils.dart';

class GenerateQrcode extends StatefulWidget {
  String? voucherNo;
  GenerateQrcode({Key? key, required this.voucherNo}) : super(key: key);

  @override
  State<GenerateQrcode> createState() => _GenerateQrcodeState();
}

class _GenerateQrcodeState extends State<GenerateQrcode> {
  var size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        /*leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          },
          icon: Image.asset(
            AppImages.icn_iconuserhome,
          ),
        ),*/
        centerTitle: true,
        title: Image.asset(
          AppImages.icn_Logo,
          fit: BoxFit.cover,
          scale: 1.2,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Utility.showLogoutDialog(context);
            },
          )
          /*IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NeueAktion()),
              );
            },
            icon: Image.asset(
              AppImages.icn_iconplushome,
            ),
          ),*/
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImages.icn_undo,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.voucherNo ?? "voucherNo",
                    style: AppTextStyle.tabBarTextStyle,
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: size.height / 20,
              ),
              QrImageView(
                data: widget.voucherNo ?? "",
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Text(
                "Mit Login-QR-Code scannen",
                style: AppTextStyle.textFieldTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
