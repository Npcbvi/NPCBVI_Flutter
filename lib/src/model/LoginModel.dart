
import 'dart:convert';
class LoginModel {
  String token;
  Result result;

  LoginModel({this.token, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String message;
  bool status;
  LoginData data;
  List<DataList> list;
  Result({this.message, this.status, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    if (json['list'] != null) {
      list = <DataList>[];
      json['list'].forEach((v) {
        list.add(new DataList.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoginData {
  String newPwd;
  int status;
  String userId;
  String roleId;
  String name;
  String emailId;
  String districtName;
  String stateName;
  int district_code;
  int state_code;

  LoginData(
      {this.newPwd,
        this.status,
        this.userId,
        this.roleId,
        this.name,
        this.emailId,
        this.districtName,
        this.stateName,
        this.district_code,
        this.state_code
      });

  LoginData.fromJson(Map<String, dynamic> json) {
    newPwd = json['new_pwd'];
    status = json['status'];
    userId = json['user_id'];
    roleId = json['role_id'];
    name = json['name'];
    emailId = json['email_id'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    district_code = json['district_code'];
    state_code = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_pwd'] = this.newPwd;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['district_code'] = this.district_code;
    data['state_code'] = this.state_code;
    return data;
  }
}
class DataList {
  String entryBy;
  String darpanNo;
  String ngoName;
  String orgaddress;
  int status;
  String memberName;
  String name;

  DataList(
      {this.entryBy,
        this.darpanNo,
        this.ngoName,
        this.orgaddress,
        this.status,
        this.memberName,
        this.name});

  DataList.fromJson(Map<String, dynamic> json) {
    entryBy = json['entryBy'];
    darpanNo = json['darpan_no'];
    ngoName = json['ngoName'];
    orgaddress = json['orgaddress'];
    status = json['status'];
    memberName = json['member_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entryBy'] = this.entryBy;
    data['darpan_no'] = this.darpanNo;
    data['ngoName'] = this.ngoName;
    data['orgaddress'] = this.orgaddress;
    data['status'] = this.status;
    data['member_name'] = this.memberName;
    data['name'] = this.name;
    return data;
  }
}