class GetSPO_DiseasewiseRecordsApproval {
  String message;
  bool status;
  List<GetSPO_DiseasewiseRecordsApprovalData> data;
  Null list;

  GetSPO_DiseasewiseRecordsApproval({this.message, this.status, this.data, this.list});

  GetSPO_DiseasewiseRecordsApproval.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetSPO_DiseasewiseRecordsApprovalData>[];
      json['data'].forEach((v) {
        data.add(new GetSPO_DiseasewiseRecordsApprovalData.fromJson(v));
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

class GetSPO_DiseasewiseRecordsApprovalData {
  String diseaseName;
  int diseaseId;
  int totalApproPending;
  int stateCode;
  int districtCode;

  GetSPO_DiseasewiseRecordsApprovalData(
      {this.diseaseName,
        this.diseaseId,
        this.totalApproPending,
        this.stateCode,
        this.districtCode});

  GetSPO_DiseasewiseRecordsApprovalData.fromJson(Map<String, dynamic> json) {
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