class ApproveMOURenewClick {
  String message;
  bool status;
  List<DataApproveMOURenewClick> data;
  Null list;

  ApproveMOURenewClick({this.message, this.status, this.data, this.list});

  ApproveMOURenewClick.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataApproveMOURenewClick>[];
      json['data'].forEach((v) {
        data.add(new DataApproveMOURenewClick.fromJson(v));
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

class DataApproveMOURenewClick {
  int srNo;

  DataApproveMOURenewClick({this.srNo});

  DataApproveMOURenewClick.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}