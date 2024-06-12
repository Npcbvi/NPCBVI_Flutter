import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';

import '../utils/Utils.dart';

class ApiController {
  static final int timeout = 18;

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
}
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
