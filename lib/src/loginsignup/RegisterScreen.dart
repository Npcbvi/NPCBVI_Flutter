import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/UpcomingHomeGuidlines.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/govtPrivateRegisterUSerId.dart';
import 'package:mohfw_npcbvi/src/registerScreens/NGORegistrationScreen.dart';
import 'package:mohfw_npcbvi/src/repositories/country_state_city_repo.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:dropdown_button2/dropdown_button2.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  Future<List<Data>> _future;
  Data _selectedUser;
  DataDsiricst _selectedUserDistrict;

  String _chosenValue,
      oganisationTypeGovtPrivateDRopDown,
      _chosenValueRegisertaion;
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

  final _ngoDarpanNumberController = new TextEditingController();
  final _ngoPANNumberController = new TextEditingController();
  SPODataFields spoDataFields = new SPODataFields();
  NGODDataFields ngodDataFields = new NGODDataFields();
  DPMDataFields dpmDataFields = new DPMDataFields();
  GovtPrivateRegistatrionDataFields govtPrivateRegistatrionDataFields =
      new GovtPrivateRegistatrionDataFields();
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
    showHomeScreen = true;
    _future = _getStatesDAta();
    submitButtonRegisteredUSerID = true; // or set based on some condition
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text(_appBarTitle,
            maxLines:2,
            style: new TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              // do something
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: 100.0, // Set the width of the drawer
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(8.0),
            // Reduce the margin to decrease space// Set the margin here
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Home',
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Home';
                      _appBarTitle="Home";
                      Navigator.pop(context);
                      showHomeScreen = true;
                      showNGOResgistration = false;
                      showSPORegistration = false;
                      showDPMRegistration = false;
                      showGOVTPrivate = false;
                      newUSerGovtPrivateRegisterRadios = false;
                      registeredUSerGovtPrivateRegsiterations = false;
                    });
                  },
                ),

                _buildDropdownItem(
                  value: _chosenValueRegisertaion,
                  hint: 'Registeration',
                  hintIcon: Icon(Icons.update, color: Colors.black),
                  // Add an icon to the hint
                  items: [
                    {'value': 'NGO', 'icon': Icons.person_add},
                    // Add an icon here
                    {'value': 'Govt./Private /Other', 'icon': Icons.update},
                    {'value': 'SPO', 'icon': Icons.visibility},
                    {'value': 'DPM', 'icon': Icons.visibility},
                  ],

                  onChanged: (String value) {
                    setState(() {
                      _chosenValueRegisertaion = value;
                      _appBarTitle = value+" Registration"; // Update AppBar title dynamically

                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValueRegisertaion == "NGO") {
                        print('@@NGO--1' + _chosenValueRegisertaion);
                        /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NGORegistrationScreen()));*/
                        showNGOResgistration = true;
                        showSPORegistration = false;
                        showDPMRegistration = false;
                        showGOVTPrivate = false;
                        newUSerGovtPrivateRegisterRadios = false;
                        registeredUSerGovtPrivateRegsiterations = false;
                        showHomeScreen = false;
                      } else if (_chosenValueRegisertaion == "SPO") {
                        //getCountries();
                        _future = _getStatesDAta();
                        print('@@showSPORegistration--2' +
                            _chosenValueRegisertaion);
                        showNGOResgistration = false;
                        showSPORegistration = true;
                        showDPMRegistration = false;
                        showGOVTPrivate = false;
                        newUSerGovtPrivateRegisterRadios = false;
                        registeredUSerGovtPrivateRegsiterations = false;
                        showHomeScreen = false;
                      } else if (_chosenValueRegisertaion == "DPM") {
                        //getCountries();
                        _future = _getStatesDAta();

                        // _getDistrictData(18);

                        print('@@showSPORegistration--3' +
                            _chosenValueRegisertaion +
                            value.toString());
                        showNGOResgistration = false;
                        showSPORegistration = false;
                        showDPMRegistration = true;
                        showGOVTPrivate = false;
                        newUSerGovtPrivateRegisterRadios = false;
                        showHomeScreen = false;
                        registeredUSerGovtPrivateRegsiterations = false;
                      } else if (_chosenValueRegisertaion ==
                          "Govt./Private /Other") {
                        showNGOResgistration = false;
                        showSPORegistration = false;
                        showDPMRegistration = false;
                        showGOVTPrivate = true;
                        showHomeScreen = false;
                        // ✅ Set the default selected radio to "New User"
                        _future = _getStatesDAta();
                        _value = 1;
                        newUSerGovtPrivateRegisterRadios = true;
                        registeredUSerGovtPrivateRegsiterations = false;
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
                // not Removes all previous screens
                /*    _buildMenuItem(
                  icon: Icons.login,
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
                    //  Navigator.pop(context);
                  },
                ),*/
                // Removes all previous screens
                _buildMenuItem(
                  icon: Icons.login,
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      Navigator.pop(context); // Close the menu if needed
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false, // Removes all previous screens
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Expanded(
                  child: Marquee(
                text: 'NGO Darpan number is mandatory for registration.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
                velocity: 50.0,
                //speed
                pauseAfterRound: Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              )),
            ),
            HomeScreen(),
            NGORegistration(),
            GovtRAdioGroups(),
            SPORegistration(),
            DPMRegistration(),
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
        Visibility(
          visible: showGOVTPrivate,
          child: Column(
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
        ),
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

  Widget HomeScreen() {
    return Column(
      children: [
        Visibility(
          visible: showHomeScreen,
          child: Center(
            child: Text(
              "UpComing Screen",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget NGORegistration() {
    return Column(
      children: [
        Visibility(
          visible: showNGOResgistration,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  // NGO Darpan Number TextField
                  SizedBox(
                    height: 50, //
                    child: TextField(
                      controller: _ngoDarpanNumberController,
                      decoration: InputDecoration(
                        labelText: 'NGO Darpan number',
                        hintText: 'Enter NGO Darpan number',
                        prefixIcon: Icon(Icons.business, color: Colors.grey),
                        // 👈 Added icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ), //
                  // NGO PAN Number TextField
                  SizedBox(
                    height: 50, //
                    child: TextField(
                      controller: _ngoPANNumberController,
                      decoration: InputDecoration(
                        labelText: 'NGO PAN number',
                        hintText: 'Enter NGO PAN number',
                        prefixIcon: Icon(Icons.credit_card, color: Colors.grey),
                        // 👈 Added icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(
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
                        print('@@NGO Button click__work pending');
                        // _NGORegistrationSubmit();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Verify',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Submit Button
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //SPO Registyartion work here

  //scroll issue resolve code
  Widget SPORegistration() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: showSPORegistration,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    width: 350, // Set consistent width
                    height: 60,
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
                              borderSide: BorderSide(color: Colors.blue, width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: TextFormField(
                              controller: stdControllerSpo,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                                // Restrict to 5 digits
                              ],
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'STD',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                hintText: 'Enter STD Code',
                                hintStyle: TextStyle(color: Colors.grey),
                                // Hint text color
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: TextFormField(
                              controller: _spoPhoneNumberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                                // Restrict to 10 digits
                              ],
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Phone Number',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                hintText: 'Enter Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                // Hint text color
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
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
                  SizedBox(height: 10),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              print('@@Spo Submit Button');
                              _spoRegistrationSubmit();
                            },
                            icon: Icon(Icons.check, color: Colors.white),
                            label: Text(
                              'Submit',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              minimumSize: Size(150, 40), // Set width and height
                              fixedSize: Size(180, 50), // Fixed width and height
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                              ),
                              elevation: 6,
                              shadowColor: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(width: 20), // Spacing between buttons
                        Expanded(
                          child: ElevatedButton.icon(
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
                            icon: Icon(Icons.refresh, color: Colors.white),
                            label: Text(
                              'Reset',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: Size(150, 40), // Set width and height
                              fixedSize: Size(180, 50), // Fixed width and height
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 6,
                              shadowColor: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newUSerGovtPrivateRegisterRadio() {
    return Column(children: [
      Visibility(
        visible: newUSerGovtPrivateRegisterRadios,
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: SingleChildScrollView(
            // ✅ Wrap ListView with SingleChildScrollView
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      filled: true,
                      fillColor: Colors.blue[50],
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
                          color: Colors.white), // Dropdown icon
                    ),
                    items: [
                      'Govt. District Hospital/Govt. Medical College',
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
                        oganisationTypeGovtPrivateDRopDown = newValue;
                        print(
                            '@@oganisationTypeGovtPrivateDRopDown--$oganisationTypeGovtPrivateDRopDown');

                        // Assigning dropDownvalueOrgnbaistaionType based on selection
                        switch (oganisationTypeGovtPrivateDRopDown) {
                          case "Govt. District Hospital/Govt. Medical College":
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

                Visibility(
                  visible: isVisibleHostpiatnNinitrictGovt,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
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
                                fillColor: Colors.blue[50],
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
                                  const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                              text: '', // Red Asterisk
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Row(
                    children: <Widget>[
                      FutureBuilder(
                        future: ApiController.getEquipmentGovtPRivateModel(),
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
                                  return Utils.getEmptyView("No data found");
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
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 5, 20.0, 0),
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                        offer.name,
                                                        textDirection:
                                                            TextDirection.ltr,
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
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        4, 5, 4.0, 0),
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black26)),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 50, // Adjust height as needed
                          child: TextField(
                            controller: _captchaControllerGovtPrivateScreen,
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
                const SizedBox(
                  height: 10,
                ),
                if (_isVisibleADDDoctorsDetails)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Container(
//                alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Text(
                            'Doctor Registration',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: SizedBox(
                          height: 50,
                          // Ensures uniform height with other input fields
                          child: TextField(
                            controller: _doctorMobileNumber,
                            keyboardType: TextInputType.number,
                            // Ensures only numeric input
                            maxLength: 10,
                            // Limits input to 10 digits
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
                              hintText: 'Enter Mobile No.',
                              // Updated hint text
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Consistent styling
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color
                          borderRadius: BorderRadius.circular(15),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              // Shadow color
                              spreadRadius: 2,

                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5), // Inner padding
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: oganisationTypeGovtPrivateDRopDown,
                            icon:
                                Icon(Icons.arrow_drop_down, color: Colors.blue),
                            // Dropdown icon
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            // Text style
                            items: <String>[
                              'Govt. District Hospital/Govt.MEdical College',
                              'CHC/Govt. Sub-Dist. Hospital',
                              'Private Practitioner',
                              'Private Medical College',
                              'Other(Institution not claiming fund from NPCBVI)',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
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
                            onChanged:
                                (String oganisationTypeGovtPrivateDRopDownss) {
                              setState(() {
                                oganisationTypeGovtPrivateDRopDown =
                                    oganisationTypeGovtPrivateDRopDownss;
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown);
                                if (oganisationTypeGovtPrivateDRopDown ==
                                    "Govt. District Hospital/Govt.MEdical College") {
                                  isVisibleHostpiatnNinitrictGovt = true;

                                  dropDownvalueOrgnbaistaionType = 10;
                                  print(
                                      '@@oganisationTypeGovtPrivateDRopDown--' +
                                          oganisationTypeGovtPrivateDRopDown +
                                          "-----" +
                                          dropDownvalueOrgnbaistaionType
                                              .toString());
                                } else if (oganisationTypeGovtPrivateDRopDown ==
                                    "CHC/Govt. Sub-Dist. Hospital") {
                                  dropDownvalueOrgnbaistaionType = 11;
                                  print(
                                      '@@oganisationTypeGovtPrivateDRopDown--' +
                                          oganisationTypeGovtPrivateDRopDown +
                                          "-----" +
                                          dropDownvalueOrgnbaistaionType
                                              .toString());
                                  isVisibleHostpiatnNinitrictGovt = false;
                                } else if (oganisationTypeGovtPrivateDRopDown ==
                                    "Private Practitioner") {
                                  dropDownvalueOrgnbaistaionType = 12;
                                  print(
                                      '@@oganisationTypeGovtPrivateDRopDown--' +
                                          oganisationTypeGovtPrivateDRopDown +
                                          "-----" +
                                          dropDownvalueOrgnbaistaionType
                                              .toString());
                                  isVisibleHostpiatnNinitrictGovt = true;
                                } else if (oganisationTypeGovtPrivateDRopDown ==
                                    "Private Medical College") {
                                  dropDownvalueOrgnbaistaionType = 13;
                                  print(
                                      '@@oganisationTypeGovtPrivateDRopDown--' +
                                          oganisationTypeGovtPrivateDRopDown +
                                          "-----" +
                                          dropDownvalueOrgnbaistaionType
                                              .toString());
                                  isVisibleHostpiatnNinitrictGovt = false;
                                } else if (oganisationTypeGovtPrivateDRopDown ==
                                    "Other(Institution not claiming fund from NPCBVI)") {
                                  dropDownvalueOrgnbaistaionType = 14;
                                  print(
                                      '@@oganisationTypeGovtPrivateDRopDown--' +
                                          oganisationTypeGovtPrivateDRopDown +
                                          "-----" +
                                          dropDownvalueOrgnbaistaionType
                                              .toString());
                                  isVisibleHostpiatnNinitrictGovt = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),

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

                    Container(
                      child: Row(
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
                    ),

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
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
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
          ),
        ],
      ),
    );
  }

  Future<void> _NewUSerGovtPrivateRegisterSubmit() async {
    print('@@registration_of_Govt_Private_Other_Hospital ---34');
    List<EquipmentName> equipmentList =
        govtPrivateRegistatrionDataFields.equipmentList ?? [];

    print('@@91--Length--' + offerList.length.toString());
    for (int i = 0; i < offerList.length; i++) {
      print('@@911--id:' + offerList[i].id.toString());
      // Add a new EquipmentName to the equipmentList
      int quantity = int.tryParse(_controllers[i].text) ?? 0;
      print('@@911--quantity:' + quantity.toString());
      equipmentList.add(
          EquipmentName(equCatId: offerList[i].id, equCatQuantity: quantity));
      print('@@equipmentData---Screenclass--' +
          EquipmentName(equCatId: offerList[i].id).toString());
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
    // List<EquipmentName> equipmentList;
    // List<EquipmentName> equipmentList;

    /*if (govtPrivateRegistatrionDataFields.organisationNameGovt.isEmpty) {
      Utils.showToast("Please enter Organisatioon Name !", false);
      return;
    }*/
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

          // Utils.showProgressDialog1(context);
          ApiController.registration_of_Govt_Private_Other_Hospital(
                  govtPrivateRegistatrionDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            if (response.message
                .contains("Hospital Registered Successfully.")) {
              //  Navigator.pop(context);
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

  Future<void> _spoRegistrationSubmit() async {
    spoDataFields.stdSPO = int.parse(stdControllerSpo.text.toString().trim());
    spoDataFields.state = stateCodeSPO;
    spoDataFields.codeSPOs = CodeSPO;
    spoDataFields.Name = _spoNAmeController.text.toString().trim();
    spoDataFields.mobileNumber = _spoMobileController.text.toString().trim();
    spoDataFields.emailId = _spoEmailIdController.text.toString().trim();
    spoDataFields.designation =
        _spoDestinationController.text.toString().trim();
    spoDataFields.PhoneNumber =
        _spoPhoneNumberController.text.toString().trim();
    spoDataFields.OfficeAddress =
        _spoOfficeAddressController.text.toString().trim();
    spoDataFields.PinCode = _spoPinCodeController.text.toString().trim();
    spoDataFields.CaptchaCodeEnter =
        _spoCaptchaCodeEnterController.text.toString().trim();
    print('@@stateCodeSPO.state' + stateCodeSPO.toString());
    print('@@spoDataFields.spoDataFields' + spoDataFields.codeSPOs);
    if (spoDataFields.Name.isEmpty) {
      Utils.showToast("Please enter Name !", false);
      return;
    }
    if (spoDataFields.mobileNumber.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    }
    if (spoDataFields.emailId.isNotEmpty &&
        !isValidEmail(_spoEmailIdController.text.toString().trim())) {
      Utils.showToast("Please enter valid email", false);
      return;
    }
    if (spoDataFields.designation.isEmpty) {
      Utils.showToast("Please enter Designation !", false);
      return;
    }
    if (spoDataFields.PhoneNumber.isEmpty) {
      Utils.showToast("Please enter PhoneNumber !", false);
      return;
    }
    if (spoDataFields.OfficeAddress.isEmpty) {
      Utils.showToast("Please enter Office Address !", false);
      return;
    }
    if (spoDataFields.PinCode.isEmpty) {
      Utils.showToast("Please enter PinCode !", false);
      return;
    }
    if (spoDataFields.CaptchaCodeEnter.isEmpty) {
      Utils.showToast("Please enter Matched Captcha !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.spoRegistrationAPiRquest(spoDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@spoAPiRquest ---' + response.status.toString());
            if (response.status) {
              //    Navigator.pop(context);
              Utils.showToast(response.message, true);
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
              Utils.showToast(response.message, true);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }

/*  Future<void> _NGORegistrationSubmit() async {
    ngodDataFields.ngoDarpanNumber =
        _ngoDarpanNumberController.text.toString().trim();
    ;
    ngodDataFields.ngoPANNumber =
        _ngoPANNumberController.text.toString().trim();

    print('@@ngoDarpanNumber' + stateCodeSPO.toString());
    print('@@ngodDataFields' + spoDataFields.codeSPOs);
    if (ngodDataFields.ngoDarpanNumber.isEmpty) {
      Utils.showToast("Please enter Name !", false);
      return;
    }
    if (ngodDataFields.ngoPANNumber.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.ngoRegistrationAPiRquest(spoDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@spoAPiRquest ---' + response.toString());
            if (response != null && response.status) {

              Navigator.pop(context);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }*/

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

  /*Widget DPMRegistration() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: showDPMRegistration,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: FutureBuilder<List<Data>>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          // Logging for debugging
                          developer.log('@@snapshot: ${snapshot.data}');

                          List<Data> stateList = snapshot.data;

                          // Ensure selected state is in the list, otherwise select the first
                          if (_selectedUser == null || !stateList.contains(_selectedUser)) {
                            _selectedUser = stateList.first;
                          }

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Select State:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonFormField<Data>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  onChanged: (user) => setState(() {
                                    _selectedUser = user;
                                    stateCodeDPM = int.parse(user.stateCode.toString());
                                    print('@@statenameSPO: $stateCodeDPM');
                                    codeDPM = user.code;
                                    print('@@CodeSPO___1: $codeDPM');
                                    distNameDPM = user.stateName;

                                    // Update shared preferences and visibility based on the selected state
                                    if (codeDPM != null) {
                                      print('@@CodeSPO___66: $codeDPM statename ----- $distNameDPM');
                                      SharedPrefs.storeSharedValue(AppConstant.txtStateDPmValue, stateCodeDPM);
                                      isVisibleDitrict = true;
                                      _getDistrictData(stateCodeDPM);
                                    } else {
                                      isVisibleDitrict = false;
                                    }
                                    setState(() {});
                                  }),
                                  value: _selectedUser,
                                  items: stateList.map<DropdownMenuItem<Data>>((Data user) {
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
                    )
                    ,

                    Visibility(
                      visible: isVisibleDitrict,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Select District:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
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

                                  // Logging for debugging
                                  developer.log('@@snapshot: ${snapshot.data}');

                                  List<DataDsiricst> districtList = snapshot.data;

                                  // Ensure selected district is in the list, otherwise select the first
                                  if (_selectedUserDistrict == null || !districtList.contains(_selectedUserDistrict)) {
                                    _selectedUserDistrict = districtList.isNotEmpty ? districtList.first : null;
                                  }

                                  return DropdownButtonFormField<DataDsiricst>(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.blue[50],
                                    ),
                                    onChanged: (districtUser) {
                                      setState(() {
                                        _selectedUserDistrict = districtUser;
                                        distCodeDPM = int.parse(districtUser.districtCode.toString());
                                        distNameDPMs_distictValues = districtUser.districtName;
                                        print('@@@Districtuser: ${districtUser.districtName}');
                                      });
                                    },
                                    value: _selectedUserDistrict,
                                    items: districtList.map<DropdownMenuItem<DataDsiricst>>((DataDsiricst district) {
                                      return DropdownMenuItem<DataDsiricst>(
                                        value: district,
                                        child: Text(district.districtName),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    ,

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _dpmNAmeController,
                        decoration: InputDecoration(
                            label: Text('Name'),
                            hintText: 'Name',
                            //prefixIcon
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _dpmMobileController,
                        maxLength: 10,
                        decoration: InputDecoration(
                            label: Text('Mobile Number'),
                            hintText: 'Mobile Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _dpmEmailIdController,
                        decoration: InputDecoration(
                            label: Text('EmailID'),
                            hintText: 'EmailID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _dpmDestinationController,
                        decoration: InputDecoration(
                            label: Text('Designation'),
                            hintText: 'Designation',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextFormField(
                              controller: stdControllerDPM,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 10,
                              decoration: InputDecoration(
                                  label: Text('Std'),
                                  hintText: 'Std',

                                  //prefixIcon

                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _dpmPhoneNumberController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  label: Text('Phone Number'),
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _dpmOfficeAddressController,
                        decoration: InputDecoration(
                            label: Text('Office Address'),
                            hintText: 'Office Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        maxLength: 6,
                        controller: _dpmPinCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            label: Text('Pin Code'),
                            hintText: 'Pin Code',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
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
                                //  buildCaptcha();
                              },
                              icon: const Icon(Icons.refresh)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // TextFormField to enter captcha value
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: TextFormField(
                        controller: _dpmCaptchaCodeEnterController,

                        */ /*  onChanged: (value) {
                        setState(() {
                          isVerified = false;
                        });
                      },*/ /*
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Captcha Value",
                            labelText: "Enter Captcha Value"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            print('@@DPMMMM Hit here-----Api---------');
                            _DPMRegistrationSubmit();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                        child: Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          _dpmNAmeController.clear();
                          _dpmMobileController.clear();
                          _dpmPinCodeController.clear();
                          _dpmOfficeAddressController.clear();
                          _dpmEmailIdController.clear();
                          _dpmPhoneNumberController.clear();
                          _dpmCaptchaCodeEnterController.clear();
                          _dpmDestinationController.clear();
                          stdControllerDPM.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
  Widget DPMRegistration() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: showDPMRegistration,
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
                children: [
                  SizedBox(
                    width: 350, // Set consistent width
                    height: 60,
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
                              fillColor: Colors.blue[50],
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

                  SizedBox(height: 10), // Adjust height as needed

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
                                  fillColor: Colors.blue[50],
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
                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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

                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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
                  SizedBox(height: 10), // Adjust height as needed

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
                              controller: _captchaController,
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
                  SizedBox(height: 10), // Adjust height as needed

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing
                      children: [
                        SizedBox(
                          width: 150, // Set button width
                          height: 50, // Set button height
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.send, color: Colors.white), // Submit Icon
                            label: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Button color
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              minimumSize: Size(150, 50), // Minimum size
                              fixedSize: Size(150, 50), // Fixed width & height
                              elevation: 5, // Shadow effect
                              shadowColor: Colors.black54, // Shadow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners
                              ),
                            ),
                            onPressed: () {
                              print('@@DPMMMM Hit here-----Api---------');
                              _DPMRegistrationSubmit();
                            },
                          ),
                        ),
                        SizedBox(width: 10), // Spacing between buttons
                        SizedBox(
                          width: 150, // Set button width
                          height: 50, // Set button height
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.refresh, color: Colors.white), // Reset Icon
                            label: Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Reset button color
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              minimumSize: Size(150, 50), // Minimum size
                              fixedSize: Size(150, 50), // Fixed width & height
                              elevation: 5, // Shadow effect
                              shadowColor: Colors.black54, // Shadow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners
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
          ),
        ],
      ),
    );
  }

  Future<void> _DPMRegistrationSubmit() async {
    dpmDataFields.stdDPMs = int.parse(stdControllerDPM.text.toString().trim());
    dpmDataFields.stateDPM = stateCodeDPM;
    dpmDataFields.distCodeDPM = distCodeDPM; //CodeDPM; testing purpose
    dpmDataFields.NameDPM = _dpmNAmeController.text.toString().trim();
    dpmDataFields.mobileNumberDPM = _dpmMobileController.text.toString().trim();
    dpmDataFields.emailIdDPM = _dpmEmailIdController.text.toString().trim();
    dpmDataFields.designationDPM =
        _dpmDestinationController.text.toString().trim();
    dpmDataFields.PhoneNumberDPM =
        _dpmPhoneNumberController.text.toString().trim();
    dpmDataFields.OfficeAddressDPM =
        _dpmOfficeAddressController.text.toString().trim();
    dpmDataFields.PinCodeDPM = _dpmPinCodeController.text.toString().trim();
    dpmDataFields.CaptchaCodeEnterDPM =
        _dpmCaptchaCodeEnterController.text.toString().trim();
    dpmDataFields.codeSPOsDPM = codeDPM;
    dpmDataFields.distNameDPMs = distNameDPM;
    dpmDataFields.distNameDPMs_distictValue = distNameDPMs_distictValues;
    print('@@codeDPM.state__Dist_name---1' +
        dpmDataFields.distNameDPMs.toString());
    print('@@codeDPM.state__1' + codeDPM.toString());
    print('@@codeDPM.state___2' + dpmDataFields.codeSPOsDPM.toString());
    if (dpmDataFields.NameDPM.isEmpty) {
      Utils.showToast("Please enter Name !", false);
      return;
    }
    if (dpmDataFields.mobileNumberDPM.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    }
    if (dpmDataFields.emailIdDPM.isNotEmpty &&
        !isValidEmail(_spoEmailIdController.text.toString().trim())) {
      Utils.showToast("Please enter valid email", false);
      return;
    }
    if (dpmDataFields.designationDPM.isEmpty) {
      Utils.showToast("Please enter Designation !", false);
      return;
    }
    if (dpmDataFields.PhoneNumberDPM.isEmpty) {
      Utils.showToast("Please enter PhoneNumber !", false);
      return;
    }
    if (dpmDataFields.OfficeAddressDPM.isEmpty) {
      Utils.showToast("Please enter Office Address !", false);
      return;
    }
    if (dpmDataFields.PinCodeDPM.isEmpty) {
      Utils.showToast("Please enter PinCode !", false);
      return;
    }
    if (dpmDataFields.CaptchaCodeEnterDPM.isEmpty) {
      Utils.showToast("Please enter Matched Captcha !", false);
      return;
    }
    if (dpmDataFields.stdDPMs == null || dpmDataFields.stdDPMs == 0) {
      Utils.showToast("Please enter std !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.DPMRegistrationAPiRquest(dpmDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@dpmDataFields ---1' + response.toString());
            print('@@dpmDataFields ---2' + response.status.toString());
            if (response.status) {
              Utils.showToast(response.message, true);
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
              Utils.showToast(response.message, true);
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

class GovtPrivateRegistatrionDataFields {
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
  List<EquipmentName> equipmentList;
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

class DPMDataFields {
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

class NGODDataFields {
  String ngoDarpanNumber;
  String ngoPANNumber;
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
  List<EquipmentName> equipmentName;

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
        equipmentName: List<EquipmentName>.from(
            json["equipmentName"].map((x) => EquipmentName.fromJson(x))),
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

class EquipmentName {
  int equCatId;
  int equCatQuantity;

  EquipmentName({
    this.equCatId,
    this.equCatQuantity,
  });

  factory EquipmentName.fromJson(Map<String, dynamic> json) => EquipmentName(
        equCatId: json["equCat_ID"],
        equCatQuantity: json["equCat_Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "equCat_ID": equCatId,
        "equCat_Quantity": equCatQuantity,
      };
}

//NGO Registration view

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
//Save
