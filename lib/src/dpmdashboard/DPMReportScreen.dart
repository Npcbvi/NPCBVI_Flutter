import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DPMReportScreen extends StatefulWidget {
  @override
  _DPMReportScreen createState() => _DPMReportScreen();
}

class _DPMReportScreen extends State<DPMReportScreen> {
  DateTime _selectedDate;

  TextEditingController fullnameController = new TextEditingController();
  String _chosenValue, districtNames, userId, stateNames;
  final GlobalKey _dropdownKey = GlobalKey();
  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  bool reportviewCatracts = false;
  String getYearNgoHopital, getfyidNgoHospital;
  String _selectedDateText = 'From Date'; // Initially set to "From Date"

  String _selectedDateTextToDate = 'To Date';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();
    _future = getDPM_ScreeningYear();
    reportviewCatracts = true;
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

  Future<List<DataGetDPM_ScreeningYear>> getDPM_ScreeningYear() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_ScreeningYear'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final GetDPM_ScreeningYear dashboardStateModel =
          GetDPM_ScreeningYear.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
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
                                "Report",
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
                                    print('@@NGO--1' + _chosenValueLOWVision);
                                  } else if (_chosenValueLOWVision ==
                                      "Diabetic") {
                                    false;
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
                      Container(
                          child: Text(
                        'PNJA Catract',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )),
                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Shown Captcha value to user
                      Container(
                          child: Text(
                        'User Type :',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text(
                        'DPM',
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
                      Flexible(
                        child: Container(
                            child: Text(
                          '${userId}',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        )),
                      ),
                      Flexible(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(30, 0, 5, 0),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w800),
                            )),
                      )

                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
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
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue, // Blue background color
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.center,
                // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                child: Text(
                  'Cataract Data Report',
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
            ),
            reportviewCatract(),
          ],
        ),
      ),
    );
  }

  Widget reportviewCatract() {
    return Row(
      children: [
        Visibility(
          visible: reportviewCatracts,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      List<DataGetDPM_ScreeningYear> list =
                          snapshot.data.map((district) {
                        return district;
                      }).toList();

                      if (_selectedUser == null ||
                          !list.contains(_selectedUser)) {
                        _selectedUser = list.first;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select year:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                              value: _selectedUser,
                              onChanged: (userc) {
                                setState(() {
                                  _selectedUser = userc;
                                  getYearNgoHopital = userc?.name ?? '';
                                  getfyidNgoHospital = userc?.fyid ?? '';
                                  print('Selected Year: $getYearNgoHopital');
                                  print('FYID: $getfyidNgoHospital');
                                });
                              },
                              items: list.map((user) {
                                return DropdownMenuItem<
                                    DataGetDPM_ScreeningYear>(
                                  value: user,
                                  child: Text(user.name,
                                      style: TextStyle(fontSize: 16)),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              dropdownColor: Colors.blue[50],
                              style: TextStyle(color: Colors.black),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () async {
                                // Handle the tap event here
                                print('@@Add New Record clicked');

                                // Open the calendar on tap
                                DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  // Default date to show
                                  firstDate: DateTime(2000),
                                  // The earliest allowed date
                                  lastDate:
                                      DateTime(2101), // The latest allowed date
                                );

                                if (pickedDate != null) {
                                  // Handle the selected date (e.g., display or save it)
                                  String formattedDate =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                                  // Update the state with the selected date
                                  setState(() {
                                    _selectedDateText = formattedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                // Padding inside the box
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  // Background color of the box
                                  borderRadius: BorderRadius.circular(8.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: Text(
                                  _selectedDateText,
                                  // Display the selected date or "From Date"
                                  style: TextStyle(
                                    color: Colors.black, // Text color
                                    fontWeight: FontWeight.w800, // Text weight
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Handle text overflow
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                // Handle the tap event here
                                print('@@Add New Record clicked');

                                // Open the calendar on tap
                                DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  // Default date to show
                                  firstDate: DateTime(2000),
                                  // The earliest allowed date
                                  lastDate:
                                      DateTime(2101), // The latest allowed date
                                );

                                if (pickedDate != null) {
                                  // Handle the selected date (e.g., display or save it)
                                  String formattedDate =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                                  // Update the state with the selected date
                                  setState(() {
                                    _selectedDateTextToDate = formattedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                // Padding inside the box
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  // Background color of the box
                                  borderRadius: BorderRadius.circular(8.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: Text(
                                  _selectedDateTextToDate,
                                  // Display the selected date or "From Date"
                                  style: TextStyle(
                                    color: Colors.black, // Text color
                                    fontWeight: FontWeight.w800, // Text weight
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Handle text overflow
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
