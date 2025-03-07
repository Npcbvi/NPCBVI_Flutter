class EquipemntDetails {
  String message;
  bool status;
  List<DataEquipemntDetails> data;
  Null list;

  EquipemntDetails({this.message, this.status, this.data, this.list});

  EquipemntDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataEquipemntDetails>[];
      json['data'].forEach((v) {
        data.add(new DataEquipemntDetails.fromJson(v));
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

class DataEquipemntDetails {
  int noOfEuipment;
  int equipmentId;
  String hRegID;
  String name;

  DataEquipemntDetails({this.noOfEuipment, this.equipmentId, this.hRegID, this.name});

  DataEquipemntDetails.fromJson(Map<String, dynamic> json) {
    noOfEuipment = json['no_of_euipment'];
    equipmentId = json['equipment_id'];
    hRegID = json['h_Reg_ID'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_of_euipment'] = this.noOfEuipment;
    data['equipment_id'] = this.equipmentId;
    data['h_Reg_ID'] = this.hRegID;
    data['name'] = this.name;
    return data;
  }
}