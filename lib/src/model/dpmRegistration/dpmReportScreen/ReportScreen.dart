class ReportScreen {
  String message;
  bool status;
  List<DataReportScreen> data;
  Null list;

  ReportScreen({this.message, this.status, this.data, this.list});

  ReportScreen.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataReportScreen>[];
      json['data'].forEach((v) {
        data.add(new DataReportScreen.fromJson(v));
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

class DataReportScreen {
  int totalpatient;
  int amount;
  int rate;
  int stateCode;
  String statename;
  String districtName;
  int oldDistrictCode;
  int districtCode;
  String ngoname;
  String npcbNo;
  int isnew;
  int roleId;

  DataReportScreen(
      {this.totalpatient,
        this.amount,
        this.rate,
        this.stateCode,
        this.statename,
        this.districtName,
        this.oldDistrictCode,
        this.districtCode,
        this.ngoname,
        this.npcbNo,
        this.isnew,
        this.roleId});

  DataReportScreen.fromJson(Map<String, dynamic> json) {
    totalpatient = json['totalpatient'];
    amount = json['amount'];
    rate = json['rate'];
    stateCode = json['state_code'];
    statename = json['statename'];
    districtName = json['district_name'];
    oldDistrictCode = json['old_district_code'];
    districtCode = json['district_code'];
    ngoname = json['ngoname'];
    npcbNo = json['npcbNo'];
    isnew = json['isnew'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalpatient'] = this.totalpatient;
    data['amount'] = this.amount;
    data['rate'] = this.rate;
    data['state_code'] = this.stateCode;
    data['statename'] = this.statename;
    data['district_name'] = this.districtName;
    data['old_district_code'] = this.oldDistrictCode;
    data['district_code'] = this.districtCode;
    data['ngoname'] = this.ngoname;
    data['npcbNo'] = this.npcbNo;
    data['isnew'] = this.isnew;
    data['role_id'] = this.roleId;
    return data;
  }
}


