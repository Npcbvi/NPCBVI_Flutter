class ScreeningCampCompletedList {
  String message;
  bool status;
  List<ScreeningCampCompletedListData> data;
  Null list;

  ScreeningCampCompletedList({this.message, this.status, this.data, this.list});

  ScreeningCampCompletedList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ScreeningCampCompletedListData>[];
      json['data'].forEach((v) {
        data.add(new ScreeningCampCompletedListData.fromJson(v));
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

class ScreeningCampCompletedListData {
  int districtCode;
  int stateCode;
  String campName;
  String stateName;
  String districtName;
  String ngoName;
  String campname;
  String address;
  String campmanagername;
  String endDate;
  int mobile;
  String startDate;
  String emailId;

  ScreeningCampCompletedListData(
      {this.districtCode,
        this.stateCode,
        this.campName,
        this.stateName,
        this.districtName,
        this.ngoName,
        this.campname,
        this.address,
        this.campmanagername,
        this.endDate,
        this.mobile,
        this.startDate,
        this.emailId});

  ScreeningCampCompletedListData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    campName = json['camp_name'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    ngoName = json['ngoName'];
    campname = json['campname'];
    address = json['address'];
    campmanagername = json['campmanagername'];
    endDate = json['end_date'];
    mobile = json['mobile'];
    startDate = json['start_date'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['camp_name'] = this.campName;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['ngoName'] = this.ngoName;
    data['campname'] = this.campname;
    data['address'] = this.address;
    data['campmanagername'] = this.campmanagername;
    data['end_date'] = this.endDate;
    data['mobile'] = this.mobile;
    data['start_date'] = this.startDate;
    data['email_id'] = this.emailId;
    return data;
  }
}