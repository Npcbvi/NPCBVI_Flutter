import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/city/GetCity.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/ScreeningCampManager.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/CenterOfficeNameSatelliteCenter.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../database/SharedPrefs.dart';
import '../model/GetHospitalForDDL/GethospitalForDDL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../model/city/GetVillage.dart';

class ScreeningCampClickAddScreeningCamp extends StatefulWidget {
  @override
  _ScreeningCampClickAddScreeningCamp createState() =>
      _ScreeningCampClickAddScreeningCamp();
}

class _ScreeningCampClickAddScreeningCamp
    extends State<ScreeningCampClickAddScreeningCamp> {
  String gethospitalName,
      getCenterOfficerName,
      gethospitalNameSrNORegRedOption,
      gethospitalNameRegRedOption;
  String gethospitalNameSrNOReg;
  String fullnameController;
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      _chosenValueMange,
      _chosenValueMangeTwo;
  bool isVisibleDitrictGovt = false;

  DataScreeningCampManager _mangerUser;
  bool _isCityInitialized = false;

  bool CampManagerRegisterartions = true; // This should be based on your logic
  String gender = 'Male'; // Default gender
  int status, district_code_login, state_code_login;
  String role_id,
      darpan_nos,
      entryby,
      ngoNames,
      eyeBankById,
      loggedInNgoId,
      fromlisteyeBankByIds;
  bool AddSatelliteManagers = true;
  bool AddScreeningCamps = true;

  int genderSatelliteManagerApi =
      1; // 1 for Male, 2 for Female, 3 for Transgender
  int genderSatelliteCenterApi;
  bool satelliteCenterMenuListdisplay = false;
  Future<List<DataGethospitalForDDL>> _futureDataGethospitalForDDL;
  DataGethospitalForDDL _dataGethospitalForDDL;
  bool AddSatelliteCenterRedOptionFields = true;
  TextEditingController _nGONameController = TextEditingController();
  TextEditingController _campNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addresssController = TextEditingController();
  TextEditingController _Pincodecontroller = TextEditingController();
  Future<List<DataCenterOfficeNameSatelliteCenter>> _futureCenterOfficerName;
  DataCenterOfficeNameSatelliteCenter _dataCenterOfficeNameSatelliteCenter;
  int getCenterOfficerNameSRNo;
  Future<List<Data>> _futureState;
  Future<List<DataGetCity>> _futureCity;
  DataGetCity _selectedUserCity;
  Data _selectedUserState;
  Future<List<DataGetVillage>> _futureVillage;
  DataGetVillage _selectedUserVillage;
  String locationTypeValues = 'Urban';
  DataDsiricst _selectedUserDistrict;
  String selectedStateName,selectedDistrictName,selectedCityName,selectedVillageName;

  String _selectedDateText = 'Start Date*'; // Initially set to "From Date"
  bool _isVillageInitialized = false;
  bool _showCityDropdown = true;

  String _selectedDateTextToDate = 'End Date*';
  Future<List<DataScreeningCampManager>> _manger;
  String getMAnagerNAme;
  int getmanagerSrNO,  village_code = 0;
  int valuetype = 0, distCodeGovtPrivate, stateCodeGovtPrivate,distCodeGovtPrivateCity;
  String CodeGovtPrivate;
  Future<List<DataGetVillage>> _villageFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Screening Camp',
          maxLines: 2,
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddScreeningCamp(), // No condition here
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

  void getUserData() async {
    try {
      SharedPrefs.getUser().then((user) async {
        entryby = await SharedPrefs.getStoreSharedValue(AppConstant.entryBy)
            as String;
        setState(() {
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;

          userId = user.userId;
          status = user.status;
          role_id = user.roleId;
          state_code_login = user.state_code;
          district_code_login = user.district_code;
          getentryby();
          getDarpanNo();
          ngoName();
          getloggedInNgoId();

          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
          print('@@9' + darpan_nos.toString());
          print('@@entryby' + entryby.toString());

          _manger = getCampManager(district_code_login, entryby);
          _futureState = _getStatesDAta();
          _futureDataGethospitalForDDL =
              GetHospitalForDDL(district_code_login, state_code_login, userId);
          _futureCenterOfficerName = getSatelliteManager(
              state_code_login, district_code_login, entryby);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget AddScreeningCamp() {
    return Column(
      children: [
        Visibility(
          visible: AddScreeningCamps,
          // Assuming CampManagerRegisterartions is true
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
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
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              // Space between Login Type and District
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login Type:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'District NGO',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
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
                      const SizedBox(width: 40),

                      // State in a Column with margin
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        // Right margin for spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'District:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${districtNames}',
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

                Container(
                  width: double.infinity,
                  // Full width
                  color: Colors.blue,
                  // Background color
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // Padding for spacing
                  child: Center(
                    child: Text(
                      'Camp Registration',
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
                ),
                // Form for Camp Manager Registration
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller: _nGONameController,
                            decoration: InputDecoration(
                              labelText: ngoNames.isNotEmpty
                                  ? ngoNames
                                  : 'Enter Ngo name *',
                              // Conditional label
                              hintText: ngoNames.isNotEmpty
                                  ? ''
                                  : 'Please provide NGO name',
                              // Hint text when label is empty
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              // Ensures the label floats when focused or filled
                              filled: true,
                              // Add a background color
                              fillColor: Colors.white,

                              // Light background color to indicate non-editable state
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                // Border when not focused
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                // Border color when disabled
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                                // Border when focused
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              labelStyle: TextStyle(color: Colors.black
                                  // Label color when the field is focused
                                  ),
                              hintStyle: TextStyle(
                                color: Colors.grey, // Hint text color
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.red, // Set the text color to red
                            ),
                            enabled: false,
                            // Makes the field non-editable
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Ngo name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            // Padding around both date containers
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // Background color of the entire box
                              borderRadius: BorderRadius.circular(12.0),
                              // Rounded corners
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Space between date pickers
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Handle the tap event here
                                        print('@@Add New Record clicked');

                                        // Open the calendar on tap
                                        DateTime pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1800),
                                          lastDate: DateTime(2101),
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
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.grey,
                                            // Border color for this date container
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          _selectedDateText.isEmpty
                                              ? 'From Date'
                                              : _selectedDateText,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),
                                // Adds space between both date fields
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Handle the tap event here
                                        print('@@Add New Record clicked');

                                        // Open the calendar on tap
                                        DateTime pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1800),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDate != null) {
                                          // Handle the selected date (e.g., display or save it)
                                          String formattedDate =
                                              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

                                          // Update the state with the selected date
                                          setState(() {
                                            _selectedDateTextToDate =
                                                formattedDate;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.grey,
                                            // Border color for this date container
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          _selectedDateTextToDate.isEmpty
                                              ? 'To Date'
                                              : _selectedDateTextToDate,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
                      SizedBox(height: 5),
                      // Username Field
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _campNameController,
                            // Attach controller
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Camp Name',
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Default label color
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors
                                            .red, // Color of the '*' to indicate it's mandatory
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                // Adds a border around the TextField
                                borderRadius: BorderRadius.circular(12),
                                // Optional: Makes the border rounded
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width:
                                      1.0, // Optional: Sets the border color and width
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter camp name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),

                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        // Add margin here
                        child: FutureBuilder<List<DataScreeningCampManager>>(
                          future: _manger,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            List<DataScreeningCampManager> list =
                                snapshot.data?.toList() ?? [];

                            if (_mangerUser == null ||
                                !list.contains(_mangerUser)) {
                              _mangerUser = list.isNotEmpty
                                  ? list.first
                                  : null; // Set the first item as default
                              getMAnagerNAme =
                                  _mangerUser.managerName ?? '';
                              getmanagerSrNO = int.tryParse(
                                  _mangerUser.srNo?.toString() ??
                                      '') ??
                                  0;
                              print(
                                  'getMAnagerNAme: $getMAnagerNAme');
                              print(
                                  'getmanagerSrNO: $getmanagerSrNO');
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: DropdownButtonFormField2<
                                        DataScreeningCampManager>(
                                      value: _mangerUser,
                                      onChanged: (userc) {
                                        setState(() {
                                          _mangerUser = userc;
                                          getMAnagerNAme =
                                              userc?.managerName ?? '';
                                          getmanagerSrNO = int.tryParse(
                                                  userc?.srNo?.toString() ??
                                                      '') ??
                                              0;
                                          print(
                                              'getMAnagerNAme: $getMAnagerNAme');
                                          print(
                                              'getmanagerSrNO: $getmanagerSrNO');
                                        });
                                      },
                                      items: list.map((user) {
                                        return DropdownMenuItem<
                                            DataScreeningCampManager>(
                                          value: user,
                                          child: Text(user.managerName,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 5.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Select Camp Manager',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 300,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        offset: const Offset(0, -3),
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        height: 50, // Set consistent height
                                      ),
                                      style: TextStyle(color: Colors.black),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Colors.black),
                                      ),
                                      hint: Text(
                                        'Select Camp Manager',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 5),

                      // Gender Selection
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Center vertically
                        children: [
                          // Center the Location Type Label

                          // Add space between label and options

                          // Use Row to center the radio buttons horizontally
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // Center radio buttons horizontally
                            children: [
                              // Urban Radio Button
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: locationTypeValues == 'Urban'
                                      ? Colors.white
                                      : Colors.transparent,
                                  // Highlight selected option
                                  borderRadius: BorderRadius.circular(4.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: locationTypeValues == 'Urban'
                                        ? Colors.grey
                                        : Colors.grey,
                                    // Border color changes when selected
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Urban',
                                      groupValue: locationTypeValues,
                                      onChanged: (value) {
                                        setState(() {
                                          locationTypeValues = value;
                                          valuetype = 0;
                                        });
                                      },
                                      activeColor: Colors
                                          .blue, // Active radio button color
                                    ),
                                    Text(
                                      'Urban',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: locationTypeValues == 'Urban'
                                            ? Colors.black
                                            : Colors.black,
                                        // Text color based on selection
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5), // Space between options
                              // Rural Radio Button
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: locationTypeValues == 'Rural'
                                      ? Colors.white
                                      : Colors.transparent,
                                  // Highlight selected option
                                  borderRadius: BorderRadius.circular(4.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: locationTypeValues == 'Rural'
                                        ? Colors.blue
                                        : Colors.grey,
                                    // Border color changes when selected
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Rural',
                                      groupValue: locationTypeValues,
                                      onChanged: (value) {
                                        setState(() {
                                          locationTypeValues = value;
                                          valuetype = 1;
                                        });
                                      },
                                      activeColor: Colors
                                          .blue, // Active radio button color
                                    ),
                                    Text(
                                      'Rural',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: locationTypeValues == 'Rural'
                                            ? Colors.blue
                                            : Colors.black,
                                        // Text color based on selection
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 5.0),
                      // Show additional content based on the selected value
                      if (locationTypeValues == 'Urban')
                        // Content to display if "Urban" is selected
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              5, 0, 5, 0), // Add margin here
                          child: Column(
                            children: [
                              FutureBuilder<List<DataGetCity>>(
                                future: _getCity(district_code_login),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  List<DataGetCity> districtList =
                                      snapshot.data;

                                  if (_selectedUserCity == null ||
                                      !districtList
                                          .contains(_selectedUserCity)) {
                                    _selectedUserCity = districtList.first;
                                  }

                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // Ensuring equal width and height for Dropdown and TextField
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50, // Set a fixed height
                                          child: DropdownButtonFormField<
                                              DataGetCity>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            onChanged: (districtUser) =>
                                                setState(() {
                                              _selectedUserCity = districtUser;
                                              distCodeGovtPrivate = int.parse(
                                                  districtUser.subdistrictCode
                                                      .toString());
                                              print(
                                                  'Selected District: ${districtUser.subdistrictCode}');
                                            }),
                                            value: _selectedUserCity,
                                            items: districtList
                                                .map((DataGetCity district) {
                                              return DropdownMenuItem<
                                                  DataGetCity>(
                                                value: district,
                                                child: Text(district.name),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 5),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                // Add margin here

                                child: SizedBox(
                                  width: double.infinity,
                                  // Same width as Dropdown
                                  height: 50,
                                  // Same height as Dropdown
                                  child: TextFormField(
                                    controller: _Pincodecontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Pin Code*',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1.0),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter PinCode number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (locationTypeValues == 'Rural')
                        // Content to display if "Urban" is selected
                        Container(
                          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          width: double.infinity,
                          child: FutureBuilder<List<Data>>(
                            future: _futureState, // Fetching States
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              List<Data> stateList = snapshot.data ?? [];

                              // ✅ Insert hint item at the top
                              if (stateList.isNotEmpty && stateList.first.stateName != 'Select State') {
                                stateList.insert(0, Data(stateName: 'Select State', stateCode: -1, code: ''));
                              }

                              // ✅ Ensure a default selection
                              if (_selectedUserState == null || !stateList.contains(_selectedUserState)) {
                                _selectedUserState = stateList.first;
                                selectedStateName = _selectedUserState.stateName.toString();
                                print('@@selectedStateName' + selectedStateName.toString());
                              }

                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'State (Camp)',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 45, // Set the desired height for dropdown
                                      child: DropdownButtonFormField2<Data>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        onChanged: (user) async {
                                          // ✅ Prevent action if "Select State" is chosen
                                          if (user != null && user.stateName != 'Select State') {
                                            setState(() {
                                              _selectedUserState = user;
                                              selectedStateName = user.stateName;
                                              stateCodeGovtPrivate = int.parse(user.stateCode.toString());
                                              CodeGovtPrivate = user.code;
                                              print('@@selectedStateName' + selectedStateName.toString());

                                              /* // RESET dependent data
                                      _selectedUserDistrict = null;
                                      _selectedUserCity = null;
                                      _selectedUserVillage = null;

                                      isVisibleDitrictGovt = false;
                                      _isCityInitialized = false;*/
                                              // Ensure that the dependent dropdowns are reset
                                              setState(() {
                                                _selectedUserDistrict = null;
                                                _selectedUserCity = null;
                                                _selectedUserVillage = null;
                                                isVisibleDitrictGovt = false;
                                                _isCityInitialized = false;
                                              });

                                            });

                                            var connectivityResult = await Connectivity().checkConnectivity();
                                            bool isConnected = connectivityResult != ConnectivityResult.none;

                                            if (isConnected) {
                                              setState(() {
                                                isVisibleDitrictGovt = true; // Show District dropdown
                                              });
                                              await _getDistrictData(stateCodeGovtPrivate);
                                            } else {
                                              setState(() {
                                                isVisibleDitrictGovt = false; // Hide District dropdown if no internet
                                              });
                                            }
                                          }
                                        },
                                        value: _selectedUserState,
                                        buttonStyleData: ButtonStyleData(
                                          height: 20, // Increase dropdown button height
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                        ),
                                        items: stateList.map<DropdownMenuItem<Data>>((Data user) {
                                          return DropdownMenuItem<Data>(
                                            value: user,
                                            child: Text(
                                              user.stateName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),


                      SizedBox(height: 5),

                      Visibility(
                        visible: isVisibleDitrictGovt,  // Control the visibility of the district dropdown
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: FutureBuilder<List<DataDsiricst>>(
                                future: _getDistrictData(stateCodeGovtPrivate),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData || snapshot.data == null || snapshot.data.isEmpty) {
                                    return Center(child: CircularProgressIndicator());
                                  }

                                  List<DataDsiricst> districtList = snapshot.data ?? [];

                                  // ✅ Insert hint at top
                                  if (districtList.isNotEmpty && districtList.first.districtName != 'Select District') {
                                    districtList.insert(0, DataDsiricst(districtName: 'Select District', districtCode: -1));
                                  }

                                  if (_selectedUserDistrict == null || !districtList.contains(_selectedUserDistrict)) {
                                    _selectedUserDistrict = districtList.first;
                                    print('@@_selectedUserDistrict--' + _selectedUserDistrict.toString());
                                    distCodeGovtPrivate = int.parse(_selectedUserDistrict?.districtCode.toString() ?? "0");
                                    selectedDistrictName = _selectedUserDistrict.districtName.toString();
                                    print('@@selectedDistrictName' + selectedDistrictName);
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'District (Camp)',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 45,  // Set your desired height
                                        child: DropdownButtonFormField<DataDsiricst>(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey), // 👈 grey border
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey), // 👈 grey border
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey), // 👈 grey border

                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey), // 👈 still grey
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey), // 👈 grey even on error
                                            ),
                                          ),
                                          onChanged: (district) {
                                            if (district != null && district.districtName != 'Select District') {
                                              setState(() {
                                                _selectedUserDistrict = district;
                                                print('@@distCodeGovtPrivate--1' + _selectedUserDistrict.toString());
                                                distCodeGovtPrivate = int.parse(district.districtCode.toString());
                                                print('@@distCodeGovtPrivate--2' + distCodeGovtPrivate.toString());
                                                _selectedUserCity = null;
                                                _isCityInitialized = false; // Reset when district changes
                                              });
                                            }
                                          },
                                          value: _selectedUserDistrict,
                                          items: districtList.map((district) {
                                            return DropdownMenuItem<DataDsiricst>(
                                              value: district,
                                              child: Text(district.districtName),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),


                            SizedBox(height: 5),

                            // City Dropdown (Visible only after District selection)
                            Visibility(
                              visible: _showCityDropdown && _selectedUserDistrict != null,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: double.infinity,
                                child: FutureBuilder<List<DataGetCity>>(
                                  //   future: _getCity(distCodeGovtPrivate),
                                  future: distCodeGovtPrivate != -1 ? _getCity(distCodeGovtPrivate) : Future.value([]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData || snapshot.data == null || snapshot.data.isEmpty) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'No cities found',
                                          style: TextStyle(fontSize: 14, color: Colors.black54),
                                        ),
                                      );

                                    }
                                    List<DataGetCity> cityList = snapshot.data ?? [];

                                    // ✅ Add "Select City/Town" hint item if not already there
                                    if (cityList.isNotEmpty && cityList.first.name != 'Select City/Town') {
                                      cityList.insert(0, DataGetCity(name: 'Select City/Town', subdistrictCode: -1));
                                    }

                                    if (!_isCityInitialized) {
                                      if (_selectedUserCity == null || !cityList.contains(_selectedUserCity)) {
                                        _selectedUserCity = cityList.firstWhere(
                                              (item) => item.subdistrictCode == distCodeGovtPrivateCity,
                                          orElse: () => cityList.first,
                                        );

                                        distCodeGovtPrivateCity = int.tryParse(_selectedUserCity?.subdistrictCode.toString() ?? "0") ?? 0;
                                        selectedCityName = _selectedUserCity?.name ?? '';
                                        _isCityInitialized = true;

                                        print('@@_selectedUserCity-- $selectedCityName');
                                      }
                                    }

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select City/ Town',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 45,
                                          child: DropdownButtonFormField<DataGetCity>(
                                            focusColor: Colors.white,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            onChanged: (city) {

                                              if (city != null && city.subdistrictCode != -1) {
                                                setState(() {
                                                  _selectedUserCity = city;
                                                  distCodeGovtPrivateCity = city.subdistrictCode;
                                                  selectedCityName = city.name;
                                                  _selectedUserVillage = null; // Reset previous village
                                                  print('@@selectedCityName--1 $distCodeGovtPrivate');
                                                  print('@@selectedCityName--2 $stateCodeGovtPrivate');
                                                  print('@@selectedCityName--3 $distCodeGovtPrivateCity');
                                                  // RESET village values
                                                  _selectedUserVillage = null;
                                                  selectedVillageName = '';
                                                  _isVillageInitialized = false;

                                                  _villageFuture = _getVillage(distCodeGovtPrivate, stateCodeGovtPrivate, distCodeGovtPrivateCity);
                                                  // 👉 HIDE the city dropdown after selection
                                                  //  _showCityDropdown = false;
                                                });
                                              }
                                            },
                                            value: _selectedUserCity,
                                            items: cityList.map((city) {
                                              return DropdownMenuItem<DataGetCity>(
                                                value: city,
                                                child: Text(city.name.trim()),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: 5),

                            // Village Dropdown (Visible only after City selection)
                            Visibility(
                              visible: _selectedUserCity != null, // Village dropdown visible if a city is selected
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: FutureBuilder<List<DataGetVillage>>(

                                  //future: _getVillage(distCodeGovtPrivate, stateCodeGovtPrivate, distCodeGovtPrivateCity),
                                  //      future: _villageFuture ??= _getVillage(distCodeGovtPrivate, stateCodeGovtPrivate, distCodeGovtPrivateCity),
                                  future: (distCodeGovtPrivate != -1 && distCodeGovtPrivateCity != -1)
                                      ? _getVillage(distCodeGovtPrivate, stateCodeGovtPrivate, distCodeGovtPrivateCity)
                                      : Future.value([]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      //   return Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData || snapshot.data == null || snapshot.data.isEmpty) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'No Villages found',
                                          style: TextStyle(fontSize: 14, color: Colors.black54),
                                        ),
                                      );

                                    }
                                    List<DataGetVillage> villageList = snapshot.data ?? [];

                                    if (villageList.isEmpty) {
                                      return SizedBox(
                                        height: 45,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'No data found',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    // ✅ Insert default 'Select Village' option at the top if not already there
                                    if (villageList.first.name != 'Select Village') {
                                      villageList.insert(0, DataGetVillage(name: 'Select Village', villageCode: -1));
                                    }

                                    // ✅ Set default selection to 'Select Village'
                                    if (_selectedUserVillage == null || !villageList.contains(_selectedUserVillage)) {
                                      _selectedUserVillage = villageList.first;
                                      selectedVillageName = _selectedUserVillage.name.toString();
                                      print('@@selectedVillageName--' + selectedVillageName.toString());
                                    }

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(

                                          'Select Village:',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 45,
                                          child: DropdownButtonFormField<DataGetVillage>(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            onChanged: (village) {
                                              if (village != null) {
                                                setState(() {
                                                  _selectedUserVillage = village;
                                                  village_code = int.parse(village.villageCode ?? "0");
                                                  selectedVillageName = village.name.toString();
                                                  print('@@selectedVillageName--' + selectedVillageName.toString());
                                                });
                                              }
                                            },
                                            value: _selectedUserVillage,
                                            items: villageList.map((village) {
                                              return DropdownMenuItem<DataGetVillage>(
                                                value: village,
                                                child: Text(village.name),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
    SizedBox(height: 5),


                        /*    Container(
                              margin:EdgeInsets.fromLTRB(5, 0, 5, 0),

                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _Pincodecontroller,
                                  decoration: InputDecoration(
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Pin Code',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black, // Label color
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' *',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              // Red asterisk for required field
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        // Default grey border
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        // Grey border when enabled
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        // Grey border when focused
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Pin Code number';
                                    } else if (value.length != 10) {
                                      return 'Please enter Pin Code number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),*/

                        SizedBox(height: 5),
                      // Mobile Number Field
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _mobileController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Mobile No.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black, // Label color
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        // Red asterisk for required field
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  // Default grey border
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Grey border when enabled
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              } else if (value.length != 10) {
                                return 'Please enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

                      // Email ID Field

                      // Address Field
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _addresssController,
                            // Attach controller
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Address',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Regular label text color
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      // The asterisk for mandatory field
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .red, // Color for the asterisk
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              // Padding inside the TextFormField
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Border color when not focused
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  // Border color when focused
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  // Border color when there's an error
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  // Border color when focused and there's an error
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

// Inside your build method:
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: FutureBuilder<List<Data>>(
                          future: _futureState,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            List<Data> stateList = snapshot.data ?? [];
                            // ✅ Show "No data found" if list is empty
                            if (stateList.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No data found',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              );
                            }

                            // Ensure selected state is in the list
                            if (_selectedUserState == null ||
                                !stateList.contains(_selectedUserState)) {
                              _selectedUserState =
                                  stateList.isNotEmpty ? stateList.first : null;
                            //  selectedStateName = _selectedUserState.stateName.toString();
                              stateCodeGovtPrivate = int.tryParse(
                                  _selectedUserState.stateCode.toString()) ??
                                  0;
                              print('@@campRegistrationstateCodeGovtPrivate' + stateCodeGovtPrivate.toString());

                            }

                            return Container(
                              decoration: BoxDecoration(

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select State:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButtonFormField2<Data>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    value: _selectedUserState,
                                    items: stateList.map((Data user) {
                                      return DropdownMenuItem<Data>(
                                        value: user,
                                        child: Text(
                                          user.stateName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (user) {
                                      if (user != null) {
                                        setState(() {
                                          _selectedUserState = user;
                                          stateCodeGovtPrivate = int.tryParse(
                                                  user.stateCode.toString()) ??
                                              0;
                                          CodeGovtPrivate = user.code;

                                          isVisibleDitrictGovt =
                                              stateCodeGovtPrivate != 0;
                                          if (isVisibleDitrictGovt) {
                                            _getDistrictData(
                                                stateCodeGovtPrivate);
                                          }
                                        });
                                      }
                                    },
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      offset: const Offset(0, -3),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      height: 20, // Set consistent height

                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                    ),
                                    hint: const Text(
                                      'Select State',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 5.0),
                      Visibility(
                        visible: isVisibleDitrictGovt,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0),
                          child: FutureBuilder<List<DataDsiricst>>(
                            future: _getDistrictData(stateCodeGovtPrivate),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child:
                                        CircularProgressIndicator()); // Loading state
                              }
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Error: ${snapshot.error}')); // Error handling
                              }
                              if (!snapshot.hasData || snapshot.data.isEmpty) {
                                return Center(
                                    child: Text(
                                        'No districts found')); // Handle empty data
                              }

                              List<DataDsiricst> districtList = snapshot.data;

                              // Ensure selected district is valid
                              if (_selectedUserDistrict == null ||
                                  !districtList
                                      .contains(_selectedUserDistrict)) {
                                _selectedUserDistrict = districtList.first;
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // Align text and dropdown
                                children: [
                                  Text('Select District:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: double.infinity,
                                    // Full width inside the container
                                    height: 50,
                                    // Prevents RenderFlex overflow
                                    child:
                                        DropdownButtonFormField2<DataDsiricst>(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      buttonStyleData: const ButtonStyleData(
                                        height: 50,
                                      ),
                                      onChanged: (districtUser) => setState(() {
                                        _selectedUserDistrict = districtUser;
                                        distCodeGovtPrivate = int.parse(
                                            districtUser.districtCode
                                                .toString());
                                      }),
                                      value: _selectedUserDistrict,
                                      items: districtList
                                          .map((DataDsiricst district) {
                                        return DropdownMenuItem<DataDsiricst>(
                                          value: district,
                                          child: Text(district.districtName,
                                              overflow: TextOverflow.ellipsis),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Designation Field

                      // Submit and Cancel Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Process the form data
                              print("@@-----CampRegistration--");
                              _ScreeningCampRegistration();
                            },
                            icon: Icon(Icons.check), // Icon for submit
                            label: Text('Submit'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Reset form fields
                              _resetForm();
                            },
                            icon: Icon(Icons.refresh), // Icon for reset
                            label: Text('Reset'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getentryby() async {
    // Use await to get the actual value from SharedPrefs
    entryby =
        await SharedPrefs.getStoreSharedValue(AppConstant.entryBy) as String;

    if (entryby != null) {
      print("entryby Number: $entryby");
    } else {
      print("No entryby found in shared preferences.");
    }
  }

  Future<void> getloggedInNgoId() async {
    // Use await to get the actual value from SharedPrefs
    loggedInNgoId =
        await SharedPrefs.getStoreSharedValue(AppConstant.loggedInNgoId)
            as String;

    if (loggedInNgoId != null) {
      print("loggedInNgoId Number: $loggedInNgoId");
    } else {
      print("No loggedInNgoId found in shared preferences.");
    }
  }

  Future<void> getDarpanNo() async {
    // Use await to get the actual value from SharedPrefs
    darpan_nos =
        await SharedPrefs.getStoreSharedValue(AppConstant.darpan_no) as String;

    if (darpan_nos != null) {
      print("Darpan Number: $darpan_nos");
    } else {
      print("No Darpan Number found in shared preferences.");
    }
  }

  Future<List<DataGethospitalForDDL>> GetHospitalForDDL(
      int districtid, int stateId, String userId) async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      // Prepare the request body as a Map
      Map<String, dynamic> body = {
        'districtid': districtid,
        'stateId': stateId,
        'userId': userId, // Add user ID to the body
      };

      try {
        // Send POST request with the body encoded as JSON
        final response = await http.post(
          Uri.parse(
              'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetHospitalForDDL'),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
          },
          body: jsonEncode(body), // Encode the body as JSON
        );
        // Print the URL and request parameters
        print('@@URL:' +
            "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetHospitalForDDL");
        print('@@Params: ${jsonEncode(body)}');
        // Check if the response is successful
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          final GethospitalForDDL dashboardStateModel =
              GethospitalForDDL.fromJson(json);
          print('@@Params: ${dashboardStateModel.data.toString()}');
          return dashboardStateModel.data;
        } else {
          // Handle the case when the server responds with an error
          Utils.showToast('Error: ${response.statusCode}', true);
          return null;
        }
      } catch (e) {
        // Handle potential JSON decoding or other unexpected errors
        Utils.showToast('An error occurred: $e', true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataCenterOfficeNameSatelliteCenter>> getSatelliteManager(
      int stateId, int districtid, String entryBy) async {
    print("@@getSatelliteManager--check for officeerName" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSatelliteManager;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtid,
        "entryBy": entryBy,
      });
      print("@@getSatelliteManager--bodyprint--yy: ${url + body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getSatelliteManager--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      CenterOfficeNameSatelliteCenter data =
          CenterOfficeNameSatelliteCenter.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);

      return [];
    }
  }

  Future<List<DataScreeningCampManager>> getCampManager(
      int districtid, String entryBy) async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      // Prepare the request body as a Map
      Map<String, dynamic> body = {
        'districtid': districtid,
        'entryBy': entryBy, // Add user ID to the body
      };
      // Send POST request with the body encoded as JSON
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCampManager'),
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },

        body: jsonEncode(body), // Encode the body as JSON
      );
      print("@@GetCampManager__printher" +
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCampManager" +
          body.toString());

      // Check if the response is successful
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final ScreeningCampManager dashboardStateModel =
            ScreeningCampManager.fromJson(json);
        return dashboardStateModel.data;
      } else {
        // Handle the case when the server responds with an error
        Utils.showToast('Error: ${response.statusCode}', true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<Data>> _getStatesDAta() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/State'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final DashboardStateModel dashboardStateModel =
          DashboardStateModel.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataGetCity>> _getCity(int districtId) async {
    GetCity dashboardDistrictModel = GetCity();

    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"districtId": districtId});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCity",
          data: body,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + body.toString());
      print("@@Response--Api=====" + response1.toString());
      dashboardDistrictModel = GetCity.fromJson(json.decode(response1.data));
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

  Future<void> _ScreeningCampRegistration() async {
    // Manual field validation
    if (_campNameController.text.trim().isEmpty) {
      Utils.showToast("Camp name is required", false);
      return;
    }

    if (_selectedDateText.isEmpty) {
      Utils.showToast("Start date is required", false);
      return;
    }

    if (_selectedDateTextToDate.isEmpty) {
      Utils.showToast("End date is required", false);
      return;
    }

    if (_mobileController.text.trim().length != 10) {
      Utils.showToast("Enter a valid 10-digit mobile number", false);
      return;
    }

    if (_addresssController.text.trim().isEmpty) {
      Utils.showToast("Address is required", false);
      return;
    }

    if (_Pincodecontroller.text.trim().length != 6) {
      Utils.showToast("Enter a valid 6-digit PIN code", false);
      return;
    }

    if (getmanagerSrNO == null || getmanagerSrNO.toString().isEmpty) {
      Utils.showToast("Select a camp manager", false);
      return;
    }

    // Passed validation, continue to API call
    Utils.showProgressDialog1(context);
    print("@@-----CampRegistration--inside api");

    var response = await ApiController.campRegistration(
      ngoNames.toString().trim(),
      _campNameController.text.trim(),
      _selectedDateText,
      _selectedDateTextToDate.trim(),
      getmanagerSrNO,
      _mobileController.text.trim(),
      _addresssController.text.trim(),
      valuetype,
      0,
      0,
      "0",
      0,
      0,
      0,
      0,
      _Pincodecontroller.text.trim(),
      distCodeGovtPrivate,
      stateCodeGovtPrivate,
      userId,
      entryby,
      darpan_nos,
    );

    Utils.hideProgressDialog1(context);
    print("@@-----CampRegistration--inside api--2");

    if (response.message == "Camp Registered Successfully.") {
      Utils.showToast(response.message.toString(), true);
      print("@@Result message----Class: " + response.message);
      _campNameController.clear();
      _mobileController.clear();
      _addresssController.clear();
      _Pincodecontroller.clear();

      // Reset dropdowns or selection variables

      // Reset date values
      _selectedDateText = '';
      _selectedDateTextToDate = '';

    } else {
      Utils.showToast("Not created successfully", true);
    }
  }

  void _resetForm() {
    setState(() {
      // Clear all text fields
      _campNameController.clear();
      _mobileController.clear();
      _addresssController.clear();
      _Pincodecontroller.clear();

      // Reset dropdowns or selection variables

      // Reset date values
      _selectedDateText = '';
      _selectedDateTextToDate = '';

      // Reset radio buttons or other custom fields
    });
  }

  Future<void> ngoName() async {
    // Use await to get the actual value from SharedPrefs
    ngoNames =
        await SharedPrefs.getStoreSharedValue(AppConstant.ngoName) as String;

    if (ngoNames != null) {
      print("ngoNames Number: $ngoNames");
    } else {
      print("No ngoNames found in shared preferences.");
    }
  }
  Future<List<DataGetVillage>> _getVillage(
      int districtId, int stateId, int cityId) async {
    GetVillage dashboardDistrictModel = GetVillage();
    Response response1;

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode(
          {"districtId": districtId, "stateId": stateId, "cityId": cityId});

      Dio dio = Dio();
      response1 = await dio.post(
        "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetVillage",
        data: body,
        options: Options(
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );
      print("@@GetVillage--Api: " +
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetVillage");
      print("@@GetVillage--Api: $body");
      print("@@GetVillage--Api Response: ${response1.data}");

      dashboardDistrictModel = GetVillage.fromJson(json.decode(response1.data));

      if (dashboardDistrictModel.status &&
          dashboardDistrictModel.data != null) {
        print("@@GetVillage--Data Size: ${dashboardDistrictModel.data.length}");
        return dashboardDistrictModel.data;
      } else {
        print("@@GetVillage--No Data Found");
        return [];
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }
  }
}
