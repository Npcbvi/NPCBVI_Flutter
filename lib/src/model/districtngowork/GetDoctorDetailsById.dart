class GetDoctorDetailsById {
  String message;
  bool status;
  List<DataGetDoctorDetailsById> data;
  Null list;

  GetDoctorDetailsById({this.message, this.status, this.data, this.list});

  GetDoctorDetailsById.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDoctorDetailsById>[];
      json['data'].forEach((v) {
        data.add(new DataGetDoctorDetailsById.fromJson(v));
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

class DataGetDoctorDetailsById {
  String mcIID;
  String hName;
  String dName;
  String gender;
  String dob;
  String mobile;
  String emailId;
  String districtName;
  String stateName;
  String pincode;

  DataGetDoctorDetailsById(
      {this.mcIID,
        this.hName,
        this.dName,
        this.gender,
        this.dob,
        this.mobile,
        this.emailId,
        this.districtName,
        this.stateName,
        this.pincode});

  DataGetDoctorDetailsById.fromJson(Map<String, dynamic> json) {
    mcIID = json['mcI_ID'];
    hName = json['h_Name'];
    dName = json['d_name'];
    gender = json['gender'];
    dob = json['dob'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcI_ID'] = this.mcIID;
    data['h_Name'] = this.hName;
    data['d_name'] = this.dName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['pincode'] = this.pincode;
    return data;
  }
}