class CenterOfficeNameSatelliteCenter {
  String message;
  bool status;
  List<DataCenterOfficeNameSatelliteCenter> data;
  Null list;

  CenterOfficeNameSatelliteCenter({this.message, this.status, this.data, this.list});

  CenterOfficeNameSatelliteCenter.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCenterOfficeNameSatelliteCenter>[];
      json['data'].forEach((v) {
        data.add(new DataCenterOfficeNameSatelliteCenter.fromJson(v));
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

class DataCenterOfficeNameSatelliteCenter {
  String name;
  int srNo;

  DataCenterOfficeNameSatelliteCenter({this.name, this.srNo});

  DataCenterOfficeNameSatelliteCenter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sr_no'] = this.srNo;
    return data;
  }
}