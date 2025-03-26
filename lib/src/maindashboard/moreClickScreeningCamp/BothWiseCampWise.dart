class BothWiseCampWise {
  String message;
  bool status;
  List<DataBothWiseCampWise> data;
  Null list;

  BothWiseCampWise({this.message, this.status, this.data, this.list});

  BothWiseCampWise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBothWiseCampWise>[];
      json['data'].forEach((v) {
        data.add(new DataBothWiseCampWise.fromJson(v));
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

class DataBothWiseCampWise {
  int districtCode;
  int stateCode;
  String stateName;
  String districtName;
  String ngoName;
  String campname;
  String campmanagername;
  String endDate;
  String startDate;
  String entryDate;

  DataBothWiseCampWise(
      {this.districtCode,
        this.stateCode,
        this.stateName,
        this.districtName,
        this.ngoName,
        this.campname,
        this.campmanagername,
        this.endDate,
        this.startDate,
        this.entryDate});

  DataBothWiseCampWise.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    ngoName = json['ngoName'];
    campname = json['campname'];
    campmanagername = json['campmanagername'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    entryDate = json['entry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['ngoName'] = this.ngoName;
    data['campname'] = this.campname;
    data['campmanagername'] = this.campmanagername;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['entry_date'] = this.entryDate;
    return data;
  }
}