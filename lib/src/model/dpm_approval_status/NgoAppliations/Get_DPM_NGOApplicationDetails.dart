class Get_DPM_NGOApplicationDetails {
  String message;
  bool status;
  List<DataGet_DPM_NGOApplicationDetails> data;
  Null list;

  Get_DPM_NGOApplicationDetails({this.message, this.status, this.data, this.list});

  Get_DPM_NGOApplicationDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGet_DPM_NGOApplicationDetails>[];
      json['data'].forEach((v) {
        data.add(new DataGet_DPM_NGOApplicationDetails.fromJson(v));
      });
    }
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data = null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['list'] = this.list;
    return data;
  }
}

class DataGet_DPM_NGOApplicationDetails {
  String darpanNo;
  String panNo;
  String ngoName;
  String stateName;
  String districtName;
  String address;
  String mobile;
  String emailid;
  String name;

  DataGet_DPM_NGOApplicationDetails(
      {this.darpanNo,
        this.panNo,
        this.ngoName,
        this.stateName,
        this.districtName,
        this.address,
        this.mobile,
        this.emailid,
        this.name});

  DataGet_DPM_NGOApplicationDetails.fromJson(Map<String, dynamic> json) {
    darpanNo = json['darpan_no'];
    panNo = json['pan_no'];
    ngoName = json['ngoName'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
    address = json['address'];
    mobile = json['mobile'];
    emailid = json['emailid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['darpan_no'] = this.darpanNo;
    data['pan_no'] = this.panNo;
    data['ngoName'] = this.ngoName;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['emailid'] = this.emailid;
    data['name'] = this.name;
    return data;
  }
}