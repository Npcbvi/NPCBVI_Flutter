class HospitallinkedwithNGO {
  String message;
  bool status;
  DataHospitallinkedwithNGO data;
  dynamic list;

  HospitallinkedwithNGO({this.message, this.status, this.data, this.list});

  HospitallinkedwithNGO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new DataHospitallinkedwithNGO.fromJson(json['data']) : null;
    list = json['list']; // Assuming this can be any data type, so it is left as dynamic.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['list'] = this.list;
    return data;
  }
}


class DataHospitallinkedwithNGO {
  List<HospitalDatalinkedwithNGO> hospitalData;
  List<HospitalEquipmentList> hospitalEquipmentList;

  DataHospitallinkedwithNGO({this.hospitalData, this.hospitalEquipmentList});

  DataHospitallinkedwithNGO.fromJson(Map<String, dynamic> json) {
    if (json['hospitalData'] != null) {
      hospitalData = <HospitalDatalinkedwithNGO>[];
      json['hospitalData'].forEach((v) {
        hospitalData.add(new HospitalDatalinkedwithNGO.fromJson(v));
      });
    }
    if (json['hospitalEquipmentList'] != null) {
      hospitalEquipmentList = <HospitalEquipmentList>[];
      json['hospitalEquipmentList'].forEach((v) {
        hospitalEquipmentList.add(new HospitalEquipmentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospitalData != null) {
      data['hospitalData'] = this.hospitalData.map((v) => v.toJson()).toList();
    }
    if (this.hospitalEquipmentList != null) {
      data['hospitalEquipmentList'] = this.hospitalEquipmentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class HospitalDatalinkedwithNGO {
  String darpanNo;
  String hName;
  String nodalOfficerName;
  String mobile;
  String emailId;
  String address;
  String districtName;
  String stateName;
  int pincode;
  int fax;

  HospitalDatalinkedwithNGO({
    this.darpanNo,
    this.hName,
    this.nodalOfficerName,
    this.mobile,
    this.emailId,
    this.address,
    this.districtName,
    this.stateName,
    this.pincode,
    this.fax,
  });

  HospitalDatalinkedwithNGO.fromJson(Map<String, dynamic> json) {
    darpanNo = json['n_Darpan_No'];
    hName = json['h_Name'];
    nodalOfficerName = json['nodal_officer_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    address = json['address'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    pincode = json['pincode'];
    fax = json['fax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_Darpan_No'] = this.darpanNo;
    data['h_Name'] = this.hName;
    data['nodal_officer_name'] = this.nodalOfficerName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['pincode'] = this.pincode;
    data['fax'] = this.fax;
    return data;
  }
}


class HospitalEquipmentList {
  String name;
  int noOfEquipment; // Adjusted for proper spelling

  HospitalEquipmentList({this.name, this.noOfEquipment});

  HospitalEquipmentList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    noOfEquipment = json['no_of_equipment']; // Adjusted key spelling
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['no_of_equipment'] = this.noOfEquipment; // Adjusted key spelling
    return data;
  }
}
