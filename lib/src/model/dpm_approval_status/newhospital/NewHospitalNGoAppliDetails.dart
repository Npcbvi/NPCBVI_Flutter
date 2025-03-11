class NewHospitalNGoAppliDetails {
  String message;
  bool status;
  List<DataNewHospitalNGoAppliDetails> data;
  Null list;

  NewHospitalNGoAppliDetails({this.message, this.status, this.data, this.list});

  NewHospitalNGoAppliDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataNewHospitalNGoAppliDetails>[];
      json['data'].forEach((v) {
        data.add(new DataNewHospitalNGoAppliDetails.fromJson(v));
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

class DataNewHospitalNGoAppliDetails {
  String darpanNo;
  String panNo;
  String ngoName;
  String memberName;
  String emailid;
  int mobile;
  String address;
  String npcbNo;
  String stateName;
  String districtName;

  DataNewHospitalNGoAppliDetails(
      {this.darpanNo,
        this.panNo,
        this.ngoName,
        this.memberName,
        this.emailid,
        this.mobile,
        this.address,
        this.npcbNo,
        this.stateName,
        this.districtName});

  DataNewHospitalNGoAppliDetails.fromJson(Map<String, dynamic> json) {
    darpanNo = json['darpan_No'];
    panNo = json['pan_no'];
    ngoName = json['ngoName'];
    memberName = json['member_name'];
    emailid = json['emailid'];
    mobile = json['mobile'];
    address = json['address'];
    npcbNo = json['npcbNo'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['darpan_No'] = this.darpanNo;
    data['pan_no'] = this.panNo;
    data['ngoName'] = this.ngoName;
    data['member_name'] = this.memberName;
    data['emailid'] = this.emailid;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['npcbNo'] = this.npcbNo;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}