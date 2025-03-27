class BothWiseSatelliteWise {
  String message;
  bool status;
  List<DataBothWiseSatelliteWise> data;
  Null list;

  BothWiseSatelliteWise({this.message, this.status, this.data, this.list});

  BothWiseSatelliteWise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBothWiseSatelliteWise>[];
      json['data'].forEach((v) {
        data.add(new DataBothWiseSatelliteWise.fromJson(v));
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

class DataBothWiseSatelliteWise {
  int districtCode;
  int stateCode;
  String stateName;
  String districtName;
  String ngoName;
  String hospitalname;
  String campmanagername;
  String endDate;
  String startDate;
  String entryDate;

  DataBothWiseSatelliteWise(
      {this.districtCode,
        this.stateCode,
        this.stateName,
        this.districtName,
        this.ngoName,
        this.hospitalname,
        this.campmanagername,
        this.endDate,
        this.startDate,
        this.entryDate});

  DataBothWiseSatelliteWise.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    ngoName = json['ngoName'];
    hospitalname = json['hospitalname'];
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
    data['hospitalname'] = this.hospitalname;
    data['campmanagername'] = this.campmanagername;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['entry_date'] = this.entryDate;
    return data;
  }
}