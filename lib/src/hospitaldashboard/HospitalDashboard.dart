import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/DatabaseHelper.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/SenTODPMCatractListData.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/SenTODPMDiabeticListData.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/SenTODPMGlaucomaListData.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/SenTODPMVRSurgeryListData.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/updatePatient/UpdatePatients.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/city/GetCity.dart';
import 'package:mohfw_npcbvi/src/model/city/GetVillage.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetDiseaseForDDL.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/GetLanguageForDDLs.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'package:image/image.dart' as img;
import '../loginsignup/LoginScreen.dart';
import '../model/spoModel/GetLanguageForDDLs.dart';
import '../model/spoModel/GetLanguageForDDLs.dart';
import '../model/spoModel/PatientRegistrations.dart';
import 'SenTODPMCornealBlindnessListData.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboard createState() => _HospitalDashboard();
}

class _HospitalDashboard extends State<HospitalDashboard> {
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
  TextEditingController _Apartment = TextEditingController();
  TextEditingController _AreaNearLandMark = TextEditingController();
  TextEditingController _PinCode = TextEditingController();
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

  String _chosenValueLOWVision,
      _chosenValueLOWVisionSendTODM,
      _chosenEyeBank,
      _chosenValueLgoutOption,
      lowVisionDatas,
      _chosenValueDiseses;

  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  bool hospitalDashboardclickDsiplay = false;
  String getYearNgoHopital, getfyidNgoHospital, _chosenValueMangeTwo;
  bool hospitalDashboardDatas = false;
  bool hospitalAddPatientData = false;
  String registerationtypeRadio = 'Hospital Walk-in'; // Default gender
  int registerationtypeRadioValueinAPi = 3; // Default gender
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
      distCodeGovtPrivate,
      stateLKanguage,
      getDissesID,
      village_code = 0;
  String CodeSPO, codeDPM, CodeGovtPrivate, distNameDPM, distNameDPMs_distictValues;
  String currentFinancialYear;

