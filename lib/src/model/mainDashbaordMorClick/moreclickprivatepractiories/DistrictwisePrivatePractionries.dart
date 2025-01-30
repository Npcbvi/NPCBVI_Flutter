class DistrictwisePrivatePractionries {
  String message;
  bool status;
  List<DistrictwisePrivatePractionriesData> data;
  Null list;

  DistrictwisePrivatePractionries({this.message, this.status, this.data, this.list});

  DistrictwisePrivatePractionries.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DistrictwisePrivatePractionriesData>[];
      json['data'].forEach((v) {
        data.add(new DistrictwisePrivatePractionriesData.fromJson(v));
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

class DistrictwisePrivatePractionriesData {
  int districtCode;
  int stateCode;
  int countState;
  String districtName;

  DistrictwisePrivatePractionriesData({this.districtCode, this.stateCode, this.countState, this.districtName});

  DistrictwisePrivatePractionriesData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    countState = json['countState'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['countState'] = this.countState;
    data['district_name'] = this.districtName;
    return data;
  }
}