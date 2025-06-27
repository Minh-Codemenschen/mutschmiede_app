class SpieleModel {
  List<Data>? data;

  SpieleModel({this.data});

  SpieleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? title;
  String? text;
  String? image;
  String? gameType;

  Data({this.title, this.text, this.image, this.gameType});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    image = json['image'];
    gameType = json['game_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['image'] = this.image;
    data['game_type'] = this.gameType;
    return data;
  }
}
