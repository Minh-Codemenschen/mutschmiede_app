class CheckCompanyStatusModel {
  String? status;
  String? message;
  CheckResponseData? responseData;

  CheckCompanyStatusModel({this.status, this.message, this.responseData});

  CheckCompanyStatusModel.fromJson(Map<String, dynamic> json) {
    print("CheckCompanyStatusModel >>>>>>> ");
    status = json['status'];
    message = json['message'];
    responseData = json['responsedata'] != null
        ? new CheckResponseData.fromJson(json['responsedata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.responseData != null) {
      data['responsedata'] = this.responseData!.toJson();
    }
    return data;
  }
}

class CheckResponseData {
  bool? isShowWhistleblower;
  bool? isShowCalendar;
  bool? isexpertshow;

  CheckResponseData(
      {this.isShowWhistleblower, this.isShowCalendar, this.isexpertshow});

  CheckResponseData.fromJson(Map<String, dynamic> json) {
    isShowWhistleblower = json['is_show_whistleblower'];
    isShowCalendar = json['is_show_calendar'];
    isexpertshow = json['isexpertshow'];
  }

  Map<String, dynamic> toJson() {
    print("ResponsData >>>>>>>>>");
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['is_show_whistleblower'] = this.isShowWhistleblower;
    data['is_show_calendar'] = this.isShowCalendar;
    data['isexpertshow'] = this.isexpertshow;
    return data;
  }
}
