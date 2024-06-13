
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

Widget registrationVisibilitybySelection(String _chosenValueget) {
  if (_chosenValueget == "NGO") {
    print('@@ValueFetchedS[innerCondition----' + _chosenValueget);
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  String _chosenValue;
  String randomString="";
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
    print("t@@he random string is $randomString");
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
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
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
                            print('@@spinnerChooseValue--' + _chosenValue);
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
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            NGORegistration(),
            SPORegistration(),


            // TextFormField to enter captcha value
          ],
        ),
      ),


    );
  }
}
//NGO Registration view
Widget NGORegistration() {
  final _ngoDarpanNumberController = new TextEditingController();
  final _ngoPANNumberController = new TextEditingController();
  body:
  return Visibility(
    visible: true,
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
  );
}
Widget SPORegistration() {
  return Visibility(
    visible: true,
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
                onPressed: () {},
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
  );
}

//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
