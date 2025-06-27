class AktuellesModel {
  String? status;
  String? message;
  List<Responsedata>? responsedata;

  AktuellesModel({this.status, this.message, this.responsedata});

  AktuellesModel.fromJson(Map<String, dynamic> json) {
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
  Events? events;
  Menu? menu;
  CompanyBuilding? companyBuilding;
  Contact? contact;
  Kooperatiospartner? kooperatiospartner;
  Whistleblower? whistleblower;
  // Qr? qr;

  Responsedata(
      {this.events,
      this.menu,
      this.companyBuilding, // this.kooperatiospartner
      this.contact,
      this.kooperatiospartner,
      this.whistleblower});

  Responsedata.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null && json['events'] is Map<String, dynamic>) {
      events = Events.fromJson(json['events']);
    }
    if (json['menu'] != null && json['menu'] is Map<String, dynamic>) {
      final menuData = json['menu'] as Map<String, dynamic>;
      menu = Menu.fromJson(menuData);
    }

    if (json['company_building'] != null && json['company_building'] is Map<String, dynamic>) {
      companyBuilding = CompanyBuilding.fromJson(json['company_building']);
    }

    if (json['contact'] != null && json['contact'] is Map<String, dynamic>) {
      contact = Contact.fromJson(json['contact']);
    }

    if (json['kooperatiospartner'] != null) {
      kooperatiospartner =
          Kooperatiospartner.fromJson(json['kooperatiospartner']);
    }
    if (json['whistleblower'] != null) {
      whistleblower = Whistleblower.fromJson(json['whistleblower']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = menu!.toJson();
    }

    if (menu != null) {
      data['menu'] = menu!.toJson();
    }

    if (companyBuilding != null) {
      data['company_building'] = companyBuilding!.toJson();
    }

    if (contact != null) {
      data['contact'] = contact!.toJson();
    }

    if (kooperatiospartner != null) {
      data['kooperatiospartner'] = kooperatiospartner!.toJson();
    }
    if (whistleblower != null) {
      data['whistleblower'] = whistleblower!.toJson();
    }
    return data;
  }
}

class Events {
  bool? isShow;
  List<DataEvents>? list;

  Events({this.isShow, this.list});

  Events.fromJson(Map<String, dynamic> json) {
    isShow = json['is_show'];
    if (json['data'] != null) {
      list = <DataEvents>[];
      json['data'].forEach((v) {
        list!.add(DataEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_show'] = isShow;
    if (list != null) {
      data['data'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataEvents {
  String? title;
  String? description;
  String? icon;
  String? date;
  String? images;

  DataEvents({this.title, this.description, this.icon, this.date});

  DataEvents.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    date = json['date'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['date'] = date;
    data['images'] = images;
    return data;
  }
}

class Menu{
  List<MenuItem>? menu;
  bool? isShow;

  Menu({
    this.menu,
    this.isShow,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menu: List<MenuItem>.from(json["data"].map((x) => MenuItem.fromJson(x))),
    isShow: json["is_show"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(menu!.map((x) => x.toJson())),
    "is_show": isShow,
  };
}

class MenuItem {
  String? menuFieldName;
  String? menuFieldValue;
  String? dateTime;
  String? icon;

  MenuItem({
    this.menuFieldName,
    this.menuFieldValue,
    this.dateTime,
    this.icon,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    menuFieldName: json["menu_field_name"],
    menuFieldValue: json["menu_field_value"],
    dateTime: json["date_time"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "menu_field_name": menuFieldName,
    "menu_field_value": menuFieldValue,
    "date_time": dateTime,
    "icon": icon,
  };
}

class MenuItems {
  String? menuFieldName;
  String? menuFieldValue;

  MenuItems({this.menuFieldName, this.menuFieldValue});

  MenuItems.fromJson(Map<String, dynamic> json) {
    menuFieldName = json['menu_field_name'];
    menuFieldValue = json['menu_field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_field_name'] = menuFieldName;
    data['menu_field_value'] = menuFieldValue;
    return data;
  }
}

class CompanyBuilding {
  String? images;
  bool? isShow;
  List<Location>? location;

  CompanyBuilding({this.images, this.location});

  CompanyBuilding.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    isShow = json['is_show'];
    if (json['data'] != null) {
      location = <Location>[];
      json['data'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['is_show'] = isShow;
    if (location != null) {
      data['data'] = location!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? order;
  String? name;

  Location({this.order, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    order = '${json['order']}';
    name = '${json['name']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['name'] = name;
    return data;
  }
}


class Contact {
  bool? isShow;
  List<ContactItem>? list;

  Contact({this.isShow});

  Contact.fromJson(Map<String, dynamic> json) {
    isShow = json['is_show'];
    if (json['data'] != null) {
      list = <ContactItem>[];
      json['data'].forEach((v) {
        list!.add(ContactItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['is_show'] = isShow;
    if (list != null) {
      data['data'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactItem {
  String? contactTitle;
  String? contactText;
  String? contactType;
  String? contactIcon;

  ContactItem({this.contactTitle, this.contactText, this.contactType, this.contactIcon});

  ContactItem.fromJson(Map<String, dynamic> json) {
    contactTitle = json['contact_title'];
    contactText = json['contact_text'];
    contactType = json['contact_type'];
    contactIcon = json['contact_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (contactTitle != null) data['contact_title'] = contactTitle;
    if (contactText != null) data['contact_text'] = contactText;
    if (contactType != null) data['contact_type'] = contactType;
    if (contactIcon != null) data['contact_icon'] = contactIcon;
    return data;
  }
}

class Kooperatiospartner {
  bool? isShow;
  KooperatiospartnerItem? info;
  List<ListPartner>? list;

  Kooperatiospartner({this.info, this.isShow, this.list});

  Kooperatiospartner.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new KooperatiospartnerItem.fromJson(json['info']) : null;
    isShow = json['is_show'];
    if (json['data'] != null) {
      list = <ListPartner>[];
      json['data'].forEach((v) {
        list!.add(new ListPartner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['is_show'] = this.isShow;
    if (this.list != null) {
      data['data'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KooperatiospartnerItem {
  String? title;
  String? description;
  String? icon;
  String? images;
  String? date;

  KooperatiospartnerItem({this.title, this.description, this.icon, this.images,  this.date});

  KooperatiospartnerItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    images = json['images'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['images'] = this.images;
    data['date'] = this.date;
    return data;
  }
}

class ListPartner {
  String? title;
  String? partnerLink;
  String? description;
  String? images;

  ListPartner({this.title, this.partnerLink, this.description, this.images});

  ListPartner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    partnerLink = json['partner_link'];
    description = json['description'];
    images = json['images'];
    partnerLink = json['partner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['partner_link'] = this.partnerLink;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}

class Whistleblower {
  bool? isShow;
  WhistleblowerItem? info;
  // List<ListPartner>? list;


  Whistleblower({this.isShow, this.info});

  Whistleblower.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new WhistleblowerItem.fromJson(json['info']) : null;
    isShow = json['is_show'];
    // if (json['data'] != null) {
    //   list = <ListPartner>[];
    //   json['data'].forEach((v) {
    //     list!.add(new ListPartner.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['is_show'] = this.isShow;
    // if (this.list != null) {
    //   data['data'] = this.list!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class WhistleblowerItem {
  String? title;
  String? description;
  String? type;

  WhistleblowerItem({this.title, this.description, this.type});

  WhistleblowerItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}
