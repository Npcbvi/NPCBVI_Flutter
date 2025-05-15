class GetDPM_Edit_UpdateUserDetail {
  String message;
  bool status;
  List<DataGetDPM_Edit_UpdateUserDetail> data;
  Null list;

  GetDPM_Edit_UpdateUserDetail({this.message, this.status, this.data, this.list});

  GetDPM_Edit_UpdateUserDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_Edit_UpdateUserDetail>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_Edit_UpdateUserDetail.fromJson(v));
      });
    }
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['list'] = this.list;
    return data;
  }
}

class DataGetDPM_Edit_UpdateUserDetail {
  int srNo;
  int dpsSpoOldUid;
  Null oldUserId;
  String userId;
  String roleId;
  String name;
  String passwordX;
  String confPasswordX;
  int stateCode;
  int districtCode;
  int mobile;
  Null otpNo;
  String emailId;
  Null entryBy;
  String entryDate;
  String ipAddress;
  int status;
  Null updatedBy;
  Null activationCode;
  String npcbNo;
  int statusId;
  String loignStatus;

  DataGetDPM_Edit_UpdateUserDetail(
      {this.srNo,
        this.dpsSpoOldUid,
        this.oldUserId,
        this.userId,
        this.roleId,
        this.name,
        this.passwordX,
        this.confPasswordX,
        this.stateCode,
        this.districtCode,
        this.mobile,
        this.otpNo,
        this.emailId,
        this.entryBy,
        this.entryDate,
        this.ipAddress,
        this.status,
        this.updatedBy,
        this.activationCode,
        this.npcbNo,
        this.statusId,
        this.loignStatus});

  DataGetDPM_Edit_UpdateUserDetail.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
    dpsSpoOldUid = json['dps_spo_old_uid'];
    oldUserId = json['old_user_id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    name = json['name'];
    passwordX = json['password_x'];
    confPasswordX = json['conf_password_x'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    mobile = json['mobile'];
    otpNo = json['otp_no'];
    emailId = json['email_id'];
    entryBy = json['entry_by'];
    entryDate = json['entry_date'];
    ipAddress = json['ip_address'];
    status = json['status'];
    updatedBy = json['updated_by'];
    activationCode = json['activation_code'];
    npcbNo = json['npcbNo'];
    statusId = json['status_id'];
    loignStatus = json['loignStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    data['dps_spo_old_uid'] = this.dpsSpoOldUid;
    data['old_user_id'] = this.oldUserId;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['password_x'] = this.passwordX;
    data['conf_password_x'] = this.confPasswordX;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['mobile'] = this.mobile;
    data['otp_no'] = this.otpNo;
    data['email_id'] = this.emailId;
    data['entry_by'] = this.entryBy;
    data['entry_date'] = this.entryDate;
    data['ip_address'] = this.ipAddress;
    data['status'] = this.status;
    data['updated_by'] = this.updatedBy;
    data['activation_code'] = this.activationCode;
    data['npcbNo'] = this.npcbNo;
    data['status_id'] = this.statusId;
    data['loignStatus'] = this.loignStatus;
    return data;
  }
}