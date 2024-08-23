class GetPatientAPprovedwithFinanceYear {
  String message;
  bool status;
  List<DataGetPatientAPprovedwithFinanceYear> data;
  Null list;

  GetPatientAPprovedwithFinanceYear({this.message, this.status, this.data, this.list});

  GetPatientAPprovedwithFinanceYear.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetPatientAPprovedwithFinanceYear>[];
      json['data'].forEach((v) {
        data.add(new DataGetPatientAPprovedwithFinanceYear.fromJson(v));
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

class DataGetPatientAPprovedwithFinanceYear {
  String diseaseName;
  int diseaseId;
  int totalApproPending;
  int stateCode;
  int districtCode;

  DataGetPatientAPprovedwithFinanceYear(
      {this.diseaseName,
        this.diseaseId,
        this.totalApproPending,
        this.stateCode,
        this.districtCode});

  DataGetPatientAPprovedwithFinanceYear.fromJson(Map<String, dynamic> json) {
    diseaseName = json['disease_name'];
    diseaseId = json['disease_id'];
    totalApproPending = json['totalApproPending'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_name'] = this.diseaseName;
    data['disease_id'] = this.diseaseId;
    data['totalApproPending'] = this.totalApproPending;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    return data;
  }
}