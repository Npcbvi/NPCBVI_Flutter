import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/home_page.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that the binding is initialized

  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    } else {
      // Handle cases where the platform is neither iOS nor Android
      deviceId = "Unknown device";
    }

    // Store device ID in Shared Preferences
    await SharedPrefs.storeSharedValues(AppConstant.deviceId, deviceId);
  } catch (e) {
    // Handle any errors that occur during device info retrieval
    print("Error retrieving device info: $e");
  }

  runApp(
    MaterialApp(
      home: LoginScreen(), // Set the initial screen
      // home: HomePage(), // Uncomment this line if you want to use HomePage instead of LoginScreen
    ),
  );
}
