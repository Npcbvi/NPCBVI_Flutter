class GovtPrivateDetails {
  String message;
  bool status;
  List<DataGovtPrivateDetails> data;
  Null list;

  GovtPrivateDetails({this.message, this.status, this.data, this.list});

  GovtPrivateDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGovtPrivateDetails>[];
      json['data'].forEach((v) {
        data.add(new DataGovtPrivateDetails.fromJson(v));
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

class DataGovtPrivateDetails {
  String npcbNo;
  String oName;
  String address;
  int fax;
  String emailId;
  int pincode;
  String nodalOfficerName;
  int roleId;
  int niNNo;
  String entryDate;
  int status;
  String stateName;
  String districtName;

  DataGovtPrivateDetails(
      {this.npcbNo,
        this.oName,
        this.address,
        this.fax,
        this.emailId,
        this.pincode,
        this.nodalOfficerName,
        this.roleId,
        this.niNNo,
        this.entryDate,
        this.status,
        this.stateName,
        this.districtName});

  DataGovtPrivateDetails.fromJson(Map<String, dynamic> json) {
    npcbNo = json['npcb_no'];
    oName = json['o_Name'];
    address = json['address'];
    fax = json['fax'];
    emailId = json['email_id'];
    pincode = json['pincode'];
    nodalOfficerName = json['nodal_officer_name'];
    roleId = json['role_id'];
    niNNo = json['niN_no'];
    entryDate = json['entry_date'];
    status = json['status'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npcb_no'] = this.npcbNo;
    data['o_Name'] = this.oName;
    data['address'] = this.address;
    data['fax'] = this.fax;
    data['email_id'] = this.emailId;
    data['pincode'] = this.pincode;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['role_id'] = this.roleId;
    data['niN_no'] = this.niNNo;
    data['entry_date'] = this.entryDate;
    data['status'] = this.status;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}