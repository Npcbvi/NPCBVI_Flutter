class GovtPRivateModel {
  String message;
  bool status;
  Null data;
  List<ListGovtPRivateModel> list;

  GovtPRivateModel({this.message, this.status, this.data, this.list});

  GovtPRivateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'];
    if (json['list'] != null) {
      list = <ListGovtPRivateModel>[];
      json['list'].forEach((v) {
        list.add(new ListGovtPRivateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListGovtPRivateModel {
  int id;
  String name;
  String quantity;
  ListGovtPRivateModel({this.id, this.name,this.quantity = ''});

  ListGovtPRivateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}