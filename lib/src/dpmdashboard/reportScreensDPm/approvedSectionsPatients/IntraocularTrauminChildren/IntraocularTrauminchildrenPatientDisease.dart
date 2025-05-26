import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMPatientDiesesParticularView.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/reportScreensDPm/approvedSectionsPatients/ApprovedClickDataPatientDiseaseInnerDataDisplay.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/reportScreensDPm/approvedSectionsPatients/IntraocularTrauminChildren/intracularTrauminChildrenPdfFiles.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/reportScreensDPm/approvedSectionsPatients/RetinopathyofPrematurity/RetinopathyofPermaturityPdfFiles.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/reportScreensDPm/approvedSectionsPatients/cornealBlindness/CornealBlindnessPdfFiles.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrganValuebiggerFive.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMCataractPatientView.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmReportScreen/ReportScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_cataract.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/DiabeticRetinpathy/DiabeticRetinopathyDataReport.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/ViewClickCatractPdfType.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/congentalPtosis/CongentialPtosisDataReport.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/cornealBlindnessReport/CornealBlindnessDataReport.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/squint/SquintDataReport.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

import '../../../../model/dpmRegistration/viewClickReportData/RetinopathyofPermaturity/RetinopathyofPermaturityDataReport.dart';
import '../../../../model/dpmRegistration/viewClickReportData/TraumainChildren/TrauminchildrenDataReport.dart';
import '../../../../model/dpmRegistration/viewClickReportData/cornealBlindnessReport/CornealBlindnessPdfFile.dart';




class IntraocularTrauminchildrenPatientDisease extends StatefulWidget {
  final String ngoName;
  final String orgNAme;
  final String npcbNo;

  IntraocularTrauminchildrenPatientDisease({ this.ngoName,this.orgNAme,this.npcbNo});
  @override
  _IntraocularTrauminchildrenPatientDisease createState() => _IntraocularTrauminchildrenPatientDisease();
}

class _IntraocularTrauminchildrenPatientDisease extends State<IntraocularTrauminchildrenPatientDisease> {
  DateTime _selectedDate;

  TextEditingController fullnameController_ = new TextEditingController();
  String fullnameController,orgNames,npcbNogetfromprviousScreen;
  String  districtNames, userId, stateNames;
  String _chosenValuechnagesONSelection="Cataract";
  final GlobalKey _dropdownKey = GlobalKey();
  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  String getYearNgoHopital, getfyidNgoHospital;
  String _selectedDateText = 'From Date'; // Initially set to "From Date"
  double sharedFontSize = 14.0;
  Color sharedFontColor = Colors.black;
  FontWeight sharedFontWeight = FontWeight.normal;
  String _selectedDateTextToDate = 'To Date';
  String  oganisationTypeGovtPrivateDRopDown;
  int dropDownvalueOrgnbaistaionType = 0;
  Future<List<DataBindOrgan>> _futureBindOrgan;
  int status, district_code_login, state_code_login,lowVisionDataValue = 0;
  String role_id,bindOrganisationNAme,npcbNo,lowVisionDatas,lowVisionDatasStatusType;
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
    oganisationTypeGovtPrivateDRopDown = 'NGO District';  // Set default selected item
    dropDownvalueOrgnbaistaionType = 5;
    orgNames = widget.orgNAme ?? "";// Set related type value
    npcbNogetfromprviousScreen=widget.npcbNo??"";
    print('@@115' + widget.orgNAme.toString());
    print('@@11' + orgNames.toString());
    print('@@11' + npcbNogetfromprviousScreen.toString());
    _futureBindOrgan = GetDPM_Bindorg();                  // Load corresponding data
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
      print('@@bindOrgan: ' + "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg"+district_code_login.toString());

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
          //   orgNames=widget.orgNAme.toString();
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
      final String url =
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg_New';

      final Map<String, dynamic> params = {
        "district_code": district_code_login,
        "organisationType": dropDownvalueOrgnbaistaionType,
      };

