// To parse this JSON data, do
//
//     final countryStateModel = countryStateModelFromJson(jsonString);

import 'dart:convert';

DashboardStateModel countryStateModelFromJson(String str) =>
    DashboardStateModel.fromJson(json.decode(str));

String countryStateModelToJson(DashboardStateModel data) =>
    json.encode(data.toJson());
class DashboardStateModel {
  String message;
  bool status;
  List<Data> data;

  DashboardStateModel({this.message, this.status, this.data});

  DashboardStateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int stateCode;
  String stateName;
  String code;

  Data({this.stateCode, this.stateName, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    stateName = json['state_name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['code'] = this.code;
    return data;
  }
}