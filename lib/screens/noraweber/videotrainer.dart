import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/models/videoTrainermodel.dart';
import 'package:mutschmiede/screens/noraweber/video.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../network/ApiManager.dart';
import '../../utils/Utils.dart';
import '../dashboardscreen.dart';

class VideoTrainer extends StatefulWidget {
  const VideoTrainer({Key? key}) : super(key: key);

  @override
  State<VideoTrainer> createState() => _VideoTrainerState();
}

class _VideoTrainerState extends State<VideoTrainer> {
  bool isCoachesLoaded = false;
  List<VideoData>? listData;
  @override
  void initState() {
    // TODO: implement initState
    videoTrainerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: 08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'Versions of Video',
                    style: AppTextStyle.tabBarTextStyle,
                  ),
                  const SizedBox()
                ],
              ),
            ),
            if (listData != null) video(size)
          ],
        ),
      ),
    );
  }

  Future<List<VideoData>?> videoTrainerModel() async {
    EasyLoading.show(
      status: 'Please Wait!',
      maskType: EasyLoadingMaskType.black,
    );
    String voucherNo = await Utility.fetchUserId();
    dio.Response? res = await ApiManager().videoTrainer(voucherNo);
    if (res != null && res.data != null) {
      Map map = res.data;
      VideoTrainerModel videoTrainer =
          VideoTrainerModel.fromJson(map as Map<String, dynamic>);
      if (videoTrainer != null &&
          videoTrainer.data != null &&
          videoTrainer.data!.isNotEmpty) {
        setState(() {
          listData = videoTrainer.data;
        });
        print("listData >>>>>>>>>> ${listData.toString()}");
        List<VideoData>? list = videoTrainer.data;
        EasyLoading.dismiss(animation: true);
        return list;
      } else {
        return [];
      }
    }

    return [];
  }

  Widget video(Size size) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listData?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerExample(
                              name: listData?[index].videoTitle,
                              url: listData?[index].videoUrl),
                        ));
                  },
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.network(
                            listData?[index].languageIcon ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          listData?[index].languageText ?? "",
                          style: AppTextStyle.tabBarTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
