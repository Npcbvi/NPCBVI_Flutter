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

class DPMRegistration extends StatefulWidget {
  @override
  _DPMRegistration createState() => _DPMRegistration();
}

class _DPMRegistration extends State<DPMRegistration> {

  Future<List<Data>> _future;
  Data _selectedUser;
  DataDsiricst _selectedUserDistrict;

  String oganisationTypeGovtPrivateDRopDown;
  String randomString = "";
  bool showGOVTPrivate = false;
  bool showNGOResgistration = false;
  bool showSPORegistration = false;
  bool showDPMRegistration = false;
  bool registeredUSerGovtPrivateRegsiterations = false;
  bool submitButtonRegisteredUSerID = false;
  bool newUSerGovtPrivateRegisterRadios = false;
  bool newUSerGovtPrivateRegisterRadiosusedForRegisteredUSer = false;
  bool isVisibleDitrict = false;
  bool isVisibleDitrictGovt = false;
  bool isVisibleHostpiatnNinitrictGovt = false;
  bool showHomeScreen = false;
  bool isLoadingApi = true;
  bool isVerified = false;



  TextEditingController _dpmNAmeController = new TextEditingController();
  TextEditingController _dpmMobileController = new TextEditingController();
  TextEditingController _dpmEmailIdController = new TextEditingController();
  TextEditingController _dpmDestinationController = new TextEditingController();
  TextEditingController _dpmPhoneNumberController = new TextEditingController();
  TextEditingController _captchaController = TextEditingController();

  TextEditingController stdControllerDPM = new TextEditingController();
  TextEditingController stdControllerSpo = new TextEditingController();

  TextEditingController _dpmOfficeAddressController =
  new TextEditingController();
  TextEditingController _dpmPinCodeController = new TextEditingController();
  TextEditingController _dpmCaptchaCodeEnterController =
  new TextEditingController();

  DPMDataFieldss dpmDataFields = new DPMDataFieldss();

  DashboardStateModel countryStateModel =
  DashboardStateModel(status: false, message: '', data: []);
  bool isDataLoaded = false;
  int stateCodeSPO,
      disrtcCode,
      stateCodeDPM,
      stateCodeGovtPrivate,
      distCodeDPM,
      distCodeGovtPrivate;
  String CodeSPO,
      codeDPM,
      CodeGovtPrivate,
      distNameDPM,
      distNameDPMs_distictValues;

  List<String> products = [];
  int dropDownvalueOrgnbaistaionType = 0;
  List<ListGovtPRivateModel> offerList = [];
  int counterSaveGovtButtonValue = 1;
  String textValueAddDoctors = 'Add Doctors';



  String str_regdgovtpvtEmailId,
      str_regdgovtpvtOrgType,
      str_regdgovtpvtstateName,
      str_regdgovtpvtdistrictName,
      str_regdgovtpvtOfficeName;

