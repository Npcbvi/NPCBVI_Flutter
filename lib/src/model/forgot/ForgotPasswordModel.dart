class ForgotPasswordModel {
  String message;
  bool status;
  List<ForgotPasswordData> data;

  ForgotPasswordModel({this.message, this.status, this.data});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ForgotPasswordData>[];
      json['data'].forEach((v) {
        data.add(new ForgotPasswordData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ForgotPasswordData {
  String link;
  String detail;

  ForgotPasswordData({this.link, this.detail});

  ForgotPasswordData.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['detail'] = this.detail;
    return data;
  }
}