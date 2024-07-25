import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/home_page.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
/*void main() {
  runApp(
    MaterialApp(
      home: LoginScreen(),
     // home: HomePage(),
    ),
  );
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    SharedPrefs.storeSharedValues(
        AppConstant.deviceId, iosDeviceInfo.identifierForVendor);
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    SharedPrefs.storeSharedValues(AppConstant.deviceId, androidDeviceInfo.id);
  }
  runApp(
    MaterialApp(
      home: LoginScreen(),
      // home: HomePage(),
    ),
  );
}
