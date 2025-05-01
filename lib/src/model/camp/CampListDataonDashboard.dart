class CampListDataonDashboard {
  String message;
  bool status;
  List<CampListDataonDashboardData> data;
  Null list;

  CampListDataonDashboard({this.message, this.status, this.data, this.list});

  CampListDataonDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CampListDataonDashboardData>[];
      json['data'].forEach((v) {
        data.add(new CampListDataonDashboardData.fromJson(v));
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

class CampListDataonDashboardData {
  String campNo;
  String srNo;

  CampListDataonDashboardData({this.campNo, this.srNo});

  CampListDataonDashboardData.fromJson(Map<String, dynamic> json) {
    campNo = json['camp_no'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['camp_no'] = this.campNo;
    data['sr_no'] = this.srNo;
    return data;
  }
}