class ViewClickHospitalDetails {
  String message;
  bool status;
  DataViewClickHospitalDetails data;
  List<dynamic> list; // Adjust this type if you have a specific structure in mind

  ViewClickHospitalDetails({
    this.message,
    this.status,
    this.data,
    this.list,
  });

  ViewClickHospitalDetails.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        status = json['status'],
        data = DataViewClickHospitalDetails.fromJson(json['data']),
        list = json['list'];

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data.toJson(),
      'list': list,
    };
  }
}

class DataViewClickHospitalDetails {
  List<HospitalDetailsDataViewClickHospitalDetails> hospitalDetails;
  List<HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails> hospitalDocuments; // Include it here

  DataViewClickHospitalDetails({
    this.hospitalDetails,
    this.hospitalDocuments,
  });

  DataViewClickHospitalDetails.fromJson(Map<String, dynamic> json)
      : hospitalDetails = (json['hospitalDetails'] as List)
      .map((v) => HospitalDetailsDataViewClickHospitalDetails.fromJson(v))
      .toList(),
        hospitalDocuments = (json['hospitalDocuments'] as List)?.map((v) => HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails.fromJson(v)).toList() ?? []; // Initialize if null

  Map<String, dynamic> toJson() {
    return {
      'hospitalDetails': hospitalDetails.map((v) => v.toJson()).toList(),
      'hospitalDocuments': hospitalDocuments.map((v) => v.toJson()).toList(),
    };
  }
}

class HospitalDetailsDataViewClickHospitalDetails {
  String darpanNo;
  String panNo;
  String ngoName;
  String name;
  String mobile;
  String emailid;
  String address;
  String districtName;
  String stateName;

  HospitalDetailsDataViewClickHospitalDetails({
    this.darpanNo,
    this.panNo,
    this.ngoName,
    this.name,
    this.mobile,
    this.emailid,
    this.address,
    this.districtName,
    this.stateName,
  });

  HospitalDetailsDataViewClickHospitalDetails.fromJson(Map<String, dynamic> json)
      : darpanNo = json['darpan_no'],
        panNo = json['pan_no'],
        ngoName = json['ngoName'],
        name = json['name'],
        mobile = json['mobile'],
        emailid = json['emailid'],
        address = json['address'],
        districtName = json['district_Name'],
        stateName = json['state_Name'];

  Map<String, dynamic> toJson() {
    return {
      'darpan_no': darpanNo,
      'pan_no': panNo,
      'ngoName': ngoName,
      'name': name,
      'mobile': mobile,
      'emailid': emailid,
      'address': address,
      'district_Name': districtName,
      'state_Name': stateName,
    };
  }
}

class HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails {
  int docId1;
  String file1;
  int docId2;
  String file2;

  HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails(int i, {
    this.docId1,
    this.file1,
    this.docId2,
    this.file2,
  });

  HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails.fromJson(Map<String, dynamic> json)
      : docId1 = json['doc_id1'],
        file1 = json['file1'],
        docId2 = json['doc_id2'],
        file2 = json['file2'];

  Map<String, dynamic> toJson() {
    return {
      'doc_id1': docId1,
      'file1': file1,
      'doc_id2': docId2,
      'file2': file2,
    };
  }
}
