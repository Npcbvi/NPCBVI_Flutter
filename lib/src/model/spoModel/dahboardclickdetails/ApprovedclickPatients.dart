class ApprovedclickPatients {
  String message;
  bool status;
  List<ApprovedclickPatientsData> data;
  Null list;

  ApprovedclickPatients({this.message, this.status, this.data, this.list});

  ApprovedclickPatients.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ApprovedclickPatientsData>[];
      json['data'].forEach((v) {
        data.add(new ApprovedclickPatientsData.fromJson(v));
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

class ApprovedclickPatientsData {
  int totalCount;
  int districtCode;
  String districtName;
  int stateCode;
  int oldDistrictCode;

  ApprovedclickPatientsData(
      {this.totalCount,
        this.districtCode,
        this.districtName,
        this.stateCode,
        this.oldDistrictCode});

  ApprovedclickPatientsData.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
    oldDistrictCode = json['old_district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    data['old_district_code'] = this.oldDistrictCode;
    return data;
  }
}