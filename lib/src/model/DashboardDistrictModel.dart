class DashboardDistrictModel {
  String message;
  bool status;
  List<DataDsiricst> data;

  DashboardDistrictModel({this.message, this.status, this.data});

  DashboardDistrictModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataDsiricst>[];
      json['data'].forEach((v) {
        data.add(new DataDsiricst.fromJson(v));
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

class DataDsiricst {
  int districtCode;
  String districtName;
  int stateCode;

  DataDsiricst({this.districtCode, this.districtName, this.stateCode});

  DataDsiricst.fromJson(Map<String, dynamic> json) {
    districtCode = json['district_code'];
    districtName = json['district_name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_code'] = this.districtCode;
    data['district_name'] = this.districtName;
    data['state_code'] = this.stateCode;
    return data;
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // Check if both objects are identical
    return other is DataDsiricst &&
        other.districtCode == districtCode &&
        other.districtName == districtName &&
        other.stateCode == stateCode;
  }

  @override
  int get hashCode {
    // Generate hash code based on fields that are used in equals comparison
    return districtCode.hashCode ^ districtName.hashCode ^ stateCode.hashCode;
  }
  @override
  String toString() {
    return 'DataDsiricst{districtCode: $districtCode, districtName: $districtName, stateCode: $stateCode}';
  }
}