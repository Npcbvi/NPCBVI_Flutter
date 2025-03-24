import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/UpcomingHomeGuidlines.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/govtPrivateRegisterUSerId.dart';
import 'package:mohfw_npcbvi/src/registerScreens/NGORegistrationScreen.dart';
import 'package:mohfw_npcbvi/src/repositories/country_state_city_repo.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class SPORegistration extends StatefulWidget {
  @override
  _SPORegistrationState createState() => _SPORegistrationState();
}

class _SPORegistrationState extends State<SPORegistration> {
  String randomString = "";
  bool showSPORegistration = true;

   Data _selectedUser;
   Future<List<Data>> _future;

  int stateCodeSPO = 0;
  String CodeSPO = "";

  final TextEditingController _spoEmailIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buildCaptcha();
    _future = _getStatesDAta();
  }

  Future<List<Data>> _getStatesDAta() async {
    if (!await Utils.isNetworkAvailable()) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/State'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final DashboardStateModel dashboardStateModel =
        DashboardStateModel.fromJson(json);
        return dashboardStateModel.data;
      } else {
        Utils.showToast("Failed to fetch states!", true);
        return [];
      }
    } catch (e) {
      Utils.showToast("Error: $e", true);
      return [];
    }
  }

  void buildCaptcha() {
    const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    final random = Random();
    setState(() {
      randomString = String.fromCharCodes(
          List.generate(6, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _spoEmailIdController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Email ID',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Enter Email ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String input) {
    if (input.trim().isEmpty) return true;
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    bool isMatch = regex.hasMatch(input.trim());
    if (!isMatch) Utils.showToast("Please enter a valid email", false);
    return isMatch;
  }
}
class SPODataFields {
  int state;
  String Name;
  String mobileNumber;
  String emailId;
  String designation;
  String PhoneNumber;
  String OfficeAddress;
  String PinCode;
  String codeSPOs;
  String CaptchaCodeEnter;
  int stdSPO;
}