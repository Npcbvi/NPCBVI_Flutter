import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/camp/CampListDataonDashboard.dart';
import 'package:mohfw_npcbvi/src/model/camp/HospitalListForDasboard.dart';
import 'package:mohfw_npcbvi/src/model/camp/totalPatient/TotalPatientCamp.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/PatientRegistrations.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:path_provider/path_provider.dart';

import '../database/DatabaseHelper.dart';
import '../model/DashboardStateModel.dart';
import '../model/city/GetCity.dart';
import '../model/city/GetVillage.dart';
import '../model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import '../model/patientCount/PatientCountDetail.dart';
import '../model/spoModel/GetDiseaseForDDL.dart';
import '../model/spoModel/GetLanguageForDDLs.dart';
import '../utils/AppConstants.dart';

class UpdatePatientCamp extends StatefulWidget {
  @override
  _UpdatePatientCamp createState() => _UpdatePatientCamp();
}

class _UpdatePatientCamp extends State<UpdatePatientCamp> {
  bool _isVillageInitialized = false;
  Future<List<DataGetVillage>> _villageFuture;
  int registerationtypeRadioValueinAPi = 2; // Default gender
  bool _showCityDropdown = true;
  String registerationtypeRadio = 'Screening Camp'; // Default gender
  TextEditingController _voterIDNumber = TextEditingController();
  TextEditingController _drivingLicenseNumber = TextEditingController();
  TextEditingController _passport = TextEditingController();
  TextEditingController _rationCard = TextEditingController();
  TextEditingController _panCard = TextEditingController();
  TextEditingController _notAvalble = TextEditingController();
  TextEditingController _reportingPlaceController = TextEditingController();
  TextEditingController _firstNamePatientDetail = TextEditingController();
  TextEditingController _lastNamePatientDetail = TextEditingController();
  TextEditingController _AgePatientDetail = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileNumberDetailsRelationtype =
  TextEditingController();
  TextEditingController _AddressHouse = TextEditingController();

  // TextEditingController _Apartment = TextEditingController();
  // TextEditingController _AreaNearLandMark = TextEditingController();
  TextEditingController _PinCode = TextEditingController();
  TextEditingController fullnameControllers = new TextEditingController();

  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController,
      role_id;
  int status, district_code_login, state_code_login;

  String lowVisionDatas;

  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  bool hospitalDashboardclickDsiplay = false;
  String getYearNgoHopital, getfyidNgoHospital, _chosenValueMangeTwo;
  bool hospitalDashboardDatas = false;
  bool hospitalAddPatientData = false;
  File _selectedImage;
  String _errorMessage,
      VoterIDtype,
      relationtypeValueMobile,
      entryby,
      loggedInNgoId;
  final ImagePicker _picker = ImagePicker();
  final _formKeyhopsitalPersonalDetal = GlobalKey<FormState>();
  String gender = 'Male'; // Default gender
  var dependencyTypeRadio;
  int voterIDTypeValue = 0;
  bool showVoterIDField = false,
      showDrivingLicenseField = false,
      showPassport = false,
      showRationCard = false,
      showPanCard = false,
      showNotAvailble = false;
  bool showSelf = false, Dependent = false;
  File _image;
  String _selectedDateText = 'Screening Date'; // Initially set to "From Date"
  String _selectedDateTextToDate = 'Tentative Date';

  String _dob = 'Date of birth';
  Future<List<Data>> _futureState;
  Data _selectedUserState;

  Future<List<CampListDataonDashboardData>> _futureCamp;
  CampListDataonDashboardData _selectedUserCamp;
  Future<List<HospitalListForDasboardData>> _futureHospital;
  HospitalListForDasboardData _selectedUserHospital;
  DataDsiricst _selectedUserDistrict;
  Future<List<DataGetVillage>> _futureVillage;
  DataGetVillage _selectedUserVillage;
  Future<List<DataGetCity>> _futureCity;
  DataGetCity _selectedUserCity;
  bool isVisibleDitrictGovt = false;
  bool _isCityInitialized = false;
  bool showCoordinates = false;

