import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/govtPrivateRegisterUSerId.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'package:dropdown_button2/dropdown_button2.dart';

import '../loginsignup/EquipmentListWidget.dart';


class GovvtPrivateHospitalRegisterScreen extends StatefulWidget {
  @override
  _GovvtPrivateHospitalRegisterScreen createState() => _GovvtPrivateHospitalRegisterScreen();
}

class _GovvtPrivateHospitalRegisterScreen extends State<GovvtPrivateHospitalRegisterScreen> {
  List<String> dropdownItems = [
    'Govt District Hospital',
    'CHC/Govt. Sub-Dist. Hospital',
    'Private Practitioner',
    'Private Medical College',
    'Other (Institution not claiming fund from NPCBVI)',
  ];


  Future<List<Data>> _future;
  Data _selectedUser;
  DataDsiricst _selectedUserDistrict;

  String oganisationTypeGovtPrivateDRopDown;
  bool _showMarquee = true;
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

  TextEditingController _spoEmailIdController = new TextEditingController();




  TextEditingController stdControllerDPM = new TextEditingController();
  TextEditingController stdControllerSpo = new TextEditingController();



  GovtPrivateRegistatrionDataFieldss govtPrivateRegistatrionDataFields =
      new GovtPrivateRegistatrionDataFieldss();
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
  int _value = 1; // int型の変数.
  String _text = ''; // String型の変数.
  final _registeredUSerID = new TextEditingController();

  final _organisationNameGovtPrivate = new TextEditingController();
  final _mobileGovtPRivate = new TextEditingController();
  final _emailIDGovtPRivate = new TextEditingController();
  final _addressGovtPRivate = new TextEditingController();
  final _pinbCodeGovtPRivate = new TextEditingController();
  final _officerNAmeGovtPRivate = new TextEditingController();
  TextEditingController _captchaControllerGovtPrivateScreen =
      new TextEditingController();
  List<String> products = [];
  int dropDownvalueOrgnbaistaionType = 0;
  final _equipmentDetailQtyController = new TextEditingController();
  List<TextEditingController> _controllers = [];
  List<ListGovtPRivateModel> offerList = [];
  final _HospitalNINnoGovtController = new TextEditingController();
  int counterSaveGovtButtonValue = 1;
  String textValueAddDoctors = 'Add Doctors';

  bool _isVisibleADDDoctorsDetails = false;

  final _doctorMCIReg = new TextEditingController();
  final _doctorDOB = new TextEditingController();
  final _doctorName = new TextEditingController();
  final _doctorMobileNumber = new TextEditingController();
  final _doctorEmailId = new TextEditingController();
  final _doctorPinCode = new TextEditingController();
  final _doctorMCICErtification = new TextEditingController();
  String _selectedMenu = 'Home'; // Default selected menu
  String str_regdgovtpvtEmailId,
      str_regdgovtpvtOrgType,
      str_regdgovtpvtstateName,
      str_regdgovtpvtdistrictName,
      str_regdgovtpvtOfficeName;
  String _appBarTitle = "Registration"; // Default title
  void _toggleVisibility() {
    setState(() {
      _isVisibleADDDoctorsDetails = !_isVisibleADDDoctorsDetails;
    });
  }

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
    _future = _getStatesDAta();
    oganisationTypeGovtPrivateDRopDown = null; // Ensure it starts as null
    submitButtonRegisteredUSerID = true; // or set based on some condition


