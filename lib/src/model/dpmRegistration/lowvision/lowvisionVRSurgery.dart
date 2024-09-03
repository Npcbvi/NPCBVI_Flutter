class lowvisionVRSurgery {
  String message;
  bool status;
  List<DatalowvisionVRSurgery> data;
  Null list;

  lowvisionVRSurgery({this.message, this.status, this.data, this.list});

  lowvisionVRSurgery.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DatalowvisionVRSurgery>[];
      json['data'].forEach((v) {
        data.add(new DatalowvisionVRSurgery.fromJson(v));
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

class DatalowvisionVRSurgery {
  int id;
  String pUniqueID;
  String name;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String image;
  int eyetype;
  String dob;
  String gender;
  int mobile;
  String ngoName;
  String operatedOn;

  DatalowvisionVRSurgery(
      {this.id,
        this.pUniqueID,
        this.name,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.image,
        this.eyetype,
        this.dob,
        this.gender,
        this.mobile,
        this.ngoName,
        this.operatedOn});

  DatalowvisionVRSurgery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pUniqueID = json['p_Unique_ID'];
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    image = json['image'];
    eyetype = json['eyetype'];
    dob = json['dob'];
    gender = json['gender'];
    mobile = json['mobile'];
    ngoName = json['ngoName'];
    operatedOn = json['operated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_Unique_ID'] = this.pUniqueID;
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['image'] = this.image;
    data['eyetype'] = this.eyetype;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['ngoName'] = this.ngoName;
    data['operated_on'] = this.operatedOn;
    return data;
  }
}