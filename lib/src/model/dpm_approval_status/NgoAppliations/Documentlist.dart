class Documentlist {
  String message;
  bool status;
  List<DataDocumentlist> data;
  Null list;

  Documentlist({this.message, this.status, this.data, this.list});

  Documentlist.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDocumentlist>[];
      json['data'].forEach((v) {
        data.add(new DataDocumentlist.fromJson(v));
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

class DataDocumentlist {
  String darpanNo;
  String filE1;
  String filE2;
  int docId1;
  int docId2;

  DataDocumentlist({this.darpanNo, this.filE1, this.filE2, this.docId1, this.docId2});

  DataDocumentlist.fromJson(Map<String, dynamic> json) {
    darpanNo = json['darpan_no'];
    filE1 = json['filE1'];
    filE2 = json['filE2'];
    docId1 = json['doc_id1'];
    docId2 = json['doc_id2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['darpan_no'] = this.darpanNo;
    data['filE1'] = this.filE1;
    data['filE2'] = this.filE2;
    data['doc_id1'] = this.docId1;
    data['doc_id2'] = this.docId2;
    return data;
  }
}