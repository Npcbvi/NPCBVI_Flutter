import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/city/GetCity.dart';
import 'package:mohfw_npcbvi/src/model/city/GetVillage.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetDiseaseForDDL.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetLanguageForDDLs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetLanguageForDDLs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetLanguageForDDLs.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../model/spoModel/GetLanguageForDDLs.dart';
import '../model/spoModel/GetLanguageForDDLs.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboard createState() => _HospitalDashboard();
}

class _HospitalDashboard extends State<HospitalDashboard> {
  TextEditingController fullnameControllers = new TextEditingController();
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController,
      role_id;
  int status, district_code_login, state_code_login;
  final GlobalKey _dropdownKey = GlobalKey();

  final GlobalKey _dropdownKeySenTODPM = GlobalKey();

  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption,lowVisionDatas,_chosenValueDiseses;

  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  bool hospitalDashboardclickDsiplay = false;
  String getYearNgoHopital, getfyidNgoHospital, _chosenValueMangeTwo;
  bool hospitalDashboardDatas = false;
  bool hospitalAddPatientData = false;
  String registerationtypeRadio = 'Hospital Walk-in'; // Default gender
  int registerationtypeRadioValueinAPi = 2; // Default gender
  File _selectedImage;
  String _errorMessage, VoterIDtype,relationtypeValue,relationtypeValueMobile;
  final ImagePicker _picker = ImagePicker();
  final _formKeyhopsitalPersonalDetal = GlobalKey<FormState>();

  TextEditingController _firstNamePatientDetail = TextEditingController();
  TextEditingController _lastNamePatientDetail = TextEditingController();
  TextEditingController _AgePatientDetail = TextEditingController();

  TextEditingController _mobileNumberDetailsRelationtype = TextEditingController();
  String gender = 'Male'; // Default gender
  var dependencyTypeRadio;
  int voterIDTypeValue = 0;
  bool showVoterIDField = false,showDrivingLicenseField=false,showPassport=false,showRationCard=false,showPanCard=false,showNotAvailble=false;
  bool showSelf = false,Dependent=false;
  TextEditingController _voterIDNumber = TextEditingController();
  TextEditingController _drivingLicenseNumber = TextEditingController();
  TextEditingController _passport = TextEditingController();
  TextEditingController _rationCard = TextEditingController();
  TextEditingController _panCard = TextEditingController();
  TextEditingController _notAvalble = TextEditingController();
  TextEditingController _reportingPlaceController = TextEditingController();

  TextEditingController _AddressHouse = TextEditingController();
  TextEditingController _Apartment = TextEditingController();
  TextEditingController _AreaNearLandMark = TextEditingController();
  TextEditingController _PinCode = TextEditingController();

  File _image;
  String _selectedDateText = 'Screening Date *'; // Initially set to "From Date"

  String _selectedDateTextToDate = 'Tentative Surgery Date *';

  String _dob = 'Date of birth';

