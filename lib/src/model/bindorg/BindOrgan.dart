class BindOrgan {
  String message;
  bool status;
  List<DataBindOrgan> data;
  Null list;

  BindOrgan({this.message, this.status, this.data, this.list});

  BindOrgan.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBindOrgan>[];
      json['data'].forEach((v) {
        data.add(new DataBindOrgan.fromJson(v));
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

class DataBindOrgan {
  String name;
  String npcbNo;

  DataBindOrgan({this.name, this.npcbNo});

  DataBindOrgan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    npcbNo = json['npcbNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['npcbNo'] = this.npcbNo;
    return data;
  }
}