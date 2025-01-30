class BothSatelliteCenterss {
  String message;
  bool status;
  List<BothSatelliteCentersData> data;
  Null list;

  BothSatelliteCenterss({this.message, this.status, this.data, this.list});

  BothSatelliteCenterss.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <BothSatelliteCentersData>[];
      json['data'].forEach((v) {
        data.add(new BothSatelliteCentersData.fromJson(v));
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

class BothSatelliteCentersData {
  int districtCode;
  int stateCode;
  String stateName;
  String districtName;
  String ngoName;
  String hospitalname;
  String sname;
  String address;
  String smanagername;

  BothSatelliteCentersData(
      {this.districtCode,
        this.stateCode,
        this.stateName,
        this.districtName,
        this.ngoName,
        this.hospitalname,
        this.sname,
        this.address,
        this.smanagername});

  BothSatelliteCentersData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    ngoName = json['ngoName'];
    hospitalname = json['hospitalname'];
    sname = json['sname'];
    address = json['address'];
    smanagername = json['smanagername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['ngoName'] = this.ngoName;
    data['hospitalname'] = this.hospitalname;
    data['sname'] = this.sname;
    data['address'] = this.address;
    data['smanagername'] = this.smanagername;
    return data;
  }
}