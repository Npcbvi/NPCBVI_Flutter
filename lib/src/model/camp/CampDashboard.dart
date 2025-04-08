class CampDashboard {
  String message;
  bool status;
  List<CampDashboardData> data;
  Null list;

  CampDashboard({this.message, this.status, this.data, this.list});

  CampDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CampDashboardData>[];
      json['data'].forEach((v) {
        data.add(new CampDashboardData.fromJson(v));
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

class CampDashboardData {
  int totalpatient;
  String campNo;
  String campName;
  String srNo;
  String campManagerId;
  String sdname;
  String address;
  String startDate;
  String endDate;

  CampDashboardData(
      {this.totalpatient,
        this.campNo,
        this.campName,
        this.srNo,
        this.campManagerId,
        this.sdname,
        this.address,
        this.startDate,
        this.endDate});

  CampDashboardData.fromJson(Map<String, dynamic> json) {
    totalpatient = json['totalpatient'];
    campNo = json['camp_no'];
    campName = json['camp_name'];
    srNo = json['sr_no'];
    campManagerId = json['camp_manager_id'];
    sdname = json['sdname'];
    address = json['address'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalpatient'] = this.totalpatient;
    data['camp_no'] = this.campNo;
    data['camp_name'] = this.campName;
    data['sr_no'] = this.srNo;
    data['camp_manager_id'] = this.campManagerId;
    data['sdname'] = this.sdname;
    data['address'] = this.address;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}