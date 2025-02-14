class Dpm_application_ngoApplications {
  String message;
  bool status;
  List<Dpm_application_ngoApplicationsData> data;
  Null list;

  Dpm_application_ngoApplications({this.message, this.status, this.data, this.list});

  Dpm_application_ngoApplications.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Dpm_application_ngoApplicationsData>[];
      json['data'].forEach((v) {
        data.add(new Dpm_application_ngoApplicationsData.fromJson(v));
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

class Dpm_application_ngoApplicationsData {
  String npcbNo;
  String emailid;
  String memberName;
  String name;
  String darpanNo;

  Dpm_application_ngoApplicationsData({this.npcbNo, this.emailid, this.memberName, this.name, this.darpanNo});

  Dpm_application_ngoApplicationsData.fromJson(Map<String, dynamic> json) {
    npcbNo = json['npcbNo'];
    emailid = json['emailid'];
    memberName = json['member_name'];
    name = json['name'];
    darpanNo = json['darpan_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npcbNo'] = this.npcbNo;
    data['emailid'] = this.emailid;
    data['member_name'] = this.memberName;
    data['name'] = this.name;
    data['darpan_no'] = this.darpanNo;
    return data;
  }
}