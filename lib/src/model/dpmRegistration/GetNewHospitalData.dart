class GetNewHospitalData {
  String message;
  bool status;
  List<DataGetNewHospitalData> data;
  Null list;

  GetNewHospitalData({this.message, this.status, this.data, this.list});

  GetNewHospitalData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetNewHospitalData>[];
      json['data'].forEach((v) {
        data.add(new DataGetNewHospitalData.fromJson(v));
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

class DataGetNewHospitalData {
  String hName;
  String hEmail;
  int hRoleId;
  String hRegID;
  String districtName;
  String stateName;
  String name;
  String darpanNo;
  String npcbNo;

  DataGetNewHospitalData(
      {this.hName,
        this.hEmail,
        this.hRoleId,
        this.hRegID,
        this.districtName,
        this.stateName,
        this.name,
        this.darpanNo,
        this.npcbNo});

  DataGetNewHospitalData.fromJson(Map<String, dynamic> json) {
    hName = json['h_Name'];
    hEmail = json['h_email'];
    hRoleId = json['h_role_id'];
    hRegID = json['h_Reg_ID'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    name = json['name'];
    darpanNo = json['darpan_no'];
    npcbNo = json['npcbNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_Name'] = this.hName;
    data['h_email'] = this.hEmail;
    data['h_role_id'] = this.hRoleId;
    data['h_Reg_ID'] = this.hRegID;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['name'] = this.name;
    data['darpan_no'] = this.darpanNo;
    data['npcbNo'] = this.npcbNo;
    return data;
  }
}