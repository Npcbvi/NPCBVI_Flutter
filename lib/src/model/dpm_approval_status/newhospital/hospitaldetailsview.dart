class hospitaldetailsview {
  String message;
  bool status;
  List<NewDatahospitaldetailsview> data;
  Null list;

  hospitaldetailsview({this.message, this.status, this.data, this.list});

  hospitaldetailsview.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <NewDatahospitaldetailsview>[];
      json['data'].forEach((v) {
        data.add(new NewDatahospitaldetailsview.fromJson(v));
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

class NewDatahospitaldetailsview {
  int sNo;
  int fax;
  String nDarpanNo;
  String hRegID;
  String hName;
  int mobile;
  String address;
  String emailId;
  int pincode;
  String nodalOfficerName;
  String npcbNo;
  String stateName;
  String districtName;

  NewDatahospitaldetailsview(
      {this.sNo,
        this.fax,
        this.nDarpanNo,
        this.hRegID,
        this.hName,
        this.mobile,
        this.address,
        this.emailId,
        this.pincode,
        this.nodalOfficerName,
        this.npcbNo,
        this.stateName,
        this.districtName});

  NewDatahospitaldetailsview.fromJson(Map<String, dynamic> json) {
    sNo = json['sNo'];
    fax = json['fax'];
    nDarpanNo = json['n_Darpan_No'];
    hRegID = json['h_Reg_ID'];
    hName = json['h_Name'];
    mobile = json['mobile'];
    address = json['address'];
    emailId = json['email_id'];
    pincode = json['pincode'];
    nodalOfficerName = json['nodal_officer_name'];
    npcbNo = json['npcbNo'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sNo'] = this.sNo;
    data['fax'] = this.fax;
    data['n_Darpan_No'] = this.nDarpanNo;
    data['h_Reg_ID'] = this.hRegID;
    data['h_Name'] = this.hName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['email_id'] = this.emailId;
    data['pincode'] = this.pincode;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['npcbNo'] = this.npcbNo;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}