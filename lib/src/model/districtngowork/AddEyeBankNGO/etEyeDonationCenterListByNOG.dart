class etEyeDonationCenterListByNOG {
  String message;
  bool status;
  List<etEyeDonationCenterListByNOGData> data;
  Null list;

  etEyeDonationCenterListByNOG({this.message, this.status, this.data, this.list});

  etEyeDonationCenterListByNOG.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <etEyeDonationCenterListByNOGData>[];
      json['data'].forEach((v) {
        data.add(new etEyeDonationCenterListByNOGData.fromJson(v));
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

class etEyeDonationCenterListByNOGData {
  String eyeDonationUniqueID;
  String status;
  int statusid;
  String officername;
  String emailid;
  String officermobile;

  etEyeDonationCenterListByNOGData(
      {this.eyeDonationUniqueID,
        this.status,
        this.statusid,
        this.officername,
        this.emailid,
        this.officermobile});

  etEyeDonationCenterListByNOGData.fromJson(Map<String, dynamic> json) {
    eyeDonationUniqueID = json['eyeDonationUnique_ID'];
    status = json['status'];
    statusid = json['statusid'];
    officername = json['officername'];
    emailid = json['emailid'];
    officermobile = json['officermobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eyeDonationUnique_ID'] = this.eyeDonationUniqueID;
    data['status'] = this.status;
    data['statusid'] = this.statusid;
    data['officername'] = this.officername;
    data['emailid'] = this.emailid;
    data['officermobile'] = this.officermobile;
    return data;
  }
}