  Future<List<Data>> _futureState;
  Data _selectedUserState;
  DataDsiricst _selectedUserDistrict;
  Future<List<DataGetVillage>> _futureVillage;
  DataGetVillage _selectedUserVillage;
  Future<List<DataGetCity>> _futureCity;
  DataGetCity _selectedUserCity;
  bool isVisibleDitrictGovt = false;
  Future<List<GetLanguageForDDLsDatas>> _futureStateGetLanguageForDDLsData;
  GetLanguageForDDLsDatas GetLanguageForDDLsDatasa;
  Future<List<GetDiseaseForDDLData>> _futureGetDiseaseForDDLDatas;
  GetDiseaseForDDLData _futureGetDiseaseForDDLDatass;
  int stateCodeSPO,
      disrtcCode,
      stateCodeDPM,
      stateCodeGovtPrivate,
      distCodeDPM,
      distCodeGovtPrivate,stateLKanguage,getDissesID;
  String CodeSPO,
      codeDPM,
      CodeGovtPrivate,
      distNameDPM,
      distNameDPMs_distictValues;
  TextEditingController relationNameController = TextEditingController();
  TextEditingController relationFatherController = TextEditingController();
  TextEditingController relationMotherController = TextEditingController();
  TextEditingController relationBrotherController = TextEditingController();
  TextEditingController relationSisterController = TextEditingController();
  TextEditingController relationDaughterController = TextEditingController();
  TextEditingController relationspouseController = TextEditingController();
  Future<void> _showPickerDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
      //  _image = pickedImage;
        _image = File(pickedImage.path); // Ensure _image is a File
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();
    hospitalDashboardclickDsiplay = true;
    _future = getDPM_ScreeningYear();
    _futureState = _getStatesDAta();
    _futureVillage = _getVillage(district_code_login, state_code_login);
_futureStateGetLanguageForDDLsData=getLanguageForDDL();
    _futureStateGetLanguageForDDLsData=getLanguageForDDL();
    _futureGetDiseaseForDDLDatas=getDiseaseForDDL();
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
          // Assuming you fetch the value from login or a previous screen
          String reportingPlace = fullnameController; // Replace with actual value
          _reportingPlaceController.text  = reportingPlace;
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome ${fullnameController}',
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 10),
                    Text("Change Password"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.book),
                    SizedBox(width: 10),
                    Text("User Manual"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
            offset: Offset(0, 50),
            color: Colors.white,
            elevation: 2,
            onSelected: (value) {
              switch (value) {
                case 1:
                  //  _showChangePasswordDialog();
                  break;
                case 2:
                  // Implement User Manual action
                  break;
                case 3:
                  // Handle Logout
                  break;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildNavigationButton('Dashboard', () {
                        setState(() {
                          print('@@dashboardviewReplace----display---');
                          _future = getDPM_ScreeningYear();
                          hospitalDashboardclickDsiplay = true;
                          hospitalAddPatientData = false;
                        });
                      }),
                      SizedBox(width: 8.0),
                      _buildDropdownRegisterPatient(),
                      SizedBox(width: 8.0),
                      _buildNavigationButton('Add PNJA', () {
                        print('@@Add PNJA');
                        setState(() {});
                      }),
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
                                    print('@@NGO--1' + _chosenValueLOWVision);
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
                                  } else {
                                    print('@@Childhood--2' +
                                        _chosenValueLOWVision);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 170.0,
                        key: _dropdownKeySenTODPM,
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
                                "Send to DPM",
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
                                  } else if (_chosenValueLOWVision ==
                                      "VR Surgery") {
                                    print('@@Childhood--' +
                                        _chosenValueLOWVision);
                                  } else if (_chosenValueLOWVision ==
                                      "Childhood Blindness") {
                                    print('@@Childhood--' +
                                        _chosenValueLOWVision);
                                  } else {
                                    print('@@Childhood--2' +
                                        _chosenValueLOWVision);
                                  }
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
            _buildUserInfo(),
            hospitalDashboardclick(),
            HospitalAddPatientData()
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildDropdownRegisterPatient() {
    return Container(
      width: 170.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue.shade200,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: _dropdownKey,
            // Assign the key here
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
                _chosenValue = value ?? '';
                if (_chosenValue == "Add Patient") {
                  print('@@NGO---Hospital--1 $_chosenValue');
                  hospitalAddPatientData = true;
                  hospitalDashboardclickDsiplay = false;
                  //_showPopupMenu();
                } else if (_chosenValue == "Update Patient") {
                  print('@@Screening--1 $_chosenValue');
                  //  _showPopupMenuScreeningCamp();
                } else if (_chosenValue == "Screening Entry") {
                  print('@@Sattelite--1 $_chosenValue');
                  //  _showPopupMenuSatteliteCenter();
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildUserInfoItem(
                  'Login Type:', 'Hospital', Colors.black, Colors.red),
              _buildUserInfoItem('Login Id:', userId, Colors.black, Colors.red),
              _buildUserInfoItem(
                  'District:', districtNames, Colors.black, Colors.red),
              _buildUserInfoItem(
                  'State:', stateNames, Colors.black, Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(
      String label, String value, Color labelColor, Color valueColor) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
        Text(value,
            style: TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
      ],
    );
  }

  Widget hospitalDashboardclick() {
    return Row(
      children: [
        Visibility(
          visible: hospitalDashboardclickDsiplay,
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
                          snapshot.data.toList();

                      // Check if _selectedUser is null or not part of the list anymore
                      if (_selectedUser == null ||
                          !list.contains(_selectedUser)) {
                        _selectedUser =
                            list.first; // Set the first item as default
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
                SizedBox(height: 10),
                buildInfoContainer(stateNames),
                SizedBox(height: 10),
                buildInfoContainer(districtNames),
                SizedBox(height: 10),
                buildDropdownHospitalType(),
                SizedBox(height: 10),
                buildInfoContainer(fullnameController),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Get button clicked');
                      setState(() {
                        // Update ngoDashboardDatas based on dropDownTwoSelcted value
                        // if (dropDownTwoSelcted == 6) {
                        if (getYearNgoHopital == null) {
                          Utils.showToast(
                              "Please Select financialYear !", false);
                        } else {
                          hospitalDashboardDatas = true;
                        }
                        /*   } else {
                          ngoDashboardDatas = false;
                        }*/
                      });
                    },
                    child: Text('Get Data'),
                  ),
                ),
                Visibility(
                  visible: hospitalDashboardDatas,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total number of patients (Hospital)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Horizontal Scrolling Header Row

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              children: [
                                _buildHeaderCell('Disease Type'),
                                _buildHeaderCell('Registered'),
                                _buildHeaderCell('Operated'),
                              ],
                            ),
                            Divider(color: Colors.blue, height: 1.0),
                            // Data Rows
                            FutureBuilder<List<DataHospitalDashboard>>(
                              future: ApiController.hospitalDashboard(
                                  int.parse(role_id),
                                  district_code_login,
                                  state_code_login,
                                  userId,
                                  getYearNgoHopital,
                                  0,
                                  "0"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Utils.getEmptyView(
                                      "Error: ${snapshot.error}");
                                } else if (!snapshot.hasData ||
                                    snapshot.data.isEmpty) {
                                  return Utils.getEmptyView("No data found");
                                } else {
                                  List<DataHospitalDashboard> ddata =
                                      snapshot.data;

                                  return Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          _buildDataCell(offer.status),
                                          _buildDataCellblue(offer.registered),
                                          _buildDataCellblue(offer.operated),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
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

  Widget buildInfoContainer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
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

  Widget _buildDataCellblue(String text) {
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
            color: Colors.blue,
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

  Widget buildDropdownHospitalType() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: 300,
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.blue.shade200),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _chosenValueMangeTwo,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'Hospitals',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  items: <String>['Hospitals']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueMangeTwo = value ?? 'All';
                      switch (_chosenValueMangeTwo) {
                        case 'Hospitals':
                          break;

                        default:
                          break;
                      }
                    });
                  },
                ),
                // Show the second dropdown only if the selected value is "Hospitals"
              ],
            ),
          ),
        ));
  }

  Widget HospitalAddPatientData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: hospitalAddPatientData,
            child: Column(
              children: [
                _sectionHeader('Patient Registration'),
                _patientInfoRow(),
                SizedBox(height: 10.0),
                _sectionTitle('Registration Type'),
                _radioButtonRow(
                  options: [
                    'Screening Camp',
                    'Satellite Centre',
                    'Hospital Walk-in'
                  ],
                  groupValue: registerationtypeRadio,
                  onChanged: (value) {
                    setState(() {
                      registerationtypeRadio = value;
                      print('@@1'+registerationtypeRadio.toString());
                      if(registerationtypeRadio=="Screening Camp"){
                        registerationtypeRadioValueinAPi=1;
                      }else if (registerationtypeRadio=="Satellite Centre"){
                        registerationtypeRadioValueinAPi=2;
                      }else if(registerationtypeRadio=="Hospital Walk-in"){
                        registerationtypeRadioValueinAPi=3;
                      }

                    });
                  },
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _showPickerDialog,
                        child: Text("Select Image"),
                      ),
                      SizedBox(height: 20),
                      if (_image != null)
                        Image.file(
                          File(_image.path),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                ),
                _sectionHeader('Personal Details'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKeyhopsitalPersonalDetal,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              // Background color of the dropdown box
                              border: Border.all(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.black,
                                value: VoterIDtype,
                                style: TextStyle(color: Colors.black),
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  'Voter ID',
                                  'Driving License',
                                  'Passport',
                                  'Ration Card',
                                  'Pan Card',
                                  'Not Available',
                                ].map<DropdownMenuItem<String>>((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Select Type",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    VoterIDtype = newValue;
                                    showVoterIDField = VoterIDtype == "Voter ID"; // Show field if "Voter ID" is selected
                                    showDrivingLicenseField = VoterIDtype == "Driving License";
                                    showPassport = VoterIDtype == "Passport";
                                    showRationCard= VoterIDtype == "Ration Card";
                                    showPanCard= VoterIDtype == "Pan Card";

                                    showNotAvailble= VoterIDtype == "Not Available";


                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        if (showVoterIDField)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Voter ID No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Voter ID No.'
                                  : null,
                            ),
                          ),
                        if (showDrivingLicenseField)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Driving License No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Driving License No.'
                                  : null,
                            ),
                          ),
                        if (showPassport)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Passport No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Passport No.'
                                  : null,
                            ),
                          ),
                        if (showRationCard)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Ration Card No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Ration Card No.'
                                  : null,
                            ),
                          ),
                        if (showPanCard)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Pan Card No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Pan Card No.'
                                  : null,
                            ),
                          ),
                        if (showNotAvailble)

                        SizedBox(height: 16.0),
                        _sectionTitle('Dependency Type'),
                        _radioButtonRow(
                          options: ['Self', 'Dependent'],
                          groupValue: dependencyTypeRadio,
                          onChanged: (value) {
                            setState(() {
                              dependencyTypeRadio = value;
                              print('@@11' + dependencyTypeRadio.toString());
                              showSelf = dependencyTypeRadio == "Self"; // Show field if "Self" is selected
                              Dependent = dependencyTypeRadio == "Dependent";
                            });
                          },
                        ),
                        if (Dependent) // Only show if "Dependent" is selected
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        focusColor: Colors.black,
                                        value: relationtypeValue,
                                        style: TextStyle(color: Colors.black),
                                        iconEnabledColor: Colors.black,
                                        items: <String>[
                                          'Father',
                                          'Mother',
                                          'Brother',
                                          'Sister',
                                          'Daughter',
                                          'Spouse',
                                        ].map<DropdownMenuItem<String>>((String type) {
                                          return DropdownMenuItem<String>(
                                            value: type,
                                            child: Text(
                                              type,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "Relation Type",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            relationtypeValue = newValue;

                                            // Set the relation name dynamically
                                            if (relationtypeValue == "Father") {
                                              relationNameController.text = "Father's Name";
                                            } else if (relationtypeValue == "Mother") {
                                              relationNameController.text = "Mother's Name";
                                            }else if (relationtypeValue == "Brother") {
                                              relationNameController.text = "Brother's Name";
                                            }
                                            else if (relationtypeValue == "Sister") {
                                              relationNameController.text = "Sister's Name";
                                            }
                                            else if (relationtypeValue == "Daughter") {
                                              relationNameController.text = "Daughter's Name";
                                            }
                                            else if (relationtypeValue == "Spouse") {
                                              relationNameController.text = "Spouse's Name";
                                            }

                                            else {
                                              relationNameController.clear();
                                            }
                                          });

                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Display input field based on selected relation
                                if (relationtypeValue == "Father")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Father's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Father\'s name'
                                          : null,
                                    ),
                                  ),
                                if (relationtypeValue == "Mother")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Mother's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Mother\'s name'
                                          : null,
                                    ),
                                  ),
                                if (relationtypeValue == "Brother")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Brother's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Brother\'s name'
                                          : null,
                                    ),
                                  ),
                                if (relationtypeValue == "Sister")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Sister's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Sister\'s name'
                                          : null,
                                    ),
                                  ),
                                if (relationtypeValue == "Daughter")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Daughter's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Daughter\'s name'
                                          : null,
                                    ),
                                  ),
                                if (relationtypeValue == "Spouse")
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _textInputField(
                                      controller: relationFatherController,
                                      labelText: "Spouse's Name",
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please enter Spouse\'s name'
                                          : null,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                        if (showSelf) // Hide the relation type section if "Self" is selected
                          SizedBox.shrink(), // This will render nothing when "Self" is selected

                        SizedBox(height: 10.0),
                        _textInputField(
                          controller: _firstNamePatientDetail,
                          labelText: 'First  Name *',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            } else if (value.length != 10) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        _textInputField(
                          controller: _lastNamePatientDetail,
                          labelText: 'Last Name *',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            } else if (value.length != 10) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
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
                                            _dob = formattedDate;
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
                                          _dob,
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
                        SizedBox(height: 10.0),
                        _textInputField(
                          controller: _AgePatientDetail,
                          labelText: 'Age *',
                          keyboardType: TextInputType.number,
                        ),
                        _sectionTitle('Gender *'),
                        _radioButtonRow(
                          options: ['Male', 'Female', 'Transgender'],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
                _sectionHeader('Mobile Number Details'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              focusColor: Colors.black,
                              value: relationtypeValueMobile,
                              style: TextStyle(color: Colors.black),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'Father',
                                'Mother',
                                'Brother',
                                'Sister',
                                'Daughter',
                                'Spouse',
                              ].map<DropdownMenuItem<String>>((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Relation Type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  relationtypeValueMobile = newValue;


                                });

                              },
                            ),
                          ),
                        ),
                      ),
                      // Display input field based on selected relation
                      if (relationtypeValue == "Father")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Father's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Father\'s name'
                                : null,
                          ),
                        ),
                      if (relationtypeValue == "Mother")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Mother's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Mother\'s name'
                                : null,
                          ),
                        ),
                      if (relationtypeValue == "Brother")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Brother's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Brother\'s name'
                                : null,
                          ),
                        ),
                      if (relationtypeValue == "Sister")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Sister's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Sister\'s name'
                                : null,
                          ),
                        ),
                      if (relationtypeValue == "Daughter")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Daughter's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Daughter\'s name'
                                : null,
                          ),
                        ),
                      if (relationtypeValue == "Spouse")
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _textInputField(
                            controller: relationFatherController,
                            labelText: "Spouse's Name",
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Spouse\'s name'
                                : null,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                           controller: _mobileNumberDetailsRelationtype,
                          labelText: 'Mobile No *',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
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

                SizedBox(height: 10.0),
                Center(
                  child: Column(
                    children: [
                      FutureBuilder<List<GetDiseaseForDDLData>>(
                        future: _futureGetDiseaseForDDLDatas,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          // Logging for debugging
                          developer
                              .log('@@snapshot: ${snapshot.data}');

                          List<GetDiseaseForDDLData> districtList =
                              snapshot.data;

                          // Ensure selected district is in the list, otherwise select the first one
                          if (_futureGetDiseaseForDDLDatass == null ||
                              !districtList
                                  .contains(_futureGetDiseaseForDDLDatass)) {
                            _futureGetDiseaseForDDLDatass = districtList.first;
                          }

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 10, 20.0, 0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                const Text('Select Diseases:'),
                                DropdownButtonFormField<GetDiseaseForDDLData>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  onChanged: (districtUser) =>
                                      setState(() {
                                        _futureGetDiseaseForDDLDatass = districtUser;
                                        getDissesID = int.parse(
                                            districtUser.id
                                                .toString());
                                        // Update state or further actions here
                                        print(
                                            'Selected District: ${districtUser.name}');
                                      }),
                                  value: _futureGetDiseaseForDDLDatass,
                                  items: districtList
                                      .map((GetDiseaseForDDLData district) {
                                    return DropdownMenuItem<
                                        GetDiseaseForDDLData>(
                                      value: district,
                                      child: Text(district.name),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),



                SizedBox(height: 10.0),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                           controller: _reportingPlaceController,
                          labelText: 'Reporting Place *',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: Colors.grey[300]),
                    ),
                  ),
                  child: Center(
                    child: FutureBuilder<List<Data>>(
                      future: _futureState, // Future to fetch the data
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        // Logging data for debugging
                        developer.log('@@snapshot: ${snapshot.data}');

                        List<Data> stateList = snapshot.data;

                        // Ensure selected state is in the list, otherwise select the first
                        if (_selectedUserState == null ||
                            !stateList.contains(_selectedUserState)) {
                          _selectedUserState = stateList.first;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: Colors.grey[300]),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 10, 20.0, 0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Select State:',
                                ),
                                DropdownButtonFormField<Data>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  onChanged: (user) => setState(() {
                                    _selectedUserState = user;
                                    stateCodeGovtPrivate = int.parse(
                                        user.stateCode.toString());
                                    CodeGovtPrivate = user.code;

                                    if (stateCodeGovtPrivate != null) {
                                      isVisibleDitrictGovt = true;
                                      _getDistrictData(
                                          stateCodeGovtPrivate);
                                    } else {
                                      isVisibleDitrictGovt = false;
                                    }
                                  }),
                                  value: _selectedUserState,
                                  items: stateList
                                      .map<DropdownMenuItem<Data>>(
                                          (Data user) {
                                        return DropdownMenuItem<Data>(
                                          value: user,
                                          child: Text(user.stateName),
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Visibility(
                  visible: isVisibleDitrictGovt,
                  child: Column(
                    children: [
                      Center(
                        child: FutureBuilder<List<DataDsiricst>>(
                          future:
                          _getDistrictData(stateCodeGovtPrivate),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            // Logging for debugging
                            developer
                                .log('@@snapshot: ${snapshot.data}');

                            List<DataDsiricst> districtList =
                                snapshot.data;

                            // Ensure selected district is in the list, otherwise select the first one
                            if (_selectedUserDistrict == null ||
                                !districtList
                                    .contains(_selectedUserDistrict)) {
                              _selectedUserDistrict =
                                  districtList.first;
                            }

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 10, 20.0, 0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Select District:'),
                                  DropdownButtonFormField<DataDsiricst>(
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.blue[50],
                                    ),
                                    onChanged: (districtUser) =>
                                        setState(() {
                                          _selectedUserDistrict =
                                              districtUser;
                                          distCodeGovtPrivate = int.parse(
                                              districtUser.districtCode
                                                  .toString());
                                          // Update state or further actions here
                                          print(
                                              'Selected District: ${districtUser.districtName}');
                                        }),
                                    value: _selectedUserDistrict,
                                    items: districtList
                                        .map((DataDsiricst district) {
                                      return DropdownMenuItem<
                                          DataDsiricst>(
                                        value: district,
                                        child:
                                        Text(district.districtName),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Center(
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

                          // Logging for debugging
                          developer
                              .log('@@snapshot: ${snapshot.data}');

                          List<DataGetCity> districtList =
                              snapshot.data;

                          // Ensure selected district is in the list, otherwise select the first one
                          if (_selectedUserCity == null ||
                              !districtList
                                  .contains(_selectedUserCity)) {
                            _selectedUserCity = districtList.first;
                          }

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 10, 20.0, 0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                const Text('Select City:'),
                                DropdownButtonFormField<DataGetCity>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  onChanged: (districtUser) =>
                                      setState(() {
                                        _selectedUserCity = districtUser;
                                        distCodeGovtPrivate = int.parse(
                                            districtUser.subdistrictCode
                                                .toString());
                                        // Update state or further actions here
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
                              ],
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: FutureBuilder<List<DataGetVillage>>(
                    future: _getVillage(district_code_login, state_code_login),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Handle null or empty data
                      if (snapshot.data == null || snapshot.data.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(16.0), // Padding inside the border
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2.0), // Border color and width
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            color: Colors.blue[50], // Background color (optional)
                          ),
                          child: const Text(
                            'No data found',
                            style: TextStyle(fontSize: 16.0, color: Colors.black), // Text style
                          ),
                        );
                      }

                      List<DataGetVillage> districtList = snapshot.data;

                      // Ensure selected district is in the list, otherwise select the first one
                      if (_selectedUserVillage == null ||
                          !districtList.contains(_selectedUserVillage)) {
                        _selectedUserVillage = districtList.first;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Select Village:'),
                            DropdownButtonFormField<DataGetVillage>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              onChanged: (districtUser) => setState(() {
                                _selectedUserVillage = districtUser;
                                distCodeGovtPrivate =
                                    int.parse(districtUser.villageCode.toString());
                              }),
                              value: _selectedUserVillage,
                              items: districtList.map((DataGetVillage district) {
                                return DropdownMenuItem<DataGetVillage>(
                                  value: district,
                                  child: Text(district.name),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),


                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _AddressHouse,
                          labelText: 'Address/ House/ Flat Number *',

                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 10.0),
             /*   Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _AddressHouse,
                          labelText: 'Address/ House/ Flat Number *',
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _Apartment,
                          labelText: 'Apartment/ building,/Colony /floor',
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _AreaNearLandMark,
                          labelText: 'Area/ Near Land Mark, etc',
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _PinCode,
                          labelText: 'Pin Code',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: Colors.grey[300]),
                    ),
                  ),
                  child: Center(
                    child: FutureBuilder<List<GetLanguageForDDLsDatas>>(
                      future: _futureStateGetLanguageForDDLsData, // Future to fetch the data
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        // Logging data for debugging
                        developer.log('@@snapshot: ${snapshot.data}');

                        List<GetLanguageForDDLsDatas> stateList = snapshot.data;

                        // Ensure selected state is in the list, otherwise select the first
                        if (GetLanguageForDDLsDatasa == null ||
                            !stateList.contains(GetLanguageForDDLsDatasa)) {
                          GetLanguageForDDLsDatasa = stateList.first;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: Colors.grey[300]),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 10, 20.0, 0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Communication Language *',
                                ),
                                DropdownButtonFormField<GetLanguageForDDLsDatas>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                  ),
                                  onChanged: (user) => setState(() {
                                    GetLanguageForDDLsDatasa = user;
                                    stateLKanguage = int.parse(
                                        user.id.toString());


                                  }),
                                  value: GetLanguageForDDLsDatasa,
                                  items: stateList
                                      .map<DropdownMenuItem<GetLanguageForDDLsDatas>>(
                                          (GetLanguageForDDLsDatas user) {
                                        return DropdownMenuItem<GetLanguageForDDLsDatas>(
                                          value: user,
                                          child: Text(user.name),
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Process the form data
                        print("@@-----click SubmitAdd Patient--");
                        ApipatientRegistration();
                      },
                      child: Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Reset form fields
                     //   _resetForm();
                      },
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> ApipatientRegistration() async {
    File imageFile = File(_image.path); // Ensure you have an image file
    Utils.showProgressDialog1(context);
    print("@@-----hopitalPatientRegistration--inside api");
    var response = await ApiController.hopitalPatientRegistration(
        registerationtypeRadioValueinAPi,imageFile,VoterIDtype.toString(),_voterIDNumber.text.toString(),dependencyTypeRadio.toString(),relationtypeValue.toString(),relationFatherController.text.toString(),
        _firstNamePatientDetail.text.toString(),_lastNamePatientDetail.text.toString(),_dob.toString(),
    _AgePatientDetail.text.toString(),gender.toString(),relationtypeValueMobile.toString(),_mobileNumberDetailsRelationtype.text.toString(),
        _selectedDateText.toString(),_selectedDateTextToDate.toString(),getDissesID.toString(),_reportingPlaceController.text.toString(),state_code_login,district_code_login,distCodeGovtPrivate,0,
        _AddressHouse.text.toString(),_Apartment.text.toString(),_AreaNearLandMark.text.toString(),_PinCode.text.toString(),stateLKanguage,state_code_login,district_code_login,"entryBy",
   "","002",int.parse(role_id),userId.toString() );

    Utils.hideProgressDialog1(context);
    print("@@-----hopitalPatientRegistration--inside api--2");
    // Check if the response is null before accessing properties
    if (response.status) {
      Utils.showToast(response.message.toString(), true);
      print("@@Result hopitalPatientRegistration----Class: " + response.message);
      /*   EyeBankApplication = true;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = true;
        CampManagerRegisterartions = false;
        AddScreeningCamps = false;*/
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }
  Widget _sectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0), // External margin
      color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _radioButtonRow({
    List<String> options,
    String groupValue,
    Function(String) onChanged,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options
            .map((option) => Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                    Text(option),
                    SizedBox(width: 10),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _textInputField({
    TextEditingController controller,
    String labelText,
    TextInputType keyboardType = TextInputType.text,
    String Function(String) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Customize as needed
          borderSide: BorderSide(
            color: Colors.grey, // Default border color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue, // Border color when focused
            width: 2.0, // Customize border width
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.red, // Border color when validation fails
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey, // Border color when enabled but not focused
            width: 1.0,
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
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

  Future<List<DataDsiricst>> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel = DashboardDistrictModel();
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
  Future<List<DataGetVillage>> _getVillage(int districtId, int stateId) async {
    GetVillage dashboardDistrictModel = GetVillage();
    Response response1;

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"districtId": districtId, "stateId": stateId});

      Dio dio = Dio();
      response1 = await dio.post(
        "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetVillage",
        data: body,
        options: Options(
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetVillage--Api: $body");
      print("@@GetVillage--Api Response: ${response1.data}");

      dashboardDistrictModel = GetVillage.fromJson(json.decode(response1.data));

      if (dashboardDistrictModel.status && dashboardDistrictModel.data != null) {
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


  Future<List<GetLanguageForDDLsDatas>> getLanguageForDDL() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetLanguageForDDL'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final GetLanguageForDDLs dashboardStateModel =
      GetLanguageForDDLs.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }
  Future<List<GetDiseaseForDDLData>> getDiseaseForDDL() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetDiseaseForDDL'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final GetDiseaseForDDL dashboardStateModel =
      GetDiseaseForDDL.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }
  Widget _patientInfoRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // Handle the tap event here
                  print('@@Today Registered Patient');
                  setState(() {
                    // Update future values to fetch data
                  });
                },
                child: Text(
                  'Today Registered Patient(s) : 0',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
