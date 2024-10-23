class GetSatelliteCenterList {
  String message;
  bool status;
  List<DataGetSatelliteCenterList> data;
  Null list;

  GetSatelliteCenterList({this.message, this.status, this.data, this.list});

  GetSatelliteCenterList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetSatelliteCenterList>[];
      json['data'].forEach((v) {
        data.add(new DataGetSatelliteCenterList.fromJson(v));
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

class DataGetSatelliteCenterList {
  String name;
  String districtName;
  String hName;
  String designation;
  String mobile;
  String emailId;
  String srNo;

  DataGetSatelliteCenterList(
      {this.name,
        this.districtName,
        this.hName,
        this.designation,
        this.mobile,
        this.emailId,
        this.srNo});

  DataGetSatelliteCenterList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    districtName = json['district_name'];
    hName = json['h_Name'];
    designation = json['designation'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['district_name'] = this.districtName;
    data['h_Name'] = this.hName;
    data['designation'] = this.designation;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['sr_no'] = this.srNo;
    return data;
  }
}