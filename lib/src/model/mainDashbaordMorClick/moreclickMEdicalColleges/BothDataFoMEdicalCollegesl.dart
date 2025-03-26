class BothDataFoMEdicalCollegesl {
  String message;
  bool status;
  List<BothDataFoMEdicalCollegesllData> data;
  Null list;

  BothDataFoMEdicalCollegesl({this.message, this.status, this.data, this.list});

  BothDataFoMEdicalCollegesl.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <BothDataFoMEdicalCollegesllData>[];
      json['data'].forEach((v) {
        data.add(new BothDataFoMEdicalCollegesllData.fromJson(v));
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

class BothDataFoMEdicalCollegesllData {
  int districtCode;
  String districtName;
  int stateCode;
  String stateName;
  String nodalOfficerName;
  String mobile;
  String type;
  String emailId;
  String ngoName;
  String address;
  String entry_date;

  BothDataFoMEdicalCollegesllData(
      {this.districtCode,
        this.districtName,
        this.stateCode,
        this.stateName,
        this.nodalOfficerName,
        this.mobile,
        this.type,
        this.emailId,
        this.ngoName,
        this.address,
      this.entry_date});

  BothDataFoMEdicalCollegesllData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    nodalOfficerName = json['nodal_officer_name'];
    mobile = json['mobile'];
    type = json['type'];
    emailId = json['email_id'];
    ngoName = json['ngoName'];
    address = json['address'];
    entry_date = json['entry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['email_id'] = this.emailId;
    data['ngoName'] = this.ngoName;
    data['address'] = this.address;
    data['entry_date'] = this.entry_date;
    return data;
  }
}


