// ignore_for_file: file_names

class FetchUserList {
  String? id;
  String? displayName;
  String? email;
  String? phoneNumbner;
  String? telNumberApp;
  String? phoneNumbnerDisplay;
  String? profileStatus;
  String? status;
  String? language;
  List<String>? speakingLanguage;
  List<String>? urlIconLanguage;
  String? avatar;
  String? ort;
  String? mp3;
  String? dw;
  String? shortIntro;
  String? intro;
  List<Expertise>? expertise;

  FetchUserList(
      {this.id,
      this.displayName,
      this.email,
      this.phoneNumbner,
      this.telNumberApp,
      this.phoneNumbnerDisplay,
      this.profileStatus,
      this.language,
      this.speakingLanguage,
      this.urlIconLanguage,
      this.avatar,
      this.ort,
      this.mp3,
      this.dw,
      this.shortIntro,
      this.intro,
      this.expertise,
      this.status});

  FetchUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    email = json['email'];
    phoneNumbner = json['phone_numbner'];
    telNumberApp = json['tel_number_app'];
    phoneNumbnerDisplay = json['phone_numbner_display'];
    profileStatus = json['profile_status'];
    language = json['language'];
    speakingLanguage = json['speaking_language'].cast<String>();
    urlIconLanguage = json['url_icon_language'].cast<String>();
    avatar = json['avatar'];
    ort = json['ort'];
    mp3 = json['mp3'];
    dw = json['dw'];
    status = '${json['status']}';
    shortIntro = json['short_intro'];
    intro = json['intro'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(Expertise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['display_name'] = displayName;
    data['email'] = email;
    data['phone_numbner'] = phoneNumbner;
    data['profile_status'] = profileStatus;
    data['language'] = language;
    data['speaking_language'] = speakingLanguage;
    data['url_icon_language'] = urlIconLanguage;
    data['tel_number_app'] = telNumberApp;
    data['phone_numbner_display'] = phoneNumbnerDisplay;
    data['avatar'] = avatar;
    data['ort'] = ort;
    data['mp3'] = mp3;
    data['dw'] = dw;
    data['status'] = status;
    data['short_intro'] = shortIntro;
    data['intro'] = intro;
    if (expertise != null) {
      data['expertise'] = expertise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expertise {
  int? termId;
  String? termName;
  String? termUrl;
  String? termStatus;

  Expertise({this.termId, this.termName, this.termUrl, this.termStatus});

  Expertise.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    termName = json['term_name'];
    termUrl = json['term_url'];
    termStatus = json['term_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['term_name'] = termName;
    data['term_url'] = termUrl;
    data['term_status'] = termStatus;
    return data;
  }
}
