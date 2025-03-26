class GuilinessPage {
  String message;
  bool status;
  DataGuilinessPage data;
  List<String> list; // Changed from Null to List<String>?

  GuilinessPage({this.message, this.status, this.data, this.list});

  GuilinessPage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataGuilinessPage.fromJson(json['data']) : null;
    list = json['list'] != null ? List<String>.from(json['list']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['list'] = list;
    return data;
  }
}

class DataGuilinessPage {
  List<LstGuidelineFileName> lstGuidelineFileName;
  List<String> lstGuidelineLink; // Changed from List<Null> to List<String>?
  List<String> guideSublineLink; // Changed from List<Null> to List<String>?

  DataGuilinessPage({this.lstGuidelineFileName, this.lstGuidelineLink, this.guideSublineLink});

  DataGuilinessPage.fromJson(Map<String, dynamic> json) {
    if (json['lstGuidelineFileName'] != null) {
      lstGuidelineFileName = [];
      json['lstGuidelineFileName'].forEach((v) {
        lstGuidelineFileName.add(LstGuidelineFileName.fromJson(v));
      });
    }
    lstGuidelineLink = json['lstGuidelineLink'] != null
        ? List<String>.from(json['lstGuidelineLink'])
        : null;

    guideSublineLink = json['guideSublineLink'] != null
        ? List<String>.from(json['guideSublineLink'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (lstGuidelineFileName != null) {
      data['lstGuidelineFileName'] = lstGuidelineFileName.map((v) => v.toJson()).toList();
    }
    data['lstGuidelineLink'] = lstGuidelineLink;
    data['guideSublineLink'] = guideSublineLink;
    return data;
  }
}

class LstGuidelineFileName {
  String filename;
  String link;

  LstGuidelineFileName({this.filename, this.link});

  LstGuidelineFileName.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['filename'] = filename;
    data['link'] = link;
    return data;
  }
}
