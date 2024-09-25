class NGODashboards {
  String message;
  bool status;
  List<DataNGODashboards> data;
  Null list;

  NGODashboards({this.message, this.status, this.data, this.list});

  NGODashboards.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataNGODashboards>[];
      json['data'].forEach((v) {
        data.add(new DataNGODashboards.fromJson(v));
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

class DataNGODashboards {
  String status;
  String registered;
  String operated;

  DataNGODashboards({this.status, this.registered, this.operated});

  DataNGODashboards.fromJson(Map<String, dynamic> json) {
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