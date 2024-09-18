import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmReportScreen/ReportScreen.dart';
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
  String  oganisationTypeGovtPrivateDRopDown;
  int dropDownvalueOrgnbaistaionType = 0;
  Future<List<DataBindOrgan>> _futureBindOrgan;
  int status, district_code_login, state_code_login,lowVisionDataValue = 0;
  String role_id,bindOrganisationNAme,npcbNo,lowVisionDatas;
  DataBindOrgan _selectBindOrgniasation;
  bool dpmReportDataList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();
    _future = getDPM_ScreeningYear();
    reportviewCatracts = true;
  }
  Future<List<DataBindOrgan>> GetDPM_Bindorg() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg'),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode({
          "district_code": district_code_login,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final BindOrgan bindOrgan = BindOrgan.fromJson(json);
        if (bindOrgan.status) {
          print('@@bindOrgan: ' + bindOrgan.message);
        }
        return bindOrgan.data;
      } else {
        // Handle the error if response status is not 200
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
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

                                  } else if (_chosenValueLOWVision ==
                                      "Glaucoma") {

                                  } else if (_chosenValueLOWVision ==
                                      "Corneal Blindness") {
                                  }
                                  else if (_chosenValueLOWVision ==
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
                  '${_chosenValueLOWVision} Data Report',
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
                                  print('@@@Selected Year: $getYearNgoHopital');
                                  print('@@ReportScreen__FYID: $getfyidNgoHospital');
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
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

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
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

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
                          'NGO District',
                          'District Hospital/government Medical College',
                          'CHC/Sub-Dist. Hospital',
                          'Private Practitioner',
                          'Private Institute',
                          'Other',
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
                                "NGO District") {

                              dropDownvalueOrgnbaistaionType = 5;
                              _futureBindOrgan = GetDPM_Bindorg();
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());
                            } else if (oganisationTypeGovtPrivateDRopDown ==
                                "District Hospital/government Medical College") {
                              dropDownvalueOrgnbaistaionType = 10;
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());
                            } else if (oganisationTypeGovtPrivateDRopDown ==
                            "CHC/Sub-Dist. Hospital") {
                            dropDownvalueOrgnbaistaionType = 11;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                            oganisationTypeGovtPrivateDRopDown +
                            "-----" +
                            dropDownvalueOrgnbaistaionType.toString());
                            }
                            else if (oganisationTypeGovtPrivateDRopDown ==
                                "Private Practitioner") {
                              dropDownvalueOrgnbaistaionType = 12;
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());
                            } else if (oganisationTypeGovtPrivateDRopDown ==
                                "Private Institue") {
                              dropDownvalueOrgnbaistaionType = 13;
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());
                            } else if (oganisationTypeGovtPrivateDRopDown ==
                                "Other") {
                              dropDownvalueOrgnbaistaionType = 14;
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());

                            }
                            else  {
                              dropDownvalueOrgnbaistaionType = 0;
                              print('@@oganisationTypeGovtPrivateDRopDown--' +
                                  oganisationTypeGovtPrivateDRopDown +
                                  "-----" +
                                  dropDownvalueOrgnbaistaionType.toString());
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                  Center(
                    child: FutureBuilder<List<DataBindOrgan>>(
                      future: _futureBindOrgan,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }

                        List<DataBindOrgan> list = snapshot.data;
                        developer.log('@@snapshot___5: $list');
                        print('@@snapshot___5: $dropDownvalueOrgnbaistaionType');

                        if (_selectBindOrgniasation == null ||
                            !list.contains(_selectBindOrgniasation)) {
                          _selectBindOrgniasation =
                          list.isNotEmpty ? list.first : null;
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Select:',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<DataBindOrgan>(
                                  onChanged: (userbindOrgan) {
                                    setState(() {
                                      _selectBindOrgniasation = userbindOrgan;
                                      bindOrganisationNAme =
                                          userbindOrgan?.name ?? '';
                                      npcbNo = userbindOrgan?.npcbNo ?? '';
                                    });
                                  },
                                  value: _selectBindOrgniasation,
                                  items: list.map((userbindorgansa) {
                                    return DropdownMenuItem<DataBindOrgan>(
                                      value: userbindorgansa,
                                      child: Text(
                                        userbindorgansa.name,

                                        maxLines: 2,
                                        // Set max lines to 2
                                        overflow: TextOverflow.ellipsis,
                                        // Handle overflow
                                        style: TextStyle(fontSize: 16),
                                      ),
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
                          ),
                        );
                      },
                    ),
                  ),
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
                        value: lowVisionDatas,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.white,
                        items: <String>[
                          'Approved',
                          'Pending',
                          'Rejected',
                        ].map<DropdownMenuItem<String>>(
                                (String lowVisionRegistry) {
                              return DropdownMenuItem<String>(
                                value: lowVisionRegistry,
                                child: Text(
                                  lowVisionRegistry,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                        hint: Text(
                          "Select Type",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String lowVisionData) {
                          setState(() {
                            lowVisionDatas = lowVisionData;

                            if (lowVisionDatas == "Approved") {
                              lowVisionDataValue = 5;
                            } else if (lowVisionDatas == "Pending") {
                              lowVisionDataValue = 4;

                            } else if (lowVisionData ==
                                "Rejected") {
                              lowVisionDataValue = 6;

                            }else{
                              lowVisionDataValue = 0;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: ElevatedButton(
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          dpmReportDataList=true;
                          setState(() {
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (dpmReportDataList)
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('Organisation Name'),
                            _buildHeaderCell('No of Patient'),
                            _buildHeaderCell('Total Amount @ 2000'),
                            _buildHeaderCell('Action'),

                          ],
                        ),
                      ),
                      Divider(color: Colors.blue, height: 1.0),
                      FutureBuilder<List<DataReportScreen>>(
                        future: ApiController.GetData_by_allngo_amount_totalCount(int.parse(getfyidNgoHospital),_selectedDateText,_selectedDateTextToDate,state_code_login,district_code_login, dropDownvalueOrgnbaistaionType.toString(),bindOrganisationNAme,lowVisionDataValue.toString(),getYearNgoHopital,npcbNo),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Utils.getEmptyView("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                            return Utils.getEmptyView("No data found");
                          } else {
                            List<DataReportScreen> ddata = snapshot.data;

                            print('@@---ddata: ' + lowVisionDataValue.toString());
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1).toString()),
                                      _buildDataCell(offer.ngoname),
                                      _buildDataCell(offer.totalpatient.toString()),
                                      _buildDataCell(offer.amount.toString()),

                                      _buildDataCellViewBlue("View", () {
                                        // Handle the view action here
                                        // Example: Navigate to a details page with the selected item
                                      }),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),


              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildHeaderCellSrNo(String text) {
    return Container(
      height: 40,
      width: 80, // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      //   padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      height: 40,
      width: 150, // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      //   padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      height: 80,
      width: 150,
      // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.1,
        ),
      ),
      // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlue(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNo(String text) {
    return Container(
      height: 80,
      width: 80, //
      // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.1,
        ),
      ),
      // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
