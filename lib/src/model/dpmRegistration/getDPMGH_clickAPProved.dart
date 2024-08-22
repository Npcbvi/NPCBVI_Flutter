class getDPMGH_clickAPProved {
  String message;
  bool status;
  List<DatagetDPMGH_clickAPProved> data;
  Null list;

  getDPMGH_clickAPProved({this.message, this.status, this.data, this.list});

  getDPMGH_clickAPProved.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DatagetDPMGH_clickAPProved>[];
      json['data'].forEach((v) {
        data.add(new DatagetDPMGH_clickAPProved.fromJson(v));
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

class DatagetDPMGH_clickAPProved {
  int districtCode;
  String nodalOfficerName;
  String oName;
  int mobile;
  int stateCode;
  String type;
  String stateName;
  String address;
  String ngoName;
  String districtName;
  String emailId;

  DatagetDPMGH_clickAPProved(
      {this.districtCode,
        this.nodalOfficerName,
        this.oName,
        this.mobile,
        this.stateCode,
        this.type,
        this.stateName,
        this.address,
        this.ngoName,
        this.districtName,
        this.emailId});

  DatagetDPMGH_clickAPProved.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    nodalOfficerName = json['nodal_officer_name'];
    oName = json['o_Name'];
    mobile = json['mobile'];
    stateCode = json['state_code'];
    type = json['type'];
    stateName = json['state_name'];
    address = json['address'];
    ngoName = json['ngoName'];
    districtName = json['district_name'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['o_Name'] = this.oName;
    data['mobile'] = this.mobile;
    data['state_code'] = this.stateCode;
    data['type'] = this.type;
    data['state_name'] = this.stateName;
    data['address'] = this.address;
    data['ngoName'] = this.ngoName;
    data['district_name'] = this.districtName;
    data['email_id'] = this.emailId;
    return data;
  }
}

