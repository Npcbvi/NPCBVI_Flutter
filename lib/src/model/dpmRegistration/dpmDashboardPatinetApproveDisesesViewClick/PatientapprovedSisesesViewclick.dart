class PatientapprovedSisesesViewclick {
  String message;
  bool status;
  List<DataPatientapprovedSisesesViewclick> data;
  Null list;

  PatientapprovedSisesesViewclick({this.message, this.status, this.data, this.list});

  PatientapprovedSisesesViewclick.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataPatientapprovedSisesesViewclick>[];
      json['data'].forEach((v) {
        data.add(new DataPatientapprovedSisesesViewclick.fromJson(v));
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

class DataPatientapprovedSisesesViewclick {
  String ngoname;
  String npcbNo;
  int roleId;
  int stateCode;
  int districtCode;
  int total;
  int approved;
  int pending;

  DataPatientapprovedSisesesViewclick(
      {this.ngoname,
        this.npcbNo,
        this.roleId,
        this.stateCode,
        this.districtCode,
        this.total,
        this.approved,
        this.pending});

  DataPatientapprovedSisesesViewclick.fromJson(Map<String, dynamic> json) {
    ngoname = json['ngoname'];
    npcbNo = json['npcbNo'];
    roleId = json['role_id'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    total = json['total'];
    approved = json['approved'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ngoname'] = this.ngoname;
    data['npcbNo'] = this.npcbNo;
    data['role_id'] = this.roleId;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['total'] = this.total;
    data['approved'] = this.approved;
    data['pending'] = this.pending;
    return data;
  }
}