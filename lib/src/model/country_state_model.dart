// To parse this JSON data, do
//
//     final countryStateModel = countryStateModelFromJson(jsonString);

import 'dart:convert';

CountryStateModel countryStateModelFromJson(String str) =>
    CountryStateModel.fromJson(json.decode(str));

String countryStateModelToJson(CountryStateModel data) =>
    json.encode(data.toJson());

class CountryStateModel {
  bool error;
  String msg;
  List<Datum> data;

  CountryStateModel({
    this.error,
    this.msg,
    this.data,
  });

  factory CountryStateModel.fromJson(Map<String, dynamic> json) =>
      CountryStateModel(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String name;
  String iso3;
  String iso2;
  List<States> states;

  Datum({
    this.name,
    this.iso3,
    this.iso2,
    this.states,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        states:
            List<States>.from(json["states"].map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class States {
  String name;
  String stateCode;

  States({
    this.name,
    this.stateCode,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        name: json["name"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state_code": stateCode,
      };
}
