class VideoTrainerModel {
  List<VideoData>? data;

  VideoTrainerModel({this.data});

  VideoTrainerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VideoData>[];
      json['data'].forEach((v) {
        data!.add(new VideoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoData {
  String? videoTitle;
  String? videoImage;
  String? videoUrl;
  String? languageIcon;
  String? languageText;

  VideoData(
      {this.videoTitle,
      this.videoImage,
      this.videoUrl,
      this.languageIcon,
      this.languageText});

  VideoData.fromJson(Map<String, dynamic> json) {
    videoTitle = json['video_title'];
    videoImage = json['video_image'];
    videoUrl = json['video_url'];
    languageIcon = json['language_icon'];
    languageText = json['language_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_title'] = this.videoTitle;
    data['video_image'] = this.videoImage;
    data['video_url'] = this.videoUrl;
    data['language_icon'] = this.languageIcon;
    data['language_text'] = this.languageText;
    return data;
  }
}
