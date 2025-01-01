class GHC_approvalList {
  String message;
  bool status;
  List<GHC_approvalListData> data;
  Null list;

  GHC_approvalList({this.message, this.status, this.data, this.list});

  GHC_approvalList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GHC_approvalListData>[];
      json['data'].forEach((v) {
        data.add(new GHC_approvalListData.fromJson(v));
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

class GHC_approvalListData {
  int districtCode;
  String nodalOfficerName;
  String oName;
  int mobile;
  int stateCode;
  String type;
  String stateName;
  String address;
  String districtName;
  String ngoname;
  String emailId;

  GHC_approvalListData(
      {this.districtCode,
        this.nodalOfficerName,
        this.oName,
        this.mobile,
        this.stateCode,
        this.type,
        this.stateName,
        this.address,
        this.districtName,
        this.ngoname,
        this.emailId});

  GHC_approvalListData.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    nodalOfficerName = json['nodal_officer_name'];
    oName = json['o_Name'];
    mobile = json['mobile'];
    stateCode = json['state_code'];
    type = json['type'];
    stateName = json['state_Name'];
    address = json['address'];
    districtName = json['district_Name'];
    ngoname = json['ngoname'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['o_Name'] = this.oName;
    data['mobile'] = this.mobile;
    data['state_code'] = this.stateCode;
    data['type'] = this.type;
    data['state_Name'] = this.stateName;
    data['address'] = this.address;
    data['district_Name'] = this.districtName;
    data['ngoname'] = this.ngoname;
    data['email_id'] = this.emailId;
    return data;
  }
}