class HospitalDashboard {
  String message;
  bool status;
  List<DataHospitalDashboard> data;
  Null list;

  HospitalDashboard({this.message, this.status, this.data, this.list});

  HospitalDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataHospitalDashboard>[];
      json['data'].forEach((v) {
        data.add(new DataHospitalDashboard.fromJson(v));
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

class DataHospitalDashboard {
  String status;
  String registered;
  String operated;

  DataHospitalDashboard({this.status, this.registered, this.operated});

  DataHospitalDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    registered = json['registered'];
    operated = json['operated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['registered'] = this.registered;
    data['operated'] = this.operated;
    return data;
  }
}