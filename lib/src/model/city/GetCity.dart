class GetCity {
  String message;
  bool status;
  List<DataGetCity> data;
  dynamic list;

  GetCity({this.message, this.status, this.data, this.list});

  GetCity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGetCity>[];
      json['data'].forEach((v) {
        data.add(DataGetCity.fromJson(v));
      });
    }
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['message'] = message;
    json['status'] = status;
    if (data != null) {
      json['data'] = data.map((v) => v.toJson()).toList();
    }
    json['list'] = list;
    return json;
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
    return {
      'name': name,
      'subdistrict_code': subdistrictCode,
    };
  }

  // ✅ Override equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DataGetCity &&
              runtimeType == other.runtimeType &&
              subdistrictCode == other.subdistrictCode;

  @override
  int get hashCode => subdistrictCode.hashCode;

  @override
  String toString() =>
      'DataGetCity(name: $name, subdistrictCode: $subdistrictCode)';
}
