import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class DPMDashboard extends StatefulWidget {
  @override
  _DPMDashboard createState() => _DPMDashboard();
}

class _DPMDashboard extends State<DPMDashboard> {
  TextEditingController fullnameController = new TextEditingController();
  String _chosenValue, districtNames, userId, stateNames;

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
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          print('@@-0----2' + user.name);
          print('@@-0----3' + fullnameController.text);
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
            Wrap(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Wrap(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Shown Captcha value to user
                              Flexible(
                                child: Container(
                                    width: 80.0,
                                    child: Text(
                                      'Dashboard',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    )),
                              ),

                              Container(
                                width: 80.0,
                                child: new DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    focusColor: Colors.white,
                                    value: _chosenValue,
                                    //elevation: 5,
                                    style: TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.white,
                                    items: <String>[
                                      'Approve Application',
                                      'New  Hospital',
                                      'Govt/private/Other',
                                      'Approve Renew MOU',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Approve Application",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValue = value;
                                        //  print('@@spinnerChooseValue--' + _chosenValue);
                                        if (_chosenValue == "Add Patient") {
                                          print('@@NGO--1' + _chosenValue);
                                        } else if (_chosenValue ==
                                            "Update Patient") {
                                        } else if (_chosenValue ==
                                            "Screening Entry") {}
                                      });
                                    },
                                  ),
                                ),
                              ),
                              //widgets that follow the Material Design guidelines display a ripple animation when tapped.

                              Flexible(
                                child: Container(
                                  width: 80.0,
                                  child: new DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      focusColor: Colors.white,
                                      value: _chosenValue,

                                      //elevation: 5,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor: Colors.white,
                                      items: <String>[
                                        'Catract',
                                        'Diabetic',
                                        'Glaucoma',
                                        'Corneal Blindness',
                                        'VR Surgery',
                                        'Childhood Blindness',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(
                                        "Low Vision Register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue = value;
                                          //  print('@@spinnerChooseValue--' + _chosenValue);
                                          if (_chosenValue == "Add Patient") {
                                            print('@@NGO--1' + _chosenValue);
                                          } else if (_chosenValue ==
                                              "Update Patient") {
                                          } else if (_chosenValue ==
                                              "Screening Entry") {}
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                    width: 80.0,
                                    child: Text(
                                      'Eye Screening',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    )),
                              ),
                              Flexible(
                                  child: Container(
                                width: 80.0,
                                child: new DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    focusColor: Colors.white,
                                    value: _chosenValue,
                                    //elevation: 5,
                                    style: TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.white,
                                    items: <String>[
                                      'Eye Bank Collection',
                                      'Eye Donation',
                                      'Eyeball Collection Via Eye Bank',
                                      'Eyeball Collection Via Eye Donation Center',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Eye Blink",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValue = value;
                                        //  print('@@spinnerChooseValue--' + _chosenValue);
                                        if (_chosenValue == "Add Patient") {
                                          print('@@NGO--1' + _chosenValue);
                                        } else if (_chosenValue ==
                                            "Update Patient") {
                                        } else if (_chosenValue ==
                                            "Screening Entry") {}
                                      });
                                    },
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                color: Colors.white70,
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
                            color: Colors.black, fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        'DPM',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          color: Colors.white70,
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    child: Text(
                                  '${districtNames}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),

                                Container(
                                    child: Text(
                                  'State :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    child: Text(
                                  '${stateNames}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
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

                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10,10),

                      child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 25,178,238),
                                  Color.fromARGB(255, 21,236,229)
                                ],
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Patient(s) (2024-2025)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Divider(color: Colors.grey, height: 1.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20.0, 0),
                                      child: new Text('Approved',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20.0, 0),
                                      child: new Text('Pending',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: new Text('0',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: new Text('1',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('NGO(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Government Hospital(s)/CHC(s)/Other',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Private Practitioner(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Private Medical College(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Screening Camp(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Satellite Centre(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10,10),
                            child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 25,178,238),
                                        Color.fromARGB(255, 21,236,229)
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Total Patient(s)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Divider(color: Colors.grey, height: 1.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
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
}
