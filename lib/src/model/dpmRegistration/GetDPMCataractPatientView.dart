class GetDPMCataractPatientView {
  String message;
  bool status;
  List<DataGetDPMCataractPatientView> data;
  Null list;

  GetDPMCataractPatientView({this.message, this.status, this.data, this.list});

  GetDPMCataractPatientView.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPMCataractPatientView>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPMCataractPatientView.fromJson(v));
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

class DataGetDPMCataractPatientView {
  String pUniqueID;
  String subDistrictName;
  String hName;
  String gender;
  int idproofTypeId;
  String dName;
  String regdate;
  String registeredfor;
  String lastName;
  String districtname;
  String statenae;
  int registrationtype;
  String languagename;
  String name;
  String dob;
  int mobile;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String image;
  String visualAcquityLeftVal;
  String visualAcquityRightVal;
  String ocularLeftVal;
  String ocularRightVal;
  int eyeOperatedUpon;
  String operatedOn;
  String operatedAt;
  int pincode;
  String operationTypeVal;
  String disVaRightVal;
  String disVaLeftVal;
  String disMedicineVal;
  String immediateComplicationVal;
  String visualAcquityLeft;
  String visualAcquityRight;
  String ocularLeft;
  String ocularRight;
  int operationTypeId;
  String sphericalLeft;
  String cylindricalLeft;
  String axisLeft;
  String vaLeft;
  String sphericalLeftVal;
  String cylindricalLeftVal;
  String axisLeftVal;
  String vaLeftVal;
  String sphericalRight;
  String sphericalRightVal;
  String cylindricalRight;
  String cylindricalRightVal;
  String disVaRight;
  String disMedicine;
  String immediateComplication;
  String registrationfor;
  String screeningDate;
  String tentivesurgerydate;
  String axisRight;
  String vaRight;
  String vaRightVal;
  String presentVaLeft;
  String presentVaLeftVal;
  String presentVaRight;
  String presentVaRightVal;
  String followUpDate;
  String followUpPlace;

  DataGetDPMCataractPatientView(
      {this.pUniqueID,
        this.subDistrictName,
        this.hName,
        this.gender,
        this.idproofTypeId,
        this.dName,
        this.regdate,
        this.registeredfor,
        this.lastName,
        this.districtname,
        this.statenae,
        this.registrationtype,
        this.languagename,
        this.name,
        this.dob,
        this.mobile,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.image,
        this.visualAcquityLeftVal,
        this.visualAcquityRightVal,
        this.ocularLeftVal,
        this.ocularRightVal,
        this.eyeOperatedUpon,
        this.operatedOn,
        this.operatedAt,
        this.pincode,
        this.operationTypeVal,
        this.disVaRightVal,
        this.disVaLeftVal,
        this.disMedicineVal,
        this.immediateComplicationVal,
        this.visualAcquityLeft,
        this.visualAcquityRight,
        this.ocularLeft,
        this.ocularRight,
        this.operationTypeId,
        this.sphericalLeft,
        this.cylindricalLeft,
        this.axisLeft,
        this.vaLeft,
        this.sphericalLeftVal,
        this.cylindricalLeftVal,
        this.axisLeftVal,
        this.vaLeftVal,
        this.sphericalRight,
        this.sphericalRightVal,
        this.cylindricalRight,
        this.cylindricalRightVal,
        this.disVaRight,
        this.disMedicine,
        this.immediateComplication,
        this.registrationfor,
        this.screeningDate,
        this.tentivesurgerydate,
        this.axisRight,
        this.vaRight,
        this.vaRightVal,
        this.presentVaLeft,
        this.presentVaLeftVal,
        this.presentVaRight,
        this.presentVaRightVal,
        this.followUpDate,
        this.followUpPlace});

