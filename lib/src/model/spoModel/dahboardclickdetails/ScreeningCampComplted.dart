class ScreeningCampComplted {
  String message;
  bool status;
  List<ScreeningCampCompltedData> data;
  Null list;

  ScreeningCampComplted({this.message, this.status, this.data, this.list});

  ScreeningCampComplted.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ScreeningCampCompltedData>[];
      json['data'].forEach((v) {
        data.add(new ScreeningCampCompltedData.fromJson(v));
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

class ScreeningCampCompltedData {
  int countstate;
  int districtCode;
  int stateCode;
  String stateName;
  String districtName;

  ScreeningCampCompltedData(
      {this.countstate,
        this.districtCode,
        this.stateCode,
        this.stateName,
        this.districtName});

  ScreeningCampCompltedData.fromJson(Map<String, dynamic> json) {
    countstate = json['countstate'];
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countstate'] = this.countstate;
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}