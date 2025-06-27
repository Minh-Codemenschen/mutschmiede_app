// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/colors.dart';
import '../../models/updatemodel.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../../widgets/custombtn.dart';

class MeinProfil extends StatefulWidget {
  const MeinProfil({Key? key}) : super(key: key);

  @override
  State<MeinProfil> createState() => _MeinProfilState();
}

class _MeinProfilState extends State<MeinProfil> {
  File? _profileImage;
  File? get profileImageFile => _profileImage;
  final ImagePicker profileImagesPicker = ImagePicker();
  UpdateModel? updateProfileResponse;

  bool isCoachesLoaded = false;

  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _phoneNo = TextEditingController(text: '');
  final TextEditingController _kunde = TextEditingController(text: '');
  final TextEditingController _department = TextEditingController(text: '');
  final TextEditingController _standort = TextEditingController(text: '');
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _gender = TextEditingController(text: '');
  final TextEditingController _subjectAreas = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    _email.text = "test@gmail.com";
    _phoneNo.text = "09090909";
    _name.text = "text";
    _department.text = "weiblich";
    _standort.text = "weiblich";
    _subjectAreas.text = "85,87";

    _gender.text = "marketing";
    _kunde.text = "Goldener Steig PG31 MVZ Waldkirchen";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            AppImages.icn_iconuserhome,
          ),
        ),
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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: InkWell(
                    onTap: () {
                      setState(() {});

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Abbrechen",
                    ),
                  ),
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Mein Profil",
                      style: AppTextStyle.buttonTextTextStyle
                          .copyWith(color: AppColors.appColors, fontSize: 17),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        updateProfileModel();
                      });
                    },
                    child: const Text('Fertig'),
                  ),
                ),
                (_profileImage == null)
                    ? CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColors.appColors,
                        child: InkWell(
                            onTap: (() {
                              _showChoiceDialog(context);
                            }),
                            child: Image.asset(
                              AppImages.icn_imageicon,
                            )),
                      )
                    : InkWell(
                        onTap: (() {
                          _showChoiceDialog(context);
                        }),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: FileImage(
                            File(_profileImage!.path),
                          ),
                        ),
                      ),
                TextField(
                  style: AppTextStyle.buttonTextTextStyle,
                  keyboardType: TextInputType.name,
                  controller: _name,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.11,
                  width: size.width * 0.89,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: AppColors.bgColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              title: Text(
                                "Geschlecht:",
                                style: AppTextStyle.titleTextStyle,
                              ),
                              isThreeLine: true,
                              subtitle: TextField(
                                controller: _standort,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              title: Text(
                                "Abteilung:",
                                style: AppTextStyle.titleTextStyle,
                              ),
                              isThreeLine: true,
                              subtitle: TextField(
                                controller: _gender,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              title: Text(
                                "Standort:",
                                style: AppTextStyle.titleTextStyle,
                              ),
                              isThreeLine: true,
                              enabled: true,
                              subtitle: TextField(
                                controller: _department,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  // border: OutlineInputBorder(),
                                  counterText: "",
                                  // '\n${updateProfileResponse?.req?.data ?? ""}',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.width * 0.01),
                  child: Text(
                    "Über mich:",
                    style: AppTextStyle.commonTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.075,
                  ),
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    onChanged: (v) {
                      setState(() {
                        _kunde.text = v;
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    controller: _kunde,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      left: size.width * 0.075, top: size.width * 0.05),
                  child: Text(
                    "Kontaktdaten",
                    style: AppTextStyle.commonTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.04,
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Email hinzufügen",
                                style: AppTextStyle.titleTextStyle.copyWith(
                                    color: AppColors.appColors, fontSize: 20),
                              )),
                          content: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            decoration: const InputDecoration(
                              enabled: true,
                              alignLabelWithHint: true,
                              filled: true,
                              border: OutlineInputBorder(),
                              counterText: '',
                            ),
                          ),
                          actions: <Widget>[
                            CustomBtn(
                              text: "Cancel",
                              background: AppColor.black87Color,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            CustomBtn(
                              text: "Ok",
                              background: AppColors.btncolor,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            log('${updateProfileResponse?.req?.data?.email != ''}');
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: AppColors.appColors,
                          ),
                        ),
                        Text(
                          "Enter your username",
                          style: AppTextStyle.commonTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.04,
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Telefonnummer hinzufügen",
                                style: AppTextStyle.titleTextStyle.copyWith(
                                    color: AppColors.appColors, fontSize: 20),
                              )),
                          content: TextField(
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.phone,
                            controller: _phoneNo,
                            decoration: const InputDecoration(
                              enabled: true,
                              alignLabelWithHint: true,
                              filled: true,
                              border: OutlineInputBorder(),
                              counterText: '',
                            ),
                          ),
                          actions: <Widget>[
                            CustomBtn(
                              text: "Cancel",
                              background: AppColor.black87Color,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            CustomBtn(
                              text: "Ok",
                              background: AppColors.btncolor,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle,
                            color: AppColors.appColors,
                          ),
                        ),
                        Text(
                          "Telefonnummer hinzufügen",
                          style: AppTextStyle.commonTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: Text(
                      "Meine Problemfelder",
                      style: AppTextStyle.titleTextStyle,
                    ),
                    subtitle: Text(
                      "(Nur für Coaches sichtbar)",
                      style: AppTextStyle.commonTextStyle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.appColors,
                                  child: const CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColor.textColorWhite,
                                  ),
                                ),
                                Positioned(
                                  left: size.width * 0.07,
                                  top: size.width * 0.07,
                                  child: Image.asset(
                                    AppImages.icn_stress,
                                    fit: BoxFit.cover,
                                    scale: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Stress',
                              style: AppTextStyle.commonTextStyle,
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.appColors,
                                  child: const CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColor.textColorWhite,
                                  ),
                                ),
                                Positioned(
                                  left: size.width * 0.07,
                                  top: size.width * 0.07,
                                  child: Image.asset(
                                    AppImages.icn_covid,
                                    fit: BoxFit.cover,
                                    scale: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Covid-19",
                              style: AppTextStyle.commonTextStyle,
                            )
                          ],
                        ))
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 0.02,
                      horizontal: size.width * 0.06),
                  child: Text(
                    'Weitere Problemfelder hinzufügen',
                    style: AppTextStyle.titleTextStyle,
                  ),
                ),
                Container(
                  height: size.height * 0.6,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 05, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 5,
                            crossAxisSpacing: 00,
                            mainAxisSpacing: 0,
                            crossAxisCount: 4),
                    itemCount: ProblemImages.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(ProblemImages[index]),
                          Container(
                            padding: const EdgeInsets.only(top: 05),
                            alignment: Alignment.center,
                            child: Text(
                              "${ProblemText[index]} ",
                              style: AppTextStyle.commonTextStyle
                                  .copyWith(fontSize: 12.5),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void _openGallery(BuildContext context) async {
    var pickedFile = await profileImagesPicker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 30,
  );
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      // avatarUpdateApiCall(_profileImage!);
    }
    setState(() {
      // _profileImage = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    var pickedImage = await profileImagesPicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (pickedImage != null) {
      _profileImage = File(pickedImage.path);
    }
    setState(() {});
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColor.nearlyWhite,
            title: Text(
              "Choose option",
              style: AppTextStyle.buttonTextTextStyle,
            ),
            actions: [
              CustomBtn(
                text: "Cancel",
                background: AppColor.black87Color,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text(
                      "Gallery",
                      style: AppTextStyle.buttonTextTextStyle
                          .copyWith(color: AppColor.black87Color),
                    ),
                    leading: Icon(
                      Icons.account_box,
                      color: AppColors.appColors,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColor.black87Color,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text(
                      "Camera",
                      style: AppTextStyle.buttonTextTextStyle
                          .copyWith(color: AppColor.black87Color),
                    ),
                    leading: Icon(
                      Icons.camera,
                      color: AppColors.appColors,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void updateProfileModel() async {
    isCoachesLoaded = false;
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherno = await Utility.fetchUserId();

    Response res = await ApiManager().updateProfile(
      voucherno,
      _email.text,
      _name.text,
      _gender.text,
      _phoneNo.text,
      _department.text,
      _kunde.text,
      _standort.text,
      _subjectAreas.text,
      File(_profileImage!.path),
    );
    if (res.statusCode == 200) {
      Navigator.pop(context);
      if (res.data != null) {
        Map<String, dynamic> map = res.data;
        updateProfileResponse = UpdateModel.fromJson(map);
        if (updateProfileResponse?.req?.data != null) {}
        setState(() {});
      } else {
        EasyLoading.showToast(AppConstants.txt_somethingwrong,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    EasyLoading.dismiss(animation: true);
    isCoachesLoaded = true;
  }
}
