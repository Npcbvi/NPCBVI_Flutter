class ScreeningCampManager {
  String message;
  bool status;
  List<DataScreeningCampManager> data;
  Null list;

  ScreeningCampManager({this.message, this.status, this.data, this.list});

  ScreeningCampManager.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataScreeningCampManager>[];
      json['data'].forEach((v) {
        data.add(new DataScreeningCampManager.fromJson(v));
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

class DataScreeningCampManager {
  String managerName;
  int srNo;

  DataScreeningCampManager({this.managerName, this.srNo});

  DataScreeningCampManager.fromJson(Map<String, dynamic> json) {
    managerName = json['manager_name'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manager_name'] = this.managerName;
    data['sr_no'] = this.srNo;
    return data;
  }
}