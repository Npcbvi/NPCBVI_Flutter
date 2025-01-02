class GetSPO_SatelliteCentreApproval {
  String message;
  bool status;
  List<GetSPO_SatelliteCentreApprovalData> data;
  Null list;

  GetSPO_SatelliteCentreApproval({this.message, this.status, this.data, this.list});

  GetSPO_SatelliteCentreApproval.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetSPO_SatelliteCentreApprovalData>[];
      json['data'].forEach((v) {
        data.add(new GetSPO_SatelliteCentreApprovalData.fromJson(v));
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

class GetSPO_SatelliteCentreApprovalData {
  int countstate;
  int districtCode;
  int stateCode;
  String stateName;
  String districtName;

  GetSPO_SatelliteCentreApprovalData(
      {this.countstate,
        this.districtCode,
        this.stateCode,
        this.stateName,
        this.districtName});

  GetSPO_SatelliteCentreApprovalData.fromJson(Map<String, dynamic> json) {
    countstate = json['countstate'];
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countstate'] = this.countstate;
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}