class SPODashboardDPMClickView {
  String message;
  bool status;
  List<SPODashboardDPMClickViewData> data;
  Null list;

  SPODashboardDPMClickView({this.message, this.status, this.data, this.list});

  SPODashboardDPMClickView.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <SPODashboardDPMClickViewData>[];
      json['data'].forEach((v) {
        data.add(new SPODashboardDPMClickViewData.fromJson(v));
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

class SPODashboardDPMClickViewData {
  String districtName;
  int stateCode;
  int districtCode;
  String stateName;
  String userId;
  String name;
  String address;
  int pincode;
  int mobile;
  int aadhaarNo;
  String designation;
  String emailId;
  String ipAddress;
  String entryBy;
  String status;
  int desstatus;

  SPODashboardDPMClickViewData(
      {this.districtName,
        this.stateCode,
        this.districtCode,
        this.stateName,
        this.userId,
        this.name,
        this.address,
        this.pincode,
        this.mobile,
        this.aadhaarNo,
        this.designation,
        this.emailId,
        this.ipAddress,
        this.entryBy,
        this.status,
        this.desstatus});

  SPODashboardDPMClickViewData.fromJson(Map<String, dynamic> json) {
    districtName = json['district_name'];
    stateCode = json['state_code'];
    districtCode = json['district_code'];
    stateName = json['state_name'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    pincode = json['pincode'];
    mobile = json['mobile'];
    aadhaarNo = json['aadhaar_no'];
    designation = json['designation'];
    emailId = json['email_id'];
    ipAddress = json['ip_address'];
    entryBy = json['entry_by'];
    status = json['status'];
    desstatus = json['desstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    data['district_code'] = this.districtCode;
    data['state_name'] = this.stateName;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['mobile'] = this.mobile;
    data['aadhaar_no'] = this.aadhaarNo;
    data['designation'] = this.designation;
    data['email_id'] = this.emailId;
    data['ip_address'] = this.ipAddress;
    data['entry_by'] = this.entryBy;
    data['status'] = this.status;
    data['desstatus'] = this.desstatus;
    return data;
  }
}