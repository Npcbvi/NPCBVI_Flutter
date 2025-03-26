class SpoListwise {
  String message;
  bool status;
  List<SpoListwiseData> data;
  Null list;

  SpoListwise({this.message, this.status, this.data, this.list});

  SpoListwise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SpoListwiseData>[];
      json['data'].forEach((v) {
        data.add(new SpoListwiseData.fromJson(v));
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

class SpoListwiseData {
  int stateCode;
  String stateName;
  String name;
  String officeAddress;
  String emailId;
  String mobile;
  String entry_date;


  SpoListwiseData(
      {this.stateCode,
        this.stateName,
        this.name,
        this.officeAddress,
        this.emailId,
        this.mobile,
      this.entry_date});

  SpoListwiseData.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    stateName = json['state_name'];
    name = json['name'];
    officeAddress = json['office_address'];
    emailId = json['email_id'];
    mobile = json['mobile'];
    entry_date = json['entry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['name'] = this.name;
    data['office_address'] = this.officeAddress;
    data['email_id'] = this.emailId;
    data['mobile'] = this.mobile;
    data['entry_date'] = this.entry_date;
    return data;
  }
}