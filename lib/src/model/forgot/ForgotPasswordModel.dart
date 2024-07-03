class ForgotPasswordModel {
  String message;
  bool status;
  DataForgotPasswordModel data;
  Null list;

  ForgotPasswordModel({this.message, this.status, this.data, this.list});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new DataForgotPasswordModel.fromJson(json['data']) : null;
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['list'] = this.list;
    return data;
  }
}

class DataForgotPasswordModel {
  String otp;
  GetUserDetails getUserDetails;

  DataForgotPasswordModel({this.otp, this.getUserDetails});

  DataForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    getUserDetails = json['getUserDetails'] != null
        ? new GetUserDetails.fromJson(json['getUserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    if (this.getUserDetails != null) {
      data['getUserDetails'] = this.getUserDetails.toJson();
    }
    return data;
  }
}

class GetUserDetails {
  String userId;
  String emailId;
  String mobile;
  String srNo;
  String name;
  String roleId;
  int status;

  GetUserDetails(
      {this.userId,
        this.emailId,
        this.mobile,
        this.srNo,
        this.name,
        this.roleId,
        this.status});

  GetUserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    emailId = json['email_id'];
    mobile = json['mobile'];
    srNo = json['sr_no'];
    name = json['name'];
    roleId = json['role_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    data['sr_no'] = this.srNo;
    data['name'] = this.name;
    data['role_id'] = this.roleId;
    data['status'] = this.status;
    return data;
  }
}


