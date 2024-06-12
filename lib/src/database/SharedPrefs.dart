
import 'dart:convert';

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

}
