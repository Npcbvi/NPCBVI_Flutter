class TotalPatientCamp {
  String message;
  bool status;
  List<TotalPatientCampData> data;
  Null list;

  TotalPatientCamp({this.message, this.status, this.data, this.list});

  TotalPatientCamp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <TotalPatientCampData>[];
      json['data'].forEach((v) {
        data.add(new TotalPatientCampData.fromJson(v));
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

class TotalPatientCampData {
  int totalCount;

  TotalPatientCampData({this.totalCount});

  TotalPatientCampData.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    return data;
  }
}