  Future<List<GetLanguageForDDLsDatas>> _futureStateGetLanguageForDDLsData;
  GetLanguageForDDLsDatas GetLanguageForDDLsDatasa;
  Future<List<GetDiseaseForDDLData>> _futureGetDiseaseForDDLDatas;
  GetDiseaseForDDLData _futureGetDiseaseForDDLDatass;
  int stateCodeSPO,
      disrtcCode,
      stateCodeDPM,
      stateCodeGovtPrivate,
      distCodeDPM,
      distCodeGovtPrivate,
      distCodeGovtPrivateCity,
      stateLKanguage,
      getDissesID,
      village_code = 0;
  String CodeSPO,
      codeDPM,
      CodeGovtPrivate,
      distNameDPM,
      distNameDPMs_distictValues;
  String currentFinancialYear;

  bool _isChecked = false;
  TextEditingController _searchController = TextEditingController();


  String getCurrentFinancialYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int nextYear = currentYear + 1;
    String financialYear;

    if (now.month >= 4) {
      // Financial year starts in April
      financialYear = '$currentYear-${nextYear.toString().substring(2)}';
    } else {
      financialYear =
      '${currentYear - 1}-${currentYear.toString().substring(2)}';
    }

    return financialYear;
  }

  // Function to determine position



  // For ImagePicker



  void getUserData() async {
    try {
      SharedPrefs.getUser().then((user) async {
        entryby = await SharedPrefs.getStoreSharedValue(AppConstant.entryBy)
        as String;
        loggedInNgoId =
        await SharedPrefs.getStoreSharedValue(AppConstant.ngoid) as String;
        setState(() {
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          status = user.status;
          role_id = user.roleId;
          state_code_login = user.state_code;
          district_code_login = user.district_code;
          getloggedInNgoId();
          getentryby();
          print('@@entryby' + entryby);
          print('@@role_id' + role_id);
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
          // Assuming you fetch the value from login or a previous screen

        });
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        print("🌐 Internet Available. Uploading Local Data...");
        //uploadLocalData(); // ✅ Upload when online
      }
    });
    getUserData();



  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Update Patient',
              maxLines: 2,
              style: new TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          /* leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Utils.hideKeyboard(context);
              Navigator.of(context).pop(context);
            }),*/
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                    Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800), // Adjust width as needed
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 30),
                                        Expanded(child: _buildInfoColumn("Login Type", "Camp Manager")),
                                        SizedBox(width: 30),
                                        Expanded(child: _buildInfoColumn("State", stateNames)),
                                        // Placeholder
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 30),
                                        Expanded(child: _buildInfoColumn("District", districtNames)),
                                        SizedBox(width: 30),
                                        Expanded(child: _buildInfoColumn("Login Id", userId)),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(color: Colors.grey, height: 1.0),
                  SizedBox(height: 5),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                _isChecked = value;
                              });
                            },
                          ),
                          Text(
                            "To see All Patient(s), Use Date search",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      SizedBox(height: 8),

                    ],
                  ),
                  SizedBox(height: 5),
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
                          flex: 3,
                          child:buildDropdownHospitalType(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Patients List (Today\'s Registered)',
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

                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ));
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

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          maxLines: 1,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }


  void logFormData(Map<String, dynamic> formData) {
    print("Logging Form Data:");
    formData.forEach((key, value) {
      if (key == "patientImage" && value is String && value.length > 100000) {
        // For large fields like images, log only the first 100 characters
        print("$key: ${value.substring(0, 100000)}... [truncated]");
      } else {
        print("$key: $value");
      }
    });
  }
  Widget buildDropdownHospitalType() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: MediaQuery.of(context).size.width * 0.45,
      height: 50,
      child: DropdownButtonFormField2<String>(
        value: _chosenValueMangeTwo,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Select Filter',
          hintStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          openMenuIcon: Icon(Icons.arrow_drop_up, color: Colors.black),
        ),
        items: <String>[
          'Todays Patients',
          'Last Week',
          'Last Month',
          'Last three Month',
          'Current FY'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _chosenValueMangeTwo = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }


}
