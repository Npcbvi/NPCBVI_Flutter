class DoctorlinkedwithHospital {
  String message;
  bool status;
  List<DataDoctorlinkedwithHospital> data;
  Null list;

  DoctorlinkedwithHospital({this.message, this.status, this.data, this.list});

  DoctorlinkedwithHospital.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDoctorlinkedwithHospital>[];
      json['data'].forEach((v) {
        data.add(new DataDoctorlinkedwithHospital.fromJson(v));
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

class DataDoctorlinkedwithHospital {
  String mcIID;
  String hRegID;
  String dName;
  String mobile;
  String emailId;

  DataDoctorlinkedwithHospital({this.mcIID, this.hRegID, this.dName, this.mobile, this.emailId});

  DataDoctorlinkedwithHospital.fromJson(Map<String, dynamic> json) {
    mcIID = json['mcI_ID'];
    hRegID = json['h_Reg_ID'];
    dName = json['d_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcI_ID'] = this.mcIID;
    data['h_Reg_ID'] = this.hRegID;
    data['d_name'] = this.dName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    return data;
  }
}