class RetinopathyofPermaturityPdf {
  String message;
  bool status;
  List<RetinopathyofPermaturityPdfData> data;
  dynamic list;

  RetinopathyofPermaturityPdf({this.message, this.status, this.data, this.list});

  RetinopathyofPermaturityPdf.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <RetinopathyofPermaturityPdfData>[];
      json['data'].forEach((v) {
        data.add(new RetinopathyofPermaturityPdfData.fromJson(v));
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

class RetinopathyofPermaturityPdfData {
  int srNo;
  String campId;
  String pUniqueID;
  String name;
  String lastName;
  String guardianName;
  int registrationType;
  String hRegID;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String aadhaarNo;
  String screeningDate;
  int villageCode;
  int townCode;
  int pincode;
  int blockCode;
  String npcbNo;
  int language;
  int vstatus;
  int diseaseId;
  String dob;
  String reportingplace;
  int orgType;
  int programmID;
  String subDistrictName;
  String hName;
  String gender;
  int idproofTypeId;
  String dName;
  String regdate;
  String districtname;
  String statenae;
  int registrationtype;
  String languagename;
  String registrationfor;
  String ngoAddress;
  int ngomobile;
  String ngoname;
  String visualAcquityAfterlaser;
  String visualAcquityBeforlaser;
  dynamic vl3;
  dynamic vr2;

  RetinopathyofPermaturityPdfData(
      {this.srNo,
        this.campId,
        this.pUniqueID,
        this.name,
        this.lastName,
        this.guardianName,
        this.registrationType,
        this.hRegID,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.aadhaarNo,
        this.screeningDate,
        this.villageCode,
        this.townCode,
        this.pincode,
        this.blockCode,
        this.npcbNo,
        this.language,
        this.vstatus,
        this.diseaseId,
        this.dob,
        this.reportingplace,
        this.orgType,
        this.programmID,
        this.subDistrictName,
        this.hName,
        this.gender,
        this.idproofTypeId,
        this.dName,
        this.regdate,
        this.districtname,
        this.statenae,
        this.registrationtype,
        this.languagename,
        this.registrationfor,
        this.ngoAddress,
        this.ngomobile,
        this.ngoname,
        this.visualAcquityAfterlaser,
        this.visualAcquityBeforlaser,
        this.vl3,
        this.vr2});

  RetinopathyofPermaturityPdfData.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
    campId = json['camp_id'];
    pUniqueID = json['p_Unique_ID'];
    name = json['name'];
    lastName = json['last_name'];
    guardianName = json['guardian_name'];
    registrationType = json['registration_type'];
    hRegID = json['h_Reg_ID'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    aadhaarNo = json['aadhaar_no'];
    screeningDate = json['screening_date'];
    villageCode = json['village_code'];
    townCode = json['town_code'];
    pincode = json['pincode'];
    blockCode = json['block_code'];
    npcbNo = json['npcbNo'];
    language = json['language'];
    vstatus = json['vstatus'];
    diseaseId = json['disease_id'];
    dob = json['dob'];
    reportingplace = json['reportingplace'];
    orgType = json['org_type'];
    programmID = json['programmID'];
    subDistrictName = json['subDistrictName'];
    hName = json['h_Name'];
    gender = json['gender'];
    idproofTypeId = json['idproof_type_id'];
    dName = json['d_Name'];
    regdate = json['regdate'];
    districtname = json['districtname'];
    statenae = json['statenae'];
    registrationtype = json['registrationtype'];
    languagename = json['languagename'];
    registrationfor = json['registrationfor'];
    ngoAddress = json['ngoAddress'];
    ngomobile = json['ngomobile'];
    ngoname = json['ngoname'];
    visualAcquityAfterlaser = json['visual_acquity_afterlaser'];
    visualAcquityBeforlaser = json['visual_acquity_beforlaser'];
    vl3 = json['vl3'];
    vr2 = json['vr2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    data['camp_id'] = this.campId;
    data['p_Unique_ID'] = this.pUniqueID;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['guardian_name'] = this.guardianName;
    data['registration_type'] = this.registrationType;
    data['h_Reg_ID'] = this.hRegID;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['aadhaar_no'] = this.aadhaarNo;
    data['screening_date'] = this.screeningDate;
    data['village_code'] = this.villageCode;
    data['town_code'] = this.townCode;
    data['pincode'] = this.pincode;
    data['block_code'] = this.blockCode;
    data['npcbNo'] = this.npcbNo;
    data['language'] = this.language;
    data['vstatus'] = this.vstatus;
    data['disease_id'] = this.diseaseId;
    data['dob'] = this.dob;
    data['reportingplace'] = this.reportingplace;
    data['org_type'] = this.orgType;
    data['programmID'] = this.programmID;
    data['subDistrictName'] = this.subDistrictName;
    data['h_Name'] = this.hName;
    data['gender'] = this.gender;
    data['idproof_type_id'] = this.idproofTypeId;
    data['d_Name'] = this.dName;
    data['regdate'] = this.regdate;
    data['districtname'] = this.districtname;
    data['statenae'] = this.statenae;
    data['registrationtype'] = this.registrationtype;
    data['languagename'] = this.languagename;
    data['registrationfor'] = this.registrationfor;
    data['ngoAddress'] = this.ngoAddress;
    data['ngomobile'] = this.ngomobile;
    data['ngoname'] = this.ngoname;
    data['visual_acquity_afterlaser'] = this.visualAcquityAfterlaser;
    data['visual_acquity_beforlaser'] = this.visualAcquityBeforlaser;
    data['vl3'] = this.vl3;
    data['vr2'] = this.vr2;
    return data;
  }
}