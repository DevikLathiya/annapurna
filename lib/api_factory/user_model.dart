class UserModel {
  UserModel({
      this.status, 
      this.message, 
      this.userName, 
      this.userid, 
      this.userRole, 
      this.userImage, 
      this.userMail, 
      this.userPhone, 
      this.branchList,});

  UserModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    userName = json['UserName'];
    userid = json['USERID'];
    userRole = json['UserRole'];
    userImage = json['UserImage'];
    userMail = json['UserMail'];
    userPhone = json['UserPhone'];
    if (json['BranchList'] != null) {
      branchList = [];
      json['BranchList'].forEach((v) {
        branchList?.add(BranchList.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'UserModel{status: $status, message: $message, userName: $userName, userid: $userid, userRole: $userRole, userImage: $userImage, userMail: $userMail, userPhone: $userPhone, branchList: $branchList}';
  }

  String? status;
  String? message;
  String? userName;
  String? userid;
  String? userRole;
  String? userImage;
  String? userMail;
  String? userPhone;
  List<BranchList>? branchList;
UserModel copyWith({  String? status,
  String? message,
  String? userName,
  String? userid,
  String? userRole,
  String? userImage,
  String? userMail,
  String? userPhone,
  List<BranchList>? branchList,
}) => UserModel(  status: status ?? this.status,
  message: message ?? this.message,
  userName: userName ?? this.userName,
  userid: userid ?? this.userid,
  userRole: userRole ?? this.userRole,
  userImage: userImage ?? this.userImage,
  userMail: userMail ?? this.userMail,
  userPhone: userPhone ?? this.userPhone,
  branchList: branchList ?? this.branchList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['UserName'] = userName;
    map['USERID'] = userid;
    map['UserRole'] = userRole;
    map['UserImage'] = userImage;
    map['UserMail'] = userMail;
    map['UserPhone'] = userPhone;
    if (branchList != null) {
      map['BranchList'] = branchList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BranchList {
  BranchList({
      this.branchID, 
      this.branchName,});

  @override
  String toString() {
    return 'BranchList{branchID: $branchID, branchName: $branchName}';
  }

  BranchList.fromJson(dynamic json) {
    branchID = json['BranchID'];
    branchName = json['BranchName'];
  }
  String? branchID;
  String? branchName;
BranchList copyWith({  String? branchID,
  String? branchName,
}) => BranchList(  branchID: branchID ?? this.branchID,
  branchName: branchName ?? this.branchName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchID'] = branchID;
    map['BranchName'] = branchName;
    return map;
  }

}