class UploadMOUNGO {
  String message;
  bool status;
  List<DataUploadMOUNGO> data;
  Null list;

  UploadMOUNGO({this.message, this.status, this.data, this.list});

  UploadMOUNGO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataUploadMOUNGO>[];
      json['data'].forEach((v) {
        data.add(new DataUploadMOUNGO.fromJson(v));
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

class DataUploadMOUNGO {
  String hRegID;
  String emailId;
  String fromDate;
  String toDate;
  String name;
  int vstatus;
  String file;
  int id;

  DataUploadMOUNGO(
      {this.hRegID,
        this.emailId,
        this.fromDate,
        this.toDate,
        this.name,
        this.vstatus,
        this.file,
        this.id});

  DataUploadMOUNGO.fromJson(Map<String, dynamic> json) {
    hRegID = json['h_Reg_ID'];
    emailId = json['email_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    name = json['name'];
    vstatus = json['vstatus'];
    file = json['file'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_Reg_ID'] = this.hRegID;
    data['email_id'] = this.emailId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['name'] = this.name;
    data['vstatus'] = this.vstatus;
    data['file'] = this.file;
    data['id'] = this.id;
    return data;
  }
}