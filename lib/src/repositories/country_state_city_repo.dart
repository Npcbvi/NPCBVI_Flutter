import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/cities_model.dart';

class CountryStateCityRepo {
  static const countriesStateURL =
      'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/State';
  static const cityURL =
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country';

  Future<DashboardStateModel> getCountriesStates() async {
    try {
      var url = Uri.parse(countriesStateURL);
      print('@@State_url_1'+url.toString());
      var response = await http.get(url);
      print('@@State_response_1'+response.toString());
      if (response.statusCode == 200) {
        final DashboardStateModel responseModel =
            countryStateModelFromJson(response.body);
        return responseModel;
      } else {
        return DashboardStateModel(
            status: false,
            message: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }



  Future<CitiesModel> getCities(
      { String country,  String state}) async {
    try {
      var url = Uri.parse("$cityURL=$country&state=$state");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CitiesModel responseModel = citiesModelFromJson(response.body);
        return responseModel;
      } else {
        return CitiesModel(
            error: true,
            msg: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
