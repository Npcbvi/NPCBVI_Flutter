import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMPatientDiesesParticularView.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMCataractPatientView.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmReportScreen/ReportScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_cataract.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../model/bindorg/BindOrganValuebiggerFive.dart';

class DPMPatientPatientDisceaseInnerDataDisplay extends StatefulWidget {
  @override
  _DPMPatientPatientDisceaseInnerDataDisplay createState() => _DPMPatientPatientDisceaseInnerDataDisplay();
}

class _DPMPatientPatientDisceaseInnerDataDisplay extends State<DPMPatientPatientDisceaseInnerDataDisplay> {
  DateTime _selectedDate;

  TextEditingController fullnameController_ = new TextEditingController();
  String fullnameController;
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
  String getYearGlucoma,
      getYearCatract,
      getYearDiabitic,
      getYearCornealBlindness,
      gerYearVRsurgery,
      gerYearCongenitalPtosis,gerYearTraumaChildren,gerYearSquint ;
  String getfyid;
  String
      npcbNoCatract;
  DataBindOrganValuebiggerFive _selectBindOrgniasationBiggerFive;
  bool lowvisionCataractDataDispla = false;
  Future<List<DataBindOrganValuebiggerFive>>
  _futureDataBindOrganValuebiggerFive;

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
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          print('@@-0----2' + user.name);
          print('@@-0----3' + fullnameController);
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
  Future<List<DataBindOrganValuebiggerFive>> GetDPM_Bindorg_New() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg_New'),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode({
          "district_code": district_code_login,
          "organisationType": lowVisionDataValue,
        }),
      );
      print("@@GetDPM_Bindorg_New--bodyprint--:" +
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg_New" +
          lowVisionDataValue.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final BindOrganValuebiggerFive bindOrganValuebiggerFive =
        BindOrganValuebiggerFive.fromJson(json);
        if (bindOrganValuebiggerFive.status) {
          print('@@bindOrganValuebiggerFive: ' +
              bindOrganValuebiggerFive.message);
        }
        return bindOrganValuebiggerFive.data;
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
          title: new Text('welcome ' +'${fullnameController}',
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
                  /*    Container(
                          child: Text(
                        'PNJA Catract',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )),*/
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
          color: Colors.blue.shade700, // Slightly darker blue for better contrast
          padding: const EdgeInsets.symmetric(vertical: 15), // Add vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // First Button with Icon and Text
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print('Cataract Data for approval');
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent, // Button background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Subtle shadow
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_copy, color: Colors.white), // Icon
                        SizedBox(width: 8), // Spacing between icon and text
                        Text(
                          '${_chosenValueLOWVision} Data Report',
                          maxLines: 3,
                          style: TextStyle(

                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between buttons
              // Second Button with Icon and Text
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print('Back button clicked');
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent, // Different color for distinction
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Subtle shadow
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white), // Icon
                        SizedBox(width: 8), // Spacing between icon and text
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


        // Horizontal Scrolling Header Row
            SizedBox(width: 8.0),
            reportviewCatract(),
          ],
        ),
      ),
    );
  }

  Widget reportviewCatract() {
    return Column(
      children: [
        Visibility(
          visible: reportviewCatracts,
          child: Column(
            children: [

              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());
                    print('@@snapshot___5: ');
                    List list =
                    snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              getYearCatract = userc.name;
                              getfyid = userc.fyid;
                              print('@@getYear--' + getYearCatract.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                    (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                        16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.blue[
                              50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
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
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
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

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;

                            _futureBindOrgan =
                                GetDPM_Bindorg();
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (lowVisionDataValue == 5)
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
                      print('@@snapshot___5: $lowVisionDataValue');

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
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
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
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                        list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
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
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                )
              else if (lowVisionDataValue == 13)
                  Center(
                    child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                      future: _futureDataBindOrganValuebiggerFive,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        // Only show CircularProgressIndicator if the connection is still waiting
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        // Once data is available, check the list
                        List<DataBindOrganValuebiggerFive> list = snapshot.data;

                        // If no data is found, show an empty dropdown with a message
                        if (list == null || list.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: Column(
                              children: [
                                const Text(
                                  'No data found',
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.red),
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<
                                    DataBindOrganValuebiggerFive>(
                                  onChanged: null,
                                  // Disable dropdown if there's no data
                                  items: [],
                                  // Provide an empty list
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  hint: const Text('No items available'),
                                  disabledHint: Text('No items to select'),
                                ),
                              ],
                            ),
                          );
                        }

                        // Select first item if not already selected
                        if (_selectBindOrgniasationBiggerFive == null ||
                            !list.contains(_selectBindOrgniasationBiggerFive)) {
                          _selectBindOrgniasationBiggerFive =
                          list.isNotEmpty ? list.first : null;
                        }

                        // Render the dropdown with available data
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
                                DropdownButtonFormField<
                                    DataBindOrganValuebiggerFive>(
                                  onChanged: (userbindOrgan) {
                                    setState(() {
                                      _selectBindOrgniasationBiggerFive =
                                          userbindOrgan;
                                      bindOrganisationNAme =
                                          userbindOrgan?.oName ?? '';
                                      npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                    });
                                  },
                                  value: _selectBindOrgniasationBiggerFive,
                                  items: list.map((userbindorgansa) {
                                    return DropdownMenuItem<
                                        DataBindOrganValuebiggerFive>(
                                      value: userbindorgansa,
                                      child: Text(
                                        userbindorgansa.oName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                  )
                else if (lowVisionDataValue == 0)
                    Center(
                      child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                        future: _futureDataBindOrganValuebiggerFive,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          // Show CircularProgressIndicator only while loading (waiting for data)
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          // List from the snapshot
                          List<DataBindOrganValuebiggerFive> list = snapshot.data;

                          // If the list is empty or null, show an empty dropdown with a message
                          if (list == null || list.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                              child: Column(
                                children: [
                                  const Text(
                                    'No data found',
                                    style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButtonFormField<
                                      DataBindOrganValuebiggerFive>(
                                    onChanged: null,
                                    // Disable dropdown when no data
                                    items: [],
                                    // Empty list as no items are available
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.blue[50],
                                    ),
                                    hint: const Text('No items available'),
                                    disabledHint: const Text('No items to select'),
                                  ),
                                ],
                              ),
                            );
                          }

                          // If an item is not selected, select the first one by default
                          if (_selectBindOrgniasationBiggerFive == null ||
                              !list.contains(_selectBindOrgniasationBiggerFive)) {
                            _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                          }

                          // Render dropdown with data if available
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
                                  DropdownButtonFormField<
                                      DataBindOrganValuebiggerFive>(
                                    onChanged: (userbindOrgan) {
                                      setState(() {
                                        _selectBindOrgniasationBiggerFive =
                                            userbindOrgan;
                                        bindOrganisationNAme =
                                            userbindOrgan?.oName ?? '';
                                        npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                      });
                                    },
                                    value: _selectBindOrgniasationBiggerFive,
                                    items: list.map((userbindorgansa) {
                                      return DropdownMenuItem<
                                          DataBindOrganValuebiggerFive>(
                                        value: userbindorgansa,
                                        child: Text(
                                          userbindorgansa.oName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@lowvisionCataractDataDispla-- click------');
                        setState(() {
                          lowvisionCataractDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionCataractDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<Datalowvisionregister_cataract>>(
                      future: ApiController.getDPM_Cataract(
                        district_code_login,
                        state_code_login,
                        npcbNoCatract,
                        getYearCatract,
                        lowVisionDataValue,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<Datalowvisionregister_cataract> ddata =
                              snapshot.data;

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
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.ngoName.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      print("@@500 Internal Server Error--DashboardWebsiteISsue hai --");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DPMPatientDiesesParticularView(offer.id.toString()),


                                        ),
                                      );
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
