// ignore_for_file: unnecessary_getters_setters

class Message {
  List<Termineinladung>? _termineinladung;
  List<F2fCoaches>? _f2fCoaches;
  List<Menu>? _menu;

  Message(
      {List<Termineinladung>? termineinladung,
      List<F2fCoaches>? f2fCoaches,
      List<Menu>? menu}) {
    if (termineinladung != null) {
      _termineinladung = termineinladung;
    }
    if (f2fCoaches != null) {
      _f2fCoaches = f2fCoaches;
    }
    if (menu != null) {
      _menu = menu;
    }
  }

  List<Termineinladung>? get termineinladung => _termineinladung;
  set termineinladung(List<Termineinladung>? termineinladung) =>
      _termineinladung = termineinladung;
  List<F2fCoaches>? get f2fCoaches => _f2fCoaches;
  set f2fCoaches(List<F2fCoaches>? f2fCoaches) => _f2fCoaches = f2fCoaches;
  List<Menu>? get menu => _menu;
  set menu(List<Menu>? menu) => _menu = menu;

  Message.fromJson(Map<String, dynamic> json) {
    if (json['termineinladung'] != null) {
      _termineinladung = <Termineinladung>[];
      json['termineinladung'].forEach((v) {
        _termineinladung!.add(Termineinladung.fromJson(v));
      });
    }
    if (json['f2f_coaches'] != null) {
      _f2fCoaches = <F2fCoaches>[];
      json['f2f_coaches'].forEach((v) {
        _f2fCoaches!.add(F2fCoaches.fromJson(v));
      });
    }
    if (json['menu'] != null) {
      _menu = <Menu>[];
      json['menu'].forEach((v) {
        _menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_termineinladung != null) {
      data['termineinladung'] =
          _termineinladung!.map((v) => v.toJson()).toList();
    }
    if (_f2fCoaches != null) {
      data['f2f_coaches'] = _f2fCoaches!.map((v) => v.toJson()).toList();
    }
    if (_menu != null) {
      data['menu'] = _menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Termineinladung {
  String? _voucherNumber;
  String? _dateTime;
  String? _call;
  String? _name;
  List<String>? _attendees;
  String? _ort;

  Termineinladung(
      {String? voucherNumber,
      String? dateTime,
      String? call,
      String? name,
      List<String>? attendees,
      String? ort}) {
    if (voucherNumber != null) {
      _voucherNumber = voucherNumber;
    }
    if (dateTime != null) {
      _dateTime = dateTime;
    }
    if (call != null) {
      _call = call;
    }
    if (name != null) {
      _name = name;
    }
    if (attendees != null) {
      _attendees = attendees;
    }
    if (ort != null) {
      _ort = ort;
    }
  }

  String? get voucherNumber => _voucherNumber;
  set voucherNumber(String? voucherNumber) => _voucherNumber = voucherNumber;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  String? get call => _call;
  set call(String? call) => _call = call;
  String? get name => _name;
  set name(String? name) => _name = name;
  List<String>? get attendees => _attendees;
  set attendees(List<String>? attendees) => _attendees = attendees;
  String? get ort => _ort;
  set ort(String? ort) => _ort = ort;

  Termineinladung.fromJson(Map<String, dynamic> json) {
    _voucherNumber = json['voucher_number'];
    _dateTime = json['date_time'];
    _call = json['call'];
    _name = json['name'];
    _attendees = json['attendees'].cast<String>();
    _ort = json['ort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucher_number'] = _voucherNumber;
    data['date_time'] = _dateTime;
    data['call'] = _call;
    data['name'] = _name;
    data['attendees'] = _attendees;
    data['ort'] = _ort;
    return data;
  }
}

class F2fCoaches {
  String? _dateTime;
  String? _invitation;
  String? _urlImage;
  String? _ort;
  String? _message;

  F2fCoaches(
      {String? dateTime,
      String? invitation,
      String? urlImage,
      String? ort,
      String? message}) {
    if (dateTime != null) {
      _dateTime = dateTime;
    }
    if (invitation != null) {
      _invitation = invitation;
    }
    if (urlImage != null) {
      _urlImage = urlImage;
    }
    if (ort != null) {
      _ort = ort;
    }
    if (message != null) {
      _message = message;
    }
  }

  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  String? get invitation => _invitation;
  set invitation(String? invitation) => _invitation = invitation;
  String? get urlImage => _urlImage;
  set urlImage(String? urlImage) => _urlImage = urlImage;
  String? get ort => _ort;
  set ort(String? ort) => _ort = ort;
  String? get message => _message;
  set message(String? message) => _message = message;

  F2fCoaches.fromJson(Map<String, dynamic> json) {
    _dateTime = json['date_time'];
    _invitation = json['invitation'];
    _urlImage = json['url_image'];
    _ort = json['ort'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = _dateTime;
    data['invitation'] = _invitation;
    data['url_image'] = _urlImage;
    data['ort'] = _ort;
    data['message'] = _message;
    return data;
  }
}

class Menu {
  String? _dateTime;
  String? _menuFieldName1;
  String? _menuFieldValue1;
  String? _menuFieldName2;
  String? _menuFieldValue2;
  String? _menuFieldName3;
  String? _menuFieldValue3;

  Menu(
      {String? dateTime,
      String? menuFieldName1,
      String? menuFieldValue1,
      String? menuFieldName2,
      String? menuFieldValue2,
      String? menuFieldName3,
      String? menuFieldValue3}) {
    if (dateTime != null) {
      _dateTime = dateTime;
    }
    if (menuFieldName1 != null) {
      _menuFieldName1 = menuFieldName1;
    }
    if (menuFieldValue1 != null) {
      _menuFieldValue1 = menuFieldValue1;
    }
    if (menuFieldName2 != null) {
      _menuFieldName2 = menuFieldName2;
    }
    if (menuFieldValue2 != null) {
      _menuFieldValue2 = menuFieldValue2;
    }
    if (menuFieldName3 != null) {
      _menuFieldName3 = menuFieldName3;
    }
    if (menuFieldValue3 != null) {
      _menuFieldValue3 = menuFieldValue3;
    }
  }

  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  String? get menuFieldName1 => _menuFieldName1;
  set menuFieldName1(String? menuFieldName1) =>
      _menuFieldName1 = menuFieldName1;
  String? get menuFieldValue1 => _menuFieldValue1;
  set menuFieldValue1(String? menuFieldValue1) =>
      _menuFieldValue1 = menuFieldValue1;
  String? get menuFieldName2 => _menuFieldName2;
  set menuFieldName2(String? menuFieldName2) =>
      _menuFieldName2 = menuFieldName2;
  String? get menuFieldValue2 => _menuFieldValue2;
  set menuFieldValue2(String? menuFieldValue2) =>
      _menuFieldValue2 = menuFieldValue2;
  String? get menuFieldName3 => _menuFieldName3;
  set menuFieldName3(String? menuFieldName3) =>
      _menuFieldName3 = menuFieldName3;
  String? get menuFieldValue3 => _menuFieldValue3;
  set menuFieldValue3(String? menuFieldValue3) =>
      _menuFieldValue3 = menuFieldValue3;

  Menu.fromJson(Map<String, dynamic> json) {
    _dateTime = json['date_time'];
    _menuFieldName1 = json['menu_field_name_1'];
    _menuFieldValue1 = json['menu_field_value_1'];
    _menuFieldName2 = json['menu_field_name_2'];
    _menuFieldValue2 = json['menu_field_value_2'];
    _menuFieldName3 = json['menu_field_name_3'];
    _menuFieldValue3 = json['menu_field_value_3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = _dateTime;
    data['menu_field_name_1'] = _menuFieldName1;
    data['menu_field_value_1'] = _menuFieldValue1;
    data['menu_field_name_2'] = _menuFieldName2;
    data['menu_field_value_2'] = _menuFieldValue2;
    data['menu_field_name_3'] = _menuFieldName3;
    data['menu_field_value_3'] = _menuFieldValue3;
    return data;
  }
}
