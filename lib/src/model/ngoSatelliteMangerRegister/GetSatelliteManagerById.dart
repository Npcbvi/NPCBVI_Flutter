class GetSatelliteManagerById {
  String message;
  bool status;
  List<DataGetSatelliteManagerById> data;
  Null list;

  GetSatelliteManagerById({this.message, this.status, this.data, this.list});

  GetSatelliteManagerById.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetSatelliteManagerById>[];
      json['data'].forEach((v) {
        data.add(new DataGetSatelliteManagerById.fromJson(v));
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

class DataGetSatelliteManagerById {
  String name;
  String hRegID;
  String designation;
  String address;
  String emailId;
  String mobile;
  int gender;
  String srNo;

  DataGetSatelliteManagerById(
      {this.name,
        this.hRegID,
        this.designation,
        this.address,
        this.emailId,
        this.mobile,
        this.gender,
        this.srNo});

  DataGetSatelliteManagerById.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hRegID = json['h_Reg_ID'];
    designation = json['designation'];
    address = json['address'];
    emailId = json['email_id'];
    mobile = json['mobile'];
    gender = json['gender'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['h_Reg_ID'] = this.hRegID;
    data['designation'] = this.designation;
    data['address'] = this.address;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['sr_no'] = this.srNo;
    return data;
  }
}