    // ✅ Set the default selected radio to "New User"
    _value = 1;
    newUSerGovtPrivateRegisterRadios = true;
    registeredUSerGovtPrivateRegsiterations = false;

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text("Registration of Govt./Private /Other Hospital",
            maxLines:2,
            style: new TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            GovtRAdioGroups(),
            registeredUSerGovtPrivateRegsiteration(),
            newUSerGovtPrivateRegisterRadio(),
            newUSerGovtPrivateRegisterRadiousedForRegisteredUSer()
          ],
        ),
      ),
    );
  }

  Widget GovtRAdioGroups() {
    return Column(
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          print('@@radio--' + _value.toString());
                          newUSerGovtPrivateRegisterRadios = true;
                          registeredUSerGovtPrivateRegsiterations = false;
                          buildCaptcha();
                          _future = _getStatesDAta();

                          print('@@radioAPi Select get value======' +
                              value.toString());
                        });
                      }),
                  SizedBox(width: 10.0),
                  Text('New User'),
                  Radio(
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          print('@@radio--' + _value.toString());
                          newUSerGovtPrivateRegisterRadios = false;
                          registeredUSerGovtPrivateRegsiterations = true;
                        });
                      }),
                  SizedBox(width: 10.0),
                  Text('Registered User'),
                ],
              )
            ]),
      ],
    );
  }

  Widget registeredUSerGovtPrivateRegsiteration() {
    return Column(
      children: [
        Visibility(
          visible: registeredUSerGovtPrivateRegsiterations,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: new TextField(
                      controller: _registeredUSerID,
                      decoration: InputDecoration(
                          label: Text('Registered User Id'),
                          hintText: 'Registered User Id',

                          //prefixIcon
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height: 10),
                  // TextFormField to enter captcha value

                  Visibility(
                    visible: submitButtonRegisteredUSerID,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(130, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black,
                        ),
                        onPressed: () {
                          print('@@GOVTPRivate-Click--Registered User Id');
                          _RegistraterUserIDSubmit();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chevron_right, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }




  //scroll issue resolve code

  Widget newUSerGovtPrivateRegisterRadio() {
    return Column(children: [
      Visibility(
        visible: newUSerGovtPrivateRegisterRadios,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
          child: SingleChildScrollView(
            // ✅ Wrap ListView with SingleChildScrollView
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                      // Background color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.grey), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.blue), // Highlighted border color
                      ),
                    ),
                    value: oganisationTypeGovtPrivateDRopDown,
                    hint: Text(
                      "Select",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconStyleData: IconStyleData(

                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.black), // Dropdown icon
                    ),
                    items: [
                      'Govt District Hospital',
                      'CHC/Govt. Sub-Dist. Hospital',
                      'Private Practitioner',
                      'Private Medical College',
                      'Other (Institution not claiming fund from NPCBVI)',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        oganisationTypeGovtPrivateDRopDown = newValue?.trim();
                        print(
                            '@@oganisationTypeGovtPrivateDRopDown--$oganisationTypeGovtPrivateDRopDown');

                        // Assigning dropDownvalueOrgnbaistaionType based on selection
                        switch (oganisationTypeGovtPrivateDRopDown) {
                          case "Govt District Hospital":
                            dropDownvalueOrgnbaistaionType = 10;
                            isVisibleHostpiatnNinitrictGovt = true;
                            break;
                          case "CHC/Govt. Sub-Dist. Hospital":
                            dropDownvalueOrgnbaistaionType = 11;
                            isVisibleHostpiatnNinitrictGovt = false;
                            break;
                          case "Private Practitioner":
                            dropDownvalueOrgnbaistaionType = 12;
                            isVisibleHostpiatnNinitrictGovt = true;
                            break;
                          case "Private Medical College":
                            dropDownvalueOrgnbaistaionType = 13;
                            isVisibleHostpiatnNinitrictGovt = false;
                            break;
                          case "Other (Institution not claiming fund from NPCBVI)":
                            dropDownvalueOrgnbaistaionType = 14;
                            isVisibleHostpiatnNinitrictGovt = false;
                            break;
                        }

                        print(
                            '@@dropDownvalueOrgnbaistaionType--$dropDownvalueOrgnbaistaionType');
                      });
                    },
                  ),
                ),



                SizedBox(height: 5),
                Visibility(
                  visible: isVisibleHostpiatnNinitrictGovt,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                          child: new TextFormField(
                            controller: _HospitalNINnoGovtController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 10,
                            decoration: InputDecoration(
                                label: Text('Hospital NIN no '),
                                hintText: 'Hospital NIN no',

                                //prefixIcon

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: ElevatedButton(
                            child: Text('Verify'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              print('@@HNNNumberAPi---');
                              //   _submitForm();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*Visibility(
                    visible: isVisibleHostpiatnNinitrictGovt,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextFormField(
                        controller: _HospitalNINnoGovtController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 10,
                        decoration: InputDecoration(
                            label: Text('Hospital NIN no '),
                            hintText: 'Hospital NIN no',

                            //prefixIcon

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    )),*/
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: _mobileGovtPRivate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Mobile No.',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Mobile No', // Regular hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 50, // Maintain consistency with other fields
                    child: TextField(
                      controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Email ID',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Email ID', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                // TextFormField to enter captcha value
                SizedBox(height:5),
                Container(
                  child: FutureBuilder<List<Data>>(
                    future: _future, // Future to fetch the data
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      // Logging data for debugging
                      developer.log('@@snapshot: ${snapshot.data}');

                      List<Data> stateList = snapshot.data;

                      // Ensure selected state is in the list, otherwise select the first
                      if (_selectedUser == null ||
                          !stateList.contains(_selectedUser)) {
                        _selectedUser = stateList.first;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            DropdownButtonFormField<Data>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
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
                              ),
                              onChanged: (user) => setState(() {
                                _selectedUser = user;
                                stateCodeGovtPrivate =
                                    int.parse(user.stateCode.toString());
                                CodeGovtPrivate = user.code;

                                if (stateCodeGovtPrivate != null) {
                                  isVisibleDitrictGovt = true;
                                  _getDistrictData(stateCodeGovtPrivate);
                                } else {
                                  isVisibleDitrictGovt = false;
                                }
                              }),
                              value: _selectedUser,
                              items: stateList
                                  .map<DropdownMenuItem<Data>>((Data user) {
                                return DropdownMenuItem<Data>(
                                  value: user,
                                  child: Text(user.stateName),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Visibility(
                  visible: isVisibleDitrictGovt,
                  child: Column(
                    children: [
                      Center(
                        child: FutureBuilder<List<DataDsiricst>>(
                          future: _getDistrictData(stateCodeGovtPrivate),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            // Logging for debugging
                            developer.log('@@snapshot: ${snapshot.data}');

                            List<DataDsiricst> districtList = snapshot.data;

                            // Ensure selected district is in the list, otherwise select the first one
                            if (_selectedUserDistrict == null ||
                                !districtList
                                    .contains(_selectedUserDistrict)) {
                              _selectedUserDistrict = districtList.first;
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButtonFormField<DataDsiricst>(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.blue[50],
                                    ),
                                    onChanged: (districtUser) => setState(() {
                                      _selectedUserDistrict = districtUser;
                                      distCodeGovtPrivate = int.parse(
                                          districtUser.districtCode
                                              .toString());
                                      // Update state or further actions here
                                      print(
                                          'Selected District: ${districtUser.districtName}');
                                    }),
                                    value: _selectedUserDistrict,
                                    items: districtList
                                        .map((DataDsiricst district) {
                                      return DropdownMenuItem<DataDsiricst>(
                                        value: district,
                                        child: Text(district.districtName),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 50, // Maintain consistency with other fields
                    child: TextField(
                      controller: _addressGovtPRivate,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Address',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Address', // Updated hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 50, // Ensure uniform height with other fields
                    child: TextField(
                      controller: _pinbCodeGovtPRivate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Pin Code',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Pin Code', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjusted to 8.0 for consistency
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 50, // Ensures consistency with other fields
                    child: TextField(
                      controller: _officerNAmeGovtPRivate,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Officer Name',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Red Asterisk
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Officer Name',
                        // Updated hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjusted for a cleaner look
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    width: double.infinity,
                    // Ensures full width
                    padding: EdgeInsets.all(12),
                    // Adds some padding inside the border
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      // Darker & thicker border
                      borderRadius: BorderRadius.circular(
                          5), // Optional: Rounded corners
                    ),
                    child: Center(
                      // Ensures text is centered inside the box
                      child: RichText(
                        text: TextSpan(
                          text: 'Equipment Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black, // Text color
                          ),
                          children: [
                            TextSpan(
                              text: ' *', // Red Asterisk
                              style: TextStyle(
                                color: Colors.red, // Red color
                                fontWeight: FontWeight.bold, // Bold for emphasis
                                fontSize: 16, // Adjust size if needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: EquipmentListWidget(), // ✅ Fixes scrolling issue
                ),


                 SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _captchaControllerGovtPrivateScreen,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Enter Captcha Value',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              // ✅ Only update if value changes significantly
                              if (!isVerified) {
                                setState(() {
                                  isVerified = false;
                                });
                              }
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
                            onPressed: () {
                              setState(() {
                                buildCaptcha(); // ✅ Refresh Captcha properly
                              });
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                if (_isVisibleADDDoctorsDetails)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          width: double.infinity,
                          // Ensures full width
                          padding: EdgeInsets.all(12),
                          // Adds some padding inside the border
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            // Darker & thicker border
                            borderRadius: BorderRadius.circular(
                                5), // Optional: Rounded corners
                          ),
                          child: Center(
                            // Ensures text is centered inside the box
                            child: RichText(
                              text: TextSpan(
                                text: 'Doctor Registration',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black, // Text color
                                ),
                                children: [
                                  TextSpan(
                                    text: '', // Red Asterisk
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures consistency with other fields
                          child: TextField(
                            controller: _doctorMCIReg,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'MCI Reg. No.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter MCI Reg. No.',
                              // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Consistent with Officer Name field
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures uniform height for all input fields
                          child: TextField(
                            controller: _doctorName,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Name',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter Name', // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Consistent styling
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures consistency with other fields
                          child: TextField(
                            controller: _doctorMobileNumber,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Mobile No.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter MCI Reg. No.',
                              // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Consistent with Officer Name field
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures consistency with other fields
                          child: TextField(
                            controller: _doctorEmailId,
                            keyboardType: TextInputType.emailAddress,
                            // Ensures email format
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Email ID',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter Email ID',
                              // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Improved UI consistency
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures consistency with other fields
                          child: TextField(
                            controller: _doctorPinCode,
                            keyboardType: TextInputType.number,
                            // Ensures numeric input
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Pin Code',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Red Asterisk
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter Pin Code',
                              // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Improved UI consistency
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SizedBox(
                          height: 40, // Reduced height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              minimumSize: Size(100, 40),
                              // Reduced button size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Slightly smaller radius
                              ),
                              elevation: 3,
                              // Reduced elevation
                              shadowColor: Colors.black,
                            ),
                            onPressed: () {
                              isVerified =
                                  _captchaControllerGovtPrivateScreen.text ==
                                      randomString;
                              setState(() {});
                              print(
                                  '@@_NewUSerGovtPrivateRegisterSubmit----Pending');
                              if (counterSaveGovtButtonValue == 1) {
                                _NewUSerGovtPrivateRegisterSubmit();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.save,
                                    color: Colors.white,
                                    size: 18), // Reduced icon size
                                SizedBox(width: 3),
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 12, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SizedBox(
                          height: 40, // Reduced height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: Size(100, 40),
                              // Reduced button size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Slightly smaller radius
                              ),
                              elevation: 3,
                              // Reduced elevation
                              shadowColor: Colors.black,
                            ),
                            onPressed: () {
                              if (counterSaveGovtButtonValue == 1) {
                                print('@@counterSaveGovtButtonValue--' +
                                    counterSaveGovtButtonValue.toString());
                                Utils.showToast(
                                    "You need to save the data first", true);
                              } else {
                                setState(() {
                                  print(
                                      '@@counterSaveGovtButtonValue--Else--' +
                                          counterSaveGovtButtonValue
                                              .toString());
                                  print('@@AddDoctors click__here');
                                  textValueAddDoctors = 'Doctors Added';
                                  _toggleVisibility();
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add,
                                    color: Colors.white,
                                    size: 18), // Reduced icon size
                                SizedBox(width: 3),
                                Text(
                                  textValueAddDoctors,
                                  style: TextStyle(
                                    fontSize: 12, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget newUSerGovtPrivateRegisterRadiousedForRegisteredUSer() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(), // Enables smooth scrolling
      child: Column(
        children: [
          Visibility(
            visible: newUSerGovtPrivateRegisterRadiosusedForRegisteredUSer,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 10, 5),
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [

              Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,

                    // ✅ Fix: Ensure value exists in items, else set null
                    value: dropdownItems.contains(oganisationTypeGovtPrivateDRopDown)
                        ? oganisationTypeGovtPrivateDRopDown
                        : null,

                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    style: TextStyle(color: Colors.black, fontSize: 10),

                    items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 10), // ⬅️ Smaller Font Size
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (String newValue) {
                      if (newValue != null) {
                        setState(() {
                          oganisationTypeGovtPrivateDRopDown = newValue;
                          developer.log('@@Selected Value: $oganisationTypeGovtPrivateDRopDown');

                          switch (oganisationTypeGovtPrivateDRopDown) {
                            case "Govt. District Hospital/Govt.MEdical College":
                              dropDownvalueOrgnbaistaionType = 10;
                              isVisibleHostpiatnNinitrictGovt = true;
                              break;
                            case "CHC/Govt. Sub-Dist. Hospital":
                              dropDownvalueOrgnbaistaionType = 11;
                              isVisibleHostpiatnNinitrictGovt = false;
                              break;
                            case "Private Practitioner":
                              dropDownvalueOrgnbaistaionType = 12;
                              isVisibleHostpiatnNinitrictGovt = true;
                              break;
                            case "Private Medical College":
                              dropDownvalueOrgnbaistaionType = 13;
                              isVisibleHostpiatnNinitrictGovt = false;
                              break;
                            case "Other(Institution not claiming fund from NPCBVI)":
                              dropDownvalueOrgnbaistaionType = 14;
                              isVisibleHostpiatnNinitrictGovt = false;
                              break;
                          }

                          developer.log('@@dropDownvalueOrgnbaistaionType: $dropDownvalueOrgnbaistaionType');
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        labelText: str_regdgovtpvtOrgType,
                        // Use labelText for dynamic text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _organisationNameGovtPrivate,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: Text('Organisation Name * '),
                          hintText: 'Organisation Name * ',
                          //prefixIcon
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height:5),
                  Visibility(
                    visible: isVisibleHostpiatnNinitrictGovt,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextFormField(
                              controller: _HospitalNINnoGovtController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 10,
                              decoration: InputDecoration(
                                  label: Text('Hospital NIN no '),
                                  hintText: 'Hospital NIN no',

                                  //prefixIcon

                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: ElevatedButton(
                              child: Text('Verify'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                print('@@HNNNumberAPi---');
                                //   _submitForm();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:5),
                  Visibility(
                      visible: isVisibleHostpiatnNinitrictGovt,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: new TextFormField(
                          controller: _HospitalNINnoGovtController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          decoration: InputDecoration(
                              label: Text('Hospital NIN no '),
                              hintText: 'Hospital NIN no',

                              //prefixIcon

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      )),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _mobileGovtPRivate,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          label: Text('Mobile No. * '),
                          hintText: 'Mobile No. *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        labelText: str_regdgovtpvtEmailId,
                        // Use labelText for dynamic text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),

                  // TextFormField to enter captcha value
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      // controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        labelText: str_regdgovtpvtstateName,
                        // Use labelText for dynamic text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.5, color: Colors.grey[300]),
                      ),
                    ),
                    child: Center(
                      child: FutureBuilder<List<Data>>(
                          future: _future,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.data == null) {
                              return const CircularProgressIndicator();
                            }

                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Colors.grey[300]),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 10, 20.0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Select State:',
                                    ),
                                    DropdownButtonFormField<Data>(
                                      onChanged: (user) => setState(() {
                                        _selectedUser = user;
                                        stateCodeGovtPrivate = int.parse(
                                            (user.stateCode).toString());
                                        print('@@statenameSPO' +
                                            stateCodeGovtPrivate.toString());
                                        CodeGovtPrivate = user.code;
                                        print('@@CodeSPO___1' +
                                            CodeGovtPrivate.toString());
                                        if (stateCodeGovtPrivate != null) {
                                          print('@@chakValue---' +
                                              stateCodeGovtPrivate
                                                  .toString());
                                          isVisibleDitrictGovt = true;
                                          _getDistrictData(
                                              stateCodeGovtPrivate);
                                        } else {
                                          isVisibleDitrictGovt = false;
                                        }
                                      }),
                                      value: _selectedUser,
                                      items: [
                                        ...snapshot.data.map(
                                          (user) => DropdownMenuItem(
                                            value: user,
                                            child: Text('${user.stateName}'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(height:5),
                  Visibility(
                    visible: isVisibleDitrictGovt,
                    child: Column(
                      children: [
                        Center(
                          child: FutureBuilder<List<DataDsiricst>>(
                              future: _getDistrictData(stateCodeGovtPrivate),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.data == null) {
                                  return const CircularProgressIndicator();
                                }
                                developer.log(
                                    '@@snapshot' + snapshot.data.toString());

                                List list = snapshot.data
                                    .map<DataDsiricst>((district) {
                                  return district;
                                }).toList();
                                if (_selectedUserDistrict == null ||
                                    list.contains(_selectedUserDistrict) ==
                                        false) {
                                  _selectedUserDistrict = list.first;
                                }
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 10, 20.0, 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Select District:',
                                      ),
                                      DropdownButtonFormField<DataDsiricst>(
                                        onChanged: (districtUser) =>
                                            setState(() {
                                          _selectedUserDistrict =
                                              districtUser;
                                          distCodeGovtPrivate = int.parse(
                                              (districtUser.districtCode
                                                  .toString()));
                                          distNameDPM = districtUser
                                              .districtName
                                              .toString();
                                          print('@@@Districtuser' +
                                              districtUser.districtName
                                                  .toString() +
                                              "-00000" +
                                              distNameDPM);
                                          setState(() {});
                                        }),
                                        value: _selectedUserDistrict,
                                        items: snapshot.data.map<
                                                DropdownMenuItem<
                                                    DataDsiricst>>(
                                            (DataDsiricst district) {
                                          return DropdownMenuItem<
                                              DataDsiricst>(
                                            value: district,
                                            child:
                                                Text(district.districtName),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      // controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        labelText: str_regdgovtpvtdistrictName,
                        // Use labelText for dynamic text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _addressGovtPRivate,
                      decoration: InputDecoration(
                          label: Text('Address  *'),
                          hintText: 'Address  *',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _pinbCodeGovtPRivate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text('Pin Code *'),
                          hintText: 'Pin Code *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      // controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                        labelText: str_regdgovtpvtOfficeName,
                        // Use labelText for dynamic text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: Container(
//                alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text(
                        'Equipment Details *',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(height:5),

                  Row(
                    children: <Widget>[
                      FutureBuilder(
                        future:
                            ApiController.getEquipmentGovtPRivateModel(),
                        builder: (context, projectSnap) {
                          if (projectSnap.connectionState ==
                                  ConnectionState.none &&
                              projectSnap.hasData == null) {
                            return Container();
                          } else {
                            if (projectSnap.hasData) {
                              GovtPRivateModel response = projectSnap.data;
                              if (response.status) {
                                offerList = response.list;
                                if (offerList.isEmpty) {
                                  return Utils.getEmptyView(
                                      "No data found");
                                } else {
                                  _controllers = List.generate(
                                      offerList.length,
                                      (index) => TextEditingController());
                                  return Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: offerList.length,
                                      itemBuilder: (context, index) {
                                        ListGovtPRivateModel offer =
                                            offerList[index];

                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            20,
                                                            10,
                                                            20.0,
                                                            0),
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Colors.white,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                        offer.name,
                                                        textDirection:
                                                            TextDirection
                                                                .ltr,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            4, 10, 4.0, 0),
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Colors.black,
                                                          //
                                                          width: 0.4,
                                                        ),
                                                      ),
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: TextField(
                                                        controller:
                                                            _controllers[
                                                                index],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          //  offerList[index].quantity = value;
                                                          // Optionally, parse the value to an integer if you need it as such
                                                          int parsedValue =
                                                              int.tryParse(
                                                                  value);

                                                          // Update the offerList with the parsed value or keep it as a string
                                                          offerList[index]
                                                                  .quantity =
                                                              parsedValue !=
                                                                      null
                                                                  ? parsedValue
                                                                      .toString()
                                                                  : value;

                                                          // Debug output
                                                          print(
                                                              '@@equpimentList__id----${offerList[index].quantity}');
                                                          print(
                                                              '@@equpimentList__value-----$value');
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              } else {
                                return Utils.getEmptyView("No data found");
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.black26,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.black26)),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height:5),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Shown Captcha value to user
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: red1)),
                            child: Text(
                              '${randomString}',
                              style: TextStyle(
                                  color: red1, fontWeight: FontWeight.w500),
                            )),
                        const SizedBox(
                          width: 10,
                        ),

                        // Regenerate captcha value
                        IconButton(
                            onPressed: () {
                              buildCaptcha();
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  ),
                  SizedBox(height:5),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(height:5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isVerified = false;
                        });
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Captcha Value",
                          labelText: "Enter Captcha Value"),
                      controller: _captchaControllerGovtPrivateScreen,
                    ),
                  ),
                  SizedBox(height:5),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(height:5),
                  if (_isVisibleADDDoctorsDetails)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            width: double.infinity,
                            // Ensures full width
                            padding: EdgeInsets.all(12),
                            // Adds some padding inside the border
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              // Darker & thicker border
                              borderRadius: BorderRadius.circular(
                                  5), // Optional: Rounded corners
                            ),
                            child: Center(
                              // Ensures text is centered inside the box
                              child: RichText(
                                text: TextSpan(
                                  text: 'Doctor Registration',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black, // Text color
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '', // Red Asterisk
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: new TextField(
                            controller: _doctorMCIReg,
                            decoration: InputDecoration(
                                label: Text('MCI Reg. No.*'),
                                hintText: 'MCI Reg. No.*',

                                //prefixIcon

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: new TextField(
                            controller: _doctorName,
                            decoration: InputDecoration(
                                label: Text('Name'),
                                hintText: 'Name *',

                                //prefixIcon

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: SizedBox(
                            height: 55, // Set desired height
                            child: TextField(
                              controller: _doctorMobileNumber,
                              decoration: InputDecoration(
                                labelText: 'Mobile No. *',
                                hintText: 'Mobile No. *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: new TextField(
                            controller: _doctorEmailId,
                            decoration: InputDecoration(
                                label: Text('Email ID *'),
                                hintText: 'Email ID. *',

                                //prefixIcon

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: new TextField(
                            controller: _doctorPinCode,
                            decoration: InputDecoration(
                                label: Text('Pin Code *'),
                                hintText: 'Pin Code *',

                                //prefixIcon

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height:5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: ElevatedButton(
                            child: Text(
                              'Save',
                              style: TextStyle(fontSize: 12),
                            ),
                            // Set smaller font size here
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              isVerified =
                                  _captchaControllerGovtPrivateScreen.text ==
                                      randomString;

                              setState(() {});

                              print(
                                  '@@_NewUSerGovtPrivateRegisterSubmit----Wait here---Pending');
                              if (counterSaveGovtButtonValue == 1) {
                                _NewUSerGovtPrivateRegisterSubmit();
                              }
                              //_NewUSerGovtPrivateRegisterSubmit();
                              //   _submitForm();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: ElevatedButton(
                            child: Text(
                              textValueAddDoctors,
                              style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              if (counterSaveGovtButtonValue == 1) {
                                print('@@counterSaveGovtButtonValue--' +
                                    counterSaveGovtButtonValue.toString());
                                Utils.showToast(
                                    "you need to save the data  First", true);
                              } else {
                                setState(() {
                                  print(
                                      '@@counterSaveGovtButtonValue--Else--' +
                                          counterSaveGovtButtonValue
                                              .toString());
                                  print('@@AddDoctors click__here');
                                  textValueAddDoctors = 'Doctors Add';
                                  _toggleVisibility();
                                });
                              }

                              //   _submitForm();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _NewUSerGovtPrivateRegisterSubmit() async {
    print('@@registration_of_Govt_Private_Other_Hospital ---34');
    List<DupRegisterEquipmentName > equipmentList =
        govtPrivateRegistatrionDataFields.equipmentList ?? [];

    print('@@91--Length--' + offerList.length.toString());
    for (int i = 0; i < offerList.length; i++) {
      print('@@911--id:' + offerList[i].id.toString());
      // Add a new EquipmentName to the equipmentList
      int quantity = int.tryParse(_controllers[i].text) ?? 0;
      print('@@911--quantity:' + quantity.toString());
      equipmentList.add(
          DupRegisterEquipmentName (equCatId: offerList[i].id, equCatQuantity: quantity));
      print('@@equipmentData---Screenclass--' +
          DupRegisterEquipmentName (equCatId: offerList[i].id).toString());
    }
    govtPrivateRegistatrionDataFields.equipmentList = equipmentList;
    govtPrivateRegistatrionDataFields.dropDownvalueOrgnbaistaionTypes =
        dropDownvalueOrgnbaistaionType;
    print('@@1' +
        govtPrivateRegistatrionDataFields.dropDownvalueOrgnbaistaionTypes
            .toString());
    govtPrivateRegistatrionDataFields.HospitalNinNumber =
        _HospitalNINnoGovtController.text.toString().trim();
    print(
        '@@2' + govtPrivateRegistatrionDataFields.HospitalNinNumber.toString());
    govtPrivateRegistatrionDataFields.organisationNameGovt =
        _organisationNameGovtPrivate.text.toString().trim();
    print('@@3' +
        govtPrivateRegistatrionDataFields.organisationNameGovt.toString());
    govtPrivateRegistatrionDataFields.MobileNoGovt =
        _mobileGovtPRivate.text.toString().trim(); //CodeDPM; testing purpose
    print('@@4' + govtPrivateRegistatrionDataFields.MobileNoGovt.toString());
    govtPrivateRegistatrionDataFields.EmailIDGovt =
        _emailIDGovtPRivate.text.toString().trim();
    print('@@5' + govtPrivateRegistatrionDataFields.EmailIDGovt.toString());
    govtPrivateRegistatrionDataFields.hStateid = stateCodeGovtPrivate;

    govtPrivateRegistatrionDataFields.hDistrictid = distCodeGovtPrivate;
    print('@@1001--' +
        govtPrivateRegistatrionDataFields.hStateid.toString() +
        "----" +
        govtPrivateRegistatrionDataFields.hDistrictid.toString());
    govtPrivateRegistatrionDataFields.AddressGovt =
        _addressGovtPRivate.text.toString().trim();
    print('@@6' + govtPrivateRegistatrionDataFields.AddressGovt.toString());
    govtPrivateRegistatrionDataFields.pinCodeGovt =
        _pinbCodeGovtPRivate.text.toString().trim();
    print('@@7' + govtPrivateRegistatrionDataFields.pinCodeGovt.toString());
    govtPrivateRegistatrionDataFields.OfficernameGovt =
        _officerNAmeGovtPRivate.text.toString().trim();
    print('@@8' + govtPrivateRegistatrionDataFields.OfficernameGovt.toString());

    govtPrivateRegistatrionDataFields.CapchaCodeGovtPvt =
        _captchaControllerGovtPrivateScreen.text.toString().trim();
    print(
        '@@9' + govtPrivateRegistatrionDataFields.CapchaCodeGovtPvt.toString());

    if (govtPrivateRegistatrionDataFields.MobileNoGovt.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    }
    if (govtPrivateRegistatrionDataFields.EmailIDGovt.isNotEmpty &&
        !isValidEmail(_spoEmailIdController.text.toString().trim())) {
      Utils.showToast("Please enter valid email", false);
      return;
    }
    if (govtPrivateRegistatrionDataFields.AddressGovt.isEmpty) {
      Utils.showToast("Please enter Address !", false);
      return;
    }
    if (govtPrivateRegistatrionDataFields.pinCodeGovt.isEmpty) {
      Utils.showToast("Please enter PhoneNumber !", false);
      return;
    }
    if (govtPrivateRegistatrionDataFields.OfficernameGovt.isEmpty) {
      Utils.showToast("Please enter Office Address !", false);
      return;
    }

    if (govtPrivateRegistatrionDataFields.CapchaCodeGovtPvt.isEmpty) {
      Utils.showToast("Please enter Matched Captcha !", false);
      return;
    } else {
      print('@@registration_of_Govt_Private_Other_Hospital ---34');

      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          print('@@registration_of_Govt_Private_Other_Hospital ---32');

          ApiController.registration_of_Govt_Private_Other_HospitalCopy(
                  govtPrivateRegistatrionDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            if (response.message
                .contains("Hospital Registered Successfully.")) {
              print('@@registration_of_Govt_Private_Other_Hospital ---3211');
              Utils.showToast("Record Saved successfully!", true);
              counterSaveGovtButtonValue = counterSaveGovtButtonValue + 1;
              _captchaControllerGovtPrivateScreen.clear();
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }




  Future<void> _RegistraterUserIDSubmit() async {
    print("@@_RegistraterUserIDSubmit----");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    String stateCode_loginFetch = prefs.getString(AppConstant.state_code) ?? "";
    print("@@districtCode_loginFetch__from login: $districtCode_loginFetch");
    print("@@stateCode_loginFetch__from login: $stateCode_loginFetch");
    String registeredUSerID = _registeredUSerID.text.toString().trim();
    if (registeredUSerID.isEmpty) {
      Utils.showToast("Please enter registered USerID !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.GetRegisteredUserGvtprivates(
                  registeredUSerID /*stateCode_loginFetch,districtCode_loginFetch*/)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@spoAPiRquest ---' + response.toString());
            if (response != null && response.status) {
              setState(() {
                List<DatagovtPrivateRegisterUSerId>
                    daatagovtPrivateRegisterUSerI = response.data;
                str_regdgovtpvtEmailId = daatagovtPrivateRegisterUSerI[0].email;
                str_regdgovtpvtOrgType = daatagovtPrivateRegisterUSerI[0].name;
                str_regdgovtpvtstateName =
                    daatagovtPrivateRegisterUSerI[0].stateName;
                str_regdgovtpvtdistrictName =
                    daatagovtPrivateRegisterUSerI[0].districtName;
                str_regdgovtpvtOfficeName =
                    daatagovtPrivateRegisterUSerI[0].orgName;
                print('@@str_regdgovtpvtEmailId--' + str_regdgovtpvtEmailId);
                //registeredUSerGovtPrivateRegsiterations = true;
                submitButtonRegisteredUSerID = false;
                newUSerGovtPrivateRegisterRadiosusedForRegisteredUSer = true;
              });
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }








  bool isValidEmail(String input) {
    //Email is opation
    if (input.trim().isEmpty) return true;
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    bool isMatch = regex.hasMatch(input);
    if (!isMatch) Utils.showToast("Please enter valid email", false);
    return isMatch;
  }

  Widget _buildMenuItem({
    IconData icon,
    String title,
    Function() onTap,
  }) {
    double size =
        14.0; // You can set a consistent size for both the icon and text

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      // Reduce the vertical padding
      title: Row(
        children: [
          Icon(icon, color: Colors.black, size: size),
          // Set icon size
          SizedBox(
            width: 8.0,
            height: 4.0,
          ),
          // Add space between the icon and the text
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: size,
              fontWeight:
                  FontWeight.normal, // Explicitly set fontWeight to normal
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDropdownItem({
    GlobalKey key,
    String value,
    String hint,
    List<Map<String, dynamic>>
        items, // List of maps to hold both item text and icon data
    Function(String) onChanged,
    Icon hintIcon, // Make hintIcon nullable
  }) {
    double size = 14.0; // Consistent size for both text and icon

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0), // Remove extra padding
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: key,
          // Assign the key here
          value: value,
          style: TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          items:
              items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Row(
                children: [
                  Icon(
                    item['icon'], // Icon from the map
                    color: Colors.black,
                    size: size, // Set icon size
                  ),
                  SizedBox(width: 8.0), // Add space between the icon and text
                  Text(
                    item['value'],
                    style: TextStyle(
                        color: Colors.black, fontSize: size), // Set text size
                  ),
                ],
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
                  children: [
                    hintIcon, // Only add the icon if it's not null
                    SizedBox(
                        width: 8.0), // Add space between the icon and hint text
                    Text(
                      hint,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Text(
                  hint,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
///////////////////////////////////////Outside the class declare heloper classes.

class GovtPrivateRegistatrionDataFieldss {
  int dropDownvalueOrgnbaistaionTypes;
  String HospitalNinNumber;
  String organisationNameGovt;
  String MobileNoGovt;
  String EmailIDGovt;
  int hStateid;
  int hDistrictid;
  String AddressGovt;
  String pinCodeGovt;
  String OfficernameGovt;
  String CapchaCodeGovtPvt;
  List<DupRegisterEquipmentName > equipmentList;
/*
  GovtPrivateRegistatrionDataFields({
     this.dropDownvalueOrgnbaistaionTypes,
     this.HospitalNinNumber,
     this.organisationNameGovt,
     this.MobileNoGovt,
     this.EmailIDGovt,
     this.AddressGovt,
     this.pinCodeGovt,
     this.OfficernameGovt,
     this.CapchaCodeGovtPvt,
     this.equipmentList,
  });*/
}

class offerLists {
  int id;
  String quantity;

  offerLists({this.id, this.quantity = ''});
}



// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  int hRoleid;
  String hName;
  String hMobileNo;
  String hEmailId;
  int hStateid;
  int hDistrictid;
  String hAddress;
  int hPinCode;
  String hOfficerName;
  String hNinNo;
  int inserttype;
  String mode;
  String npcbnumber;
  List<DupRegisterEquipmentName > equipmentName;

  Welcome({
    this.hRoleid,
    this.hName,
    this.hMobileNo,
    this.hEmailId,
    this.hStateid,
    this.hDistrictid,
    this.hAddress,
    this.hPinCode,
    this.hOfficerName,
    this.hNinNo,
    this.inserttype,
    this.mode,
    this.npcbnumber,
    this.equipmentName,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        hRoleid: json["h_roleid"],
        hName: json["h_Name"],
        hMobileNo: json["h_MobileNo"],
        hEmailId: json["h_EmailID"],
        hStateid: json["h_stateid"],
        hDistrictid: json["h_districtid"],
        hAddress: json["h_Address"],
        hPinCode: json["h_PinCode"],
        hOfficerName: json["h_Officer_Name"],
        hNinNo: json["h_NIN_no"],
        inserttype: json["inserttype"],
        mode: json["mode"],
        npcbnumber: json["npcbnumber"],
        equipmentName: List<DupRegisterEquipmentName >.from(
            json["equipmentName"].map((x) => DupRegisterEquipmentName .fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "h_roleid": hRoleid,
        "h_Name": hName,
        "h_MobileNo": hMobileNo,
        "h_EmailID": hEmailId,
        "h_stateid": hStateid,
        "h_districtid": hDistrictid,
        "h_Address": hAddress,
        "h_PinCode": hPinCode,
        "h_Officer_Name": hOfficerName,
        "h_NIN_no": hNinNo,
        "inserttype": inserttype,
        "mode": mode,
        "npcbnumber": npcbnumber,
        "equipmentName":
            List<dynamic>.from(equipmentName.map((x) => x.toJson())),
      };
}

class DupRegisterEquipmentName  {
  int equCatId;
  int equCatQuantity;

  DupRegisterEquipmentName ({
    this.equCatId,
    this.equCatQuantity,
  });

  factory DupRegisterEquipmentName .fromJson(Map<String, dynamic> json) => DupRegisterEquipmentName (
        equCatId: json["equCat_ID"],
        equCatQuantity: json["equCat_Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "equCat_ID": equCatId,
        "equCat_Quantity": equCatQuantity,
      };
}

