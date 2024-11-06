import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboard createState() => _HospitalDashboard();
}

class _HospitalDashboard extends State<HospitalDashboard> {
  TextEditingController fullnameControllers = new TextEditingController();
  String _chosenValue, districtNames, userId, stateNames,fullnameController,role_id;
  int status, district_code_login, state_code_login;
  final GlobalKey _dropdownKey = GlobalKey();
  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();
  }

  void getUserData() {
    try {
      SharedPrefs.getUser().then((user) {
        setState(() {
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          status = user.status;
          role_id = user.roleId;
          state_code_login = user.state_code;
          district_code_login = user.district_code;
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('welcome +${fullnameController}',
              style: new TextStyle(
                color: Colors.black,
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
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('@@dashboardviewReplace----display---');
                          //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 80.0,
                          child: Text(
                            'Dashboard',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 8.0), // Add spacing between widgets
                      Container(
                        width: 170.0,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenValue,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Add Patient',
                                'Update Patient',
                                'Screening Entry',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Register Patient",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValue = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenValue == "Add Patient") {
                                    print('@@NGO--1' + _chosenValue);
                                  } else if (_chosenValue == "Update Patient") {
                                  } else if (_chosenValue == "Screening Entry") {}
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      InkWell(
                        onTap: () {
                          print('@@ADD PNJA');
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 100.0,
                          child: Text(
                            'ADD PNJA',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 170.0,
                        key: _dropdownKey,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenValueLOWVision,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Cataract',
                                'Diabetic',
                                'Glaucoma',
                                'Corneal Blindness',
                                'VR Surgery',
                                'Childhood Blindness',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Low Vision Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValueLOWVision = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenValueLOWVision == "Cataract") {

                                  } else if (_chosenValueLOWVision ==
                                      "Diabetic") {

                                  } else if (_chosenValueLOWVision ==
                                      "Glaucoma") {

                                  } else if (_chosenValueLOWVision ==
                                      "Corneal Blindness") {

                                  } else if (_chosenValueLOWVision ==
                                      "VR Surgery") {
                                    print('@@Childhood--' +
                                        _chosenValueLOWVision);

                                  } else if (_chosenValueLOWVision ==
                                      "Childhood Blindness") {
                                    print('@@Childhood--' +
                                        _chosenValueLOWVision);
                                    if (_chosenValueLOWVision ==
                                        "Childhood Blindness") {
                                      print('@@Childhood--1' +
                                          _chosenValueLOWVision);

                                    } else {
                                      print('@@Childhood--2' +
                                          _chosenValueLOWVision);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),


                      SizedBox(width: 8.0),
                      Container(
                        width: 200,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenEyeBank,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Cataract',
                                'Diabetic',
                                'Glaucoma',
                                'Corneal Blindness',
                                'VR Surgery',
                                'Childhood Blindness',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Send To DPM",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenEyeBank = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenEyeBank == "Eye Bank Collection") {
                                    print('@@NGO--1' + _chosenEyeBank);
                                  } else if (_chosenEyeBank == "Eye Donation") {
                                  } else if (_chosenEyeBank ==
                                      "Eyeball Collection Via Eye Bank") {}
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Shown Captcha value to user
                      Container(
                          child: Text(
                        'Login Type:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        'Hospital',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),

                      Flexible(
                        child: Container(
                            child: Text(
                          '${userId}',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        )),
                      ),

                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Shown Captcha value to user
                      Container(
                          child: Text(
                        'District:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        '${districtNames}',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                          child: Text(
                        'State :',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        '${stateNames}',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