      print('@@API URL: $url');
      print('@@API Params: ${jsonEncode(params)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final BindOrganValuebiggerFive bindOrganValuebiggerFive =
        BindOrganValuebiggerFive.fromJson(json);
        if (bindOrganValuebiggerFive.status) {
          print('@@Response Success: ${bindOrganValuebiggerFive.message}');
        }
        return bindOrganValuebiggerFive.data;
      } else {
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
          title: new Text('Welcome ' + '${fullnameController}',
              maxLines: 2,
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
            SizedBox(height: 5.0),
            Row(
              children: [
                // Dropdown with FutureBuilder
                Container(
                  width: 150, // ✅ Now this will work
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0), // Add outer margin
                      height: 50, // Same height
                      child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          List<DataGetDPM_ScreeningYear> list = snapshot.data?.toList() ?? [];

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (list.isNotEmpty && (_selectedUser == null || !list.contains(_selectedUser))) {
                              setState(() {
                                _selectedUser = list.first;
                                getYearNgoHopital = _selectedUser.name;
                                getfyidNgoHospital = _selectedUser.fyid;
                              });
                            }
                          });

                          if (list.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'No data found',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            );
                          }

                          return DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                            value: _selectedUser,
                            onChanged: (userc) {
                              setState(() {
                                _selectedUser = userc;
                                getYearNgoHopital = userc?.name ?? '';
                                getfyidNgoHospital = userc?.fyid ?? '';
                              });
                            },
                            items: list.map((user) {
                              return DropdownMenuItem<DataGetDPM_ScreeningYear>(
                                value: user,
                                child: Text(user.name, style: TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            buttonStyleData: ButtonStyleData(
                              height: 60, // Match height
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                              iconSize: 20,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),


                Expanded(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () async {
                                    print('@@From Date clicked');
                                    DateTime pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1700),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                      setState(() {
                                        _selectedDateText = formattedDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.34, // 50% of screen width
                                    height: 50, // Set the fixed height
                                    padding: EdgeInsets.all(12.0),

                                    decoration: BoxDecoration(

                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.grey, width: 1.0),

                                    ),

                                    child: Text(
                                      _selectedDateText.isEmpty ? 'Screening Date' : _selectedDateText,
                                      style: TextStyle(
                                        color: _selectedDateText.isEmpty ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5), // Space between the two fields
                          Container(
                            child: Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    print('@@To Date clicked');
                                    DateTime pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1700),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                      setState(() {
                                        _selectedDateTextToDate = formattedDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.34, // 50% of screen width
                                    height: 50, // Set the fixed height
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.grey, width: 1.0),
                                    ),
                                    child: Text(
                                      _selectedDateTextToDate.isEmpty ? 'Tentative Date' : _selectedDateTextToDate,
                                      style: TextStyle(
                                        color: _selectedDateTextToDate.isEmpty ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0), // 👈 Add outer margin
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Grey border
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  alignment: Alignment.centerLeft, // 👈 Align child to center-left
                  child: _buildDropdownItem(
                    value: _chosenValuechnagesONSelection,
                    hint: 'Low Vision Register',
                    hintIcon: Icon(Icons.update, color: Colors.black),
                    items: [
                      {'value': 'Cataract', 'icon': Icons.local_hospital},
                      // Add an icon here
                      {'value': 'Diabetic', 'icon': Icons.healing},
                      {'value': 'Glaucoma', 'icon': Icons.healing},
                      {'value': 'Corneal Blindness', 'icon': Icons.healing},
                      {'value': 'VR Surgery', 'icon': Icons.healing},
                      /*   {'value': 'Childhood Blindness', 'icon': Icons.child_care},*/
                    ],
                    onChanged: (String value) {

                      setState(() {
                        _chosenValuechnagesONSelection = value;
                        //  print('@@spinnerChooseValue--' + _chosenValue);
                        if (_chosenValuechnagesONSelection == "Cataract") {

                          print('@@NGO--1' + _chosenValuechnagesONSelection);
                        } else if (_chosenValuechnagesONSelection == "Diabetic") {

                        } else if (_chosenValuechnagesONSelection == "Glaucoma") {

                        } else if (_chosenValuechnagesONSelection == "Corneal Blindness") {

                        } else if (_chosenValuechnagesONSelection == "VR Surgery") {
                          print('@@Childhood--' + _chosenValuechnagesONSelection);

                        }
                      });
                    },
                  ),
                ),


              ],
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Login Type and District in a Row
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              // Margin for spacing
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${stateNames}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 50),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    // Space between Login Type and District
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ngo ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          widget.ngoName,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500),
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            // Space between Row and State Column

                            // State in a Column with margin

                            // State in a Column with margin
                          ],
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
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Shown Captcha value to user
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Login Type and District in a Row
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              // Margin for spacing
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'State:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${stateNames}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Space between Row and State Column
                            const SizedBox(width: 50),

                            // State in a Column with margin
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              // Right margin for spacing
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'District:',
                                    style: TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${districtNames}',
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),

                            // State in a Column with margin
                          ],
                        ),
                      ),


                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              // Full width
              color: Colors.blue,
              // Background color
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              // Padding for spacing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between text and button
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Trauma in Children data approved by DPM',
                      // Added spacing between words
                      maxLines: 2,
                      textAlign: TextAlign.left, // Align text to the left
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        print('Back button clicked');
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApprovedClickDataPatientDiseaseInnerDataDisplay(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white, // ✅ White background
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors
                                  .grey), // ✅ Light border for visibility
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.black, // ✅ Black text
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
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
            reportviewCataract(),
          ],
        ),
      ),
    );
  }

  // ─────────────────── 2.  CATARACT-REPORT LISTVIEW ────────────────────
  Widget reportviewCataract() {
    return FutureBuilder<List<TrauminchildrenDataReportData>>(
      future: _loadCataractReport(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }
        final data = snap.data ?? [];
        if (data.isEmpty) {
          return const Center(child: Text('No data found'));
        }

        return ListView.builder(
          shrinkWrap: true,                               // ← take only needed space
          physics: const NeverScrollableScrollPhysics(),  // ← disable its own scroll
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            final d = data[i];
            return ListTile(
              leading: Text('${i + 1}'),
              title: Text(d.pUniqueID ?? '—'),
              trailing: TextButton(
                onPressed: () {  _showDetails(context,d);  },
                child: const Text('View', style: TextStyle(color: Colors.blue)),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<TrauminchildrenDataReportData>> _loadCataractReport() async {
    try {


      final String fyId        = (getfyidNgoHospital ?? "0").toString();
      final String stateCode   = state_code_login.toString();
      final String districtCode= district_code_login.toString();

      final String orgId = orgNames; // Hardcoded, you can replace if needed
      final String orgName = bindOrganisationNAme ?? "";
      final String orgType     = dropDownvalueOrgnbaistaionType.toString();
      final String year        = (getYearNgoHopital ?? "0").toString();
      final String npcb        = (npcbNogetfromprviousScreen ?? "").toString();

      return await ApiController.getDPM_TraumaReport(
        int.parse(fyId),
        "",
        "",
        state_code_login,
        district_code_login,
        orgId,
        orgName,
        orgType,
        year,
        npcb,
      );
    } catch (e) {
      print("Error loading cataract report: $e");
      return Future.error("Invalid or missing input data: $e");
    }
  }







  Widget _buildDropdownItem({
    GlobalKey key,
    String value,
    String hint,
    List<Map<String, dynamic>> items,
    Function(String) onChanged,
    Icon hintIcon,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      title: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          key: key,
          value: value,
          isExpanded: true, // Ensure dropdown takes up full width
          style: TextStyle(color: Colors.black, fontSize: sharedFontSize),
          dropdownStyleData: DropdownStyleData(
            offset: Offset(0, 8), // Controls the dropdown's position
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0), // Adjust vertical padding
          ),
          items: items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Align(
                alignment: Alignment.centerLeft, // Ensure text aligns left
                child: Row(
                  children: [
                    Icon(item['icon'], color: Colors.black, size: sharedFontSize),
                    SizedBox(width: 8.0),
                    Text(
                      item['value'],
                      style: TextStyle(
                        color: Colors.black, // Text color black
                        fontSize: sharedFontSize,
                        fontWeight: sharedFontWeight,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
            children: [
              hintIcon,
              SizedBox(width: 8.0),
              Text(
                hint,
                style: TextStyle(
                  color: Colors.black, // Text color black for hint
                  fontSize: sharedFontSize,
                  fontWeight: sharedFontWeight,
                ),
              ),
            ],
          )
              : Text(
            hint,
            style: TextStyle(
              color: Colors.black, // Text color black for hint
              fontSize: sharedFontSize,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    IconData icon,
    String title,
    Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 12.0, top: 30.0, right: 10.0),
        // Apply left, top, and right margin
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
        // Custom padding
        child: Row(
          children: [
            Icon(icon, color: sharedFontColor, size: sharedFontSize),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: sharedFontColor,
                fontSize: sharedFontSize,
                fontWeight: sharedFontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value ?? 'N/A',
          ),
        ),
      ],
    );
  }




  Widget _buildHeaderCell(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }





  Widget _buildDataCell(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.04, // Scales with screen width
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlue(String text, VoidCallback onTap) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 35,
        width: screenWidth * 0.3, // 30% of screen width for adaptability
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.1, color: Colors.black), // Top border

            bottom:
            BorderSide(width: 0.1, color: Colors.black), // Bottom border
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.blue,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildHeaderCellNGOActionSmallShow(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.18, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04, // Scales with screen width
          ),
        ),
      ),
    );
  }




  //related disease Data view
  Widget _buildHeaderCellSrNoDiseaseData(String text, BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
          // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.035, // Scales with screen width
          ),
        ),
      ),
    );
  }




  Widget _buildDataCellSrNoDiseaseData(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        // Aligns text to the left
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.03, // Scales with screen width
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context,
      TrauminchildrenDataReportData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Trauma in Children data approved by DPM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(color: Colors.black, width: 0.5),
              columnWidths: {
                0: FixedColumnWidth(120.0), // Label column width
                1: FlexColumnWidth(), // Value column width
              },
              children: [
                _buildTableRow('Patient Id	:',offer.pUniqueID),
                _buildTableRow('Name of Person:', offer.name.toString()),
                _buildTableRow('Mobile No:', offer.mobile.toString()),
                _buildTableRow('DOB:', Utils.formatDateString(offer.dob.toString())),

                _buildTableRow('Gender:', mapGender(offer.gender)),
                _buildTableRow('Address:', offer.addressLine1.toString()),
                _buildTableRow('Operation Date:', Utils.formatDateString(offer.operatedOn.toString())),

                // _buildTableRow('Squint type', (offer.squinttypeVal.toString())),
                _buildTableRow("Operated Eye", offer.eyetype == "1" ? "Left" : "Right"),
                _buildTableRow("NGO", offer.ngoName),

                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Actions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ), // Placeholder for the "key"
                    ),
                    // Apply a SingleChildScrollView with horizontal scroll direction
                    // Second column: Action + View buttons
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),

                            child: ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        intracularTrauminChildrenPdfFiles(
                                            id: offer.id.toString() ?? '',
                                            orgNAme:orgNames
                                        ),
                                  ),
                                );


                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              child: Text('View'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  String mapGender(dynamic value) {
    // Convert to int first if it’s a String that looks like a number
    int code;
    if (value is int)      code = value;
    else if (value is String) code = int.tryParse(value);

    if (code == null) return '—';
    return code == -1 ? 'Male' : 'Female';
  }




}
