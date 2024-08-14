class GetDPM_NGOAPProved_pending {
  String message;
  bool status;
  List<DataGetDPM_NGOAPProved_pending> data;
  Null list;

  GetDPM_NGOAPProved_pending({this.message, this.status, this.data, this.list});

  GetDPM_NGOAPProved_pending.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_NGOAPProved_pending>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_NGOAPProved_pending.fromJson(v));
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

class DataGetDPM_NGOAPProved_pending {
  int districtCode;
  String memberName;
  String darpanNo;
  int stateCode;
  String stateName;
  String name;
  String districtName;
  String hName;
  String nodalOfficerName;
  String address;
  String emailid;
  int mobile;

  DataGetDPM_NGOAPProved_pending(
      {this.districtCode,
        this.memberName,
        this.darpanNo,
        this.stateCode,
        this.stateName,
        this.name,
        this.districtName,
        this.hName,
        this.nodalOfficerName,
        this.address,
        this.emailid,
        this.mobile});

  DataGetDPM_NGOAPProved_pending.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    memberName = json['member_name'];
    darpanNo = json['darpan_no'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    name = json['name'];
    districtName = json['district_name'];
    hName = json['h_name'];
    nodalOfficerName = json['nodal_officer_name'];
    address = json['address'];
    emailid = json['emailid'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['member_name'] = this.memberName;
    data['darpan_no'] = this.darpanNo;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['name'] = this.name;
    data['district_name'] = this.districtName;
    data['h_name'] = this.hName;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['address'] = this.address;
    data['emailid'] = this.emailid;
    data['mobile'] = this.mobile;
    return data;
  }
}