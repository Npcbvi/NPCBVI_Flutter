import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';

import '../utils/Utils.dart';
import 'dart:developer';
import 'package:mohfw_npcbvi/src/model/cities_model.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static final int timeout = 18;
  static const countriesStateURL =
      'https://countriesnow.space/api/v0.1/countries/states';
  static const cityURL =
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country';
  static Future<LoginModel> loginAPiRequest(UserData user) async {
    LoginModel loginModel = LoginModel();
    Response response1;

    try {
      var url = ApiConstants.baseUrl + ApiConstants.UserLogin;
      //Way to send headers
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };
      //Way to send params
      var body =
          json.encode({"username": user.loginId, "password": user.password});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(url,
          data: body,
          options: new Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + response1.toString());
      loginModel = LoginModel.fromJson(json.decode(response1.data));
      print("@@token" + loginModel.token);
      Result result = loginModel.result;
      print("@@Result message----" + result.message);
      if (result.status) {
        SharedPrefs.saveUser(loginModel.result);
      }
      Utils.showToast(result.message, true);
      return loginModel;
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null;
    }
    //Way to send url with methodname
  }
  static Future<DashboardStateModel> getSatatAPi() async {
    DashboardStateModel dashboardStateModel = DashboardStateModel();
    Response response1;

    try {
      var url = ApiConstants.baseUrl + ApiConstants.State;
      //Way to send headers
     /* Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };*/
      //Way to send params

      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.get(url,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + response1.toString());
      dashboardStateModel = DashboardStateModel.fromJson(json.decode(response1.data));
      print("@@token" + dashboardStateModel.message);
      print("@@Result message----" + dashboardStateModel.message);
      print("@@Result message----" + dashboardStateModel.data.toString());

      Utils.showToast(dashboardStateModel.message, true);
      return dashboardStateModel;
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null;
    }
    //Way to send url with methodname
  }
  Future<CountryStateModel> getCountriesStates() async {
    try {
      var url = Uri.parse(countriesStateURL);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CountryStateModel responseModel =
        countryStateModelFromJson(response.body);
        return responseModel;
      } else {
        return CountryStateModel(
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
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
