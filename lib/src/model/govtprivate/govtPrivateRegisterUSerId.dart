class govtPrivateRegisterUSerId {
  String message;
  bool status;
  List<DatagovtPrivateRegisterUSerId> data;
  Null list;

  govtPrivateRegisterUSerId({this.message, this.status, this.data, this.list});

  govtPrivateRegisterUSerId.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DatagovtPrivateRegisterUSerId>[];
      json['data'].forEach((v) {
        data.add(new DatagovtPrivateRegisterUSerId.fromJson(v));
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

class DatagovtPrivateRegisterUSerId {
  int id;
  int userId;
  int utypeId;
  int orgId;
  String uname;
  String pwd;
  String name;
  String orgName;
  String address;
  String email;
  String status;
  Null mobile;
  int oldStateCode;
  int oldOrgStateId;
  String stateName;
  int oldDistrictCode;
  int oldOrgDistrictId;
  String districtName;
  int lgStateCode;
  String lgStateName;
  int lgDistrictCode;
  String lgDistrictName;

  DatagovtPrivateRegisterUSerId(
      {this.id,
        this.userId,
        this.utypeId,
        this.orgId,
        this.uname,
        this.pwd,
        this.name,
        this.orgName,
        this.address,
        this.email,
        this.status,
        this.mobile,
        this.oldStateCode,
        this.oldOrgStateId,
        this.stateName,
        this.oldDistrictCode,
        this.oldOrgDistrictId,
        this.districtName,
        this.lgStateCode,
        this.lgStateName,
        this.lgDistrictCode,
        this.lgDistrictName});

  DatagovtPrivateRegisterUSerId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    utypeId = json['utype_id'];
    orgId = json['org_id'];
    uname = json['uname'];
    pwd = json['pwd'];
    name = json['name'];
    orgName = json['org_name'];
    address = json['address'];
    email = json['email'];
    status = json['status'];
    mobile = json['mobile'];
    oldStateCode = json['old_StateCode'];
    oldOrgStateId = json['old_org_state_id'];
    stateName = json['stateName'];
    oldDistrictCode = json['old_DistrictCode'];
    oldOrgDistrictId = json['old_org_district_id'];
    districtName = json['districtName'];
    lgStateCode = json['lg_state_code'];
    lgStateName = json['lg_state_name'];
    lgDistrictCode = json['lg_district_code'];
    lgDistrictName = json['lg_district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['utype_id'] = this.utypeId;
    data['org_id'] = this.orgId;
    data['uname'] = this.uname;
    data['pwd'] = this.pwd;
    data['name'] = this.name;
    data['org_name'] = this.orgName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['status'] = this.status;
    data['mobile'] = this.mobile;
    data['old_StateCode'] = this.oldStateCode;
    data['old_org_state_id'] = this.oldOrgStateId;
    data['stateName'] = this.stateName;
    data['old_DistrictCode'] = this.oldDistrictCode;
    data['old_org_district_id'] = this.oldOrgDistrictId;
    data['districtName'] = this.districtName;
    data['lg_state_code'] = this.lgStateCode;
    data['lg_state_name'] = this.lgStateName;
    data['lg_district_code'] = this.lgDistrictCode;
    data['lg_district_name'] = this.lgDistrictName;
    return data;
  }
}