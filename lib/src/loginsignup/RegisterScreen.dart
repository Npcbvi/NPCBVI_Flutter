import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:mohfw_npcbvi/src/repositories/country_state_city_repo.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  Future<List<Data>> _future;
  Future<List<DataDsirict>> _futureDataDsirict;

  Data _selectedUser;
  DataDsirict _selectedUserDistrict;

  String _chosenValue,oganisationTypeGovtPrivateDRopDown;
  String randomString = "";
  bool showGOVTPrivate = false;
  bool showNGOResgistration = false;
  bool showSPORegistration = false;
  bool showDPMRegistration = false;
  bool registeredUSerGovtPrivateRegsiterations=false;
  bool newUSerGovtPrivateRegisterRadios=false;
  bool isVisibleDitrict = false;
  bool isLoadingApi = true;
  DashboardStateModel dashboardStateModel;

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
  DashboardStateModel countryStateModel =
      DashboardStateModel(status: false, message: '', data: []);
  bool isDataLoaded = false;
  int stateCodeSPO, disrtcCode, stateCodeDPM,stateCodeGovtPrivate;
  String CodeSPO, codeDPM,CodeGovtPrivate;
  int _value = 1; // int型の変数.
  String _text = ''; // String型の変数.
  final _registeredUSerID = new TextEditingController();

  final _organisationNameGovtPrivate = new TextEditingController();
  final _mobileGovtPRivate = new TextEditingController();
  final _emailIDGovtPRivate = new TextEditingController();
  final _addressGovtPRivate = new TextEditingController();
  final _pinbCodeGovtPRivate = new TextEditingController();
  final _officerNAmeGovtPRivate = new TextEditingController();

  Future<List<Data>> _getStatesDAta() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http
          .get(Uri.parse('https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/State'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final DashboardStateModel dashboardStateModel =
      DashboardStateModel.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }


  }

  Future<DashboardDistrictModel> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel;
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"state_code": stateCode});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/ListDistrict",
          data: body,
          options: new Options(responseType: ResponseType.plain));
      print("@@Response--Api" + response1.toString());
      dashboardDistrictModel =
          DashboardDistrictModel.fromJson(json.decode(response1.data));
      print("@@dashboardDistrictModel" + dashboardDistrictModel.toString());

      return dashboardDistrictModel;
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Registration ',
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
                                showDPMRegistration = false;
                                showGOVTPrivate=false;
                                newUSerGovtPrivateRegisterRadios=false;
                                 registeredUSerGovtPrivateRegsiterations=false;
                              } else if (_chosenValue == "SPO") {
                                //getCountries();
                                _future = _getStatesDAta();
                                print(
                                    '@@showSPORegistration--2' + _chosenValue);
                                showNGOResgistration = false;
                                showSPORegistration = true;
                                showDPMRegistration = false;
                                showGOVTPrivate=false;
                                newUSerGovtPrivateRegisterRadios=false;
                                registeredUSerGovtPrivateRegsiterations=false;
                              } else if (_chosenValue == "DPM") {
                                //getCountries();
                                _future = _getStatesDAta();

                                // _getDistrictData(18);

                                print('@@showSPORegistration--3' +
                                    _chosenValue +
                                    value.toString());
                                showNGOResgistration = false;
                                showSPORegistration = false;
                                showDPMRegistration = true;
                                showGOVTPrivate=false;
                                newUSerGovtPrivateRegisterRadios=false;
                                registeredUSerGovtPrivateRegsiterations=false;
                              }
                              else if(_chosenValue=="Govt./Private /Other"){
                                showNGOResgistration = false;
                                showSPORegistration = false;
                                showDPMRegistration = false;
                                showGOVTPrivate=true;
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
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Expanded(
                  child: Marquee(
                    text: 'NGO Darpan number is mandatory for registration.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:20,color: Colors.red),
                    velocity: 50.0, //speed
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )
              ),
            ),
            NGORegistration(),
            GovtRAdioGroups(),
            SPORegistration(),
            DPMRegistration(),
            newUSerGovtPrivateRegisterRadio(),
            registeredUSerGovtPrivateRegsiteration()
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
                            print('@@radio--'+_value.toString());
                            newUSerGovtPrivateRegisterRadios=true;
                            registeredUSerGovtPrivateRegsiterations=false;
                            _future = _getStatesDAta();
                            print(
                                '@@radioAPi hoit state--2');
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
                            print('@@radio--'+_value.toString());
                            newUSerGovtPrivateRegisterRadios=false;
                            registeredUSerGovtPrivateRegsiterations=true;

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
  Widget registeredUSerGovtPrivateRegsiteration(){
    return Column(
      children: [
        Visibility(
          visible: registeredUSerGovtPrivateRegsiterations,
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
                      controller: _registeredUSerID,
                      decoration: InputDecoration(
                          label: Text('Registered User Id'),
                          hintText: 'Registered User Id',

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
                      onPressed: () {
                        print('@@GOVTPRivate  Button click__work prnding');
                        _NGORegistrationSubmit();
                      },
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
  Widget newUSerGovtPrivateRegisterRadio() {
    return Column(
      children: [
        Visibility(
          visible: newUSerGovtPrivateRegisterRadios,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.circular(10)),

                      child: new DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          focusColor: Colors.white,
                          value: oganisationTypeGovtPrivateDRopDown,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          items: <String>[
                            'Govt. District Hospital/Govt.MEdical College',
                            'CHC/Govt. Sub-Dist. Hospital',
                            'Private Practitioner',
                            'Private Medical College',
                            'Other(Institution not claiming fund from NPCBVI)',
                          ].map<DropdownMenuItem<String>>((String oganisationTypeGovtPrivateDRopDowns) {
                            return DropdownMenuItem<String>(
                              value: oganisationTypeGovtPrivateDRopDowns,
                              child: Text(
                                oganisationTypeGovtPrivateDRopDowns,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Select",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String oganisationTypeGovtPrivateDRopDownss) {
                            setState(() {
                              oganisationTypeGovtPrivateDRopDown = oganisationTypeGovtPrivateDRopDownss;
                                print('@@oganisationTypeGovtPrivateDRopDown--' + oganisationTypeGovtPrivateDRopDown);

                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _organisationNameGovtPrivate,
                      decoration: InputDecoration(
                          label: Text('Organisation Name * '),
                          hintText: 'Organisation Name * ',

                          //prefixIcon
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _mobileGovtPRivate,
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text('Mobile No. * '),
                          hintText: 'Mobile No. *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _emailIDGovtPRivate,
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text('Email ID *'),
                          hintText: 'Email ID *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  // TextFormField to enter captcha value
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
                                    stateCodeGovtPrivate = int.parse(
                                        (user.stateCode).toString());
                                    print('@@statenameSPO' +
                                        stateCodeGovtPrivate.toString());
                                    CodeGovtPrivate = user.code;
                                    print('@@CodeSPO___1' +
                                        CodeGovtPrivate.toString());
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
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                    child: ElevatedButton(
                      child: Text('Verify'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        print('@@NGO Button click__work prnding');
                        _NGORegistrationSubmit();
                      },
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
                      onPressed: () {
                        print('@@NGO Button click__work prnding');
                        _NGORegistrationSubmit();
                      },
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

  //SPO Registyartion work here
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
                            label: Text('Designation'),
                            hintText: 'Designation',
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

  Future<void> _NGORegistrationSubmit() async {
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
  }

//SPo Registration work h
  //DPM Work Here
  Widget DPMRegistration() {
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
                                      stateCodeDPM = int.parse(
                                          (user.stateCode).toString());
                                      print('@@statenameSPO' +
                                          stateCodeDPM.toString());
                                      codeDPM = user.code;
                                      print('@@CodeSPO___1' +
                                          stateCodeDPM.toString());

                                      if (codeDPM != null) {
                                        print('@@CodeSPO___66' +
                                            codeDPM.toString());

                                        SharedPrefs.storeSharedValue(
                                            AppConstant.txtStateDPmValue,
                                            stateCodeDPM);
                                        // setState(() {
                                        //   //    isVisibleDitrict = true;
                                        //   _getDistrictData(stateCodeSPO);
                                        // });
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
                            );
                          }),
                    ),
                    /*Visibility(
                        visible:  isVisibleDitrict,*/
                    /*   Center(
                      child: FutureBuilder<List<DataDsirict>>(
                          future: _futureDataDsirict,
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
                                    'Select District:',
                                  ),
                                  DropdownButtonFormField<DataDsirict>(
                                    onChanged: (Districtuser) => setState(() {
                                      _selectedUserDistrict = Districtuser;
                                      print('@@@Districtuser'+Districtuser.toString());
                                      disrtcCode = int.parse(
                                          (Districtuser.districtCode)
                                              .toString());
                                      print('@@disrtcCode' +
                                          disrtcCode.toString());
                                      //  CodeDPM = Districtuser.districtCode;
                                      *//* print('@@CodeDPM' +
                                          CodeDPM.toString());*//*
                                    }),
                                    value: _selectedUserDistrict,
                                    items: [
                                      ...snapshot.data.map(
                                        (userDistrict) => DropdownMenuItem(
                                          value: userDistrict,
                                          child: Text(
                                              '${userDistrict.districtName}'),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),*/

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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _dpmPhoneNumberController,
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
                        controller: _dpmPinCodeController,
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
                            print('@@DPMMMM  Button');
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

  Future<void> _DPMRegistrationSubmit() async {
    dpmDataFields.stateDPM = stateCodeDPM;
    dpmDataFields.distCodeDPM = 18; //CodeDPM; testing purpose
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
    print('@@stateCodeSPO.state' + dpmDataFields.toString());
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
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.DPMRegistrationAPiRquest(dpmDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@dpmDataFields ---' + response.toString());
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

class DPMDataFields {
  int stateDPM;
  int distCodeDPM;
  String NameDPM;
  String mobileNumberDPM;
  String emailIdDPM;
  String designationDPM;
  String stdDPM;
  String PhoneNumberDPM;
  String OfficeAddressDPM;
  String PinCodeDPM;
  String codeSPOsDPM;
  String CaptchaCodeEnterDPM;
}

class NGODDataFields {
  String ngoDarpanNumber;
  String ngoPANNumber;
}
//NGO Registration view

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
