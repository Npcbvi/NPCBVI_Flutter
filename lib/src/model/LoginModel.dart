
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

  Result({this.message, this.status, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
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