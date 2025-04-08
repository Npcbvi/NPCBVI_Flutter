class ViewDashboardclick {
  String message;
  bool status;
  List<ViewDashboardclickData> data;
  Null list;

  ViewDashboardclick({this.message, this.status, this.data, this.list});

  ViewDashboardclick.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ViewDashboardclickData>[];
      json['data'].forEach((v) {
        data.add(new ViewDashboardclickData.fromJson(v));
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

class ViewDashboardclickData {
  String status;
  String registered;
  String operated;

  ViewDashboardclickData({this.status, this.registered, this.operated});

  ViewDashboardclickData.fromJson(Map<String, dynamic> json) {
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