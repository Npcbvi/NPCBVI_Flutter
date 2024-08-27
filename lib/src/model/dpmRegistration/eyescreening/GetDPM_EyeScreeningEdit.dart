class GetDPM_EyeScreeningEdit {
  String message;
  bool status;
  List<DataGetDPM_EyeScreeningEdit> data;
  Null list;

  GetDPM_EyeScreeningEdit({this.message, this.status, this.data, this.list});

  GetDPM_EyeScreeningEdit.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_EyeScreeningEdit>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_EyeScreeningEdit.fromJson(v));
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

class DataGetDPM_EyeScreeningEdit {
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

  DataGetDPM_EyeScreeningEdit(
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
        this.schoolAddress});

  DataGetDPM_EyeScreeningEdit.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}