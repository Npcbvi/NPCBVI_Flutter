class SchoolEyeScreening_Registration {
  String message;
  bool status;
  List<DataSchoolEyeScreening_Registration> data;
  Null list;

  SchoolEyeScreening_Registration({this.message, this.status, this.data, this.list});

  SchoolEyeScreening_Registration.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataSchoolEyeScreening_Registration>[];
      json['data'].forEach((v) {
        data.add(new DataSchoolEyeScreening_Registration.fromJson(v));
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

class DataSchoolEyeScreening_Registration {
  int srNo;

  DataSchoolEyeScreening_Registration({this.srNo});

  DataSchoolEyeScreening_Registration.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}