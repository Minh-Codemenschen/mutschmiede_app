// ignore_for_file: file_names

class LoginRespons {
  String? status;
  String? message;
  Responsedata? responsedata;

  LoginRespons({this.status, this.message, this.responsedata});

  LoginRespons.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? vouchernumber;
  String? createdAt;
  String? location;
  String? urlImage;
  String? company_name;
  String? is_show_whistleblower;
  String? is_show_calendar;

  Responsedata(
      {this.id,
      this.vouchernumber,
      this.createdAt,
      this.location,
      this.urlImage,
      this.company_name,
      this.is_show_calendar,
      this.is_show_whistleblower});

  Responsedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vouchernumber = json['vouchernumber'];
    createdAt = json['created_at'];
    location = json['location'];
    urlImage = json['url_image'];
    company_name = json['company_name'];
    is_show_calendar = json['is_show_calendar'];
    is_show_whistleblower = json['is_show_whistleblower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vouchernumber'] = vouchernumber;
    data['created_at'] = createdAt;
    data['location'] = location;
    data['url_image'] = urlImage;
    data['company_name'] = company_name;
    data['is_show_whistleblower'] = is_show_whistleblower;
    data['is_show_calendar'] = is_show_calendar;
    return data;
  }
}
