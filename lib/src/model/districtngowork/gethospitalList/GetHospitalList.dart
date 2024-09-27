class GetHospitalList {
  String message;
  bool status;
  List<DataGetHospitalList> data;
  Null list;

  GetHospitalList({this.message, this.status, this.data, this.list});

  GetHospitalList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetHospitalList>[];
      json['data'].forEach((v) {
        data.add(new DataGetHospitalList.fromJson(v));
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

class DataGetHospitalList {
  String hRegID;
  String hName;
  String mobile;
  String emailId;
  int eqCount;
  int drcount;
  int moucount;
  int modPercount;
  String status;
  int statusid;

  DataGetHospitalList(
      {this.hRegID,
        this.hName,
        this.mobile,
        this.emailId,
        this.eqCount,
        this.drcount,
        this.moucount,
        this.modPercount,
        this.status,
        this.statusid});

  DataGetHospitalList.fromJson(Map<String, dynamic> json) {
    hRegID = json['h_Reg_ID'];
    hName = json['h_Name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    eqCount = json['eqCount'];
    drcount = json['drcount'];
    moucount = json['moucount'];
    modPercount = json['modPercount'];
    status = json['status'];
    statusid = json['statusid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_Reg_ID'] = this.hRegID;
    data['h_Name'] = this.hName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['eqCount'] = this.eqCount;
    data['drcount'] = this.drcount;
    data['moucount'] = this.moucount;
    data['modPercount'] = this.modPercount;
    data['status'] = this.status;
    data['statusid'] = this.statusid;
    return data;
  }
}