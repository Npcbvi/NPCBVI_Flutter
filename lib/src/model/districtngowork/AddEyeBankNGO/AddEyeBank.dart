class AddEyeBank {
  String message;
  bool status;
  List<DataAddEyeBank> data;
  Null list;

  AddEyeBank({this.message, this.status, this.data, this.list});

  AddEyeBank.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataAddEyeBank>[];
      json['data'].forEach((v) {
        data.add(new DataAddEyeBank.fromJson(v));
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

class DataAddEyeBank {
  String eyeBankUniqueID;
  String eyebankName;
  String status;
  String officername;
  String emailid;

  DataAddEyeBank(
      {this.eyeBankUniqueID,
        this.eyebankName,
        this.status,
        this.officername,
        this.emailid});

  DataAddEyeBank.fromJson(Map<String, dynamic> json) {
    eyeBankUniqueID = json['eyeBankUnique_ID'];
    eyebankName = json['eyebank_name'];
    status = json['status'];
    officername = json['officername'];
    emailid = json['emailid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eyeBankUnique_ID'] = this.eyeBankUniqueID;
    data['eyebank_name'] = this.eyebankName;
    data['status'] = this.status;
    data['officername'] = this.officername;
    data['emailid'] = this.emailid;
    return data;
  }
}