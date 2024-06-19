import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/RegisterScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/spoRegistartion/SPORegisterModel.dart';

import '../utils/Utils.dart';
import 'dart:developer';
import 'package:mohfw_npcbvi/src/model/cities_model.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static final int timeout = 18;

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

  static Future<SPORegisterModel> spoAPiRquest(SPODataFields spoDataFields) async {
    SPORegisterModel spoRegisterModel = SPORegisterModel();
    Response response1;

    try {
      var url = ApiConstants.baseUrl + ApiConstants.spoRegistration;
      //Way to send headers
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };
      //Way to send params
      var body =
      json.encode({"state_code":spoDataFields.state, "name":spoDataFields.Name,"mobile":spoDataFields.mobileNumber,
        "email_id":spoDataFields.emailId,"designation":spoDataFields.designation,"std":spoDataFields.std,"phone_no":spoDataFields.PhoneNumber,
        "office_address":spoDataFields.OfficeAddress,  "pincode":spoDataFields.PinCode,  "user_id":"NPCB" +spoDataFields.codeSPOs ,
      });
      print("@@SPOURL" + url+body);
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(url,
          data: body,
          options: new Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@SPOURL" + url+body);
      print("@@SPOURL--Api" + response1.toString());
      spoRegisterModel = SPORegisterModel.fromJson(json.decode(response1.data));
      print("@@token" + spoRegisterModel.message);
    //  Result result = loginModel.result;
    //  print("@@Result message----" + result.message);
      if (spoRegisterModel.status) {
      }
      Utils.showToast(spoRegisterModel.message, true);
      return spoRegisterModel;
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null;
    }
    //Way to send url with methodname
  }
}
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