  TextEditingController relationNameController = TextEditingController();
  TextEditingController relationFatherController = TextEditingController();
  TextEditingController relationMotherController = TextEditingController();
  TextEditingController relationBrotherController = TextEditingController();
  TextEditingController relationSisterController = TextEditingController();
  TextEditingController relationDaughterController = TextEditingController();
  TextEditingController relationspouseController = TextEditingController();
  String relationtypeValue; // Initialize as null
  String formattedDate;
  final dbHelper = DatabaseHelper();
  bool isConnected = false;
  String _locationMessage = "Press the button to get location";
  String _address = "No address found";
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  // Function to get current position
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}"); // Print coordinates

      setState(() {
        _locationMessage = "Lat: ${position.latitude}, Lng: ${position.longitude}";

        // Store Latitude & Longitude in Text Controllers
        _latitudeController.text = position.latitude.toString();
        _longitudeController.text = position.longitude.toString();
      });

      // Get address from coordinates
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String fullAddress =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        setState(() {
          _AreaNearLandMark.text = fullAddress;
        });
        print("Address: $fullAddress"); // Print address in console
      }
    } catch (e) {

      setState(() {
        _locationMessage = "Error: $e";
        _address = "Failed to get address";
        _AreaNearLandMark.text = "Error: $e";
      });

      print("Error getting location: $e"); // Print error in console
    }
  }
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
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected = connectivityResult != ConnectivityResult.none;
    setState(() {}); // Trigger UI update
  } // Global variable// Initialize the database helper

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

  // For ImagePicker

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Create an instance of ImagePicker
      final ImagePicker picker = ImagePicker();

      // Use the instance to pick an image
      final File pickedFile = await ImagePicker.pickImage(source: source);

      if (pickedFile != null) {
        // Convert XFile to File
        final File imageFile = File(pickedFile.path);

        setState(() {
          _image = imageFile; // Ensure _image is a File
          print('@@_image+_image.toString()' + _image.path.toString());
        });

        // Convert the selected image to Base64
        final bytes = await imageFile.readAsBytes(); // Read the image as bytes
        final base64Image = base64Encode(bytes); // Encode bytes to Base64
        print('Base64 String: $base64Image');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking or processing image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        print("🌐 Internet Available. Uploading Local Data...");
        uploadLocalData(); // ✅ Upload when online
      }
    });

    checkInternetConnection();
    getUserData();
    _getLocation();
    _future = getDPM_ScreeningYear();

    hospitalDashboardclickDsiplay = true;
    _futureState = _getStatesDAta();
    //_futureVillage = _getVillage(district_code_login, state_code_login,distCodeGovtPrivate);
    _futureStateGetLanguageForDDLsData = getLanguageForDDL();
    _futureStateGetLanguageForDDLsData = getLanguageForDDL();
    _futureGetDiseaseForDDLDatas = getDiseaseForDDL();
    hospitalDashboardDatas = true;

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
          getentryby();
          // getloggedInNgoId();
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
          // Assuming you fetch the value from login or a previous screen
          String reportingPlace =
              fullnameController; // Replace with actual value
          _reportingPlaceController.text = reportingPlace;
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
   // getYearNgoHopital = getCurrentFinancialYear();
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
                    Icon(Icons.lock, color: Colors.black),
                    // Black icon color
                    SizedBox(width: 10),
                    Text("Change Password",
                        style: TextStyle(color: Colors.black)),
                    // Black text color
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.book, color: Colors.black),
                    // Black icon color
                    SizedBox(width: 10),
                    Text("User Manual", style: TextStyle(color: Colors.black)),
                    // Black text color
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    // Black icon color
                    SizedBox(width: 10),
                    Text("Logout", style: TextStyle(color: Colors.black)),
                    // Black text color
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            // White background color
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                // _showChangePasswordDialog();
              } else if (value == 2) {
                // Implement User Manual action
              } else if (value == 3) {
                setState(() {
                  showLogoutDialog();
                });
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: 100.0, // Set the width of the drawer
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(8.0),
            // Reduce the margin to decrease space// Set the margin here
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    setState(() {
                      print('@@dashboardviewReplace----display---');
                      _future = getDPM_ScreeningYear();
                      hospitalDashboardclickDsiplay = true;
                      hospitalAddPatientData = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  value: _chosenValue,
                  hint: 'Register Patient',
                  hintIcon: Icon(Icons.update, color: Colors.black),
                  // Add an icon to the hint
                  items: [
                    {'value': 'Add Patient', 'icon': Icons.person_add},
                    // Add an icon here
                    {'value': 'Update Patient', 'icon': Icons.update},
                    {'value': 'Screening Entry', 'icon': Icons.visibility},
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value ?? '';
                      if (_chosenValue == "Add Patient") {
                        print('@@NGO---Hospital--1 $_chosenValue');
                        hospitalAddPatientData = true;
                        hospitalDashboardclickDsiplay = false;
                        //_showPopupMenu();
                      } else if (_chosenValue == "Update Patient") {
                        // Navigate to UpdatePatients screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePatients()),
                        );
                      } else if (_chosenValue == "Screening Entry") {
                        print('@@Sattelite--1 $_chosenValue');
                        //  _showPopupMenuSatteliteCenter();
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.assignment,
                  title: 'Add PNJA',
                  onTap: () {
                    print('@@Add PNJA');
                    Utils.showToast("Complete in Next Sprint!", true);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  key: _dropdownKey,
                  value: _chosenValueLOWVision,
                  hint: 'Low Vision Register',
                  hintIcon: Icon(Icons.update, color: Colors.black),
                  // Add an icon to the hint
                  items: [
                    {'value': 'Cataract', 'icon': Icons.local_hospital},
                    // Add an icon here
                    {'value': 'Diabetic', 'icon': Icons.healing},
                    {'value': 'Glaucoma', 'icon': Icons.healing},
                    {'value': 'Corneal Blindness', 'icon': Icons.healing},
                    {'value': 'VR Surgery', 'icon': Icons.healing},
                    {'value': 'Childhood Blindness', 'icon': Icons.child_care},
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueLOWVision = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValueLOWVision == "Cataract") {
                        print('@@NGO--1' + _chosenValueLOWVision);
                        Utils.showToast("Complete in Next Sprint!", true);

                      } else if (_chosenValueLOWVision == "Diabetic") {
                        Utils.showToast("Complete in Next Sprint!", true);

                      } else if (_chosenValueLOWVision == "Glaucoma") {
                        Utils.showToast("Complete in Next Sprint!", true);

                      } else if (_chosenValueLOWVision == "Corneal Blindness") {
                        Utils.showToast("Complete in Next Sprint!", true);

                      } else if (_chosenValueLOWVision == "VR Surgery") {
                        print('@@Childhood--' + _chosenValueLOWVision);
                        Utils.showToast("Complete in Next Sprint!", true);


                      } else if (_chosenValueLOWVision ==
                          "Childhood Blindness") {
                        print('@@Childhood--' + _chosenValueLOWVision);
                        Utils.showToast("Complete in Next Sprint!", true);

                      } else {
                        print('@@Childhood--2' + _chosenValueLOWVision);
                        Utils.showToast("Complete in Next Sprint!", true);

                      }
                    });

                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  key: _dropdownKeySenTODPM,
                  value: _chosenValueLOWVisionSendTODM,
                  hint: 'Send to DPM',
                  hintIcon: Icon(Icons.local_hospital, color: Colors.black),
                  // Add an icon to the hint
                  items: [
                    {'value': 'Cataract', 'icon': Icons.local_hospital},
                    {'value': 'Diabetic', 'icon': Icons.healing},
                    {'value': 'Glaucoma', 'icon': Icons.healing},
                    {'value': 'Corneal Blindness', 'icon': Icons.healing},
                    {'value': 'VR Surgery', 'icon': Icons.healing},
                    {'value': 'Childhood Blindness', 'icon': Icons.child_care},
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueLOWVisionSendTODM = value;
                      print('@@SelectedValue: $_chosenValueLOWVisionSendTODM');

                      if (_chosenValueLOWVisionSendTODM == "Cataract") {
                        print('@@Navigating to LoginScreen');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SenTODPMCatractListData(),
                          ),
                        );
                      } else if (_chosenValueLOWVisionSendTODM == "Diabetic") {
                        print('Diabetic selected');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SenTODPMDiabeticListData(),
                          ),
                        );
                      } else if (_chosenValueLOWVisionSendTODM == "Glaucoma") {
                        print('Glaucoma selected');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SenTODPMGlaucomaListData(),
                          ),
                        );
                      } else if (_chosenValueLOWVisionSendTODM ==
                          "Corneal Blindness") {
                        print('Corneal Blindness selected');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SenTODPMCornealBlindnessListData(),
                          ),
                        );
                      } else if (_chosenValueLOWVisionSendTODM ==
                          "VR Surgery") {
                        print('VR Surgery selected');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SenTODPMVRSurgeryListData(),
                          ),
                        );
                      } else if (_chosenValueLOWVisionSendTODM ==
                          "Childhood Blindness") {
                        print('Childhood Blindness selected');
                      } else {
                        print('Other value selected');
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

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
              _buildUserInfoGrid(
                  'Login Type:', 'Hospital', Colors.black, Colors.red),
              _buildUserInfoGrid('Login Id:', userId?.toString() ?? 'N/A',
                  Colors.black, Colors.red),
              _buildUserInfoGrid('District:',
                  districtNames?.toString() ?? 'N/A', Colors.black, Colors.red),
              _buildUserInfoGrid('State:', stateNames?.toString() ?? 'N/A',
                  Colors.black, Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoGrid(
      String label, String value, Color labelColor, Color valueColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: valueColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
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
                FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<DataGetDPM_ScreeningYear> list = snapshot.data.toList();

                    // ✅ Set default first value when opening the screen
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_selectedUser == null || !list.contains(_selectedUser)) {
                        setState(() {
                          _selectedUser = list.first;
                          getYearNgoHopital = _selectedUser.name;
                          getfyidNgoHospital = _selectedUser.fyid;
                        });
                      }
                    });


                    // Show "No data found" if the list is empty
                    if (list.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Container(
                          width: 300,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'No data found',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                      child: SizedBox(
                        width: 300, // Set width using SizedBox
                        child: DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                          value: _selectedUser,
                          onChanged: (userc) {
                            setState(() {
                              _selectedUser = userc;
                              getYearNgoHopital = userc?.name ?? '';
                              getfyidNgoHospital = userc?.fyid ?? '';
                              print('@@Selected Year: $getYearNgoHopital');
                              print('@@FYID: $getfyidNgoHospital');
                            });
                          },
                          items: list.map((user) {
                            return DropdownMenuItem<DataGetDPM_ScreeningYear>(
                              value: user,
                              child: Text(
                                user.name,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                            hintText: null, // Remove the hint text
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          buttonStyleData: ButtonStyleData(
                            height: 21, // Adjust button height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                            iconSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),

             /*   SizedBox(height: 5),
                buildInfoContainer(stateNames),
                SizedBox(height: 5),
                buildInfoContainer(districtNames),*/
                SizedBox(height: 5),
                buildDropdownHospitalType(),

                SizedBox(height: 5),
                buildInfoContainer(fullnameController),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Get button clicked');
                        setState(() {

                            hospitalDashboardDatas = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Ensures button wraps around content
                        children: [
                          Icon(Icons.search, color: Colors.white), // Change icon as needed
                          SizedBox(width: 8), // Space between icon and text
                          Text('Get Data'),
                        ],
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: hospitalDashboardDatas,
                  child: Column(
                    children: [
                      // Header Container
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

                      // Data Table with FutureBuilder
                      Container(
                        margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: FutureBuilder<List<DataHospitalDashboard>>(
                          future: ApiController.hospitalDashboard(
                              int.parse(role_id),
                              district_code_login,
                              state_code_login,
                              userId,
                              getYearNgoHopital,
                              0,
                              "0"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Utils.getEmptyView("Error: ${snapshot.error}"));
                            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                              // Show "No data found" if the list is empty
                              return Center(child: Utils.getEmptyView("No data found"));
                            } else {
                              List<DataHospitalDashboard> ddata = snapshot.data;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Show header row only if data is available
                                    Row(
                                      children: [
                                        _buildHeaderCellDiseaseData('Disease Type'),
                                        _buildHeaderCellDiseaseData('Registered'),
                                        _buildHeaderCellDiseaseData('Operated'),
                                      ],
                                    ),
                                    // Data Rows
                                    Column(
                                      children: ddata.map((offer) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            _buildDataCellDiseaseData(offer.status),
                                            _buildDataCellDiseaseData(offer.registered),
                                            _buildDataCellDiseaseData(offer.operated),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )

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
        height: 50,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
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
        child: DropdownButtonFormField2<String>(
          value: _chosenValueMangeTwo,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: 'Hospitals',
            hintStyle: TextStyle(color: Colors.black),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
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
          buttonStyleData: ButtonStyleData(
            height: 25, // Adjust button height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ),
    );
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
                SizedBox(height: 2.0),
                _sectionTitle('Registration Type'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left section: Radio button column
                    Expanded(
                      flex: 3,
                      child: _radioButtonColumn(
                        options: [
                          'Screening Camp',
                          'Satellite Centre',
                          'Hospital Walk-in'
                        ],
                        enabledOptions: ['Hospital Walk-in'],
                        // Only this option is enabled
                        groupValue: registerationtypeRadio,
                        onChanged: (value) {
                          if (value == "Hospital Walk-in") {
                            // Allow only if enabled
                            setState(() {
                              registerationtypeRadio = value;
                              print('@@1 ' + registerationtypeRadio.toString());

                              registerationtypeRadioValueinAPi = 3;
                            });
                          }
                        },
                      ),
                    ),

                    SizedBox(width: 10), // Add spacing between the two sections
                    // Right section: Image picker and preview
                    Expanded(
                      flex: 2, // Weight for the image picker section
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _showPickerDialog,
                            child: Text("Select Image"),
                          ),
                          SizedBox(height: 10),
                          if (_image != null)
                            Image.file(
                              File(_image.path),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _sectionHeader('Personal Details'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Form(
                    key: _formKeyhopsitalPersonalDetal,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              // Background color of the dropdown box
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
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
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    VoterIDtype = newValue;
                                    showVoterIDField = VoterIDtype ==
                                        "Voter ID"; // Show field if "Voter ID" is selected
                                    showDrivingLicenseField =
                                        VoterIDtype == "Driving License";
                                    showPassport = VoterIDtype == "Passport";
                                    showRationCard =
                                        VoterIDtype == "Ration Card";
                                    showPanCard = VoterIDtype == "Pan Card";

                                    showNotAvailble =
                                        VoterIDtype == "Not Available";
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        if (showVoterIDField)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

                            child: _textInputField(
                              controller: _voterIDNumber,
                              keyboardType: TextInputType.number,
                              labelText: "Voter ID No.",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter Voter ID No.'
                                      : null,
                            ),
                          ),
                        if (showDrivingLicenseField)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              labelText: "Driving License No.",
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter Driving License No.'
                                      : null,
                            ),
                          ),
                        if (showPassport)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              keyboardType: TextInputType.number,
                              labelText: "Passport No.",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter Passport No.'
                                      : null,
                            ),
                          ),
                        if (showRationCard)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              keyboardType: TextInputType.number,
                              labelText: "Ration Card No.",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter Ration Card No.'
                                      : null,
                            ),
                          ),
                        if (showPanCard)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                            child: _textInputField(
                              controller: _voterIDNumber,
                              keyboardType: TextInputType.number,
                              labelText: "Pan Card No.",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter Pan Card No.'
                                      : null,
                            ),
                          ),
                        if (showNotAvailble)
                          SizedBox(height: 10.0),
                        _sectionTitle('Dependency Type'),
                        _radioButtonRow(
                          options: ['Self', 'Dependent'],
                          groupValue: dependencyTypeRadio,
                          onChanged: (value) {
                            setState(() {
                              dependencyTypeRadio = value;
                              print('@@11' + dependencyTypeRadio.toString());
                              showSelf = dependencyTypeRadio ==
                                  "Self"; // Show field if "Self" is selected
                              Dependent = dependencyTypeRadio == "Dependent";
                              if (showSelf) {
                                relationFatherController.text = "string";
                                relationtypeValue =
                                    null; // Reset value for dropdown
                                relationFatherController.text = 'xr';
                                // Set to '0' or a special indicator for "Self"
                                // relationNameController.clear();
                              }
                            });
                          },
                        ),
                        if (Dependent) // Only show if "Dependent" is selected
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
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
                                      ].map<DropdownMenuItem<String>>(
                                          (String type) {
                                        return DropdownMenuItem<String>(
                                          value: type,
                                          child: Text(
                                            type,
                                            style: TextStyle(
                                                color: Colors.black),
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
                                            relationNameController.text =
                                                "Father's Name";
                                          } else if (relationtypeValue ==
                                              "Mother") {
                                            relationNameController.text =
                                                "Mother's Name";
                                          } else if (relationtypeValue ==
                                              "Brother") {
                                            relationNameController.text =
                                                "Brother's Name";
                                          } else if (relationtypeValue ==
                                              "Sister") {
                                            relationNameController.text =
                                                "Sister's Name";
                                          } else if (relationtypeValue ==
                                              "Daughter") {
                                            relationNameController.text =
                                                "Daughter's Name";
                                          } else if (relationtypeValue ==
                                              "Spouse") {
                                            relationNameController.text =
                                                "Spouse's Name";
                                          } else {
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
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Father's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Father\'s name'
                                            : null,
                                  ),
                                ),
                              if (relationtypeValue == "Mother")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Mother's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Mother\'s name'
                                            : null,
                                  ),
                                ),
                              if (relationtypeValue == "Brother")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Brother's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Brother\'s name'
                                            : null,
                                  ),
                                ),
                              if (relationtypeValue == "Sister")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Sister's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Sister\'s name'
                                            : null,
                                  ),
                                ),
                              if (relationtypeValue == "Daughter")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Daughter's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Daughter\'s name'
                                            : null,
                                  ),
                                ),
                              if (relationtypeValue == "Spouse")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                                  child: _textInputField(
                                    controller: relationFatherController,
                                    labelText: "Spouse's Name",
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter Spouse\'s name'
                                            : null,
                                  ),
                                ),
                            ],
                          ),

                        if (showSelf)
                          // Hide the relation type section if "Self" is selected
                          SizedBox.shrink(),
                        // This will render nothing when "Self" is selected

                        SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                          child: _textInputField(
                            controller: _firstNamePatientDetail,
                            labelText: 'First  Name *',
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your First name';
                              } else if (value.length != 10) {
                                return 'Please enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                          child: _textInputField(
                            controller: _lastNamePatientDetail,
                            labelText: 'Last Name *',
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Last name';
                              } else if (value.length != 10) {
                                return 'Please enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Date Picker Container with fixed height and width
                                SizedBox(
                                  width: 150, // Set same width for both widgets
                                  height: 50, // Set desired height
                                  child: GestureDetector(
                                    onTap: () async {
                                      DateTime pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );

                                      if (pickedDate != null) {
                                        String formattedDateForDisplay =
                                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}"; // For UI display

                                        String formattedDateForAPI =
                                            DateFormat('yyyy-MM-dd').format(
                                                pickedDate); // For API request

                                        setState(() {
                                          _dob =
                                              formattedDateForAPI; // Use this for the API
                                          print("@@_dob (API format): $_dob");
                                          print(
                                              "@@_dob (display format): $formattedDateForDisplay");
                                          // Calculate age and update age field
                                          int age = _calculateAge(pickedDate);
                                          _ageController.text = age.toString();
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _dob.isEmpty ? "Select Date" : _dob,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                // Spacing between the widgets
                                // Age Input Field with same width and height
                                SizedBox(
                                  width: 150, // Same width as Date Picker
                                  height: 50, // Same height as Date Picker
                                  child: _textInputField(
                                    controller: _ageController,
                                    labelText: 'Age *',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _sectionTitle('Gender'),
                        _radioButtonRow(
                          options: ['Male', 'Female', 'Transgender'],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
                _sectionHeader('Mobile Number Details'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10.0, 5),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.grey, width: 1.0),
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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                          padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

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
                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0.0), // Left & Right margins
                    child: _textInputField(
                      controller: _mobileNumberDetailsRelationtype,
                      labelText: 'Mobile No *',
                      maxLength: 10, // Add this
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
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
                                    color: Colors.grey, // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: Text(
                                  _selectedDateText,
                                  // Display the selected date or "From Date"
                                  style: TextStyle(
                                    color: Colors.grey, // Text color
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
                                    color: Colors.grey, // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: Text(
                                  _selectedDateTextToDate,
                                  // Display the selected date or "From Date"
                                  style: TextStyle(
                                    color: Colors.grey, // Text color
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

                Column(
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
                        developer.log('@@snapshot: ${snapshot.data}');

                        List<GetDiseaseForDDLData> districtList =
                            snapshot.data;

                        // Ensure selected district is in the list, otherwise select the first one
                        if (_futureGetDiseaseForDDLDatass == null ||
                            !districtList
                                .contains(_futureGetDiseaseForDDLDatass)) {
                          _futureGetDiseaseForDDLDatass = districtList.first;
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10.0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text('Select Diseases:'),
                              DropdownButtonFormField<GetDiseaseForDDLData>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 5.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                onChanged: (districtUser) => setState(() {
                                  _futureGetDiseaseForDDLDatass =
                                      districtUser;
                                  getDissesID =
                                      int.parse(districtUser.id.toString());
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
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          child: _textInputField(
                            controller: _reportingPlaceController,
                            labelText: 'Reporting Place *',
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 350, // Set your desired width
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder<List<Data>>(
                    future: _futureState,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<Data> stateList = snapshot.data ?? [];

                      // Ensure selected state is in the list, otherwise select the first
                      if (_selectedUserState == null ||
                          !stateList.contains(_selectedUserState)) {
                        _selectedUserState =
                            stateList.isNotEmpty ? stateList.first : null;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Select State:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            DropdownButtonFormField<Data>(
                              isExpanded: true,
                              // ✅ Prevent overflow by expanding
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              onChanged: (user) async {
                                if (user != null) {
                                  setState(() {
                                    _selectedUserState = user;
                                    stateCodeGovtPrivate =
                                        int.parse(user.stateCode.toString());
                                    CodeGovtPrivate = user.code;
                                  });

                                  var connectivityResult =
                                      await Connectivity().checkConnectivity();
                                  bool isConnected = connectivityResult !=
                                      ConnectivityResult.none;

                                  if (isConnected) {
                                    setState(() {
                                      isVisibleDitrictGovt = true;
                                    });
                                    await _getDistrictData(
                                        stateCodeGovtPrivate);
                                  } else {
                                    setState(() {
                                      isVisibleDitrictGovt = false;
                                    });
                                  }
                                }
                              },
                              value: _selectedUserState,
                              items: stateList
                                  .map<DropdownMenuItem<Data>>((Data user) {
                                return DropdownMenuItem<Data>(
                                  value: user,
                                  child: Text(
                                    user.stateName,
                                    overflow: TextOverflow.ellipsis,
                                    // ✅ Handles long text
                                    maxLines: 1,
                                    // ✅ Restricts to a single line
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: isConnected && isVisibleDitrictGovt,
                  // Check for both internet and visibility flag
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 400,
                        // Set your desired width
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        // Optional padding

                        child: FutureBuilder<List<DataDsiricst>>(
                          future: _getDistrictData(stateCodeGovtPrivate),
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            if (!snapshot.hasData)
                              return Center(child: CircularProgressIndicator());

                            developer.log('@@snapshot: ${snapshot.data}');

                            List<DataDsiricst> districtList = snapshot.data;

                            // Ensure selected district is in the list, otherwise select the first one
                            if (_selectedUserDistrict == null ||
                                !districtList.contains(_selectedUserDistrict)) {
                              _selectedUserDistrict = districtList.first;
                            }
                            if (districtList.isEmpty) {
                              return Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  // Blue border
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      Colors.blue[50], // Light blue background
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
                              );
                            }

                            // Ensure selected district is in the list, otherwise select the first one
                            _selectedUserDistrict ??= districtList.first;
                            return DropdownButtonFormField<DataDsiricst>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              onChanged: (district) {
                                setState(() {
                                  _selectedUserDistrict = district;
                                  distCodeGovtPrivate =
                                      int.parse(district?.districtCode ?? "0");
                                });
                              },
                              value: _selectedUserDistrict,
                              items: districtList.map((district) {
                                return DropdownMenuItem<DataDsiricst>(
                                  value: district,
                                  child: Text(district.districtName),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      // City Dropdown
                      if (_selectedUserDistrict != null)
                        Container(
                          width: 400,
                          // Set your desired width here
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          // Optional padding

                          child: FutureBuilder<List<DataGetCity>>(
                            future: _getCity(district_code_login),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              if (!snapshot.hasData)
                                return Center(
                                    child: CircularProgressIndicator());

                              List<DataGetCity> districtList = snapshot.data;
                              // Default selection logic
                              if (_selectedUserCity == null ||
                                  !districtList.contains(_selectedUserCity)) {
                                _selectedUserCity = districtList.first;
                              }

                              return DropdownButtonFormField<DataGetCity>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                onChanged: (city) {
                                  setState(() {
                                    _selectedUserCity = city;
                                    distCodeGovtPrivate =
                                        city?.subdistrictCode ??
                                            0; // Removed int.parse
                                    print(
                                        '@@distCodeGovtPrivate: ${distCodeGovtPrivate}');
                                  });
                                },
                                value: _selectedUserCity,
                                items: districtList.map((city) {
                                  return DropdownMenuItem<DataGetCity>(
                                    value: city,
                                    child: Text(city.name),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),

                      SizedBox(height: 10),

                      // Village Dropdown
                      if (_selectedUserCity != null)
                        Container(
                          width: 400,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          // Added margin to left and right
                          child: FutureBuilder<List<DataGetVillage>>(
                            future: _getVillage(district_code_login,
                                state_code_login, distCodeGovtPrivate),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              List<DataGetVillage> villageList =
                                  snapshot.data ?? [];

                              // 🔔 Check if the village list is empty
                              if (villageList.isEmpty) {
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 2),
                                    // Blue border
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors
                                        .blue[50], // Light blue background
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
                                );
                              }

                              // Default selection for village
                              _selectedUserVillage ??= villageList.first;

                              return DropdownButtonFormField<DataGetVillage>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                onChanged: (village) {
                                  setState(() {
                                    _selectedUserVillage = village;
                                    village_code =
                                        int.parse(village?.villageCode ?? "0");
                                  });
                                },
                                value: _selectedUserVillage,
                                items: villageList.map((village) {
                                  return DropdownMenuItem<DataGetVillage>(
                                    value: village,
                                    child: Text(village.name),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Row(
                    children: [
                      // Expanded to take available width
                      Expanded(
                        child: _textInputField(
                          controller: _AreaNearLandMark,
                          labelText: 'Area/ Near Land Mark, etc',
                          keyboardType: TextInputType.text,



                        ),
                      ),
                      SizedBox(width: 10),
                      // Location Icon Button
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                        child: IconButton(
                          icon: Icon(Icons.my_location, color: Colors.blue),
                          onPressed: _getCurrentLocation,
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                // Latitude and Longitude fields
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _textInputField(
                          controller: _latitudeController,
                          labelText: 'Latitude',
                          readOnly: true, // Prevent manual input
                          prefixIcon: Icon(Icons.my_location, color: Colors.blue), // Icon for Latitude
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _textInputField(
                          controller: _longitudeController,
                          labelText: 'Longitude',
                          readOnly: true, // Prevent manual input
                          prefixIcon: Icon(Icons.location_searching, color: Colors.green), // Icon for Longitude
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
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
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          controller: _PinCode,
                          labelText: 'Pin Code',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              Container(
                width:  double.infinity, // Full width
                height:80, // Increased height for dropdown
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.transparent),
                  ),
                ),
                child: FutureBuilder<List<GetLanguageForDDLsDatas>>(
                  future: _futureStateGetLanguageForDDLsData,
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

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Communication Language *',
                          ),
                          SizedBox(
                            width: double.infinity, // Let it take full width of parent
                            child: DropdownButtonFormField<GetLanguageForDDLsDatas>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              onChanged: (user) => setState(() {
                                GetLanguageForDDLsDatasa = user;
                                stateLKanguage = int.parse(user.id.toString());
                              }),
                              value: GetLanguageForDDLsDatasa,
                              items: stateList.map<DropdownMenuItem<GetLanguageForDDLsDatas>>(
                                      (GetLanguageForDDLsDatas user) {
                                    return DropdownMenuItem<GetLanguageForDDLsDatas>(
                                      value: user,
                                      child: Text(user.name),
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

              SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        print("@@-----click SubmitAdd Patient--");

                        var connectivityResult =
                            await Connectivity().checkConnectivity();

                        if (connectivityResult == ConnectivityResult.none) {
                          print("No internet connection. Saving data locally.");
                          await dbHelper.savePatientData(); // ✅ Save to SQLite
                          Utils.showToast(
                              "No internet. Data saved locally.", true);
                        } else {
                          print("Internet available. Uploading data to API.");
                          await ApipatientRegistration(); // Submit to API
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Ensures button wraps around content
                        children: [
                          Icon(Icons.send, color: Colors.white), // Change icon as needed
                          SizedBox(width: 8), // Space between icon and text
                          Text('Submit'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetForm();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Ensures button wraps around content
                        children: [
                          Icon(Icons.refresh, color: Colors.white), // Reset icon
                          SizedBox(width: 8), // Space between icon and text
                          Text('Reset'),
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void resetForm() {
    // Clear text fields
    _firstNamePatientDetail.clear();
    _lastNamePatientDetail.clear();
    _AgePatientDetail.clear();
    _mobileNumberDetailsRelationtype.clear();
    _AddressHouse.clear();
    _Apartment.clear();
    _AreaNearLandMark.clear();
    _PinCode.clear();
    _voterIDNumber.clear();
    _reportingPlaceController.clear();
    relationFatherController.clear();

    // Reset dropdowns and radio buttons
    registerationtypeRadioValueinAPi = null;
    VoterIDtype = null;
    dependencyTypeRadio = null;
    relationtypeValue = null;
    gender = null;
    relationtypeValueMobile = null;
    getDissesID = null;
    stateLKanguage = null;
    distCodeGovtPrivate = null;
    village_code = null;

    // Reset date pickers
    _dob = "Select Date";
    _selectedDateText = "Select Date";
    _selectedDateTextToDate = "Select Date";

    // Clear image
    _image = null;

    // Trigger UI update
    setState(() {});

    // Optional: Show a toast message
    Utils.showToast("Form has been reset!", true);
  }

  Future<String> compressAndEncodeImage(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();

    // Decode the image
    final decodedImage = img.decodeImage(bytes);

    // Compress the image
    final compressedImage = img.encodeJpg(decodedImage, quality: 50);

    // Encode to base64
    return base64Encode(compressedImage);
  }

//Comment here for Offline ki bajah se other working fine
  Future<void> ApipatientRegistration() async {
    print("### Starting patient registration ###");

    // Validation checks for inputs
    if (_firstNamePatientDetail.text.isEmpty) {
      print("Error: First name is empty");
      Utils.showToast("Please enter first name", false);
      return;
    }
    if (_image == null) {
      print("Error: Image is not selected");
      Utils.showToast("Please select an image", false);
      return;
    }
    if (_lastNamePatientDetail.text.isEmpty) {
      print("Error: Last name is empty");
      Utils.showToast("Please enter last name", false);
      return;
    }
    if (_dob.isEmpty || _dob == "Select Date") {
      print("Error: Date of birth is not selected");
      Utils.showToast("Please select a date of birth", false);
      return;
    }
    if (_AgePatientDetail.text.isEmpty) {
      print("Error: Age is empty");
      Utils.showToast("Please enter age", false);
      return;
    }
    if (_mobileNumberDetailsRelationtype.text.isEmpty) {
      print("Error: Mobile number is empty");
      Utils.showToast("Please enter mobile number", false);
      return;
    } else if (_mobileNumberDetailsRelationtype.text.length != 10) {
      print("Error: Mobile number must be 10 digits");
      Utils.showToast("Please enter a valid 10-digit mobile number", false);
      return;
    }

    if (_AddressHouse.text.isEmpty) {
      print("Error: House address is empty");
      Utils.showToast("Please enter house address", false);
      return;
    }
    if (_Apartment.text.isEmpty) {
      print("Error: Apartment is empty");
      Utils.showToast("Please enter apartment", false);
      return;
    }
    if (_AreaNearLandMark.text.isEmpty) {
      print("Error: Area/landmark is empty");
      Utils.showToast("Please enter area/landmark", false);
      return;
    }
    if (_PinCode.text.isEmpty) {
      print("Error: Pin code is empty");
      Utils.showToast("Please enter pin code", false);
      return;
    }

    // Show progress dialog
    Utils.showProgressDialog1(context);

    try {
      // Compress image
      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/compressed_image.jpg';
      File compressedImage = await FlutterImageCompress.compressAndGetFile(
        _image.path,
        targetPath,
        quality: 80,
      );

      if (compressedImage == null) throw Exception("Image compression failed");

      // Prepare MultipartFile for image
      MultipartFile multipartFile = await MultipartFile.fromFile(
        compressedImage.path,
        filename: "patient_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      // Prepare form data
      FormData formData = FormData.fromMap({
        "registrationType": registerationtypeRadioValueinAPi,
        "patientImage": multipartFile,
        "idType": VoterIDtype.toString(),
        "idName": _voterIDNumber.text.toString(),
        "dependencyType": dependencyTypeRadio.toString(),
        "relationType": relationtypeValue.toString(),
        "relationName": relationFatherController.text.toString(),
        "firstName": _firstNamePatientDetail.text.toString(),
        "lastName": _lastNamePatientDetail.text.toString(),

        "dob": _dob.toString(),
        //"dob": "12-12-2000",
        "age": _AgePatientDetail.text.toString(),
        "gender": gender.toString(),
        "mobileRelationType": relationtypeValueMobile.toString(),
        "mobileNo": _mobileNumberDetailsRelationtype.text.toString(),
        "screeningDate": _selectedDateText,
        "tentativeSurgeryDate": _selectedDateTextToDate,
        "disease": getDissesID.toString(),
        "reportingPlace": _reportingPlaceController.text,
        "state": state_code_login,
        "district": district_code_login,
        "city": distCodeGovtPrivate,
        "village": village_code,
        "address": _AddressHouse.text,
        "apartment": _Apartment.text,
        "nearLandMark": _AreaNearLandMark.text,
        "pincode": _PinCode.text,
        "communicationLanguage": stateLKanguage,
        "loggedInUserStateId": state_code_login,
        "loggedInUserDistrictId": district_code_login,
        "entryBy": entryby,
        "loggedInNgoId": "10126",
        "programeId": "002",
        "loggedInUserRole": int.parse(role_id),
        "userId": userId,
      });
      print(
          "Form data prepared successfully. Payload: ${formData.fields.toString()}");
      print("Form data prepared successfully. Fields:");
      for (int i = 0; i < formData.fields.length; i++) {
        var field = formData.fields[i];
        print("Index $i: Key = ${field.key}, Value = ${field.value}");
      }
      // API URL
      final dio = Dio();
      final url =
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/PatientRegistration";
      print("url: ${url}");
// Prepare headers
      final headers = {
        'Content-Type': 'multipart/form-data',
        // Correctly specify the content type
      };

// Set up Dio options
      dio.options.headers = headers;

      final response = await dio.post(
        url,
        data: formData, // FormData object with your fields
      );

      print("API response received: ${response.statusCode}");

      Utils.hideProgressDialog1(context);

      if (response.statusCode == 200) {
        final result = PatientRegistrations.fromJson(response.data);
        if (result.status) {
          Utils.showToast(result.message, true);
          _firstNamePatientDetail.clear();
          _lastNamePatientDetail.clear();
          _AgePatientDetail.clear();
          _mobileNumberDetailsRelationtype.clear();
          _AddressHouse.clear();
          _Apartment.clear();
          _AreaNearLandMark.clear();
          _PinCode.clear();
          _voterIDNumber.clear();
          _reportingPlaceController.clear();
          relationFatherController.clear();

          // Reset dropdowns and radio buttons
          registerationtypeRadioValueinAPi = null;
          VoterIDtype = null;
          dependencyTypeRadio = null;
          relationtypeValue = null;
          gender = null;
          relationtypeValueMobile = null;
          getDissesID = null;
          stateLKanguage = null;
          distCodeGovtPrivate = null;
          village_code = null;

          // Reset date pickers
          _dob = "Select Date";
          _selectedDateText = "Select Date";
          _selectedDateTextToDate = "Select Date";

          // Clear image
          _image = null;

          // Trigger UI update
          setState(() {});

          // Optional: Show a toast message
          Utils.showToast("Form has been reset!", true);
        } else {
          Utils.showToast("Registration failed: ${result.message}", false);
        }
      } else {
        Utils.showToast(
            "Failed to register. Status code: ${response.statusCode}", false);
      }
    } catch (e) {
      Utils.hideProgressDialog1(context);
      print("Error: $e");

      if (e is DioError && e.response != null) {
        print("DioError Response: ${e.response?.data}");
        Utils.showToast("Error: ${e.response?.data}", false);
      } else {
        Utils.showToast("Unexpected error occurred", false);
      }
    }
  }

  Future<void> ApipatientRegistrations(
      {Map<String, dynamic> patientData}) async {
    print("### Starting patient registration ###");

    try {
      // Show progress dialog only for real-time submission
      if (patientData == null) Utils.showProgressDialog1(context);

      // Determine the data source
      final isOfflineData = patientData != null;

      // Validation checks (only for real-time submissions)
      if (!isOfflineData) {
        if (_firstNamePatientDetail.text.isEmpty) {
          Utils.showToast("Please enter first name", false);
          return;
        }
        if (_image == null) {
          Utils.showToast("Please select an image", false);
          return;
        }
        if (_lastNamePatientDetail.text.isEmpty) {
          Utils.showToast("Please enter last name", false);
          return;
        }
        if (_dob.isEmpty || _dob == "Select Date") {
          Utils.showToast("Please select a date of birth", false);
          return;
        }
        if (_AgePatientDetail.text.isEmpty) {
          Utils.showToast("Please enter age", false);
          return;
        }
        if (_mobileNumberDetailsRelationtype.text.isEmpty ||
            _mobileNumberDetailsRelationtype.text.length != 10) {
          Utils.showToast("Please enter a valid 10-digit mobile number", false);
          return;
        }
        if (_AddressHouse.text.isEmpty) {
          Utils.showToast("Please enter house address", false);
          return;
        }
        if (_Apartment.text.isEmpty) {
          Utils.showToast("Please enter apartment", false);
          return;
        }
        if (_AreaNearLandMark.text.isEmpty) {
          Utils.showToast("Please enter area/landmark", false);
          return;
        }
        if (_PinCode.text.isEmpty) {
          Utils.showToast("Please enter pin code", false);
          return;
        }
      }

      // Handle Image
      MultipartFile multipartFile;
      if (isOfflineData && patientData['imagePath'] != null) {
        multipartFile = await MultipartFile.fromFile(patientData['imagePath']);
      } else if (_image != null) {
        final tempDir = await getTemporaryDirectory();
        final targetPath = '${tempDir.path}/compressed_image.jpg';
        File compressedImage = await FlutterImageCompress.compressAndGetFile(
              _image.path,
              targetPath,
              quality: 30,
            ) ??
            _image;

        multipartFile = await MultipartFile.fromFile(compressedImage.path);
      }

      // Prepare form data
      FormData formData = FormData.fromMap({
        "registrationType": registerationtypeRadioValueinAPi,
        "patientImage": multipartFile,
        "idType": VoterIDtype.toString(),
        "idName": _voterIDNumber.text,
        "dependencyType": dependencyTypeRadio.toString(),
        "relationType": relationtypeValue.toString(),
        "relationName": relationFatherController.text,
        "firstName": _firstNamePatientDetail.text,
        "lastName": _lastNamePatientDetail.text,
        "dob": _dob,
        "age": _AgePatientDetail.text,
        "gender": gender.toString(),
        "mobileRelationType": relationtypeValueMobile.toString(),
        "mobileNo": _mobileNumberDetailsRelationtype.text,
        "screeningDate": _selectedDateText,
        "tentativeSurgeryDate": _selectedDateTextToDate,
        "disease": getDissesID.toString(),
        "reportingPlace": _reportingPlaceController.text,
        "state": state_code_login,
        "district": 0,
        "city": 0,
        "village": 0,
        "address": _AddressHouse.text,
        "apartment": _Apartment.text,
        "nearLandMark": _AreaNearLandMark.text,
        "pincode": _PinCode.text,
        "communicationLanguage": stateLKanguage,
        "loggedInUserStateId": state_code_login ?? "",
        "loggedInUserDistrictId": district_code_login ?? "",
        "entryBy": entryby,
        "loggedInNgoId": "10126",
        "programeId": "002",
        "loggedInUserRole": int.tryParse(role_id) ?? 0,
        "userId": userId ?? "",
      });

      // Debug: Print form data line by line
      print("### Form Data to be Submitted ###");
      formData.fields.forEach((field) {
        print("${field.key}: ${field.value}");
      });

      // API call
      final dio = Dio();
      final url =
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/PatientRegistration";
      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        final result = PatientRegistrations.fromJson(response.data);
        if (result.status) {
          Utils.showToast(result.message, true);

          if (isOfflineData) {
            await dbHelper.deleteLocalPatient(patientData['id']);
            print("🗑️ Local data deleted after upload.");
          }
        } else {
          Utils.showToast("Registration failed: ${result.message}", false);
        }
      } else {
        Utils.showToast(
            "Failed to register. Status code: ${response.statusCode}", false);
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Unexpected error occurred", false);
    } finally {
      if (patientData == null) Utils.hideProgressDialog1(context);
    }
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

  Widget _sectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      // External margin
      color: Colors.blue,
      
      padding: const EdgeInsets.all(10.0),
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
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
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

  Widget _radioButtonColumn({
    List<String> options,
    String groupValue,
    Function(String) onChanged,
    List<String> enabledOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map((option) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0), // Reduce from 4.0 to 2.0
        child: Row(
          children: [
            Radio<String>(
              value: option,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }


  Widget _textInputField({
     TextEditingController controller,
     String labelText,
    TextInputType keyboardType = TextInputType.text,
    String Function(String) validator,
    int maxLength,
    double width,  // Width parameter
    double height, // Height parameter
    Widget prefixIcon, // Prefix icon support
    bool readOnly = false, // Read-only support
  }) {
    return SizedBox(
      width: width ?? double.infinity, // Default to full width
      height: height ?? 50, // Default height
      child: TextFormField(
        controller: controller,
        readOnly: readOnly, // Prevent manual input if true
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), // Adjust padding
          labelText: labelText,
          prefixIcon: prefixIcon, // Assign prefix icon
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
      ),
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
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
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

  Future<void> showLogoutDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.redAccent),
              SizedBox(width: 8),
              Text("Logout"),
            ],
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                logoutUserStatic(); // Call the logout function
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> logoutUserStatic() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Utils.showToast("You have been logged out!", false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  Widget _buildMenuItem({
    IconData icon,
    String title,
    Function() onTap,
  }) {
    double size =
        14.0; // You can set a consistent size for both the icon and text

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      // Reduce the vertical padding
      title: Row(
        children: [
          Icon(icon, color: Colors.black, size: size),
          // Set icon size
          SizedBox(
            width: 8.0,
            height: 4.0,
          ),
          // Add space between the icon and the text
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: size,
              fontWeight:
                  FontWeight.normal, // Explicitly set fontWeight to normal
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDropdownItem({
    GlobalKey key,
    String value,
    String hint,
    List<Map<String, dynamic>>
        items, // List of maps to hold both item text and icon data
    Function(String) onChanged,
    Icon hintIcon, // Make hintIcon nullable
  }) {
    double size = 14.0; // Consistent size for both text and icon

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0), // Remove extra padding
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: key,
          // Assign the key here
          value: value,
          style: TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          items:
              items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Row(
                children: [
                  Icon(
                    item['icon'], // Icon from the map
                    color: Colors.black,
                    size: size, // Set icon size
                  ),
                  SizedBox(width: 8.0), // Add space between the icon and text
                  Text(
                    item['value'],
                    style: TextStyle(
                        color: Colors.black, fontSize: size), // Set text size
                  ),
                ],
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
                  children: [
                    hintIcon, // Only add the icon if it's not null
                    SizedBox(
                        width: 8.0), // Add space between the icon and hint text
                    Text(
                      hint,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Text(
                  hint,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  //related disease Data view
  Widget _buildHeaderCellSrNoDiseaseData(String text) {
    return Container(
      height: 35,
      width: 40, // Fixed width to ensure horizontal scrolling
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }

  /*Widget _buildHeaderCellDiseaseData(String text) {
    return Container(
      height: 35,
      width: 90, // Fixed width to ensure horizontal scrolling
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
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }*/

  Widget _buildHeaderCellDiseaseData(String text) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.35, // 30% of screen width
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.1),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 2, // Restrict lines for readability
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
          ),
        ),
      ),
    );
  }





  Widget _buildDataCellDiseaseData(String text) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.35, // 30% of screen width
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
          maxLines: 3,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }




  Future<void> uploadLocalData() async {
    final localDataList =
        await dbHelper.getAllLocalPatients(); // ✅ Fetch data from SQLite

    for (var patientData in localDataList) {
      try {
        await ApipatientRegistrations(
            patientData: patientData); // ✅ Use named argument
        await dbHelper.deleteLocalPatient(
            patientData['id']); // ✅ Delete after successful upload
        print("✅ Data uploaded and removed from local DB.");
      } catch (e) {
        print("❌ Error uploading data: $e");
      }
    }
  }
  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust age if the birthday hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
  void _getLocation() async {
    try {
      Position position = await _determinePosition();
      print('@@Latitude: ${position.latitude}, Longitude: ${position.longitude},');
    } catch (e) {
      print('Error: $e');
    }
  }
}
