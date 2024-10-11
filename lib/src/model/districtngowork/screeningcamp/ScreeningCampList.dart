class ScreeningCampList {
  String message;
  bool status;
  List<DataScreeningCampList> data;
  Null list;

  ScreeningCampList({this.message, this.status, this.data, this.list});

  ScreeningCampList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataScreeningCampList>[];
      json['data'].forEach((v) {
        data.add(new DataScreeningCampList.fromJson(v));
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

class DataScreeningCampList {
  String campNo;
  String startDate;
  String endDate;
  String name;
  int srNo;

  DataScreeningCampList({this.campNo, this.startDate, this.endDate, this.name, this.srNo});

  DataScreeningCampList.fromJson(Map<String, dynamic> json) {
    campNo = json['camp_no'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    name = json['name'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['camp_no'] = this.campNo;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['name'] = this.name;
    data['sr_no'] = this.srNo;
    return data;
  }
}