class NGOAPPRovedClickListDetail {
  String message;
  bool status;
  List<NGOAPPRovedClickListDetailData> data;
  Null list;

  NGOAPPRovedClickListDetail({this.message, this.status, this.data, this.list});

  NGOAPPRovedClickListDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <NGOAPPRovedClickListDetailData>[];
      json['data'].forEach((v) {
        data.add(new NGOAPPRovedClickListDetailData.fromJson(v));
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

class NGOAPPRovedClickListDetailData {
  int stateCode;
  int districtCode;
  int mobile;
  String stateName;
  String districtName;
  String memberName;
  String darpanNo;
  String name;
  String hName;
  String nodalOfficerName;
  String address;
  String emailid;

  NGOAPPRovedClickListDetailData(
      {this.stateCode,
        this.districtCode,
        this.mobile,
        this.stateName,
        this.districtName,
        this.memberName,
        this.darpanNo,
        this.name,
        this.hName,
        this.nodalOfficerName,
        this.address,
        this.emailid});

  NGOAPPRovedClickListDetailData.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    mobile = json['mobile'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
    memberName = json['member_name'];
    darpanNo = json['darpan_no'];
    name = json['name'];
    hName = json['h_name'];
    nodalOfficerName = json['nodal_officer_name'];
    address = json['address'];
    emailid = json['emailid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['mobile'] = this.mobile;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    data['member_name'] = this.memberName;
    data['darpan_no'] = this.darpanNo;
    data['name'] = this.name;
    data['h_name'] = this.hName;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['address'] = this.address;
    data['emailid'] = this.emailid;
    return data;
  }
}