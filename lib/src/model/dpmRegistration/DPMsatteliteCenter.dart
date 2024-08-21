class DPMsatteliteCenter {
  String message;
  bool status;
  List<DataDPMsatteliteCenter> data;
  Null list;

  DPMsatteliteCenter({this.message, this.status, this.data, this.list});

  DPMsatteliteCenter.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDPMsatteliteCenter>[];
      json['data'].forEach((v) {
        data.add(new DataDPMsatteliteCenter.fromJson(v));
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

class DataDPMsatteliteCenter {
  int districtCode;
  String districtName;
  int stateCode;
  String stateName;
  String name;
  String address;
  String hospitalname;
  String ngoName;
  String emailId;
  int mobile;
  String sname;
  String smanagername;

  DataDPMsatteliteCenter(
      {this.districtCode,
        this.districtName,
        this.stateCode,
        this.stateName,
        this.name,
        this.address,
        this.hospitalname,
        this.ngoName,
        this.emailId,
        this.mobile,
        this.sname,
        this.smanagername});

  DataDPMsatteliteCenter.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    name = json['name'];
    address = json['address'];
    hospitalname = json['hospitalname'];
    ngoName = json['ngoName'];
    emailId = json['email_id'];
    mobile = json['mobile'];
    sname = json['sname'];
    smanagername = json['smanagername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['name'] = this.name;
    data['address'] = this.address;
    data['hospitalname'] = this.hospitalname;
    data['ngoName'] = this.ngoName;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    data['sname'] = this.sname;
    data['smanagername'] = this.smanagername;
    return data;
  }
}