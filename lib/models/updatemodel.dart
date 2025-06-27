class UpdateModel {
  Req? req;

  UpdateModel({this.req});

  UpdateModel.fromJson(Map<String, dynamic> json) {
    req = json['req'] != null ? Req.fromJson(json['req']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (req != null) {
      data['req'] = req!.toJson();
    }
    return data;
  }
}

class Req {
  Data? data;
  List<dynamic>? headers;
  int? status;

  Req({this.data, this.headers, this.status});

  Req.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['headers'] != null) {
      headers = <dynamic>[];
      json['headers'].forEach((v) {
        headers!.add(v.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (headers != null) {
      data['headers'] = headers!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  String? voucherNumber;
  String? name;
  String? gender;
  String? email;
  String? phone;
  String? department;
  String? kunde;
  String? standort;
  String? subjectAreas;
  AsyncUpload? asyncUpload;

  Data(
      {this.voucherNumber,
      this.name,
      this.gender,
      this.email,
      this.phone,
      this.department,
      this.kunde,
      this.standort,
      this.subjectAreas,
      this.asyncUpload});

  Data.fromJson(Map<String, dynamic> json) {
    voucherNumber = json['voucher_number'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    department = json['department'];
    kunde = json['kunde'];
    standort = json['standort'];
    subjectAreas = json['subject_areas'];
    asyncUpload = json['async_upload'] != null
        ? AsyncUpload.fromJson(json['async_upload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucher_number'] = voucherNumber;
    data['name'] = name;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['department'] = department;
    data['kunde'] = kunde;
    data['standort'] = standort;
    data['subject_areas'] = subjectAreas;
    if (asyncUpload != null) {
      data['async_upload'] = asyncUpload!.toJson();
    }
    return data;
  }
}

class AsyncUpload {
  String? name;
  String? type;
  String? tmpName;
  int? error;
  int? size;

  AsyncUpload({this.name, this.type, this.tmpName, this.error, this.size});

  AsyncUpload.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    tmpName = json['tmp_name'];
    error = json['error'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['tmp_name'] = tmpName;
    data['error'] = error;
    data['size'] = size;
    return data;
  }
}
