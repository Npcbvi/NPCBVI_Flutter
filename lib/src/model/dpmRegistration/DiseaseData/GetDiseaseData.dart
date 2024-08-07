class GetDiseaseData {
  final int serialNo;
  final String diseaseName;
  final String name;
  final int total;

  GetDiseaseData({ this.serialNo,  this.diseaseName,  this.name,  this.total});

  factory GetDiseaseData.fromJson(Map<String, dynamic> json) {
    return GetDiseaseData(
      serialNo: json['serialNo'],
      diseaseName: json['diseaseName'],
      name: json['name'],
      total: json['total'],
    );
  }
}
