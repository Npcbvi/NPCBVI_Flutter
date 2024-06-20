class DashboardDistrictModel {
  String message;
  bool status;
  List<DataDsirict> data;

  DashboardDistrictModel({this.message, this.status, this.data});

  DashboardDistrictModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDsirict>[];
      json['data'].forEach((v) {
        data.add(new DataDsirict.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataDsirict {
  int districtCode;
  String districtName;
  int stateCode;

  DataDsirict({this.districtCode, this.districtName, this.stateCode});

  DataDsirict.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    return data;
  }
}