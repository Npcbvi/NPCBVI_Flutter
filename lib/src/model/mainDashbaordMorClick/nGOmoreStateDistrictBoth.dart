class nGOmoreStateDistrictBoth {
  String message;
  bool status;
  List<nGOmoreStateDistrictBothData> data;
  Null list;

  nGOmoreStateDistrictBoth({this.message, this.status, this.data, this.list});

  nGOmoreStateDistrictBoth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <nGOmoreStateDistrictBothData>[];
      json['data'].forEach((v) {
        data.add(new nGOmoreStateDistrictBothData.fromJson(v));
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

class nGOmoreStateDistrictBothData {
  int districtCode;
  String districtName;
  int stateCode;
  String stateName;
  String memberName;
  String darpanNo;
  String name;
  String address;

  nGOmoreStateDistrictBothData(
      {this.districtCode,
        this.districtName,
        this.stateCode,
        this.stateName,
        this.memberName,
        this.darpanNo,
        this.name,
        this.address});

  nGOmoreStateDistrictBothData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    memberName = json['member_name'];
    darpanNo = json['darpan_no'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['member_name'] = this.memberName;
    data['darpan_no'] = this.darpanNo;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}