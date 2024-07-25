
import 'dart:convert';
import 'dart:ffi';

import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/forgot/ForgotPasswordModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  static void saveUser(LoginData model) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    dynamic userResponse = model.toJson();
    String jsonString = jsonEncode(userResponse);
    sharedUser.setString('user', jsonString);
  }

  static Future<LoginData> getUser() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = json.decode(sharedUser.getString('user'));
    var user = LoginData.fromJson(userMap);
    return user;
  }
  static Future storeSharedValue(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
  static Future storeSharedValues(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future getStoreSharedValue(String key) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    return sharedUser.getInt(key);
  }
  static void saveForgotPasswordData(ForgotPasswordModel model) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    dynamic storeResponse = model.toJson();
    String jsonString = jsonEncode(storeResponse);
    sharedUser.setString('user_forget', jsonString);
  }
  static Future<ForgotPasswordModel> getForgotPasswordData() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map<String, dynamic> storeMap = json.decode(sharedUser.getString('user_forget'));
    var user = ForgotPasswordModel.fromJson(storeMap);
    return user;
  }
}
