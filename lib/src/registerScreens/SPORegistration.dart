import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  TextEditingController _spoNAmeController = new TextEditingController();
  TextEditingController _spoMobileController = new TextEditingController();
  TextEditingController _spoEmailIdController = new TextEditingController();
  TextEditingController _spoDestinationController = new TextEditingController();
  TextEditingController _spoPhoneNumberController = new TextEditingController();
  TextEditingController _spoOfficeAddressController =
  new TextEditingController();
  TextEditingController _spoPinCodeController = new TextEditingController();
  TextEditingController _spoCaptchaCodeEnterController =
  new TextEditingController();
  String randomString = "";
  bool showSPORegistration = true;
  SPODataFieldss spoDataFields = new SPODataFieldss();

   Data _selectedUser;
   Future<List<Data>> _future;

  int stateCodeSPO = 0;
  String CodeSPO = "";
  bool isVerified = false;

  TextEditingController stdControllerDPM = new TextEditingController();
  TextEditingController stdControllerSpo = new TextEditingController();
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
    return Scaffold(
      appBar: AppBar(title: Text("SPO Registration")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    width: 350, // Set consistent width
                    height: 50,
                    child: FutureBuilder<List<Data>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: CircularProgressIndicator()); // ✅ Proper loading indicator
                        }

                        // Logging for debugging
                        developer.log('@@snapshot: ${snapshot.data}');

                        List<Data> stateList = snapshot.data;


                        // Ensure selected state is in the list, otherwise select the first
                        if (_selectedUser == null || !stateList.contains(_selectedUser)) {
                          _selectedUser = stateList.first;
                        }

                        return DropdownButtonFormField2<Data>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('Select State'),
                          value: _selectedUser,
                          onChanged: (user) {
                            setState(() {
                              _selectedUser = user;
                              stateCodeSPO = int.parse(user.stateCode.toString());
                              CodeSPO = user.code;
                              print('@@statenameSPO: $stateCodeSPO');
                              print('@@CodeSPO: $CodeSPO');
                            });
                          },
                          items: stateList.map<DropdownMenuItem<Data>>((Data user) {
                            return DropdownMenuItem<Data>(
                              value: user,
                              child: Text(user.stateName),
                            );
                          }).toList(),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 350,
                            width: 350, // ✅ Ensure dropdown width matches TextField width
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _spoNAmeController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Name',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style:
                                TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Name', // Regular hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _spoMobileController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Mobile Number',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style:
                                TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _spoEmailIdController,
                      keyboardType: TextInputType.emailAddress,
                      // Set keyboard type for email
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Email ID',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style:
                                TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Email ID', // Regular hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _spoDestinationController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Designation',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Designation', // Regular hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50, // Ensuring height consistency
                            child: TextFormField(
                              controller: stdControllerSpo,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5), // Restrict to 5 digits
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10), // Adjust padding
                                label: RichText(
                                  text: TextSpan(
                                    text: 'STD',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' *', // Red Asterisk
                                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Enter STD Code',
                                hintStyle: TextStyle(color: Colors.grey), // Hint text color
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5), // Ensures spacing is consistent
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 50, // Ensuring height consistency
                            child: TextFormField(
                              controller: _spoPhoneNumberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10), // Restrict to 10 digits
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10), // Adjust padding
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Phone Number',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' *', // Red Asterisk
                                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Enter Phone Number',
                                hintStyle: TextStyle(color: Colors.grey), // Hint text color
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: TextField(
                        controller: _spoOfficeAddressController,
                        maxLines: 3, // Allows multiline input for addresses
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Office Address ',
                                  style: TextStyle(
                                      color: Colors.black), // Label text color
                                ),
                                TextSpan(
                                  text: '*', // Asterisk
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter Office Address',
                          hintStyle: TextStyle(color: Colors.grey),
                          // Hint text color
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: SizedBox(
                        height: 50, // Ensuring height consistency
                        child: TextField(
                          controller: _spoPinCodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                            // Restrict to 6 digits
                          ],
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Pin Code ',
                                    style: TextStyle(
                                        color: Colors.black), // Label text color
                                  ),
                                  TextSpan(
                                    text: '*', // Asterisk
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter Pin Code',
                            hintStyle: TextStyle(color: Colors.grey),
                            // Hint text color
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 50, // Adjust height as needed
                            child: TextField(
                              controller: _spoCaptchaCodeEnterController,
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Enter Captcha Value',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        // Red Asterisk for required field
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isVerified = false;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                randomString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: buildCaptcha,
                              icon: Icon(Icons.refresh),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing
                      children: [
                        SizedBox(
                          width: 120, // Reduced button width
                          height: 40, // Reduced button height
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.send, color: Colors.white, size: 18), // Smaller icon
                            label: Text(
                              'Submit',
                              style: TextStyle(fontSize: 14), // Smaller text
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Button color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Smaller padding
                              minimumSize: Size(120, 40), // Minimum size
                              fixedSize: Size(120, 40), // Fixed width & height
                              elevation: 3, // Reduced shadow effect
                              shadowColor: Colors.black45, // Shadow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                              ),
                            ),
                            onPressed: () {
                              print('@@Spo Submit Button');
                             // _spoRegistrationSubmit();
                            },
                          ),
                        ),
                        SizedBox(width: 8), // Reduced spacing between buttons
                        SizedBox(
                          width: 120, // Reduced button width
                          height: 40, // Reduced button height
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.refresh, color: Colors.white, size: 18), // Smaller icon
                            label: Text(
                              'Reset',
                              style: TextStyle(fontSize: 14), // Smaller text
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Reset button color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Smaller padding
                              minimumSize: Size(120, 40), // Minimum size
                              fixedSize: Size(120, 40), // Fixed width & height
                              elevation: 3, // Reduced shadow effect
                              shadowColor: Colors.black45, // Shadow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                              ),
                            ),
                            onPressed: () {
                              _spoNAmeController.clear();
                              _spoMobileController.clear();
                              _spoPinCodeController.clear();
                              _spoOfficeAddressController.clear();
                              _spoEmailIdController.clear();
                              _spoPhoneNumberController.clear();
                              _spoCaptchaCodeEnterController.clear();
                              _spoDestinationController.clear();
                              stdControllerSpo.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
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
  Future<void> _spoRegistrationSubmit() async {
    try {
      // Safely parse integer values
      spoDataFields.stdSPO = stdControllerSpo.text.trim().isNotEmpty
          ? int.tryParse(stdControllerSpo.text.trim()) ?? 0
          : 0;

      spoDataFields.state = stateCodeSPO;
      spoDataFields.codeSPOs = CodeSPO ?? "";  // Prevent null issues
      spoDataFields.Name = _spoNAmeController.text.trim();
      spoDataFields.mobileNumber = _spoMobileController.text.trim();
      spoDataFields.emailId = _spoEmailIdController.text.trim();
      spoDataFields.designation = _spoDestinationController.text.trim();
      spoDataFields.PhoneNumber = _spoPhoneNumberController.text.trim();
      spoDataFields.OfficeAddress = _spoOfficeAddressController.text.trim();
      spoDataFields.PinCode = _spoPinCodeController.text.trim();
      spoDataFields.CaptchaCodeEnter = _spoCaptchaCodeEnterController.text.trim();

      print('@@stateCodeSPO: ${stateCodeSPO}');
      print('@@spoDataFields.codeSPOs: ${spoDataFields.codeSPOs}');

      // Validation checks
      if (spoDataFields.Name.isEmpty) {
        Utils.showToast("Please enter Name!", true);
        return;
      }
      if (spoDataFields.mobileNumber.isEmpty) {
        Utils.showToast("Please enter Mobile number!", true);
        return;
      }
      if (spoDataFields.emailId.isNotEmpty &&
          !isValidEmail(spoDataFields.emailId)) {
        Utils.showToast("Please enter a valid email!", true);
        return;
      }
      if (spoDataFields.designation.isEmpty) {
        Utils.showToast("Please enter Designation!", true);
        return;
      }
      if (spoDataFields.PhoneNumber.isEmpty) {
        Utils.showToast("Please enter Phone Number!", true);
        return;
      }
      if (spoDataFields.OfficeAddress.isEmpty) {
        Utils.showToast("Please enter Office Address!", true);
        return;
      }
      if (spoDataFields.PinCode.isEmpty) {
        Utils.showToast("Please enter Pin Code!", true);
        return;
      }
      if (spoDataFields.CaptchaCodeEnter.isEmpty) {
        Utils.showToast("Please enter the Matched Captcha!", true);
        return;
      }

      // Check for network availability before API call
      bool isNetworkAvailable = await Utils.isNetworkAvailable();
      if (!isNetworkAvailable) {
        Utils.showToast(AppConstant.noInternet, true);
        return;
      }

      // Show progress dialog
      Utils.showProgressDialog1(context);

      // API call
      var response = await ApiController.spoRegistrationAPiRquestCopy(spoDataFields);

      // Hide progress dialog
      Utils.hideProgressDialog1(context);

      print('@@spoAPiRquest Status: ${response.status}');

      if (response.status) {
        Utils.showToast(response.message, true);

        // Clear text fields
        _spoNAmeController.clear();
        _spoMobileController.clear();
        _spoPinCodeController.clear();
        _spoOfficeAddressController.clear();
        _spoEmailIdController.clear();
        _spoPhoneNumberController.clear();
        _spoCaptchaCodeEnterController.clear();
        _spoDestinationController.clear();
        stdControllerSpo.clear();
      } else {
        Utils.showToast(response.message, false);
      }
    } catch (e) {
      print("Error in _spoRegistrationSubmit: $e");
      Utils.showToast("An error occurred. Please try again.", false);
    }
  }

}
class SPODataFieldss {
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