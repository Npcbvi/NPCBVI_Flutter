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
import 'package:mohfw_npcbvi/src/loginsignup/CardEquipmentListScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/repositories/country_state_city_repo.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

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

  String _chosenValue, oganisationTypeGovtPrivateDRopDown;
  String randomString = "";
  bool showGOVTPrivate = false;
  bool showNGOResgistration = false;
  bool showSPORegistration = false;
  bool showDPMRegistration = false;
  bool registeredUSerGovtPrivateRegsiterations = false;
  bool newUSerGovtPrivateRegisterRadios = false;
  bool isVisibleDitrict = false;
  bool isVisibleDitrictGovt = false;
  bool isVisibleHostpiatnNinitrictGovt = false;

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
  int stateCodeSPO, disrtcCode, stateCodeDPM, stateCodeGovtPrivate, distCodeDPM;
  String CodeSPO, codeDPM, CodeGovtPrivate,distNameDPM;
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

  final _HospitalNINnoGovtController = new TextEditingController();

  /* final _organisationNameGovtContoller = new TextEditingController();
  final _MobileGovtContoller = new TextEditingController();
  final _EmailGovtContoller = new TextEditingController();

  final _AddressGovtContoller = new TextEditingController();

  final _PincodeGovtContoller = new TextEditingController();

  final _officerNameGovtContoller = new TextEditingController();*/

  Future<List<Data>> _getStatesDAta() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(
          Uri.parse('https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/State'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final DashboardStateModel dashboardStateModel =
          DashboardStateModel.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  /*Future< List<DataDsiricst>> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel
    =DashboardDistrictModel();;
    var response = await http.post("https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/ListDistrict",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "state_code": stateCode,
        }));

    if (response.statusCode == 200) {
      dashboardDistrictModel =
          DashboardDistrictModel.fromJson(json.decode(response.body));
      List<DataDsiricst> list=dashboardDistrictModel.data;
      return list;
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }
  }*/
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
                                showGOVTPrivate = false;
                                newUSerGovtPrivateRegisterRadios = false;
                                registeredUSerGovtPrivateRegsiterations = false;
                              } else if (_chosenValue == "SPO") {
                                //getCountries();
                                _future = _getStatesDAta();
                                print(
                                    '@@showSPORegistration--2' + _chosenValue);
                                showNGOResgistration = false;
                                showSPORegistration = true;
                                showDPMRegistration = false;
                                showGOVTPrivate = false;
                                newUSerGovtPrivateRegisterRadios = false;
                                registeredUSerGovtPrivateRegsiterations = false;
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
                                showGOVTPrivate = false;
                                newUSerGovtPrivateRegisterRadios = false;
                                registeredUSerGovtPrivateRegsiterations = false;
                              } else if (_chosenValue ==
                                  "Govt./Private /Other") {
                                showNGOResgistration = false;
                                showSPORegistration = false;
                                showDPMRegistration = false;
                                showGOVTPrivate = true;
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

  Widget getEquipmentsDetails() {
    return Container(
      child: Row(
        children: <Widget>[
          FutureBuilder(
            future: ApiController.getEquipmentGovtPRivateModel(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none &&
                  projectSnap.hasData == null) {
                return Container();
              } else {
                if (projectSnap.hasData) {
                  GovtPRivateModel response = projectSnap.data;
                  print('@@GovtPRivateModel__1' + response.status.toString());
                  List<ListGovtPRivateModel> offerList = response.list;
                  print('@@GovtPRivateModel__1--length' +
                      offerList.length.toString());
                  if (response.status) {
                    List<ListGovtPRivateModel> offerList = response.list;
                    if (offerList.isEmpty) {
                      return Utils.getEmptyView("No data found");
                    } else {
                      print(
                          '@@GovtPRivateModel__3' + response.status.toString());
                      print('@@GovtPRivateModel__length' +
                          offerList.length.toString());
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: offerList.length,
                          itemBuilder: (context, index) {
                            ListGovtPRivateModel offer = offerList[index];

                            print('@@GovtPRivateModel__4' + offer.toString());
                            return ListTile(
                              title: Text(
                                offer.id.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(offer.name.toString(),
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              trailing: Wrap(
                                spacing: 12, // space between two icons
                                children: <Widget>[
                                  Icon(Icons.arrow_right), // icon-2
                                ],
                              ),
                              onTap: () {},
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
                            AlwaysStoppedAnimation<Color>(Colors.black26)),
                  );
                }
              }
            },
          ),
        ],
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
                    Row(
                      children: [

                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextFormField(
                              controller: stdControllerSpo,
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
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child:       Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _spoPhoneNumberController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  label: Text('Phone Number'),

                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                      ],
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
                          stdControllerSpo.clear();
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
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
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
                          ].map<DropdownMenuItem<String>>(
                              (String oganisationTypeGovtPrivateDRopDowns) {
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
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown +
                                    "-----" +
                                    dropDownvalueOrgnbaistaionType.toString());
                              } else if (oganisationTypeGovtPrivateDRopDown ==
                                  "CHC/Govt. Sub-Dist. Hospital") {
                                dropDownvalueOrgnbaistaionType = 11;
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown +
                                    "-----" +
                                    dropDownvalueOrgnbaistaionType.toString());
                                isVisibleHostpiatnNinitrictGovt = false;
                              } else if (oganisationTypeGovtPrivateDRopDown ==
                                  "Private Practitioner") {
                                dropDownvalueOrgnbaistaionType = 12;
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown +
                                    "-----" +
                                    dropDownvalueOrgnbaistaionType.toString());
                                isVisibleHostpiatnNinitrictGovt = true;
                              } else if (oganisationTypeGovtPrivateDRopDown ==
                                  "Private Medical College") {
                                dropDownvalueOrgnbaistaionType = 13;
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown +
                                    "-----" +
                                    dropDownvalueOrgnbaistaionType.toString());
                                isVisibleHostpiatnNinitrictGovt = false;
                              } else if (oganisationTypeGovtPrivateDRopDown ==
                                  "Other(Institution not claiming fund from NPCBVI)") {
                                dropDownvalueOrgnbaistaionType = 14;
                                print('@@oganisationTypeGovtPrivateDRopDown--' +
                                    oganisationTypeGovtPrivateDRopDown +
                                    "-----" +
                                    dropDownvalueOrgnbaistaionType.toString());
                                isVisibleHostpiatnNinitrictGovt = false;
                              }
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _emailIDGovtPRivate,
                      decoration: InputDecoration(
                          label: Text('Email ID *'),
                          hintText: 'Email ID *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  // TextFormField to enter captcha value
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
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
                                        if (stateCodeGovtPrivate != null) {
                                          print('@@chakValue---' +
                                              stateCodeGovtPrivate.toString());
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

                                List list =
                                    snapshot.data.map<DataDsiricst>((district) {
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Select District:',
                                      ),
                                      DropdownButtonFormField<DataDsiricst>(
                                        onChanged: (districtUser) =>
                                            setState(() {
                                          _selectedUserDistrict = districtUser;
                                          distCodeDPM = int.parse((districtUser
                                              .districtCode
                                              .toString()));
                                        /*  distNameDPM= districtUser.districtName
                                              .toString();*/
                                          print('@@@Districtuser' +
                                              districtUser.districtName
                                                  .toString()/*+"-00000"+distNameDPM*/);
                                          setState(() {});
                                        }),
                                        value: _selectedUserDistrict,
                                        items: snapshot.data.map<
                                                DropdownMenuItem<DataDsiricst>>(
                                            (DataDsiricst district) {
                                          return DropdownMenuItem<DataDsiricst>(
                                            value: district,
                                            child: Text(district.districtName),
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: new TextField(
                      controller: _officerNAmeGovtPRivate,
                      decoration: InputDecoration(
                          label: Text('Officer Name *'),
                          hintText: 'Officer Name *',

                          //prefixIcon

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
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
                          future: ApiController.getEquipmentGovtPRivateModel(),
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none &&
                                projectSnap.hasData == null) {
                              return Container();
                            } else {
                              if (projectSnap.hasData) {
                                GovtPRivateModel response = projectSnap.data;
                                print('@@GovtPRivateModel__1' +
                                    response.status.toString());
                                if (response.status) {
                                  List<ListGovtPRivateModel> offerList =
                                      response.list;
                                  if (offerList.isEmpty) {
                                    return Utils.getEmptyView("No data found");
                                  } else {
                                    return Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: offerList.length,
                                        itemBuilder: (context, index) {
                                          ListGovtPRivateModel offer =
                                              offerList[index];

                                          print('@@GovtPRivateModel__4' +
                                              offer.toString());
                                         /* return Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            //                   <--- border color
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          offer.name,
                                                          textDirection: TextDirection.ltr,
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(4, 10, 4.0, 0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.black, //
                                                            width: 0.4,
                                                          ),
                                                        ),
                                                        alignment: Alignment.centerLeft,
                                                        child: TextField(
                                                          controller: _equipmentDetailQtyController,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );*/

                                          return CardEquipmentListScreen(offer);
                                          /*   return ListTile(

                                            title: Text(
                                              offer.id.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    offer.name.toString(), style: TextStyle(color: Colors.black
                                                )),
                                              ],
                                            ),
                                     trailing: Wrap(
                                              spacing: 12, // space between two icons
                                              children: <Widget>[
                                                Icon(Icons.arrow_right), // icon-2
                                              ],
                                            ),

                                            onTap: () {

                                            },

                                          );*/
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: ElevatedButton(
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              isVerified =
                                  _captchaControllerGovtPrivateScreen.text ==
                                      randomString;
                              print('@@isVerified' + isVerified.toString());
                              print('@@controller.text' +
                                  _captchaControllerGovtPrivateScreen.text
                                      .toString());
                              print('@@randomString' + randomString.toString());
                              setState(() {});

                              print(
                                  '@@_NewUSerGovtPrivateRegisterSubmit----Wait here---Pending');
                              _NewUSerGovtPrivateRegisterSubmit();
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
                            child: Text('Add Doctors'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              print('@@AddDoctors click__here');
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
    );
  }

  Future<void> _spoRegistrationSubmit() async {
    spoDataFields.stdSPO=int.parse(stdControllerSpo.text.toString().trim());
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
            }else{
              Utils.showToast(response.message, true);
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
                                      distNameDPM= user.stateName;
                                      if (codeDPM != null) {
                                        print('@@CodeSPO___66' +
                                            codeDPM.toString()+"statename -----"+distNameDPM);

                                        SharedPrefs.storeSharedValue(
                                            AppConstant.txtStateDPmValue,
                                            stateCodeDPM);
                                        if (stateCodeDPM != null) {
                                          print('@@chakValue---' +
                                              codeDPM.toString());
                                          isVisibleDitrict = true;
                                          _getDistrictData(stateCodeDPM);
                                        } else {
                                          isVisibleDitrict = false;
                                        }
                                        setState(() {});
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

                    Visibility(
                      visible: isVisibleDitrict,
                      child: Column(
                        children: [
                          Center(
                            child: FutureBuilder<List<DataDsiricst>>(
                                future: _getDistrictData(stateCodeDPM),
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
                                            distCodeDPM = int.parse(
                                                (districtUser.districtCode
                                                    .toString()));
                                            print('@@@Districtuser' +
                                                districtUser.districtName
                                                    .toString());
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
                                          /*      items: [
                                            ...snapshot.data
                                                .map(
                                                  (userDistricts) =>
                                                      DropdownMenuItem(
                                                    value: userDistricts,
                                                    child: Text(userDistricts
                                                        .districtName),
                                                  ),
                                                )
                                                .toList()
                                          ],*/
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
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child:     Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _dpmPhoneNumberController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  label: Text('Phone Number'),
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                /*    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _dpmPhoneNumberController,
                        maxLength: 10,
                        decoration: InputDecoration(
                            label: Text('Phone Number'),
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),*/
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
  }

  Future<void> _DPMRegistrationSubmit() async {
    dpmDataFields.stdDPMs=int.parse(stdControllerDPM.text.toString().trim());
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
    dpmDataFields.distNameDPMs=distNameDPM;
    print('@@codeDPM.state__Dist_name---1' + dpmDataFields.distNameDPMs.toString());
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
            }else{
              Utils.showToast(response.message, true);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }

  Future<void> _NewUSerGovtPrivateRegisterSubmit() async {
    //govtPrivateRegistatrionDataFields.equipeDestailsID=1;
   // govtPrivateRegistatrionDataFields.equipDetailsQty=int.parse(_equipmentDetailQtyController.text.toString());
    govtPrivateRegistatrionDataFields.dropDownvalueOrgnbaistaionTypes =
        dropDownvalueOrgnbaistaionType;
    govtPrivateRegistatrionDataFields.HospitalNinNumber =
        _HospitalNINnoGovtController.text.toString().trim();
    govtPrivateRegistatrionDataFields.organisationNameGovt =
        _organisationNameGovtPrivate.text.toString().trim();
    govtPrivateRegistatrionDataFields.MobileNoGovt =
        _mobileGovtPRivate.text.toString().trim(); //CodeDPM; testing purpose
    govtPrivateRegistatrionDataFields.EmailIDGovt =
        _emailIDGovtPRivate.text.toString().trim();
    govtPrivateRegistatrionDataFields.AddressGovt =
        _addressGovtPRivate.text.toString().trim();
    govtPrivateRegistatrionDataFields.pinCodeGovt =
        _pinbCodeGovtPRivate.text.toString().trim();
    govtPrivateRegistatrionDataFields.OfficernameGovt =
        _officerNAmeGovtPRivate.text.toString().trim();

    govtPrivateRegistatrionDataFields.CapchaCodeGovtPvt =
        _captchaControllerGovtPrivateScreen.text.toString().trim();
    print('@@stateCodeSPO.state' + dpmDataFields.toString());
    if (govtPrivateRegistatrionDataFields.organisationNameGovt.isEmpty) {
      Utils.showToast("Please enter Organisatioon Name !", false);
      return;
    }
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
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.registration_of_Govt_Private_Other_Hospital(govtPrivateRegistatrionDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@registration_of_Govt_Private_Other_Hospital ---' + response.status.toString());
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
  int stdDPMs;
}

class NGODDataFields {
  String ngoDarpanNumber;
  String ngoPANNumber;
}

class GovtPrivateRegistatrionDataFields {
  int dropDownvalueOrgnbaistaionTypes;
  String organisationNameGovt,
      MobileNoGovt,
      EmailIDGovt,
      StateGovt,
      DistrictGovt,
      AddressGovt,
      pinCodeGovt,
      OfficernameGovt,
      CapchaCodeGovtPvt,
      HospitalNinNumber;
  int equipeDestailsID,equipDetailsQty;
}
//NGO Registration view

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
//Save
