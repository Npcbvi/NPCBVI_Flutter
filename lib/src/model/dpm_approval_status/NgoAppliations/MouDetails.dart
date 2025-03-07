class MouDetails {
  String message;
  bool status;
  List<DataMouDetails> data;
  Null list;

  MouDetails({this.message, this.status, this.data, this.list});

  MouDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataMouDetails>[];
      json['data'].forEach((v) {
        data.add(new DataMouDetails.fromJson(v));
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

class DataMouDetails {
  String file;
  String fromDate;
  String toDate;

  DataMouDetails({this.file, this.fromDate, this.toDate});

  DataMouDetails.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}
