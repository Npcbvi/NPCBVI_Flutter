class ContactUS {
  String message;
  bool status;
  List<ContactUsData> data;

  ContactUS({this.message, this.status, this.data});

  ContactUS.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ContactUsData>[];
      json['data'].forEach((v) {
        data.add(new ContactUsData.fromJson(v));
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

class ContactUsData {
  String link;
  String detail;

  ContactUsData({this.link, this.detail});

  ContactUsData.fromJson(Map<String, dynamic> json) {
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