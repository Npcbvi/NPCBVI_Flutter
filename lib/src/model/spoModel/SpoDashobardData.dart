class SpoDashobardData {
  String message;
  bool status;
  SpoDashobardDatas data;
  Null list;

  SpoDashobardData({this.message, this.status, this.data, this.list});

  SpoDashobardData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new SpoDashobardDatas.fromJson(json['data']) : null;
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['list'] = this.list;
    return data;
  }
}

class SpoDashobardDatas {
  String totalPatientApproved;
  String totalPatientPending;
  String ngoCount;
  String ngoPendingCount;
  String gHCHCCount;
  String gHCHCCountPending;
  String ppCount;
  String ppCountPending;
  String pmcCount;
  String pmcCountPending;
  String campCompletedCount;
  String campongoingCount;
  String campCommingCount;
  String campCount;
  String satellitecentreCount;
  String patientCount;

  SpoDashobardDatas(
      {this.totalPatientApproved,
        this.totalPatientPending,
        this.ngoCount,
        this.ngoPendingCount,
        this.gHCHCCount,
        this.gHCHCCountPending,
        this.ppCount,
        this.ppCountPending,
        this.pmcCount,
        this.pmcCountPending,
        this.campCompletedCount,
        this.campongoingCount,
        this.campCommingCount,
        this.campCount,
        this.satellitecentreCount,
        this.patientCount});

  SpoDashobardDatas.fromJson(Map<String, dynamic> json) {
    totalPatientApproved = json['totalPatientApproved'];
    totalPatientPending = json['totalPatientPending'];
    ngoCount = json['ngoCount'];
    ngoPendingCount = json['ngoPendingCount'];
    gHCHCCount = json['gH_CHC_Count'];
    gHCHCCountPending = json['gH_CHC_Count_Pending'];
    ppCount = json['ppCount'];
    ppCountPending = json['ppCount_pending'];
    pmcCount = json['pmcCount'];
    pmcCountPending = json['pmcCountPending'];
    campCompletedCount = json['campCompletedCount'];
    campongoingCount = json['campongoingCount'];
    campCommingCount = json['campCommingCount'];
    campCount = json['campCount'];
    satellitecentreCount = json['satellitecentreCount'];
    patientCount = json['patientCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPatientApproved'] = this.totalPatientApproved;
    data['totalPatientPending'] = this.totalPatientPending;
    data['ngoCount'] = this.ngoCount;
    data['ngoPendingCount'] = this.ngoPendingCount;
    data['gH_CHC_Count'] = this.gHCHCCount;
    data['gH_CHC_Count_Pending'] = this.gHCHCCountPending;
    data['ppCount'] = this.ppCount;
    data['ppCount_pending'] = this.ppCountPending;
    data['pmcCount'] = this.pmcCount;
    data['pmcCountPending'] = this.pmcCountPending;
    data['campCompletedCount'] = this.campCompletedCount;
    data['campongoingCount'] = this.campongoingCount;
    data['campCommingCount'] = this.campCommingCount;
    data['campCount'] = this.campCount;
    data['satellitecentreCount'] = this.satellitecentreCount;
    data['patientCount'] = this.patientCount;
    return data;
  }
}
