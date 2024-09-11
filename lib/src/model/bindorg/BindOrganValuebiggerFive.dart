class BindOrganValuebiggerFive {
  String message;
  bool status;
  List<DataBindOrganValuebiggerFive> data;
  Null list;

  BindOrganValuebiggerFive({this.message, this.status, this.data, this.list});

  BindOrganValuebiggerFive.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBindOrganValuebiggerFive>[];
      json['data'].forEach((v) {
        data.add(new DataBindOrganValuebiggerFive.fromJson(v));
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

class DataBindOrganValuebiggerFive {
  String oName;
  String npcbNo;

  DataBindOrganValuebiggerFive({this.oName, this.npcbNo});

  DataBindOrganValuebiggerFive.fromJson(Map<String, dynamic> json) {
    oName = json['o_Name'];
    npcbNo = json['npcbNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['o_Name'] = this.oName;
    data['npcbNo'] = this.npcbNo;
    return data;
  }
}
