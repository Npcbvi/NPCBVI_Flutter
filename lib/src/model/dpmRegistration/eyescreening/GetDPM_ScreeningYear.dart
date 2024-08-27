class GetDPM_ScreeningYear {
  String message;
  bool status;
  List<DataGetDPM_ScreeningYear> data;
  Null list;

  GetDPM_ScreeningYear({this.message, this.status, this.data, this.list});

  GetDPM_ScreeningYear.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetDPM_ScreeningYear>[];
      json['data'].forEach((v) {
        data.add(new DataGetDPM_ScreeningYear.fromJson(v));
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

class DataGetDPM_ScreeningYear {
  int id;
  String name;
  String fyid;

  DataGetDPM_ScreeningYear({this.id, this.name, this.fyid});

  DataGetDPM_ScreeningYear.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fyid = json['fyid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fyid'] = this.fyid;
    return data;
  }
}