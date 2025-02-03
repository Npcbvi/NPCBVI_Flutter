class GovtPrivateHospital {
  String message;
  bool status;
  List<GovtPrivateHospitalData> data;
  Null list;

  GovtPrivateHospital({this.message, this.status, this.data, this.list});

  GovtPrivateHospital.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GovtPrivateHospitalData>[];
      json['data'].forEach((v) {
        data.add(new GovtPrivateHospitalData.fromJson(v));
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

class GovtPrivateHospitalData {
  String npcbNo;
  String stateName;
  String districtName;
  String oName;
  String emailId;
  String nodalOfficerName;

  GovtPrivateHospitalData(
      {this.npcbNo,
        this.stateName,
        this.districtName,
        this.oName,
        this.emailId,
        this.nodalOfficerName});

  GovtPrivateHospitalData.fromJson(Map<String, dynamic> json) {
    npcbNo = json['npcb_no'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
    oName = json['o_Name'];
    emailId = json['email_id'];
    nodalOfficerName = json['nodal_officer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npcb_no'] = this.npcbNo;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    data['o_Name'] = this.oName;
    data['email_id'] = this.emailId;
    data['nodal_officer_name'] = this.nodalOfficerName;
    return data;
  }
}