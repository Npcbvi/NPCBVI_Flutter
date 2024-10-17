class GetCity {
  String message;
  bool status;
  List<DataGetCity> data;
  Null list;

  GetCity({this.message, this.status, this.data, this.list});

  GetCity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetCity>[];
      json['data'].forEach((v) {
        data.add(new DataGetCity.fromJson(v));
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

class DataGetCity {
  String name;
  int subdistrictCode;

  DataGetCity({this.name, this.subdistrictCode});

  DataGetCity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subdistrictCode = json['subdistrict_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subdistrict_code'] = this.subdistrictCode;
    return data;
  }
}