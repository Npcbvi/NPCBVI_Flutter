import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class CampDashboard extends StatefulWidget {
  @override
  _CampDashboard createState() => _CampDashboard();
}

class _CampDashboard extends State<CampDashboard> {
  TextEditingController fullnameController = new TextEditingController();
  String _chosenValue,districtNames,userId,stateNames;
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
          fullnameController.text = user.name;
          districtNames= user.districtName;
          stateNames=user.stateName;
          userId= user.userId;
          print('@@-0----2'+user.name);
          print('@@-0----3'+fullnameController.text);
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
          title: new Text(
         'welcome +${fullnameController}',
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
                        'Dashboard',
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
                            'Add Patient',
                            'Update Patient',
                            'Screening Entry',
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
                            "Registration Patient",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
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
                            'Login Type:',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w800),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                            'Camp Manager',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          )),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                          child: Text(
                            'Login Id:',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w800),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                            '${userId}',
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
