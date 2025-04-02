class PatientCountDetail {
  String message;
  bool status;
  List<DataPatientCountDetail> data;
  Null list;

  PatientCountDetail({this.message, this.status, this.data, this.list});

  PatientCountDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataPatientCountDetail>[];
      json['data'].forEach((v) {
        data.add(new DataPatientCountDetail.fromJson(v));
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

class DataPatientCountDetail {
  int patientCount;

  DataPatientCountDetail({this.patientCount});

  DataPatientCountDetail.fromJson(Map<String, dynamic> json) {
    patientCount = json['patientCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientCount'] = this.patientCount;
    return data;
  }
}