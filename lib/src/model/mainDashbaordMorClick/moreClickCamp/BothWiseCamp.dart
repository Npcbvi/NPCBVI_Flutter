class BothWiseCamps {
  String message;
  bool status;
  List<BothWiseCampsData> data;
  Null list;

  BothWiseCamps({this.message, this.status, this.data, this.list});

  BothWiseCamps.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <BothWiseCampsData>[];
      json['data'].forEach((v) {
        data.add(new BothWiseCampsData.fromJson(v));
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

class BothWiseCampsData {
  int districtCode;
  int stateCode;
  int countState;
  String stateName;
  String districtName;
  String ngoName;
  String npcbNo;
  String entry_date;

  BothWiseCampsData(
      {this.districtCode,
        this.stateCode,
        this.countState,
        this.stateName,
        this.districtName,
        this.ngoName,
        this.npcbNo,
      this.entry_date});

  BothWiseCampsData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    countState = json['countState'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    ngoName = json['ngoName'];
    npcbNo = json['npcbNo'];

    entry_date = json['entry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['countState'] = this.countState;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['ngoName'] = this.ngoName;
    data['npcbNo'] = this.npcbNo;
    data['entry_date'] = this.entry_date;
    return data;
  }
}