class CornealBlindnessDataReport {
  String message;
  bool status;
  List<CornealBlindnessDataReportData> data;
  dynamic list;

  CornealBlindnessDataReport({this.message, this.status, this.data, this.list});

  CornealBlindnessDataReport.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CornealBlindnessDataReportData>[];
      json['data'].forEach((v) {
        data.add(new CornealBlindnessDataReportData.fromJson(v));
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

class CornealBlindnessDataReportData {
  int id;
  String pUniqueID;
  String name;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String image;
  int eyetype;
  String dob;
  String gender;
  int mobile;
  String campId;
  int registrationType;
  String operatedOn;
  String vstatus;
  String visualAcquityBeforlaser;
  String visualAcquityBeforlaserVal;
  String visualAcquityAfterlaser;
  String visualAcquityAfterlaserVal;
  String disMedicine;
  String disMedicineVal;
  String ngoName;

  CornealBlindnessDataReportData(
      {this.id,
        this.pUniqueID,
        this.name,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.image,
        this.eyetype,
        this.dob,
        this.gender,
        this.mobile,
        this.campId,
        this.registrationType,
        this.operatedOn,
        this.vstatus,
        this.visualAcquityBeforlaser,
        this.visualAcquityBeforlaserVal,
        this.visualAcquityAfterlaser,
        this.visualAcquityAfterlaserVal,
        this.disMedicine,
        this.disMedicineVal,
        this.ngoName});

  CornealBlindnessDataReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pUniqueID = json['p_Unique_ID'];
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    image = json['image'];
    eyetype = json['eyetype'];
    dob = json['dob'];
    gender = json['gender'];
    mobile = json['mobile'];
    campId = json['camp_id'];
    registrationType = json['registration_type'];
    operatedOn = json['operated_on'];
    vstatus = json['vstatus'];
    visualAcquityBeforlaser = json['visual_acquity_beforlaser'];
    visualAcquityBeforlaserVal = json['visual_acquity_beforlaser_val'];
    visualAcquityAfterlaser = json['visual_acquity_afterlaser'];
    visualAcquityAfterlaserVal = json['visual_acquity_afterlaser_val'];
    disMedicine = json['dis_medicine'];
    disMedicineVal = json['dis_medicine_val'];
    ngoName = json['ngoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_Unique_ID'] = this.pUniqueID;
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['image'] = this.image;
    data['eyetype'] = this.eyetype;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['camp_id'] = this.campId;
    data['registration_type'] = this.registrationType;
    data['operated_on'] = this.operatedOn;
    data['vstatus'] = this.vstatus;
    data['visual_acquity_beforlaser'] = this.visualAcquityBeforlaser;
    data['visual_acquity_beforlaser_val'] = this.visualAcquityBeforlaserVal;
    data['visual_acquity_afterlaser'] = this.visualAcquityAfterlaser;
    data['visual_acquity_afterlaser_val'] = this.visualAcquityAfterlaserVal;
    data['dis_medicine'] = this.disMedicine;
    data['dis_medicine_val'] = this.disMedicineVal;
    data['ngoName'] = this.ngoName;
    return data;
  }
}