  DataGetDPMCataractPatientView.fromJson(Map<String, dynamic> json) {
    pUniqueID = json['p_Unique_ID'];
    subDistrictName = json['subDistrictName'];
    hName = json['h_Name'];
    gender = json['gender'];
    idproofTypeId = json['idproof_type_id'];
    dName = json['d_Name'];
    regdate = json['regdate'];
    registeredfor = json['registeredfor'];
    lastName = json['last_name'];
    districtname = json['districtname'];
    statenae = json['statenae'];
    registrationtype = json['registrationtype'];
    languagename = json['languagename'];
    name = json['name'];
    dob = json['dob'];
    mobile = json['mobile'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    image = json['image'];
    visualAcquityLeftVal = json['visual_acquity_left_val'];
    visualAcquityRightVal = json['visual_acquity_right_val'];
    ocularLeftVal = json['ocular_left_val'];
    ocularRightVal = json['ocular_right_val'];
    eyeOperatedUpon = json['eye_operated_upon'];
    operatedOn = json['operated_on'];
    operatedAt = json['operated_at'];
    pincode = json['pincode'];
    operationTypeVal = json['operation_type_val'];
    disVaRightVal = json['dis_va_right_val'];
    disVaLeftVal = json['dis_va_left_val'];
    disMedicineVal = json['dis_medicine_val'];
    immediateComplicationVal = json['immediate_complication_val'];
    visualAcquityLeft = json['visual_acquity_left'];
    visualAcquityRight = json['visual_acquity_right'];
    ocularLeft = json['ocular_left'];
    ocularRight = json['ocular_right'];
    operationTypeId = json['operation_type_id'];
    sphericalLeft = json['spherical_left'];
    cylindricalLeft = json['cylindrical_left'];
    axisLeft = json['axis_left'];
    vaLeft = json['va_left'];
    sphericalLeftVal = json['spherical_left_val'];
    cylindricalLeftVal = json['cylindrical_left_val'];
    axisLeftVal = json['axis_left_val'];
    vaLeftVal = json['va_left_val'];
    sphericalRight = json['spherical_right'];
    sphericalRightVal = json['spherical_right_val'];
    cylindricalRight = json['cylindrical_right'];
    cylindricalRightVal = json['cylindrical_right_val'];
    disVaRight = json['dis_va_right'];
    disMedicine = json['dis_medicine'];
    immediateComplication = json['immediate_complication'];
    registrationfor = json['registrationfor'];
    screeningDate = json['screening_date'];
    tentivesurgerydate = json['tentivesurgerydate'];
    axisRight = json['axis_right'];
    vaRight = json['va_right'];
    vaRightVal = json['va_right_val'];
    presentVaLeft = json['present_va_left'];
    presentVaLeftVal = json['present_va_left_val'];
    presentVaRight = json['present_va_right'];
    presentVaRightVal = json['present_va_right_val'];
    followUpDate = json['follow_up_date'];
    followUpPlace = json['follow_up_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_Unique_ID'] = this.pUniqueID;
    data['subDistrictName'] = this.subDistrictName;
    data['h_Name'] = this.hName;
    data['gender'] = this.gender;
    data['idproof_type_id'] = this.idproofTypeId;
    data['d_Name'] = this.dName;
    data['regdate'] = this.regdate;
    data['registeredfor'] = this.registeredfor;
    data['last_name'] = this.lastName;
    data['districtname'] = this.districtname;
    data['statenae'] = this.statenae;
    data['registrationtype'] = this.registrationtype;
    data['languagename'] = this.languagename;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['image'] = this.image;
    data['visual_acquity_left_val'] = this.visualAcquityLeftVal;
    data['visual_acquity_right_val'] = this.visualAcquityRightVal;
    data['ocular_left_val'] = this.ocularLeftVal;
    data['ocular_right_val'] = this.ocularRightVal;
    data['eye_operated_upon'] = this.eyeOperatedUpon;
    data['operated_on'] = this.operatedOn;
    data['operated_at'] = this.operatedAt;
    data['pincode'] = this.pincode;
    data['operation_type_val'] = this.operationTypeVal;
    data['dis_va_right_val'] = this.disVaRightVal;
    data['dis_va_left_val'] = this.disVaLeftVal;
    data['dis_medicine_val'] = this.disMedicineVal;
    data['immediate_complication_val'] = this.immediateComplicationVal;
    data['visual_acquity_left'] = this.visualAcquityLeft;
    data['visual_acquity_right'] = this.visualAcquityRight;
    data['ocular_left'] = this.ocularLeft;
    data['ocular_right'] = this.ocularRight;
    data['operation_type_id'] = this.operationTypeId;
    data['spherical_left'] = this.sphericalLeft;
    data['cylindrical_left'] = this.cylindricalLeft;
    data['axis_left'] = this.axisLeft;
    data['va_left'] = this.vaLeft;
    data['spherical_left_val'] = this.sphericalLeftVal;
    data['cylindrical_left_val'] = this.cylindricalLeftVal;
    data['axis_left_val'] = this.axisLeftVal;
    data['va_left_val'] = this.vaLeftVal;
    data['spherical_right'] = this.sphericalRight;
    data['spherical_right_val'] = this.sphericalRightVal;
    data['cylindrical_right'] = this.cylindricalRight;
    data['cylindrical_right_val'] = this.cylindricalRightVal;
    data['dis_va_right'] = this.disVaRight;
    data['dis_medicine'] = this.disMedicine;
    data['immediate_complication'] = this.immediateComplication;
    data['registrationfor'] = this.registrationfor;
    data['screening_date'] = this.screeningDate;
    data['tentivesurgerydate'] = this.tentivesurgerydate;
    data['axis_right'] = this.axisRight;
    data['va_right'] = this.vaRight;
    data['va_right_val'] = this.vaRightVal;
    data['present_va_left'] = this.presentVaLeft;
    data['present_va_left_val'] = this.presentVaLeftVal;
    data['present_va_right'] = this.presentVaRight;
    data['present_va_right_val'] = this.presentVaRightVal;
    data['follow_up_date'] = this.followUpDate;
    data['follow_up_place'] = this.followUpPlace;
    return data;
  }
}