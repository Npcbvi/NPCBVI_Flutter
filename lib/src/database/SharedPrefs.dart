
import 'dart:convert';
import 'dart:ffi';

import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  static void saveUser(Result model) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    dynamic userResponse = model.toJson();
    String jsonString = jsonEncode(userResponse);
    sharedUser.setString('user', jsonString);
  }

  static Future<LoginModel> getUser() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = json.decode(sharedUser.getString('user'));
    var user = LoginModel.fromJson(userMap);
    return user;
  }
  static Future storeSharedValue(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future getStoreSharedValue(String key) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    return sharedUser.getInt(key);
  }
}
