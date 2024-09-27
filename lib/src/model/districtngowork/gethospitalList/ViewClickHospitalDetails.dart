class ViewClickHospitalDetails {
  String message;
  bool status;
  DataViewClickHospitalDetails data;
  List<dynamic> list; // Change to a meaningful type if applicable

  ViewClickHospitalDetails({this.message, this.status, this.data, this.list});

  ViewClickHospitalDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null
        ? DataViewClickHospitalDetails.fromJson(json['data'])
        : null;
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['list'] = this.list; // Ensure proper handling if list is needed
    return data;
  }
}

class DataViewClickHospitalDetails {
  List<HospitalDetailsDataViewClickHospitalDetails> hospitalDetails;
  List<HospitalDetailsDataViewClickHospitalDetails> hospitalDocuments;

  DataViewClickHospitalDetails({this.hospitalDetails, this.hospitalDocuments});

  DataViewClickHospitalDetails.fromJson(Map<String, dynamic> json) {
    if (json['hospitalDetails'] != null) {
      hospitalDetails = <HospitalDetailsDataViewClickHospitalDetails>[];
      json['hospitalDetails'].forEach((v) {
        hospitalDetails.add(HospitalDetailsDataViewClickHospitalDetails.fromJson(v));
      });
    }
    if (json['hospitalDocuments'] != null) {
      hospitalDocuments = <HospitalDetailsDataViewClickHospitalDetails>[];
      json['hospitalDocuments'].forEach((v) {
        hospitalDocuments.add(HospitalDetailsDataViewClickHospitalDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.hospitalDetails != null) { // Fixed condition
      data['hospitalDetails'] = this.hospitalDetails.map((v) => v.toJson()).toList();
    }
    if (this.hospitalDocuments != null) { // Fixed condition
      data['hospitalDocuments'] = this.hospitalDocuments.map((v) => v.toJson()).toList();
    }
    return data;
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

  HospitalDetailsDataViewClickHospitalDetails.fromJson(Map<String, dynamic> json) {
    darpanNo = json['darpan_no'];
    panNo = json['pan_no'];
    ngoName = json['ngoName'];
    name = json['name'];
    mobile = json['mobile'];
    emailid = json['emailid'];
    address = json['address'];
    districtName = json['district_Name'];
    stateName = json['state_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['darpan_no'] = this.darpanNo;
    data['pan_no'] = this.panNo;
    data['ngoName'] = this.ngoName;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['emailid'] = this.emailid;
    data['address'] = this.address;
    data['district_Name'] = this.districtName;
    data['state_Name'] = this.stateName;
    return data;
  }
}

class HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails {
  int docId1;
  String file1;
  int docId2;
  String file2;

  HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails({
    this.docId1,
    this.file1,
    this.docId2,
    this.file2,
  });

  HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails.fromJson(Map<String, dynamic> json) {
    docId1 = json['doc_id1'];
    file1 = json['file1'];
    docId2 = json['doc_id2'];
    file2 = json['file2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doc_id1'] = this.docId1;
    data['file1'] = this.file1;
    data['doc_id2'] = this.docId2;
    data['file2'] = this.file2;
    return data;
  }
}
