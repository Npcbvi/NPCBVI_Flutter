class ManageDoctor {
  String message;
  bool status;
  List<DataManageDoctor> data;
  Null list;

  ManageDoctor({this.message, this.status, this.data, this.list});

  ManageDoctor.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataManageDoctor>[];
      json['data'].forEach((v) {
        data.add(new DataManageDoctor.fromJson(v));
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

class DataManageDoctor {
  String mcIID;
  String hRegID;
  String dName;
  String mobile;
  String emailId;
  String status;
  int statusid;

  DataManageDoctor(
      {this.mcIID,
        this.hRegID,
        this.dName,
        this.mobile,
        this.emailId,
        this.status,
        this.statusid});

  DataManageDoctor.fromJson(Map<String, dynamic> json) {
    mcIID = json['mcI_ID'];
    hRegID = json['h_Reg_ID'];
    dName = json['d_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    status = json['status'];
    statusid = json['statusid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcI_ID'] = this.mcIID;
    data['h_Reg_ID'] = this.hRegID;
    data['d_name'] = this.dName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['status'] = this.status;
    data['statusid'] = this.statusid;
    return data;
  }
}