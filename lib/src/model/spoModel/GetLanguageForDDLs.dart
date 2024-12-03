class GetLanguageForDDLs {
  String message;
  bool status;
  List<GetLanguageForDDLsDatas> data;
  Null list;

  GetLanguageForDDLs({this.message, this.status, this.data, this.list});

  GetLanguageForDDLs.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetLanguageForDDLsDatas>[];
      json['data'].forEach((v) {
        data.add(new GetLanguageForDDLsDatas.fromJson(v));
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

class GetLanguageForDDLsDatas {
  String name;
  int id;

  GetLanguageForDDLsDatas({this.name, this.id});

  GetLanguageForDDLsDatas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}