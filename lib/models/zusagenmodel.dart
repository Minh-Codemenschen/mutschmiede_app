class AcceptRejectResponse {
  Req? req;

  AcceptRejectResponse({this.req});

  AcceptRejectResponse.fromJson(Map<String, dynamic> json) {
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
  int? status;

  Req({this.data, this.status});

  Req.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  String? postId;
  String? accept;
  String? cancel;

  Data({this.postId, this.accept, this.cancel});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    accept = json['accept'];
    cancel = json['cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['accept'] = accept;
    data['cancel'] = cancel;
    return data;
  }
}
