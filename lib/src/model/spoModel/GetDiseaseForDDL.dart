class GetDiseaseForDDL {
  String message;
  bool status;
  List<GetDiseaseForDDLData> data;
  Null list;

  GetDiseaseForDDL({this.message, this.status, this.data, this.list});

  GetDiseaseForDDL.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <GetDiseaseForDDLData>[];
      json['data'].forEach((v) {
        data.add(new GetDiseaseForDDLData.fromJson(v));
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

class GetDiseaseForDDLData {
  String name;
  int id;

  GetDiseaseForDDLData({this.name, this.id});

  GetDiseaseForDDLData.fromJson(Map<String, dynamic> json) {
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


