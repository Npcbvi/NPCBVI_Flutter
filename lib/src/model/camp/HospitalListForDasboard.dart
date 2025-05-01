class HospitalListForDasboard {
  String message;
  bool status;
  List<HospitalListForDasboardData> data;
  Null list;

  HospitalListForDasboard({this.message, this.status, this.data, this.list});

  HospitalListForDasboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <HospitalListForDasboardData>[];
      json['data'].forEach((v) {
        data.add(new HospitalListForDasboardData.fromJson(v));
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

class HospitalListForDasboardData {
  String hName;
  String hRegID;

  HospitalListForDasboardData({this.hName, this.hRegID});

  HospitalListForDasboardData.fromJson(Map<String, dynamic> json) {
    hName = json['h_Name'];
    hRegID = json['h_Reg_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_Name'] = this.hName;
    data['h_Reg_ID'] = this.hRegID;
    return data;
  }
}
