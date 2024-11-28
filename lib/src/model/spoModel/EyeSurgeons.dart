class EyeSurgeons {
  bool status;
  String message;
  List<EyeSurgeonsData> data;

  EyeSurgeons({ this.status,  this.message,  this.data});

  factory EyeSurgeons.fromJson(Map<String, dynamic> json) {
    // Ensure you're accessing the correct fields here
    return EyeSurgeons(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => EyeSurgeonsData.fromJson(item)) // Parse each item in the data list
          .toList(),
    );
  }
}

class EyeSurgeonsData {
  int sno;
  String entryDate;
  String entryBy;
  String updatedDate;
  String updatedBy;
  String ipaddress;
  String updatedIpaddress;
  int status;
  int stateCode;
  int totalNgo;
  int totalGov;
  int totalPp;
  int totalPmc;

  EyeSurgeonsData({
     this.sno,
     this.entryDate,
     this.entryBy,
     this.updatedDate,
     this.updatedBy,
     this.ipaddress,
     this.updatedIpaddress,
     this.status,
     this.stateCode,
     this.totalNgo,
     this.totalGov,
     this.totalPp,
     this.totalPmc,
  });

  factory EyeSurgeonsData.fromJson(Map<String, dynamic> json) {
    return EyeSurgeonsData(
      sno: json['sno'],
      entryDate: json['entry_date'],
      entryBy: json['entry_by'],
      updatedDate: json['updated_date'],
      updatedBy: json['updated_by'],
      ipaddress: json['ipaddress'],
      updatedIpaddress: json['updated_ipaddress'],
      status: json['status'],
      stateCode: json['state_code'],
      totalNgo: json['totalngo'],
      totalGov: json['totalGov'],
      totalPp: json['totalPP'],
      totalPmc: json['totalPMC'],
    );
  }
}
