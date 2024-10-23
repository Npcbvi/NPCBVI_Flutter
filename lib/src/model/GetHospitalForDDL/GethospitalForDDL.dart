class GethospitalForDDL {
  String message;
  bool status;
  List<DataGethospitalForDDL> data;
  Null list;

  GethospitalForDDL({this.message, this.status, this.data, this.list});

  GethospitalForDDL.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGethospitalForDDL>[];
      json['data'].forEach((v) {
        data.add(new DataGethospitalForDDL.fromJson(v));
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

class DataGethospitalForDDL {
  String hName;
  String hRegID;

  DataGethospitalForDDL({this.hName, this.hRegID});

  DataGethospitalForDDL.fromJson(Map<String, dynamic> json) {
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