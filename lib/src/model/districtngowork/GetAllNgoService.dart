class GetAllNgoService {
  String message;
  bool status;
  List<DataGetAllNgoService> data;
  Null list;

  GetAllNgoService({this.message, this.status, this.data, this.list});

  GetAllNgoService.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetAllNgoService>[];
      json['data'].forEach((v) {
        data.add(new DataGetAllNgoService.fromJson(v));
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

class DataGetAllNgoService {
  String name;

  DataGetAllNgoService({this.name});

  DataGetAllNgoService.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}