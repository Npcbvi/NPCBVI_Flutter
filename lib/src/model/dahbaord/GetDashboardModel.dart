class GetDashboardModel {
  String message;
  bool status;
  Data data;

  GetDashboardModel({this.message, this.status, this.data});

  GetDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String ngoCount;
  String gHCHCCount;
  String ppCount;
  String campCount;
  String satellitecentreCount;
  String patientCount;
  String dpm;
  String pmcCount;
  String totalEB;
  String totalEd;
  String spo;

  Data(
      {this.ngoCount,
        this.gHCHCCount,
        this.ppCount,
        this.campCount,
        this.satellitecentreCount,
        this.patientCount,
        this.dpm,
        this.pmcCount,
        this.totalEB,
        this.totalEd,
        this.spo});

  Data.fromJson(Map<String, dynamic> json) {
    ngoCount = json['ngoCount'];
    gHCHCCount = json['gH_CHC_Count'];
    ppCount = json['ppCount'];
    campCount = json['campCount'];
    satellitecentreCount = json['satellitecentreCount'];
    patientCount = json['patientCount'];
    dpm = json['dpm'];
    pmcCount = json['pmcCount'];
    totalEB = json['totalEB'];
    totalEd = json['totalEd'];
    spo = json['spo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ngoCount'] = this.ngoCount;
    data['gH_CHC_Count'] = this.gHCHCCount;
    data['ppCount'] = this.ppCount;
    data['campCount'] = this.campCount;
    data['satellitecentreCount'] = this.satellitecentreCount;
    data['patientCount'] = this.patientCount;
    data['dpm'] = this.dpm;
    data['pmcCount'] = this.pmcCount;
    data['totalEB'] = this.totalEB;
    data['totalEd'] = this.totalEd;
    data['spo'] = this.spo;
    return data;
  }
}