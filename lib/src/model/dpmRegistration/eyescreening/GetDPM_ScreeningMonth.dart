class GetDPM_ScreeningMonth {
  String message;
  bool status;
  List<DataGetDPM_ScreeningMonth> data;
  Null list;

  GetDPM_ScreeningMonth({this.message, this.status, this.data, this.list});

  GetDPM_ScreeningMonth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_ScreeningMonth>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_ScreeningMonth.fromJson(v));
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

class DataGetDPM_ScreeningMonth {
  int monthId;
  String monthname;

  DataGetDPM_ScreeningMonth({this.monthId, this.monthname});

  DataGetDPM_ScreeningMonth.fromJson(Map<String, dynamic> json) {
    monthId = json['month_id'];
    monthname = json['monthname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_id'] = this.monthId;
    data['monthname'] = this.monthname;
    return data;
  }
}