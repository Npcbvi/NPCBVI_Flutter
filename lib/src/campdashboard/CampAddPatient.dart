
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../database/DatabaseHelper.dart';
import '../model/DashboardStateModel.dart';
import '../model/city/GetCity.dart';
import '../model/city/GetVillage.dart';
import '../model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import '../model/patientCount/PatientCountDetail.dart';
import '../model/spoModel/GetDiseaseForDDL.dart';
import '../model/spoModel/GetLanguageForDDLs.dart';
import '../utils/AppConstants.dart';

class CampAddPatient extends StatefulWidget {

  @override
  _CampAddPatient createState() => _CampAddPatient();
}

class _CampAddPatient extends State<CampAddPatient> {
  bool _isVillageInitialized = false;
  Future<List<DataGetVillage>> _villageFuture;
  int registerationtypeRadioValueinAPi = 1; // Default gender
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
  String _selectedDateText = 'Screening Date *'; // Initially set to "From Date"
  String _selectedDateTextToDate = 'Tentative Surgery Date *';
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
      distCodeGovtPrivate,distCodeGovtPrivateCity,
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
  int patientCount = 0;
  String selectedStateName,selectedDistrictName,selectedCityName,selectedVillageName,selectedCamp,selectedHospital;
  // Function to get current position

  LatLng updatedLatLng;
  String updatedAddress = '';
  String updatedPincode = '';
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
          _AddressHouse.text = fullAddress;
        });
        print("Address: $fullAddress"); // Print address in console
      }
    } catch (e) {

      setState(() {
        _locationMessage = "Error: $e";
        _address = "Failed to get address";
        _AddressHouse.text = "Error: $e";
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


  Future<void> getPatientCount() async {
    DataPatientCountDetail data = await ApiController.fetchPatientCount();
    if (data != null) {
      setState(() {
        patientCount = data.patientCount ?? 0;
      });
    }
  }

  void getUserData() async {
    try {

      SharedPrefs.getUser().then((user) async{
        entryby = await SharedPrefs.getStoreSharedValue(AppConstant.entryBy)
        as String;
        loggedInNgoId = await SharedPrefs.getStoreSharedValue(AppConstant.ngoid)
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
           getloggedInNgoId();
          getentryby();
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
          _futureCamp = getCampListDropdown(
            stateId: state_code_login, // your state value
            districtId: district_code_login, // your district value
            entryBy: entryby.toString(), // logged in user ID
          );
          _futureHospital = getHospitalinCampForDDL(
            stateId: state_code_login, // your state value
            districtId: district_code_login, // your district value
            ngoId: loggedInNgoId.toString(), // logged in user ID
          );
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
    getPatientCount(); // Call API
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Add Patient',
            maxLines:2,
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
        body:SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 5.0),
                  Container(

                    width: double.infinity, // Ensures the container takes full width
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adds spacing
                    color: Colors.blue, // Background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left & right
                      children: [
                        Text(
                          'Patient Registration',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Ensure text is visible on blue background
                          ),
                        ),
                        Text(
                          "Today Registered Patient(s): $patientCount",
                          maxLines:2,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Change to white to be visible on blue
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.0),
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
                          enabledOptions: ['Screening Camp'],
                          // Only this option is enabled
                          groupValue: registerationtypeRadio,
                          onChanged: (value) {
                            if (value == "Screening Camp") {
                              // Allow only if enabled
                              setState(() {
                                registerationtypeRadio = value;
                                print('@@1 ' + registerationtypeRadio.toString());

                                registerationtypeRadioValueinAPi = 1;
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
              //  camp ka code hai ye hide
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    width: double.infinity,
                    child: FutureBuilder<List<CampListDataonDashboardData>>(
                      future: _futureCamp, // Fetching States
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        List<CampListDataonDashboardData> campList = snapshot.data ?? [];
// ✅ Show 'No data found' if list is empty
                        if (campList.isEmpty) {
                          return const Text(
                            'No data found',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          );
                        }
                        // ✅ Insert hint item at the top
                        if (campList.isNotEmpty && campList.first.campNo != 'Select Camp') {
                          campList.insert(0, CampListDataonDashboardData(campNo: 'Select Camp', srNo: '-1'));
                        }

                        // ✅ Ensure a default selection
                        if (_selectedUserCamp == null || !campList.contains(_selectedUserCamp)) {
                          _selectedUserCamp = campList.first;
                          selectedCamp = _selectedUserCamp.campNo.toString();
                          print('@@selectedCamp' + selectedCamp.toString());
                        }

                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select Camp:',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 45, // Set the desired height for dropdown
                                child: DropdownButtonFormField2<CampListDataonDashboardData>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
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
                                    if (user != null && user.campNo != 'Select Camp') {
                                      setState(() {
                                        _selectedUserCamp = user;
                                        selectedCamp = user.campNo;
                                        //stateCodeGovtPrivate = int.parse(user.stateCode.toString());
                                        //CodeGovtPrivate = user.code;
                                        print('@@selectedCamp' + selectedCamp.toString());
                                        setState(() {

                                        });

                                      });



                                    }
                                  },
                                  value: _selectedUserCamp,
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
                                    height: 20, // Increase dropdown button height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                  ),
                                  items: campList.map<DropdownMenuItem<CampListDataonDashboardData>>((CampListDataonDashboardData user) {
                                    return DropdownMenuItem<CampListDataonDashboardData>(
                                      value: user,
                                      child: Text(
                                        user.campNo,
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
                 // Hospital ka code hai ye hide
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    width: double.infinity,
                    child: FutureBuilder<List<HospitalListForDasboardData>>(
                      future: _futureHospital, // Fetching States
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        List<HospitalListForDasboardData> hospitalList = snapshot.data ?? [];
// ✅ Show 'No data found' if list is empty
                        if (hospitalList.isEmpty) {
                          return const Text(
                            'No data found',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          );
                        }
                        // ✅ Insert hint item at the top
                        if (hospitalList.isNotEmpty && hospitalList.first.hName != 'Select Hospital') {
                          hospitalList.insert(0, HospitalListForDasboardData(hName: 'Select Hospital', hRegID: '-1'));
                        }

                        // ✅ Ensure a default selection
                        if (_selectedUserHospital == null || !hospitalList.contains(_selectedUserHospital)) {
                          _selectedUserHospital = hospitalList.first;
                          selectedHospital = _selectedUserHospital.hName.toString();
                          print('@@selectedHospital' + selectedHospital.toString());
                        }

                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select Hospital:',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 45, // Set the desired height for dropdown
                                child: DropdownButtonFormField2<HospitalListForDasboardData>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
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
                                    if (user != null && user.hName != 'Select Hospital') {
                                      setState(() {
                                        _selectedUserHospital = user;
                                        selectedHospital= user.hName;
                                        //stateCodeGovtPrivate = int.parse(user.stateCode.toString());
                                        //CodeGovtPrivate = user.code;
                                        print('@@selectedHospital' + selectedHospital.toString());


                                        setState(() {

                                        });

                                      });



                                    }
                                  },
                                  value: _selectedUserHospital,
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
                                    height: 20, // Increase dropdown button height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                  ),
                                  items: hospitalList.map<DropdownMenuItem<HospitalListForDasboardData>>((HospitalListForDasboardData user) {
                                    return DropdownMenuItem<HospitalListForDasboardData>(
                                      value: user,
                                      child: Text(
                                        user.hName,
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
                  Container(

                    width: double.infinity, // Ensures the container takes full width
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adds spacing
                    color: Colors.blue, // Background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left & right
                      children: [
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Ensure text is visible on blue background
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    child: Form(
                      key: _formKeyhopsitalPersonalDetal,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: SizedBox(
                              height: 45,
                              child: DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),

                                ),
                                value: VoterIDtype,
                                style: TextStyle(color: Colors.black),
                                items: [
                                  'Voter ID',
                                  'Driving License',
                                  'Passport',
                                  'Ration Card',
                                  'Pan Card',
                                  'Not Available',
                                ].map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Select ID Type",

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    VoterIDtype = newValue;
                                    showVoterIDField = VoterIDtype == "Voter ID";
                                    showDrivingLicenseField = VoterIDtype == "Driving License";
                                    showPassport = VoterIDtype == "Passport";
                                    showRationCard = VoterIDtype == "Ration Card";
                                    showPanCard = VoterIDtype == "Pan Card";
                                    showNotAvailble = VoterIDtype == "Not Available";
                                  });
                                },
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                  iconEnabledColor: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 5.0),
                          if (showVoterIDField)
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),

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
                            ),
                          if (showDrivingLicenseField)
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                            ),
                          if (showPassport)
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                            ),
                          if (showRationCard)
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                            ),
                          if (showPanCard)
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                            ),
                          if (showNotAvailble)


                            SizedBox(height: 10.0),

                          Container( margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0), // left, top, right, bottom
                            width: double.infinity, // Ensures the container takes full width
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Adds spacing
                            color: Colors.white, // Background color
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left & right
                              children: [
                                Text(
                                  'Dependency Type',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // Ensure text is visible on blue background
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
                                  child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white, // Background color of the dropdown
                                    ),
                                    value: relationtypeValue,
                                    style: TextStyle(color: Colors.black),
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        relationtypeValue = newValue;

                                        // Set the relation name dynamically
                                        if (relationtypeValue == "Father") {
                                          relationNameController.text = "Father's Name";
                                        } else if (relationtypeValue == "Mother") {
                                          relationNameController.text = "Mother's Name";
                                        } else if (relationtypeValue == "Brother") {
                                          relationNameController.text = "Brother's Name";
                                        } else if (relationtypeValue == "Sister") {
                                          relationNameController.text = "Sister's Name";
                                        } else if (relationtypeValue == "Daughter") {
                                          relationNameController.text = "Daughter's Name";
                                        } else if (relationtypeValue == "Spouse") {
                                          relationNameController.text = "Spouse's Name";
                                        } else {
                                          relationNameController.text = "";

                                        }
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 25, // Increase dropdown button height
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        // Removed border here
                                        color: Colors.white,
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      iconEnabledColor: Colors.black,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 5),
                                // Display input field based on selected relation
                                if (relationtypeValue == "Father")
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
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
                          Container(
                            margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom
                            child: SizedBox(
                              height: 45, // Adjust height as needed
                              child: TextFormField(
                                controller: _firstNamePatientDetail,
                                decoration: InputDecoration(
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'First Name',
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: ' *', // Red Asterisk
                                          style: TextStyle(color: Colors.red, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hintText: 'Enter First Name',
                                  hintStyle: TextStyle(color: Colors.black),
                                  // Border when the field is not focused
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey), // Grey border
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),

                                  // Border when the field is focused
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 2), // Grey border when focused
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  // Set hint text color

                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your First name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 5.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom

                            child: SizedBox(
                              height: 45, // Adjust height as needed
                              child: TextFormField(
                                controller: _lastNamePatientDetail,
                                decoration: InputDecoration(
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Last Name ',
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: ' *', // Red Asterisk
                                          style: TextStyle(color: Colors.red, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hintText: 'Enter Last Name *',
                                  hintStyle: TextStyle(color: Colors.black),
                                  // Regular hint text
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey), // Grey border
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),

                                  // Border when the field is focused
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 1), // Grey border when focused
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Last Name *';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Date Picker Container with fixed height and width
                                  /*SizedBox(
                                  width: 150, // Set same width for both widgets
                                  height: 40, // Adjust height as needed
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
                                      alignment: Alignment.centerLeft,  // Left side, vertically centered
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 6.0), // Adjust padding as needed
                                        child: Text(
                                          _dob.isEmpty ? "Date of birth" : _dob,

                                          style: TextStyle(
                                            color: (_dob.isEmpty || _dob == "Date of birth") ? Colors.grey : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),


                                    ),
                                  ),
                                ),*/

                                  SizedBox(
                                    width: 150, // Set same width for both widgets
                                    height: 45, // Adjust height as needed
                                    child: GestureDetector(
                                      onTap: () async {
                                        DateTime pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1700),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDate != null) {
                                          String formattedDateForDisplay = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}"; // For UI display
                                          String formattedDateForAPI = DateFormat('yyyy-MM-dd').format(pickedDate); // For API request

                                          setState(() {
                                            _dob = formattedDateForAPI; // Use this for the API
                                            print("@@_dob (API format): $_dob");
                                            print("@@_dob (display format): $formattedDateForDisplay");
                                            // Calculate age and update age field
                                            int age = _calculateAge(pickedDate);
                                            _ageController.text = age.toString();
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft, // Align text to the left
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 6.0), // Adjust padding as needed
                                          child: Text(
                                            _dob.isEmpty ? "Select date" : _dob,
                                            style: TextStyle(
                                              color: (_dob.isEmpty || _dob == "Select date") ? Colors.grey : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),






                                  SizedBox(width: 5.0),
                                  // Spacing between the widgets
                                  // Age Input Field with same width and height
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom

                                    child: SizedBox(
                                      width: 150, // Same width as Date Picker
                                      height: 45,
                                      child: TextFormField(
                                        controller: _ageController,
                                        readOnly: true,   // 🔒 Prevents editing
                                        enabled: false,   // 🔒 Grays out and disables the field (still visible)
                                        decoration: InputDecoration(
                                          label: RichText(
                                            text: TextSpan(
                                              text: 'Age ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                              children: [
                                                TextSpan(
                                                  text: ' *', // Red Asterisk
                                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          hintText: 'Enter Age *',
                                          hintStyle: TextStyle(color: Colors.black),
// Regular hint text
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your Age *';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                          SizedBox(height: 5.0),
                          Container(
                            width: double.infinity, // Ensures the container takes full width
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adds spacing
                            color: Colors.white, // Background color
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left & right
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // Ensure text is visible on blue background
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _radioButtonRow(
                            options: ['Male', 'Female', 'Transgender'],
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),

                  Container(

                    width: double.infinity, // Ensures the container takes full width
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adds spacing
                    color: Colors.blue, // Background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left & right
                      children: [
                        Text(
                          'Mobile Number Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Ensure text is visible on blue background
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0.0, 0),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SizedBox(
                              height: 45,

                              child: DropdownButtonFormField2<String>(
                                isExpanded: true,
                                value: relationtypeValueMobile,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0), // Content padding
                                  border: InputBorder.none, // Remove the default border (already set by the container)
                                ),
                                style: TextStyle(color: Colors.black),
                                hint: Text(
                                  "Relation Type",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                items: <String>[
                                  'Father',
                                  'Mother',
                                  'Brother',
                                  'Sister',
                                  'Daughter',
                                  'Spouse',
                                  'Self',
                                ].map<DropdownMenuItem<String>>((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
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
                        if (relationtypeValue == "Self")
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5.0, 0),

                            child: _textInputField(
                              controller: relationFatherController,
                              labelText: "Self Name",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Self'
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),

                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom

                    child: SizedBox(
                      width: double.infinity, // Same width as Date Picker
                      height: 45, // Adjust height as needed
                      child: TextFormField(
                        controller: _mobileNumberDetailsRelationtype,
                        keyboardType: TextInputType.phone, // Use number pad for phone input
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'Mobile No ',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: ' *', // Red Asterisk
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter Mobile No *',
                          hintStyle: TextStyle(color: Colors.black),
// Regular hint text
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Grey border
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                          // Border when the field is focused
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1), // Grey border when focused
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Mobile No *';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),


                  SizedBox(height: 5),
                  Container(
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
                                    width: MediaQuery.of(context).size.width * 0.4, // 50% of screen width
                                    height: 40, // Set the fixed height
                                    padding: EdgeInsets.all(10.0),

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
                          SizedBox(width: 30), // Space between the two fields
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
                                    width: MediaQuery.of(context).size.width * 0.4, // 50% of screen width
                                    height: 40, // Set the fixed height
                                    padding: EdgeInsets.all(10.0),
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


                  SizedBox(height: 5.0),
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

                          List<GetDiseaseForDDLData> districtList = snapshot.data;

                          // Ensure selected district is in the list, otherwise select the first one
                          if (_futureGetDiseaseForDDLDatass == null ||
                              !districtList.contains(_futureGetDiseaseForDDLDatass)) {
                            _futureGetDiseaseForDDLDatass = districtList.first;
                          }

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5.0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,  // Align children to the start
                              crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the left
                              children: <Widget>[
                                Text(
                                  'Select Diseases',
                                  textAlign: TextAlign.left,  // Align text to the left
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                DropdownButtonFormField2<GetDiseaseForDDLData>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (districtUser) => setState(() {
                                    _futureGetDiseaseForDDLDatass = districtUser;
                                    getDissesID = int.parse(districtUser.id.toString());
                                    // Update state or further actions here
                                    print('Selected District: ${districtUser.name}');
                                  }),
                                  value: _futureGetDiseaseForDDLDatass,
                                  items: districtList.map((GetDiseaseForDDLData district) {
                                    return DropdownMenuItem<GetDiseaseForDDLData>(
                                      value: district,
                                      child: Text(district.name),
                                    );
                                  }).toList(),
                                  buttonStyleData: ButtonStyleData(
                                    height: 25, // Increase dropdown button height
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
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
                  SizedBox(height: 5.0),
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
                                'Select State:',
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
                                    'Select District:',
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


                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center, // Align the items vertically centered
                      children: [
                        // Address/House/Flat Number TextField
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _AddressHouse,
                              maxLines: 1, // Force single line
                              textAlignVertical: TextAlignVertical.center, // Center text vertically
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Address/ House/ Flat Number',
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Enter Address/ House/ Flat Number',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                // Customizing focus and enabled borders
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey), // Set border color to grey or any color you want
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey), // Border color when not focused
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Spacer to add some space between TextField and IconButton
                        SizedBox(width: 10),

                        // Location Icon Button
                        SizedBox(
                          height: 45,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Border color
                              borderRadius: BorderRadius.circular(10), // Border radius
                            ),
                            child: IconButton(
                              icon: Icon(Icons.my_location, color: Colors.blue),
                              onPressed: () {
                                if (selectedDistrictName != null && selectedDistrictName.isNotEmpty &&
                                    selectedCityName != null && selectedCityName.isNotEmpty) {
                                  openMapDialog(context, selectedStateName, selectedDistrictName, selectedCityName,selectedVillageName);
                                  setState(() {
                                    showCoordinates = true; // Show the coordinates section
                                  });
                                } else {
                                  // Show error or toast/snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please select State, District, and City first."),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                  SizedBox(height: 5.0),
                  // Latitude and Longitude fields
                  Visibility(
                    visible: showCoordinates,
                    child: SizedBox(
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _textInputField(
                                controller: _latitudeController,
                                labelText: 'Latitude',
                                readOnly: true,
                                prefixIcon: Icon(Icons.my_location, color: Colors.blue),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _textInputField(
                                controller: _longitudeController,
                                labelText: 'Longitude',
                                readOnly: true,
                                prefixIcon: Icon(Icons.location_searching, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  /* Padding(
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
                ),*/
                  /*          Padding(
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
                ),*/
                  /*     Padding(
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
                ),*/
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0), // left, top, right, bottom
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _PinCode,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'Pin Code',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: ' *', // Red Asterisk
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Pin Code',
                          hintStyle: TextStyle(color: Colors.black),
// Regular hint text
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Grey border
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                          // Border when the field is focused
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1), // Grey border when focused
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: double.infinity, // Full width
                    height: 80, // Increased height for dropdown

                    child: FutureBuilder<List<GetLanguageForDDLsDatas>>(
                      future: _futureStateGetLanguageForDDLsData,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Logging data for debugging
                        developer.log('@@snapshot: ${snapshot.data}');

                        List<GetLanguageForDDLsDatas> stateList = snapshot.data ?? [];

                        // Ensure selected language is in the list, otherwise select the first
                        if (GetLanguageForDDLsDatasa == null || !stateList.contains(GetLanguageForDDLsDatasa)) {
                          GetLanguageForDDLsDatasa = stateList.isNotEmpty ? stateList.first : null;
                          stateLKanguage = int.parse(GetLanguageForDDLsDatasa?.id.toString() ?? "0");

                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,  // Aligning text to the left
                            children: [
                              Text(
                                'Communication Language *',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 45,
                                child: DropdownButtonFormField2<GetLanguageForDDLsDatas>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (user) => setState(() {
                                    GetLanguageForDDLsDatasa = user;
                                    stateLKanguage = int.parse(user?.id.toString() ?? "0");
                                  }),
                                  value: GetLanguageForDDLsDatasa,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 300,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    offset: const Offset(0, -3),
                                  ),
                                  items: stateList.map<DropdownMenuItem<GetLanguageForDDLsDatas>>(
                                        (GetLanguageForDDLsDatas user) {
                                      return DropdownMenuItem<GetLanguageForDDLsDatas>(
                                        value: user,
                                        child: Text(user.name),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),





                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("@@-----click SubmitAdd Patient--");

                            var connectivityResult = await Connectivity().checkConnectivity();

                            if (connectivityResult == ConnectivityResult.none) {
                              print("No internet connection. Saving data locally.");
                              await dbHelper.savePatientData(); // ✅ Save to SQLite
                              Utils.showToast("No internet. Data saved locally.", true);
                            } else {
                              print("Internet available. Uploading data to API.");
                         //     await ApipatientRegistration(); // Submit to API
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Set the radius for rounded corners
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Ensures button wraps around content
                            children: [
                              Icon(Icons.send, color: Colors.white), // Change icon as needed
                              SizedBox(width: 8), // Space between icon and text
                              Text('Submit'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            resetForm();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Set the radius for rounded corners
                            ),
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
                      ),
                    ],
                  )


                ],
              ),
            ],
          ),
        )
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
      mainAxisSize: MainAxisSize.min, // Ensures the column only takes required height
      children: options
          .map((option) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0), // Reduce from 4.0 to 2.0
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
                  fontSize: 13.0,
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
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
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
      print('@@district_code_login'+"https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCity".toString()+body.toString());

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

 /* Future<void> uploadLocalData() async {
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
  }*/
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
  void openMapDialog(BuildContext context, String state, String district, String city, String village) async {
    String fullAddress = '$city, $district, $state';

    try {
      List<Location> locations = await locationFromAddress(fullAddress);

      if (locations.isNotEmpty) {
        LatLng initialLatLng = LatLng(locations[0].latitude, locations[0].longitude);
        updatedLatLng = initialLatLng;

        // Fetch address & pincode initially
        List<Placemark> placemarks = await placemarkFromCoordinates(
          initialLatLng.latitude,
          initialLatLng.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          updatedAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
          updatedPincode = place.postalCode ?? '';

          _AddressHouse.text = updatedAddress;
          _PinCode.text = updatedPincode;
          _latitudeController.text = initialLatLng.latitude.toString();
          _longitudeController.text = initialLatLng.longitude.toString();
        }

        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: 300,
                  height: 500,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: initialLatLng,
                              zoom: 14.0,
                            ),
                            onMapCreated: (controller) {},
                            markers: updatedLatLng != null
                                ? {
                              Marker(
                                markerId: MarkerId('selected_location'),
                                position: updatedLatLng,
                              ),
                            }
                                : {},
                            onTap: (LatLng tappedLatLng) async {
                              updatedLatLng = tappedLatLng;
                              _latitudeController.text = tappedLatLng.latitude.toString();
                              _longitudeController.text = tappedLatLng.longitude.toString();

                              List<Placemark> placemarks = await placemarkFromCoordinates(
                                tappedLatLng.latitude,
                                tappedLatLng.longitude,
                              );

                              if (placemarks.isNotEmpty) {
                                Placemark place = placemarks[0];
                                setState(() {
                                  updatedAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
                                  updatedPincode = place.postalCode ?? '';
                                });

                                _AddressHouse.text = updatedAddress;
                                _PinCode.text = updatedPincode;
                              }

                              setState(() {}); // Refresh UI to update marker
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address: $updatedAddress"),
                            SizedBox(height: 4),
                            Text("Pincode: $updatedPincode"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      } else {
        print('No location found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void resetForm() {
    // Clear text fields
    _firstNamePatientDetail.clear();
    _lastNamePatientDetail.clear();
    _AgePatientDetail.clear();
    _mobileNumberDetailsRelationtype.clear();
    _AddressHouse.clear();
    _ageController.clear();
    _latitudeController.clear();
    _longitudeController.clear();
    //  _Apartment.clear();
    //  _AreaNearLandMark.clear();

    _selectedUserState = null;
    _selectedUserDistrict = null;
    _selectedUserCity = null;
    _selectedUserVillage = null;
    // ✅ Reset the name variables too
    selectedStateName = "";
    selectedDistrictName = "";
    selectedCityName = "";
    selectedVillageName = "";
    _PinCode.clear();
    _voterIDNumber.clear();
    //  _reportingPlaceController.clear();
    relationFatherController.clear();

    // Reset dropdowns and radio buttons
    // registerationtypeRadioValueinAPi = null;

    VoterIDtype = null;
    // dependencyTypeRadio = null;
    //relationtypeValue = null;
    // gender = null;
    // relationtypeValueMobile = null;
    // getDissesID = null;
    stateLKanguage = null;
    distCodeGovtPrivate = null;
    village_code = null;

    // Reset date pickers
    _dob = "Select Date";
    _selectedDateText = "Screening Date";
    _selectedDateTextToDate = "Tentative Date";

    // Clear image
    _image = null;

    // Trigger UI update
    setState(() {});

    // Optional: Show a toast message
    //Utils.showToast("Form has been reset!", true);
  }
  Future<List<CampListDataonDashboardData>> getCampListDropdown({
     int stateId,
     int districtId,
     String entryBy,
  }) async {

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    final url = Uri.parse('https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Camp/api/GetCampForDDL');

    final Map<String, dynamic> requestBody = {
      "stateId": stateId,
      "districtId": districtId,
      "entryBy": entryBy,
    };

    // ✅ Print URL and request body
    print('@@CampForDDL URL: $url');
    print('@@CampForDDL Body: ${jsonEncode(requestBody)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final campList = (json['data'] as List)
          .map((e) => CampListDataonDashboardData.fromJson(e))
          .toList();
      return campList;
    } else {
      Utils.showToast("Failed to load camp list", true);
      return [];
    }
  }

  Future<List<HospitalListForDasboardData>> getHospitalinCampForDDL({
    int stateId,
    int districtId,
    String ngoId,
  }) async {

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    final url = Uri.parse('https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Camp/api/GetHospitalinCampForDDL');

    final Map<String, dynamic> requestBody = {
      "stateId": stateId,
      "districtId": districtId,
      "ngoId": ngoId,
    };

    // ✅ Print URL and request body
    print('@@HospitalinCampForDDL URL: $url');
    print('@@HospitalinCampForDDL Body: ${jsonEncode(requestBody)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final campList = (json['data'] as List)
          .map((e) => HospitalListForDasboardData.fromJson(e))
          .toList();
      return campList;
    } else {
      Utils.showToast("Failed to load camp list", true);
      return [];
    }
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
}