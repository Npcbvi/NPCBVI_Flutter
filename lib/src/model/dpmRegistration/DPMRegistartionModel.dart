class DPMRegistartionModel {
  String message;
  bool status;
 /* List<DataDPM> data;
  Null list;*/

  DPMRegistartionModel({this.message, this.status/*, this.data, this.list*/});

  DPMRegistartionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
   /* if (json['data'] != null) {
      data = <DataDPM>[];
      json['data'].forEach((v) {
        data.add(new DataDPM.fromJson(v));
      });
    }
    list = json['list'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
  /*  if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['list'] = this.list;*/
    return data;
  }
}

/*class DataDPM {
  int srNo;

  DataDPM({this.srNo});

  DataDPM.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}*/

/*
class DPMRegistartionModel {
  String message;
  bool status;
  DataDPM data;

  DPMRegistartionModel({this.message, this.status, this.data});

  DPMRegistartionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new DataDPM.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data = null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataDPM {
  Null message;
  bool status;
  List<DataDPM> data;

  DataDPM({this.message, this.status, this.data});

  DataDPM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDPM>[];
      json['data'].forEach((v) {
        data.add(new DataDPM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data = null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int stateCode;
  int districtCode;

  Data({this.stateCode, this.districtCode});

  Data.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    return data;
  }
}*/
