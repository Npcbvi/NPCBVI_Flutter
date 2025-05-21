class SquintDataReport {
  String message;
  bool status;
  List<SquintDataReportData> data;
  Null list;

  SquintDataReport({this.message, this.status, this.data, this.list});

  SquintDataReport.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SquintDataReportData>[];
      json['data'].forEach((v) {
        data.add(new SquintDataReportData.fromJson(v));
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

class SquintDataReportData {
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
  String deviationEsoExo;
  String deviationEsoExoVal;
  String squinttype;
  String squinttypeVal;
  String disMedicine;
  String disMedicineVal;
  String ngoName;

  SquintDataReportData(
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
        this.deviationEsoExo,
        this.deviationEsoExoVal,
        this.squinttype,
        this.squinttypeVal,
        this.disMedicine,
        this.disMedicineVal,
        this.ngoName});

  SquintDataReportData.fromJson(Map<String, dynamic> json) {
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
    deviationEsoExo = json['deviation_eso_exo'];
    deviationEsoExoVal = json['deviation_eso_exo_val'];
    squinttype = json['squinttype'];
    squinttypeVal = json['squinttype_val'];
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
    data['deviation_eso_exo'] = this.deviationEsoExo;
    data['deviation_eso_exo_val'] = this.deviationEsoExoVal;
    data['squinttype'] = this.squinttype;
    data['squinttype_val'] = this.squinttypeVal;
    data['dis_medicine'] = this.disMedicine;
    data['dis_medicine_val'] = this.disMedicineVal;
    data['ngoName'] = this.ngoName;
    return data;
  }
}