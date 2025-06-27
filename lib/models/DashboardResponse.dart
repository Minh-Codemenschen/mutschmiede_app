// ignore_for_file: file_names, empty_catches

import 'UserResponse.dart';

class DasboardResponse {
  News? news;
  List<FetchUserList>? coachesOnline;
  List<Category>? category;

  DasboardResponse({this.news, this.coachesOnline, this.category});

  DasboardResponse.fromJson(Map<String, dynamic> json) {
    news = json['news'] != null ? News.fromJson(json['news']) : null;
    if (json['coaches_online'] != null) {
      coachesOnline = <FetchUserList>[];
      json['coaches_online'].forEach((v) {
        coachesOnline!.add(FetchUserList.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.toJson();
    }
    if (coachesOnline != null) {
      data['coaches_online'] = coachesOnline!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  Termineinladung? termineinladung;
  List<F2fCoaches>? f2fCoaches;
  List<Menu1>? menu1;

  News({this.termineinladung, this.f2fCoaches, this.menu1});

  News.fromJson(Map<String, dynamic> json) {
    termineinladung = json['termineinladung'] != null
        ? Termineinladung.fromJson(json['termineinladung'])
        : null;
    if (json['f2f_coaches'] != null && json['responsedata'] != "Error data") {
      f2fCoaches = <F2fCoaches>[];
      try {
        json['f2f_coaches']?.forEach((v) {
          f2fCoaches!.add(F2fCoaches.fromJson(v));
        });
      } catch (e) {}
    }
    if (json['menu'] != null && json['responsedata'] != "Error data") {
      menu1 = <Menu1>[];
      try {
        json['menu']?.forEach((v) {
          menu1!.add(Menu1.fromJson(v));
        });
      } catch (e) {}
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (termineinladung != null) {
      data['termineinladung'] = termineinladung!.toJson();
    }
    if (f2fCoaches != null) {
      data['f2f_coaches'] = f2fCoaches!.map((v) => v.toJson()).toList();
    }
    if (menu1 != null) {
      data['menu'] = menu1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Termineinladung {
  String? status;
  String? message;
  List<ResponseData>? responsedata;

  Termineinladung({this.status, this.message, this.responsedata});

  Termineinladung.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['responsedata'] != null && json['responsedata'] != "Error data") {
      responsedata = <ResponseData>[];
      try {
        json['responsedata']?.forEach((v) {
          responsedata!.add(ResponseData.fromJson(v));
        });
      } catch (e) {}
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

class ResponseData {
  String? postId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? location;
  List<Participant>? participant;
  String? accept;

  ResponseData(
      {this.postId,
      this.title,
      this.date,
      this.startTime,
      this.endTime,
      this.location,
      this.participant,
      this.accept});

  ResponseData.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    title = json['title'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    location = json['location'];
    if (json['participant'] != null) {
      participant = <Participant>[];
      json['participant'].forEach((v) {
        participant!.add(Participant.fromJson(v));
      });
    }
    accept = json['accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['title'] = title;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['location'] = location;
    if (participant != null) {
      data['participant'] = participant!.map((v) => v.toJson()).toList();
    }
    data['accept'] = accept;
    return data;
  }
}

class Participant {
  String? name;

  Participant({this.name});

  Participant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class F2fCoaches {
  String? postId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? location;
  String? personal;
  String? accept;

  F2fCoaches(
      {this.postId,
      this.title,
      this.date,
      this.startTime,
      this.endTime,
      this.location,
      this.personal,
      this.accept});

  F2fCoaches.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    title = json['title'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    location = json['location'];
    personal = json['personal'];
    accept = json['accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['title'] = title;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['location'] = location;
    data['personal'] = personal;
    data['accept'] = accept;
    return data;
  }
}

class Menu1 {
  int? postId;
  String? dateTime;
  List<MenuItems>? menuItems;

  Menu1({this.postId, this.dateTime, this.menuItems});

  Menu1.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    dateTime = json['date_time'];
    if (json['menu_items'] != null) {
      menuItems = <MenuItems>[];
      json['menu_items'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['date_time'] = dateTime;
    if (menuItems != null) {
      data['menu_items'] = menuItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuItems {
  String? menuFieldName1;
  String? menuFieldValue1;

  MenuItems({this.menuFieldName1, this.menuFieldValue1});

  MenuItems.fromJson(Map<String, dynamic> json) {
    menuFieldName1 = json['menu_field_name'];
    menuFieldValue1 = json['menu_field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_field_name'] = menuFieldName1;
    data['menu_field_value'] = menuFieldValue1;
    return data;
  }
}

class Category {
  int? termId;
  String? termName;
  String? termIcon;
  String? termTitle;
  String? termDescription;

  Category(
      {this.termId,
      this.termName,
      this.termIcon,
      this.termTitle,
      this.termDescription});

  Category.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    termName = json['term_name'];
    termIcon = json['term_icon'];
    termTitle = json['term_title'];
    termDescription = json['term_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['term_name'] = this.termName;
    data['term_icon'] = this.termIcon;
    data['term_title'] = this.termTitle;
    data['term_description'] = this.termDescription;
    return data;
  }
}
