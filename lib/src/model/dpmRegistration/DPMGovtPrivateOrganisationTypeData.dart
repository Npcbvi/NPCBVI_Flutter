class DPMGovtPrivateOrganisationTypeData {
  String message;
  bool status;
  List<DataDPMGovtPrivateOrganisationTypeData> data;
  Null list;

  DPMGovtPrivateOrganisationTypeData({this.message, this.status, this.data, this.list});

  DPMGovtPrivateOrganisationTypeData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDPMGovtPrivateOrganisationTypeData>[];
      json['data'].forEach((v) {
        data.add(new DataDPMGovtPrivateOrganisationTypeData.fromJson(v));
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

class DataDPMGovtPrivateOrganisationTypeData {
  String npcbNo;
  String emailId;
  int mobile;
  String oName;
  String nodalOfficerName;
  String stateName;
  String districtName;

  DataDPMGovtPrivateOrganisationTypeData(
      {this.npcbNo,
        this.emailId,
        this.mobile,
        this.oName,
        this.nodalOfficerName,
        this.stateName,
        this.districtName});

  DataDPMGovtPrivateOrganisationTypeData.fromJson(Map<String, dynamic> json) {
    npcbNo = json['npcb_no'];
    emailId = json['email_id'];
    mobile = json['mobile'];
    oName = json['o_Name'];
    nodalOfficerName = json['nodal_officer_name'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npcb_no'] = this.npcbNo;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    data['o_Name'] = this.oName;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}