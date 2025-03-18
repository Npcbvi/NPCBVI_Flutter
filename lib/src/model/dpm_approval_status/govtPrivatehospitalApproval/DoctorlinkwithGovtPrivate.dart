class DoctorlinkwithGovtPrivate {
  String message;
  bool status;
  List<DataDoctorlinkwithGovtPrivate> data;
  Null list;

  DoctorlinkwithGovtPrivate({this.message, this.status, this.data, this.list});

  DoctorlinkwithGovtPrivate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDoctorlinkwithGovtPrivate>[];
      json['data'].forEach((v) {
        data.add(new DataDoctorlinkwithGovtPrivate.fromJson(v));
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

class DataDoctorlinkwithGovtPrivate {
  int srNo;
  String mcIIDX;
  String document;
  String nDarpanNo;
  String hRegID;
  String dName;
  String dob;
  int gender;
  Null designation;
  String aadhaar;
  int mobile;
  String emailId;
  int status;
  int stateCode;
  int districtCode;
  String pincode;
  String npcbNo;
  int roleId;
  String mcIID;
  String orgType;
  int sNo;
  int pMobile;
  String address;
  int fax;
  String pEmail;
  int pPincode;
  String nodalOfficerName;
  int pStatus;
  int pRoleId;
  int pNinno;
  String oldUserId;
  int oldNpcbUserid;
  String stateName;
  String districtName;
  String hName;

  DataDoctorlinkwithGovtPrivate(
      {this.srNo,
        this.mcIIDX,
        this.document,
        this.nDarpanNo,
        this.hRegID,
        this.dName,
        this.dob,
        this.gender,
        this.designation,
        this.aadhaar,
        this.mobile,
        this.emailId,
        this.status,
        this.stateCode,
        this.districtCode,
        this.pincode,
        this.npcbNo,
        this.roleId,
        this.mcIID,
        this.orgType,
        this.sNo,
        this.pMobile,
        this.address,
        this.fax,
        this.pEmail,
        this.pPincode,
        this.nodalOfficerName,
        this.pStatus,
        this.pRoleId,
        this.pNinno,
        this.oldUserId,
        this.oldNpcbUserid,
        this.stateName,
        this.districtName,
        this.hName});

  DataDoctorlinkwithGovtPrivate.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
    mcIIDX = json['mcI_ID_X'];
    document = json['document'];
    nDarpanNo = json['n_Darpan_No'];
    hRegID = json['h_Reg_ID'];
    dName = json['d_name'];
    dob = json['dob'];
    gender = json['gender'];
    designation = json['designation'];
    aadhaar = json['aadhaar'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    status = json['status'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    pincode = json['pincode'];
    npcbNo = json['npcbNo'];
    roleId = json['role_id'];
    mcIID = json['mcI_ID'];
    orgType = json['org_type'];
    sNo = json['sNo'];
    npcbNo = json['npcb_no'];
    pMobile = json['p_mobile'];
    address = json['address'];
    fax = json['fax'];
    pEmail = json['p_Email'];
    pPincode = json['p_pincode'];
    nodalOfficerName = json['nodal_officer_name'];
    pStatus = json['p_status'];
    pRoleId = json['p_role_id'];
    pNinno = json['p_ninno'];
    oldUserId = json['old_user_id'];
    oldNpcbUserid = json['old_npcb_userid'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
    hName = json['h_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    data['mcI_ID_X'] = this.mcIIDX;
    data['document'] = this.document;
    data['n_Darpan_No'] = this.nDarpanNo;
    data['h_Reg_ID'] = this.hRegID;
    data['d_name'] = this.dName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['designation'] = this.designation;
    data['aadhaar'] = this.aadhaar;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['status'] = this.status;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['pincode'] = this.pincode;
    data['npcbNo'] = this.npcbNo;
    data['role_id'] = this.roleId;
    data['mcI_ID'] = this.mcIID;
    data['org_type'] = this.orgType;
    data['sNo'] = this.sNo;
    data['npcb_no'] = this.npcbNo;
    data['p_mobile'] = this.pMobile;
    data['address'] = this.address;
    data['fax'] = this.fax;
    data['p_Email'] = this.pEmail;
    data['p_pincode'] = this.pPincode;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['p_status'] = this.pStatus;
    data['p_role_id'] = this.pRoleId;
    data['p_ninno'] = this.pNinno;
    data['old_user_id'] = this.oldUserId;
    data['old_npcb_userid'] = this.oldNpcbUserid;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    data['h_Name'] = this.hName;
    return data;
  }
}