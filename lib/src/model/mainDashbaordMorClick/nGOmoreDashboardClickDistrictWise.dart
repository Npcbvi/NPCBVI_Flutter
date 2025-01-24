class nGOmoreDashboardClickDistrictWise {
  String message;
  bool status;
  List<nGOmoreDashboardClickDistrictWiseData> data;
  Null list;

  nGOmoreDashboardClickDistrictWise({this.message, this.status, this.data, this.list});

  nGOmoreDashboardClickDistrictWise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <nGOmoreDashboardClickDistrictWiseData>[];
      json['data'].forEach((v) {
        data.add(new nGOmoreDashboardClickDistrictWiseData.fromJson(v));
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

class nGOmoreDashboardClickDistrictWiseData {
  int districtCode;
  int stateCode;
  int countState;
  String districtName;

  nGOmoreDashboardClickDistrictWiseData({this.districtCode, this.stateCode, this.countState, this.districtName});

  nGOmoreDashboardClickDistrictWiseData.fromJson(Map<String, dynamic> json) {
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