import 'dart:math';

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

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
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

  SPODataFields spoDataFields=new SPODataFields();

  DashboardStateModel countryStateModel =
  DashboardStateModel(status: false, message: '', data: []);
  bool isDataLoaded = false;



  getCountries() async {
    //
    countryStateModel = await _countryStateCityRepo.getCountriesStates();
    statesName.add('Select Country');
    // states.add('Select State');
    //cities.add('Select City');
    for (var element in countryStateModel.data) {
      statesName.add(element.stateName);
      staCode.add(element.code);
      state_code.add(element.stateCode);
      print("@@statesName"  +element.stateName);
      print("@@statesCode"  +element.code);
      print("@@state_code"  +element.stateCode.toString());
    }
    isDataLoaded = true;
    setState(() {});
    //
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
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
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
                                getCountries();
                                /*        ApiController.getSatatAPi().then((value) {
                                  setState(() {
                                    print('@@getSatatAPi--1' + _chosenValue);
                                    isLoadingApi = false;
                                    if (value != null && value.status) {
                                      dashboardStateModel = value;
                                        if (dashboardStateModel.data.isNotEmpty) {
                                          for (int i = 0; i < dashboardStateModel.data.length; i++) {
                                              data = dashboardStateModel.data[i] ;
                                              print('@@data--1' +    data.stateName.toString());

                                              break;
                                          }
                                        }
                                    }

                                  });
                                });*/
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: selectedCountry,
                          validator: (value) =>  value.isEmpty ? 'field required' : null,
                          items: statesName
                              .map((String country) => DropdownMenuItem(
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
                            /*  if (selectedCountry != 'Select Country') {
                              getStates();
                            }*/
                            //
                          }),
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: new TextField(
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
                        obscureText: true,
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
                                "randomString",
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
                          }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                        child: Text('Reset'),
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
      ),
    );
  }
  Future<void> _spoRegistrationSubmit() async {
    TextEditingController _spoNAme = new TextEditingController();
    TextEditingController _spoMobile = new TextEditingController();
    TextEditingController _spoEmailId = new TextEditingController();
    TextEditingController _spoDestination = new TextEditingController();
    TextEditingController _spoPhoneNumber = new TextEditingController();
    TextEditingController _spoOfficeAddress = new TextEditingController();
    TextEditingController _spoPinCode = new TextEditingController();
    TextEditingController _spoCaptchaCodeEnter= new TextEditingController();
  //  spoDataFields.state = _spoNAme.text.toString().trim();
    spoDataFields.Name = _spoNAme.text.toString().trim();
    spoDataFields.mobileNumber = _spoMobile.text.toString().trim();
    spoDataFields.emailId = _spoEmailId.text.toString().trim();
    spoDataFields.designation = _spoDestination.text.toString().trim();
    spoDataFields.PhoneNumber = _spoPhoneNumber.text.toString().trim();
    spoDataFields.OfficeAddress = _spoOfficeAddress.text.toString().trim();
    spoDataFields.PinCode = _spoPinCode.text.toString().trim();
    spoDataFields.CaptchaCodeEnter = _spoCaptchaCodeEnter.text.toString().trim();

    if (spoDataFields.Name.isEmpty) {
      Utils.showToast("Please enter Name !", false);
      return;
    }
    if (spoDataFields.mobileNumber.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    }
    if (spoDataFields.emailId.isEmpty) {
      Utils.showToast("Please enter EmailId !", false);
      return;
    } if (spoDataFields.designation.isEmpty) {
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
    }
    else {
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

}

class SPODataFields {
  String state;
  String Name ;
  String mobileNumber;
  String emailId;
  String designation ;
  String std ;
  String PhoneNumber ;
  String OfficeAddress;
  String PinCode ;
  String CaptchaCodeEnter;
}
//NGO Registration view

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
