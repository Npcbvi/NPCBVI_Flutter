class ScreenCampRegister {
  String message;
  bool status;
  Null data;
  Null list;

  ScreenCampRegister({this.message, this.status, this.data, this.list});

  ScreenCampRegister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'];
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    data['list'] = this.list;
    return data;
  }
}