  Future<List<Data>> _getStatesDAta() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/State'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final DashboardStateModel dashboardStateModel =
      DashboardStateModel.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataDsiricst>> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel = DashboardDistrictModel();
    ;
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"state_code": stateCode});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/ListDistrict",
          data: body,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + body.toString());
      print("@@Response--Api=====" + response1.toString());
      dashboardDistrictModel =
          DashboardDistrictModel.fromJson(json.decode(response1.data));
      if (dashboardDistrictModel.status) {
        print("@@dashboardDistrictModel----getting of size +++--" +
            dashboardDistrictModel.data.length.toString());
      } else {
        print("@@no data---" + dashboardDistrictModel.data.length.toString());
      }
      return dashboardDistrictModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  void buildCaptcha() {
    const letters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    // Length of Captcha to be generated
    final random = Random();
    // Select random letters from above list
    randomString = String.fromCharCodes(List.generate(
        length, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
    setState(() {});
    print("@@ random string is $randomString");
  }

  // Primary Marquee text

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    buildCaptcha();
    showHomeScreen = false;
    _future = _getStatesDAta();
    showNGOResgistration = true;
    oganisationTypeGovtPrivateDRopDown = null; // Ensure it starts as null
    submitButtonRegisteredUSerID = true; // or set based on some condition
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DPM Registration")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
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

                        if (!snapshot.hasData) {
                          //    return const CircularProgressIndicator();
                        }

                        List<Data> stateList = snapshot.data ?? [];

                        // Ensure selected state is valid
                        if (_selectedUser == null ||
                            !stateList.contains(_selectedUser)) {
                          _selectedUser =
                          stateList.isNotEmpty ? stateList.first : null;
                        }

                        return SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.9, // Dynamically adjust width
                          child: DropdownButtonFormField2<Data>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1),
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
                                stateCodeDPM =
                                    int.parse(user.stateCode.toString());
                                codeDPM = user.code;
                                distNameDPM = user.stateName;

                                if (codeDPM != null) {
                                  SharedPrefs.storeSharedValue(
                                      AppConstant.txtStateDPmValue,
                                      stateCodeDPM);
                                  isVisibleDitrict = true;
                                  _getDistrictData(stateCodeDPM);
                                } else {
                                  isVisibleDitrict = false;
                                }
                              });
                            },
                            items: stateList
                                .map<DropdownMenuItem<Data>>((Data user) {
                              return DropdownMenuItem<Data>(
                                value: user,
                                child: Text(user.stateName),
                              );
                            }).toList(),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 350,
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 5), // Adjust height as needed

                  Visibility(
                    visible: isVisibleDitrict,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: FutureBuilder<List<DataDsiricst>>(
                            future: _getDistrictData(stateCodeDPM),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }

                              List<DataDsiricst> districtList = snapshot.data;

                              if (_selectedUserDistrict == null ||
                                  !districtList
                                      .contains(_selectedUserDistrict)) {
                                _selectedUserDistrict = districtList.isNotEmpty
                                    ? districtList.first
                                    : null;
                              }

                              return DropdownButtonFormField2<DataDsiricst>(
                                isExpanded: true,

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 5.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Select District',
                                ),
                                hint: Text("Select District"),
                                value: _selectedUserDistrict,
                                onChanged: (districtUser) {
                                  setState(() {
                                    _selectedUserDistrict = districtUser;
                                    distCodeDPM = int.parse(
                                        districtUser.districtCode.toString());
                                    distNameDPMs_distictValues =
                                        districtUser.districtName;
                                  });
                                },
                                items: districtList
                                    .map<DropdownMenuItem<DataDsiricst>>(
                                        (DataDsiricst district) {
                                      return DropdownMenuItem<DataDsiricst>(
                                        value: district,
                                        child: Text(district.districtName),
                                      );
                                    }).toList(),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _dpmNAmeController,
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
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        // Set hint text color here
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _dpmMobileController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: "",
                        // Hide the default counter text
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
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(color: Colors.grey),
                        // Set hint text color here
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _dpmEmailIdController,
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
                        hintText: 'Email ID',
                        hintStyle: TextStyle(color: Colors.grey),
                        // Set hint text color here
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _dpmDestinationController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Designation',
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
                        hintText: 'Designation',
                        hintStyle: TextStyle(color: Colors.grey),
                        // Set hint text color here
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: stdControllerDPM,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 5, // Std code is usually 5 digits max
                            decoration: InputDecoration(
                              counterText: "", // Hides default counter text
                              label: RichText(
                                text: TextSpan(
                                  text: 'Std',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Std',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Added spacing between fields
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _dpmPhoneNumberController,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "", // Hides default counter text
                              label: RichText(
                                text: TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _dpmOfficeAddressController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Office Address',
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
                        hintText: 'Office Address',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _dpmPinCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Pin Code',
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
                        hintText: 'Pin Code',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Adjust height as needed

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 50, // Adjust height as needed
                            child: TextField(
                              controller: _dpmCaptchaCodeEnterController,
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Enter Captcha Value',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                  SizedBox(height: 5), // Adjust height as needed

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
                              print('@@DPMMMM Hit here-----Api---------');
                              _DPMRegistrationSubmit();
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
                            onPressed: () {},
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
  Future<void> _DPMRegistrationSubmit() async {
    try {
      // Safely parse integer values
      dpmDataFields.stdDPMs = int.tryParse(stdControllerDPM.text.trim()) ?? 0;
      dpmDataFields.stateDPM = (stateCodeDPM is int) ? stateCodeDPM : int.tryParse(stateCodeDPM?.toString() ?? "") ?? 0;
      dpmDataFields.distCodeDPM = (distCodeDPM is int) ? distCodeDPM : int.tryParse(distCodeDPM?.toString() ?? "") ?? 0;
      dpmDataFields.codeSPOsDPM = codeDPM ?? "";

      // Ensure string fields are properly trimmed
      dpmDataFields.NameDPM = _dpmNAmeController.text.trim();
      dpmDataFields.mobileNumberDPM = _dpmMobileController.text.trim();
      dpmDataFields.emailIdDPM = _dpmEmailIdController.text.trim();
      dpmDataFields.designationDPM = _dpmDestinationController.text.trim();
      dpmDataFields.PhoneNumberDPM = _dpmPhoneNumberController.text.trim();
      dpmDataFields.OfficeAddressDPM = _dpmOfficeAddressController.text.trim();
      dpmDataFields.PinCodeDPM = _dpmPinCodeController.text.trim();
      dpmDataFields.CaptchaCodeEnterDPM = _dpmCaptchaCodeEnterController.text.trim();
      dpmDataFields.distNameDPMs = distNameDPM ?? "";
      dpmDataFields.distNameDPMs_distictValue = distNameDPMs_distictValues ?? "";

      // Debugging logs
      print('@@stateDPM: ${dpmDataFields.stateDPM}');
      print('@@distCodeDPM: ${dpmDataFields.distCodeDPM}');
      print('@@stdDPMs: ${dpmDataFields.stdDPMs}');
// Additional validation if needed

      if (dpmDataFields.stateDPM == 0) {
        Utils.showToast("Invalid State Code. Please select again.", false);
        return;
      }

      if (dpmDataFields.distCodeDPM == 0) {
        Utils.showToast("Invalid District Code. Please select again.", false);
        return;
      }
      // === VALIDATION CHECKS ===
      if (dpmDataFields.NameDPM.isEmpty) {
        Utils.showToast("Please enter Name!", false);
        return;
      }
      if (dpmDataFields.mobileNumberDPM.isEmpty) {
        Utils.showToast("Please enter Mobile number!", false);
        return;
      }
      if (dpmDataFields.emailIdDPM.isNotEmpty && !isValidEmail(dpmDataFields.emailIdDPM)) {
        Utils.showToast("Please enter a valid email!", false);
        return;
      }
      if (dpmDataFields.designationDPM.isEmpty) {
        Utils.showToast("Please enter Designation!", false);
        return;
      }
      if (dpmDataFields.PhoneNumberDPM.isEmpty) {
        Utils.showToast("Please enter Phone Number!", false);
        return;
      }
      if (dpmDataFields.OfficeAddressDPM.isEmpty) {
        Utils.showToast("Please enter Office Address!", false);
        return;
      }
      if (dpmDataFields.PinCodeDPM.isEmpty) {
        Utils.showToast("Please enter Pin Code!", false);
        return;
      }
      if (dpmDataFields.CaptchaCodeEnterDPM.isEmpty) {
        Utils.showToast("Please enter the Matched Captcha!", false);
        return;
      }
      if (dpmDataFields.stdDPMs == 0) {
        Utils.showToast("Please enter a valid STD!", false);
        return;
      }

      // === NETWORK CHECK ===
      bool isNetworkAvailable = await Utils.isNetworkAvailable();
      if (!isNetworkAvailable) {
        Utils.showToast(AppConstant.noInternet, true);
        return;
      }

      // Show progress dialog
      Utils.showProgressDialog1(context);

      try {
        // === API CALL ===
        var response = await ApiController.DPMRegistrationAPiRquestCopy(dpmDataFields);

        // Hide progress dialog
        Utils.hideProgressDialog1(context);

        // Handle API response
        print('@@DPM API Response: ${response.status}');
        if (response.status) {
          Utils.showToast(response.message, true);

          // Clear text fields
          _dpmNAmeController.clear();
          _dpmMobileController.clear();
          _dpmPinCodeController.clear();
          _dpmOfficeAddressController.clear();
          _dpmEmailIdController.clear();
          _dpmPhoneNumberController.clear();
          _dpmCaptchaCodeEnterController.clear();
          _dpmDestinationController.clear();
          stdControllerDPM.clear();
        } else {
          Utils.showToast(response.message, false);
        }
      } catch (apiError) {
        Utils.hideProgressDialog1(context);
        print("API Error: $apiError");
        Utils.showToast("Failed to register. Try again later.", false);
      }
    } catch (e, stacktrace) {
      print("Error in _DPMRegistrationSubmit: $e");
      print(stacktrace);
      Utils.showToast("An unexpected error occurred. Please try again.", false);
    }
  }

}
class DPMDataFieldss {
  int stateDPM;
  int distCodeDPM;
  String NameDPM;
  String mobileNumberDPM;
  String emailIdDPM;
  String designationDPM;
  String PhoneNumberDPM;
  String OfficeAddressDPM;
  String PinCodeDPM;
  String codeSPOsDPM;
  String CaptchaCodeEnterDPM;
  String distNameDPMs;
  String distNameDPMs_distictValue;
  int stdDPMs;
}
