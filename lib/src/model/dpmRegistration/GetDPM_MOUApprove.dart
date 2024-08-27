class GetDPM_MOUApprove {
  String message;
  bool status;
  List<DataGetDPM_MOUApprove> data;
  Null list;

  GetDPM_MOUApprove({this.message, this.status, this.data, this.list});

  GetDPM_MOUApprove.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_MOUApprove>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_MOUApprove.fromJson(v));
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

class DataGetDPM_MOUApprove {
  String hRegID;
  String emailId;
  String hName;
  String fromDate;
  int mobile;
  String toDate;
  String name;
  int vstatus;
  String file;
  int id;

  DataGetDPM_MOUApprove(
      {this.hRegID,
        this.emailId,
        this.hName,
        this.fromDate,
        this.mobile,
        this.toDate,
        this.name,
        this.vstatus,
        this.file,
        this.id});

  DataGetDPM_MOUApprove.fromJson(Map<String, dynamic> json) {
    hRegID = json['h_Reg_ID'];
    emailId = json['email_id'];
    hName = json['h_Name'];
    fromDate = json['from_date'];
    mobile = json['mobile'];
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
    data['h_Name'] = this.hName;
    data['from_date'] = this.fromDate;
    data['mobile'] = this.mobile;
    data['to_date'] = this.toDate;
    data['name'] = this.name;
    data['vstatus'] = this.vstatus;
    data['file'] = this.file;
    data['id'] = this.id;
    return data;
  }
}