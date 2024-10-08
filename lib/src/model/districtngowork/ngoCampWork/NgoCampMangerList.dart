class NgoCampMangerList {
  String message;
  bool status;
  List<DataNgoCampMangerList> data;
  Null list;

  NgoCampMangerList({this.message, this.status, this.data, this.list});

  NgoCampMangerList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataNgoCampMangerList>[];
      json['data'].forEach((v) {
        data.add(new DataNgoCampMangerList.fromJson(v));
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

class DataNgoCampMangerList {
  String userId;
  String managerName;
  String mobile;
  String emailId;
  String address;
  String designation;
  String srNo;

  DataNgoCampMangerList(
      {this.userId,
        this.managerName,
        this.mobile,
        this.emailId,
        this.address,
        this.designation,
        this.srNo});

  DataNgoCampMangerList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    managerName = json['manager_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    address = json['address'];
    designation = json['designation'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['manager_name'] = this.managerName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['designation'] = this.designation;
    data['sr_no'] = this.srNo;
    return data;
  }
}