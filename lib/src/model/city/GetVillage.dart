class GetVillage {
  String message;
  bool status;
  List<DataGetVillage> data;
  Null list;

  GetVillage({this.message, this.status, this.data, this.list});

  GetVillage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetVillage>[];
      json['data'].forEach((v) {
        data.add(new DataGetVillage.fromJson(v));
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

class DataGetVillage {
  String name;
  int villageCode;

  DataGetVillage({this.name, this.villageCode});

  DataGetVillage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    villageCode = json['village_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['village_code'] = this.villageCode;
    return data;
  }
}