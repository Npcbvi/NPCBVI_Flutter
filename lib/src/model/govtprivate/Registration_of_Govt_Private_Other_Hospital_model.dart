class Registration_of_Govt_Private_Other_Hospital_model {
  String message;
  bool status;
  List<Registration_of_Govt_Private_Other_Hospital_model_Data> data;
  Null list;

  Registration_of_Govt_Private_Other_Hospital_model({this.message, this.status, this.data, this.list});

  Registration_of_Govt_Private_Other_Hospital_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Registration_of_Govt_Private_Other_Hospital_model_Data>[];
      json['data'].forEach((v) {
        data.add(new Registration_of_Govt_Private_Other_Hospital_model_Data.fromJson(v));
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

class Registration_of_Govt_Private_Other_Hospital_model_Data {
  int srNo;

  Registration_of_Govt_Private_Other_Hospital_model_Data({this.srNo});

  Registration_of_Govt_Private_Other_Hospital_model_Data.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}