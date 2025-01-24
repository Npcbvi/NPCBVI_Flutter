class nGOmoreDashboardClickStateWise {
  String message;
  bool status;
  List<nGOmoreDashboardClickStateWiseData> data;
  Null list;

  nGOmoreDashboardClickStateWise({this.message, this.status, this.data, this.list});

  nGOmoreDashboardClickStateWise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <nGOmoreDashboardClickStateWiseData>[];
      json['data'].forEach((v) {
        data.add(new nGOmoreDashboardClickStateWiseData.fromJson(v));
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

class nGOmoreDashboardClickStateWiseData {
  int stateCode;
  int countState;
  String stateName;

  nGOmoreDashboardClickStateWiseData({this.stateCode, this.countState, this.stateName});

  nGOmoreDashboardClickStateWiseData.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    countState = json['countState'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['countState'] = this.countState;
    data['state_name'] = this.stateName;
    return data;
  }
}