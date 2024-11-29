class EyeSurgeons {
  String message;
  bool status;
  List<EyeSurgeonsData> data;
  Null list;

  EyeSurgeons({this.message, this.status, this.data, this.list});

  EyeSurgeons.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <EyeSurgeonsData>[];
      json['data'].forEach((v) {
        data.add(new EyeSurgeonsData.fromJson(v));
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

class EyeSurgeonsData {
  int sno;
  String entryDate;
  String entryBy;
  String updatedDate;
  String updatedBy;
  String ipaddress;
  String updatedIpaddress;
  int status;
  int stateCode;
  int totalngo;
  int totalGov;
  int totalPP;
  int totalPMC;

  EyeSurgeonsData(
      {this.sno,
        this.entryDate,
        this.entryBy,
        this.updatedDate,
        this.updatedBy,
        this.ipaddress,
        this.updatedIpaddress,
        this.status,
        this.stateCode,
        this.totalngo,
        this.totalGov,
        this.totalPP,
        this.totalPMC});

  EyeSurgeonsData.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    entryDate = json['entry_date'];
    entryBy = json['entry_by'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
    ipaddress = json['ipaddress'];
    updatedIpaddress = json['updated_ipaddress'];
    status = json['status'];
    stateCode = json['state_code'];
    totalngo = json['totalngo'];
    totalGov = json['totalGov'];
    totalPP = json['totalPP'];
    totalPMC = json['totalPMC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['entry_date'] = this.entryDate;
    data['entry_by'] = this.entryBy;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    data['ipaddress'] = this.ipaddress;
    data['updated_ipaddress'] = this.updatedIpaddress;
    data['status'] = this.status;
    data['state_code'] = this.stateCode;
    data['totalngo'] = this.totalngo;
    data['totalGov'] = this.totalGov;
    data['totalPP'] = this.totalPP;
    data['totalPMC'] = this.totalPMC;
    return data;
  }
}