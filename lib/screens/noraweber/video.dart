import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../constants/AppConstants.dart';
import '../../constants/app_text_style.dart';
import '../../utils/Utils.dart';
import '../dashboardscreen.dart';

class VideoPlayerExample extends StatefulWidget {
  String? url, name;
  VideoPlayerExample({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  State<VideoPlayerExample> createState() => _VideoPlayerExampleState();
}

class _VideoPlayerExampleState extends State<VideoPlayerExample> {
  late VideoPlayerController _videoPlayerController;

  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings();

  late CustomVideoPlayerWebSettings _customVideoPlayerWebSettings;

  @override
  void initState() {
    super.initState();
    _customVideoPlayerWebSettings = CustomVideoPlayerWebSettings(
      src: widget.url ?? "",
    );
    _videoPlayerController = VideoPlayerController.network(
      widget.url ?? "",
    )..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "720p": _videoPlayerController,
      },
    );

    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );

    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: 15),
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
                  widget.name ?? "",
                  style: AppTextStyle.tabBarTextStyle,
                ),
                const SizedBox()
              ],
            ),
          ),
          kIsWeb
              ? Expanded(
                  child: CustomVideoPlayerWeb(
                    customVideoPlayerWebController:
                        _customVideoPlayerWebController,
                  ),
                )
              : CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
        ],
      ),
    );
  }
}
