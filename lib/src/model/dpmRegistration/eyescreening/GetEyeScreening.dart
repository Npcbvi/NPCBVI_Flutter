class GetEyeScreening {
  String message;
  bool status;
  List<DataGetEyeScreening> data;
  Null list;

  GetEyeScreening({this.message, this.status, this.data, this.list});

  GetEyeScreening.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetEyeScreening>[];
      json['data'].forEach((v) {
        data.add(new DataGetEyeScreening.fromJson(v));
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

class DataGetEyeScreening {
  int schoolid;
  int stateCode;
  int districtCode;
  String principal;
  int trainedTeacher;
  int childScreen;
  int childDetect;
  int freeglass;
  int monthid;
  int yearid;
  String entryBy;
  int status;
  String schoolName;
  String schoolAddress;
  String yearname;
  String monthname;
  int yearId;
  String yearfyid;
  int monthId;

  DataGetEyeScreening(
      {this.schoolid,
        this.stateCode,
        this.districtCode,
        this.principal,
        this.trainedTeacher,
        this.childScreen,
        this.childDetect,
        this.freeglass,
        this.monthid,
        this.yearid,
        this.entryBy,
        this.status,
        this.schoolName,
        this.schoolAddress,
        this.yearname,
        this.monthname,
        this.yearId,
        this.yearfyid,
        this.monthId});

  DataGetEyeScreening.fromJson(Map<String, dynamic> json) {
    schoolid = json['schoolid'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    principal = json['principal'];
    trainedTeacher = json['trained_teacher'];
    childScreen = json['child_screen'];
    childDetect = json['child_detect'];
    freeglass = json['freeglass'];
    monthid = json['monthid'];
    yearid = json['yearid'];
    entryBy = json['entry_by'];
    status = json['status'];
    schoolName = json['school_name'];
    schoolAddress = json['school_address'];
    yearname = json['yearname'];
    monthname = json['monthname'];
    yearId = json['year_id'];
    yearfyid = json['yearfyid'];
    monthId = json['month_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolid'] = this.schoolid;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['principal'] = this.principal;
    data['trained_teacher'] = this.trainedTeacher;
    data['child_screen'] = this.childScreen;
    data['child_detect'] = this.childDetect;
    data['freeglass'] = this.freeglass;
    data['monthid'] = this.monthid;
    data['yearid'] = this.yearid;
    data['entry_by'] = this.entryBy;
    data['status'] = this.status;
    data['school_name'] = this.schoolName;
    data['school_address'] = this.schoolAddress;
    data['yearname'] = this.yearname;
    data['monthname'] = this.monthname;
    data['year_id'] = this.yearId;
    data['yearfyid'] = this.yearfyid;
    data['month_id'] = this.monthId;
    return data;
  }
}