import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

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

  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption;

  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  bool hospitalDashboardclickDsiplay = false;
  String getYearNgoHopital, getfyidNgoHospital, _chosenValueMangeTwo;
  bool hospitalDashboardDatas = false;
  bool hospitalAddPatientData = false;
  String registerationtypeRadio = 'Hospital Walk-in'; // Default gender
  File _selectedImage;
  String _errorMessage, VoterIDtype;
  final ImagePicker _picker = ImagePicker();
  final _formKeyhopsitalPersonalDetal = GlobalKey<FormState>();

  TextEditingController _firstNamePatientDetail = TextEditingController();
  TextEditingController _lastNamePatientDetail = TextEditingController();
  TextEditingController _AgePatientDetail = TextEditingController();
  String gender = 'Male'; // Default gender
  var dependencyTypeRadio;
  int voterIDTypeValue = 0;
  bool showVoterIDField = false,showDrivingLicenseField=false,showPassport=false,showRationCard=false,showPanCard=false,showNotAvailble=false;
  TextEditingController _voterIDNumber = TextEditingController();
  TextEditingController _drivingLicenseNumber = TextEditingController();
  TextEditingController _passport = TextEditingController();
  TextEditingController _rationCard = TextEditingController();
  TextEditingController _panCard = TextEditingController();
  TextEditingController _notAvalble = TextEditingController();
  File _image;

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
        _image = pickedImage;
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
                              controller: _drivingLicenseNumber,
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
                              controller: _passport,
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
                              controller: _rationCard,
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
                              controller: _panCard,
                              labelText: "Pan Card No.",
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Pan Card No.'
                                  : null,
                            ),
                          ),
                        if (showNotAvailble)
                        _textInputField(
                          controller: _firstNamePatientDetail,
                          labelText: 'First Name *',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter First name'
                              : null,
                        ),
                        SizedBox(height: 16.0),
                        _sectionTitle('Dependency Type'),
                        _radioButtonRow(
                          options: ['Self', 'Dependent'],
                          groupValue: dependencyTypeRadio,
                          onChanged: (value) {
                            setState(() {
                              dependencyTypeRadio = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
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
                        SizedBox(height: 16.0),
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
                  child: Form(
                    child: Column(
                      children: [
                        _textInputField(
                          // controller: _mobileNumberDetails,
                          labelText: 'Mobile No *',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
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
