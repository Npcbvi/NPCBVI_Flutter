class DropDownHospitalSelected {
  String message;
  bool status;
  List<DataDropDownHospitalSelected> data;
  Null list;

  DropDownHospitalSelected({this.message, this.status, this.data, this.list});

  DropDownHospitalSelected.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDropDownHospitalSelected>[];
      json['data'].forEach((v) {
        data.add(new DataDropDownHospitalSelected.fromJson(v));
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

class DataDropDownHospitalSelected {
  String hName;
  String hRegID;

  DataDropDownHospitalSelected({this.hName, this.hRegID});

  DataDropDownHospitalSelected.fromJson(Map<String, dynamic> json) {
    hName = json['h_Name'];
    hRegID = json['h_Reg_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_Name'] = this.hName;
    data['h_Reg_ID'] = this.hRegID;
    return data;
  }
}