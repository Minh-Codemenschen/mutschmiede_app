class UserListModel {
  List<GroupUser>? groupUser;
  List<AllUser>? allUser;

  UserListModel({this.groupUser, this.allUser});

  UserListModel.fromJson(Map<String, dynamic> json) {
    if (json['group_user'] != null) {
      groupUser = <GroupUser>[];
      json['group_user'].forEach((v) {
        groupUser!.add(GroupUser.fromJson(v));
      });
    }
    if (json['all_user'] != null) {
      allUser = <AllUser>[];
      json['all_user'].forEach((v) {
        allUser!.add(AllUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groupUser != null) {
      data['group_user'] = groupUser!.map((v) => v.toJson()).toList();
    }
    if (allUser != null) {
      data['all_user'] = allUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupUser {
  String? groupId;
  String? groupSubject;
  String? groupIcon;
  String? creationDate;
  List<UserOnGroup>? userOnGroup;

  GroupUser(
      {this.groupId,
      this.groupSubject,
      this.groupIcon,
      this.creationDate,
      this.userOnGroup});

  GroupUser.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupSubject = json['group_subject'];
    groupIcon = json['group_icon'];
    creationDate = json['creation_date'];
    if (json['user_on_group'] != null) {
      userOnGroup = <UserOnGroup>[];
      json['user_on_group'].forEach((v) {
        userOnGroup!.add(UserOnGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['group_subject'] = groupSubject;
    data['group_icon'] = groupIcon;
    data['creation_date'] = creationDate;
    if (userOnGroup != null) {
      data['user_on_group'] = userOnGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserOnGroup {
  String? userId;
  String? displayName;
  String? avatar;
  String? position;
  String? positionInCompany;

  UserOnGroup(
      {this.userId,
      this.displayName,
      this.avatar,
      this.position,
      this.positionInCompany});

  UserOnGroup.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    displayName = json['display_name'];
    avatar = json['avatar'];
    position = json['position'];
    positionInCompany = json['position_in_company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['display_name'] = displayName;
    data['avatar'] = avatar;
    data['position'] = position;
    data['position_in_company'] = positionInCompany;
    return data;
  }
}

class AllUser {
  int? iD;
  String? displayName;
  String? avatar;
  String? position;
  String? positionInCompany;

  AllUser(
      {this.iD,
      this.displayName,
      this.avatar,
      this.position,
      this.positionInCompany});

  AllUser.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    displayName = json['display_name'];
    avatar = json['avatar'];
    position = json['position'];
    positionInCompany = json['position_in_company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['display_name'] = displayName;
    data['avatar'] = avatar;
    data['position'] = position;
    data['position_in_company'] = positionInCompany;
    return data;
  }
}
