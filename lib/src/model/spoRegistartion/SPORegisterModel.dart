class SPORegisterModel {
  String message;
  bool status;
  List<SPOData> data;
  Null list;

  SPORegisterModel({this.message, this.status, this.data, this.list});

  SPORegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SPOData>[];
      json['data'].forEach((v) {
        data.add(new SPOData.fromJson(v));
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

class SPOData {
  int srNo;

  SPOData({this.srNo});

  SPOData.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    return data;
  }
}



/*
class SPORegisterModel {
  String message;
  bool status;
  SPOData data;

  SPORegisterModel({this.message, this.status, this.data});

  SPORegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new SPOData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SPOData {
  Null message;
  bool status;
  List<SPOData> data;

  SPOData({this.message, this.status, this.data});

  SPOData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SPOData>[];
      json['data'].forEach((v) {
        data.add(new SPOData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int stateCode;

  Data({this.stateCode});

  Data.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    return data;
  }
}*/
