class GovtPrivateApprovedFinalScreen {
  String message;
  bool status;
  List<DataGovtPrivateApprovedFinalScreen> data;
  Null list;

  GovtPrivateApprovedFinalScreen({this.message, this.status, this.data, this.list});

  GovtPrivateApprovedFinalScreen.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGovtPrivateApprovedFinalScreen>[];
      json['data'].forEach((v) {
        data.add(new DataGovtPrivateApprovedFinalScreen.fromJson(v));
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

class DataGovtPrivateApprovedFinalScreen {
  int srNo;

  DataGovtPrivateApprovedFinalScreen({this.srNo});

  DataGovtPrivateApprovedFinalScreen.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}