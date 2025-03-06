class HospitallinkedwithNGO {
  String message;
  bool status;
  List<DataHospitallinkedwithNGO> data;
  Null list;

  HospitallinkedwithNGO({this.message, this.status, this.data, this.list});

  HospitallinkedwithNGO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataHospitallinkedwithNGO>[];
      json['data'].forEach((v) {
        data.add(new DataHospitallinkedwithNGO.fromJson(v));
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

class DataHospitallinkedwithNGO {
  String nDarpanNo;
  String hRegID;
  String hName;
  int mobile;
  String address;
  String emailId;
  String stateName;
  String districtName;

  DataHospitallinkedwithNGO(
      {this.nDarpanNo,
        this.hRegID,
        this.hName,
        this.mobile,
        this.address,
        this.emailId,
        this.stateName,
        this.districtName});

  DataHospitallinkedwithNGO.fromJson(Map<String, dynamic> json) {
    nDarpanNo = json['n_Darpan_No'];
    hRegID = json['h_Reg_ID'];
    hName = json['h_Name'];
    mobile = json['mobile'];
    address = json['address'];
    emailId = json['email_id'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_Darpan_No'] = this.nDarpanNo;
    data['h_Reg_ID'] = this.hRegID;
    data['h_Name'] = this.hName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['email_id'] = this.emailId;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}