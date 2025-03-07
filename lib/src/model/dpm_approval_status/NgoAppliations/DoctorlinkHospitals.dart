class DoctorlinkHospitals {
  String message;
  bool status;
  List<DataDoctorlinkHospitals> data;
  Null list;

  DoctorlinkHospitals({this.message, this.status, this.data, this.list});

  DoctorlinkHospitals.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDoctorlinkHospitals>[];
      json['data'].forEach((v) {
        data.add(new DataDoctorlinkHospitals.fromJson(v));
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

class DataDoctorlinkHospitals {
  int srNo;
  String mcIID;
  String document;
  String nDarpanNo;
  String hRegID;
  String dName;
  int mobile;
  String emailId;
  String stateName;
  String districtName;
  String hName;
  String pincode;
  int gender;
  String dob;

  DataDoctorlinkHospitals(
      {this.srNo,
        this.mcIID,
        this.document,
        this.nDarpanNo,
        this.hRegID,
        this.dName,
        this.mobile,
        this.emailId,
        this.stateName,
        this.districtName,
        this.hName,
        this.pincode,
        this.gender,
        this.dob});

  DataDoctorlinkHospitals.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
    mcIID = json['mcI_ID'];
    document = json['document'];
    nDarpanNo = json['n_Darpan_No'];
    hRegID = json['h_Reg_ID'];
    dName = json['d_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
    hName = json['h_Name'];
    pincode = json['pincode'];
    gender = json['gender'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    data['mcI_ID'] = this.mcIID;
    data['document'] = this.document;
    data['n_Darpan_No'] = this.nDarpanNo;
    data['h_Reg_ID'] = this.hRegID;
    data['d_name'] = this.dName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    data['h_Name'] = this.hName;
    data['pincode'] = this.pincode;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    return data;
  }
}