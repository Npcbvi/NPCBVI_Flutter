class NGOAPPlicationDropDownDPm {
  String message;
  bool status;
  List<DataNGOAPPlicationDropDownDPm> data;

  NGOAPPlicationDropDownDPm({this.message, this.status, this.data});

  NGOAPPlicationDropDownDPm.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataNGOAPPlicationDropDownDPm>[];
      json['data'].forEach((v) {
        data.add(new DataNGOAPPlicationDropDownDPm.fromJson(v));
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

class DataNGOAPPlicationDropDownDPm {
  String npcbNo;
  String darpanNo;
  String name;
  String memberName;
  String emailid;

  DataNGOAPPlicationDropDownDPm({
    this.npcbNo,
    this.darpanNo,
    this.name,
    this.memberName,
    this.emailid
  });

  DataNGOAPPlicationDropDownDPm.fromJson(Map<String, dynamic> json) {
    npcbNo = json['npcbNo'];
    darpanNo = json['darpan_No'];
    name = json['name'];
    memberName = json['member_name'];
    emailid = json['emailid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npcbNo'] = this.npcbNo;
    data['darpan_No'] = this.darpanNo;
    data['name'] = this.name;
    data['member_name'] = this.memberName;
    data['emailid'] = this.emailid;
    return data;
  }
}
