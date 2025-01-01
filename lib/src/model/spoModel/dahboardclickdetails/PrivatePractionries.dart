class PrivatePractionries {
  String message;
  bool status;
  List<PrivatePractionriesData> data;
  Null list;

  PrivatePractionries({this.message, this.status, this.data, this.list});

  PrivatePractionries.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <PrivatePractionriesData>[];
      json['data'].forEach((v) {
        data.add(new PrivatePractionriesData.fromJson(v));
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

class PrivatePractionriesData {
  int districtCode;
  String nodalOfficerName;
  String oName;
  int mobile;
  int stateCode;
  String type;
  String stateName;
  String address;
  String districtName;
  String ngoname;
  String emailId;

  PrivatePractionriesData(
      {this.districtCode,
        this.nodalOfficerName,
        this.oName,
        this.mobile,
        this.stateCode,
        this.type,
        this.stateName,
        this.address,
        this.districtName,
        this.ngoname,
        this.emailId});

  PrivatePractionriesData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    nodalOfficerName = json['nodal_officer_name'];
    oName = json['o_Name'];
    mobile = json['mobile'];
    stateCode = json['state_code'];
    type = json['type'];
    stateName = json['state_Name'];
    address = json['address'];
    districtName = json['district_Name'];
    ngoname = json['ngoname'];
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
    data['state_Name'] = this.stateName;
    data['address'] = this.address;
    data['district_Name'] = this.districtName;
    data['ngoname'] = this.ngoname;
    data['email_id'] = this.emailId;
    return data;
  }
}