class DistrictWiseDpm {
  String message;
  bool status;
  List<DistrictWiseDpmData> data;
  Null list;

  DistrictWiseDpm({this.message, this.status, this.data, this.list});

  DistrictWiseDpm.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DistrictWiseDpmData>[];
      json['data'].forEach((v) {
        data.add(new DistrictWiseDpmData.fromJson(v));
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

class DistrictWiseDpmData {
  int districtCode;
  int stateCode;
  String districtName;
  String name;
  String officeAddress;
  String emailId;
  String mobile;

  DistrictWiseDpmData(
      {this.districtCode,
        this.stateCode,
        this.districtName,
        this.name,
        this.officeAddress,
        this.emailId,
        this.mobile});

  DistrictWiseDpmData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    districtName = json['district_name'];
    name = json['name'];
    officeAddress = json['office_address'];
    emailId = json['email_id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['district_name'] = this.districtName;
    data['name'] = this.name;
    data['office_address'] = this.officeAddress;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    return data;
  }
}