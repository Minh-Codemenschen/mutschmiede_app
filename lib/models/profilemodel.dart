class ProfileResponse {
  String? status;
  String? message;
  Responsedata? responsedata;

  ProfileResponse({this.status, this.message, this.responsedata});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responsedata = json['responsedata'] != null
        ? Responsedata.fromJson(json['responsedata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (responsedata != null) {
      data['responsedata'] = responsedata!.toJson();
    }
    return data;
  }
}

class Responsedata {
  String? vouchernumber;
  String? gender;
  String? department;
  String? location;
  String? aboutMe;
  String? email;
  String? phone;
  String? urlImage;
  List<Areas>? areas;

  Responsedata(
      {this.vouchernumber,
      this.gender,
      this.department,
      this.location,
      this.aboutMe,
      this.email,
      this.phone,
      this.urlImage,
      this.areas});

  Responsedata.fromJson(Map<String, dynamic> json) {
    vouchernumber = json['vouchernumber'];
    gender = json['gender'];
    department = json['department'];
    location = json['location'];
    aboutMe = json['about_me'];
    email = json['email'];
    phone = json['phone'];
    urlImage = json['url_image'];
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vouchernumber'] = vouchernumber;
    data['gender'] = gender;
    data['department'] = department;
    data['location'] = location;
    data['about_me'] = aboutMe;
    data['email'] = email;
    data['phone'] = phone;
    data['url_image'] = urlImage;
    if (areas != null) {
      data['areas'] = areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  String? termId;
  String? termName;
  String? termUrl;
  String? termStatus;

  Areas({this.termId, this.termName, this.termUrl, this.termStatus});

  Areas.fromJson(Map<String, dynamic> json) {
    termId = '${json['term_id']}';
    termName = json['term_name'];
    termUrl = json['term_url'];
    termStatus = '${json['term_status']}';
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
