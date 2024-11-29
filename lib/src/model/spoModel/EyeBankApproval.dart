class EyeBankApproval {
  String message;
  bool status;
  List<EyeBankApprovalDataData> data;
  Null list;

  EyeBankApproval({this.message, this.status, this.data, this.list});

  EyeBankApproval.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <EyeBankApprovalDataData>[];
      json['data'].forEach((v) {
        data.add(new EyeBankApprovalDataData.fromJson(v));
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

class EyeBankApprovalDataData {
  String eyeBankUniqueID;
  String emailid;
  String eyebankName;
  String officername;
  int officermobile;
  String stateName;
  String districtName;

  EyeBankApprovalDataData(
      {this.eyeBankUniqueID,
        this.emailid,
        this.eyebankName,
        this.officername,
        this.officermobile,
        this.stateName,
        this.districtName});

  EyeBankApprovalDataData.fromJson(Map<String, dynamic> json) {
    eyeBankUniqueID = json['eyeBankUnique_ID'];
    emailid = json['emailid'];
    eyebankName = json['eyebank_name'];
    officername = json['officername'];
    officermobile = json['officermobile'];
    stateName = json['state_Name'];
    districtName = json['district_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eyeBankUnique_ID'] = this.eyeBankUniqueID;
    data['emailid'] = this.emailid;
    data['eyebank_name'] = this.eyebankName;
    data['officername'] = this.officername;
    data['officermobile'] = this.officermobile;
    data['state_Name'] = this.stateName;
    data['district_Name'] = this.districtName;
    return data;
  }
}