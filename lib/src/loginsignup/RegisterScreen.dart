import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:mohfw_npcbvi/src/repositories/country_state_city_repo.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  Future<List<Data>> _future;
  Data _selectedUser;
  String _chosenValue;
  String randomString = "";
  bool showNGOResgistration = false;
  bool showSPORegistration = false;
  bool isLoadingApi = true;
  DashboardStateModel dashboardStateModel;
  String selectedCountry = 'Select Country';
  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();
  List<String> statesName = [];
  List<String> staCode = [];
  List<int> state_code = [];
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
  SPODataFields spoDataFields = new SPODataFields();

  DashboardStateModel countryStateModel =
      DashboardStateModel(status: false, message: '', data: []);
  bool isDataLoaded = false;
  int stateCodeSPO;
  String CodeSPO;

  /*getCountries() async {
    //
    isDataLoaded = false;
    countryStateModel = await _countryStateCityRepo.getCountriesStates();
    statesName.add('Select Country');
    for (var element in countryStateModel.data) {
      statesName.add(element.stateName);
      staCode.add(element.code);
      state_code.add(element.stateCode);
    }
    isDataLoaded = true;
    setState(() {});
    //
  }*/
  Future<List<Data>> _getUsers() async {
    final response = await http
        .get(Uri.parse('https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/State'));
    Map<String, dynamic> json = jsonDecode(response.body);
    final DashboardStateModel dashboardStateModel =
        DashboardStateModel.fromJson(json);
    return dashboardStateModel.data;
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Registeration',
              style: new TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Utils.hideKeyboard(context);
                Navigator.of(context).pop(context);
              })),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Shown Captcha value to user
                      Container(
                          child: Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      new DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          items: <String>[
                            'NGO',
                            'Govt./Private /Other',
                            'SPO',
                            'DPM',
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
                            "Registration",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                              //  print('@@spinnerChooseValue--' + _chosenValue);
                              if (_chosenValue == "NGO") {
                                print('@@NGO--1' + _chosenValue);

                                showNGOResgistration = true;
                                showSPORegistration = false;
                              } else if (_chosenValue == "SPO") {
                                //getCountries();
                                _future = _getUsers();
                                print(
                                    '@@showSPORegistration--2' + _chosenValue);
                                showNGOResgistration = false;
                                showSPORegistration = true;
                              }
                            });
                          },
                        ),
                      ),
                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                      InkWell(
                        onTap: () {
                          //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Container(
                            child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            NGORegistration(),
            SPORegistration(),
          ],
        ),
      ),
    );
  }

  Widget NGORegistration() {
    final _ngoDarpanNumberController = new TextEditingController();
    final _ngoPANNumberController = new TextEditingController();
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _ngoDarpanNumberController,
                      decoration: InputDecoration(
                          label: Text('NGO Darpan number'),
                          hintText: 'NGO Darpan number',

                          //prefixIcon
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _ngoPANNumberController,
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text('NGO PAN number'),
                          hintText: 'NGO PAN number',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  // TextFormField to enter captcha value

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                    child: ElevatedButton(
                      child: Text('Verify'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {},
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

  Widget SPORegistration() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: showSPORegistration,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    /*     Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: selectedCountry,
                          validator: (value) =>
                              value.isEmpty ? 'field required' : null,
                          items: statesName
                              .map((country) => DropdownMenuItem(
                                  value: country, child: Text(country)))
                              .toList(),
                          onChanged: (selectedValue) {
                            //
                            setState(() {
                              selectedCountry = selectedValue;
                            });
                            // In Video we have used getStates();
                            // getStates();
                            // But for improvement we can use one extra check

                            //
                          }),
                    ),*/
                    Center(
                      child: FutureBuilder<List<Data>>(
                          future: _future,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.data == null) {
                              return const CircularProgressIndicator();
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Select State:',
                                  ),
                                  DropdownButtonFormField<Data>(
                                    onChanged: (user) => setState(() {
                                      _selectedUser = user;
                                      stateCodeSPO = int.parse(
                                          (user.stateCode).toString());
                                      print('@@statenameSPO' +
                                          stateCodeSPO.toString());
                                      CodeSPO = user.code;
                                      print('@@CodeSPO___1' +
                                          stateCodeSPO.toString());
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
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _spoNAmeController,
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
                        controller: _spoMobileController,
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
                        controller: _spoEmailIdController,
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
                        controller: _spoDestinationController,
                        decoration: InputDecoration(
                            label: Text('Destination'),
                            hintText: 'Destination',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _spoPhoneNumberController,
                        decoration: InputDecoration(
                            label: Text('Phone Number'),
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        controller: _spoOfficeAddressController,
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
                        controller: _spoPinCodeController,
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
                        controller: _spoCaptchaCodeEnterController,

                        /*  onChanged: (value) {
                        setState(() {
                          isVerified = false;
                        });
                      },*/
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
                            print('@@Spo Submit Button');
                            _spoRegistrationSubmit();
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
                          _spoNAmeController.clear();
                          _spoMobileController.clear();
                          _spoPinCodeController.clear();
                          _spoOfficeAddressController.clear();
                          _spoEmailIdController.clear();
                          _spoPhoneNumberController.clear();
                          _spoCaptchaCodeEnterController.clear();
                          _spoDestinationController.clear();
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
  }

  Future<void> _spoRegistrationSubmit() async {
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
      Utils.showToast("Please enter Destination !", false);
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
          ApiController.spoAPiRquest(spoDataFields).then((response) async {
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
}

class SPODataFields {
  int state;
  String Name;
  String mobileNumber;
  String emailId;
  String designation;
  String std;
  String PhoneNumber;
  String OfficeAddress;
  String PinCode;
  String codeSPOs;
  String CaptchaCodeEnter;
}
//NGO Registration view

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
