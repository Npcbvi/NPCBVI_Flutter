class RegistryDonatiopnCenterClick {
  String message;
  bool status;
  List<RegistryDonatiopnCenterClickData> data;
  Null list;

  RegistryDonatiopnCenterClick({this.message, this.status, this.data, this.list});

  RegistryDonatiopnCenterClick.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <RegistryDonatiopnCenterClickData>[];
      json['data'].forEach((v) {
        data.add(new RegistryDonatiopnCenterClickData.fromJson(v));
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

class RegistryDonatiopnCenterClickData {
  String eyeDonationUniqueID;
  int officermobile;

  RegistryDonatiopnCenterClickData({this.eyeDonationUniqueID, this.officermobile});

  RegistryDonatiopnCenterClickData.fromJson(Map<String, dynamic> json) {
    eyeDonationUniqueID = json['eyeDonationUnique_ID'];
    officermobile = json['officermobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eyeDonationUnique_ID'] = this.eyeDonationUniqueID;
    data['officermobile'] = this.officermobile;
    return data;
  }
}