class CalendarModel {
  EventCalendar? eventCalendar;

  CalendarModel({this.eventCalendar});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    eventCalendar = json['event_calendar'] != null
        ? EventCalendar.fromJson(json['event_calendar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventCalendar != null) {
      data['event_calendar'] = eventCalendar!.toJson();
    }
    return data;
  }
}

class EventCalendar {
  String? status;
  String? message;
  List<Responsedata>? responsedata;

  EventCalendar({this.status, this.message, this.responsedata});

  EventCalendar.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['responsedata'] != null) {
      responsedata = <Responsedata>[];
      json['responsedata'].forEach((v) {
        responsedata!.add(Responsedata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (responsedata != null) {
      data['responsedata'] = responsedata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responsedata {
  String? name;
  List<Attendees>? attendees;
  String? ort;
  String? dateTime;
  String? startTime;
  String? endTime;
  List<Call>? call;

  Responsedata(
      {this.name,
      this.attendees,
      this.ort,
      this.dateTime,
      this.startTime,
      this.endTime,
      this.call});

  Responsedata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendees.fromJson(v));
      });
    }
    ort = json['ort'];
    dateTime = json['date_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    if (json['call'] != null) {
      call = <Call>[];
      json['call'].forEach((v) {
        call!.add(Call.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (attendees != null) {
      data['attendees'] = attendees!.map((v) => v.toJson()).toList();
    }
    data['ort'] = ort;
    data['date_time'] = dateTime;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (call != null) {
      data['call'] = call!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendees {
  String? name;

  Attendees({this.name});

  Attendees.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Call {
  String? name;

  Call({this.name});

  Call.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
