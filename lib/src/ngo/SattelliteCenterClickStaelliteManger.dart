import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../database/SharedPrefs.dart';
import '../model/GetHospitalForDDL/GethospitalForDDL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
class SattelliteCenterClickStaelliteManger extends StatefulWidget {
  @override
  _SattelliteCenterClickStaelliteManger createState() => _SattelliteCenterClickStaelliteManger();
}

class _SattelliteCenterClickStaelliteManger extends State<SattelliteCenterClickStaelliteManger> {
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  bool CampManagerRegisterartions = true; // This should be based on your logic
  String gender = 'Male'; // Default gender
  int status, district_code_login, state_code_login;
  String role_id,
      darpan_nos,
      entryby,
      ngoNames,
      eyeBankById,loggedInNgoId,
      fromlisteyeBankByIds;
  bool AddSatelliteManagers = true;
  TextEditingController _userNameControllerStatelliteMangerReg =
  TextEditingController();
  TextEditingController _mobileNumberControllerStatelliteMangerReg =
  TextEditingController();
  TextEditingController _emailIdControllerStatelliteMangerReg =
  TextEditingController();
  TextEditingController _addressControllerStatelliteMangerReg =
  TextEditingController();
  TextEditingController _designationControllerStatelliteMangerReg =
  TextEditingController();
  TextEditingController _hospitalControllerStatelliteMangerReg =
  TextEditingController();
  int genderSatelliteManagerApi=1; // 1 for Male, 2 for Female, 3 for Transgender
  int genderSatelliteCenterApi;
  bool satelliteCenterMenuListdisplay = false;
  bool AddSatelliteCenterRedOptionFields = false;
  Future<List<DataGethospitalForDDL>> _futureDataGethospitalForDDL;
  DataGethospitalForDDL _dataGethospitalForDDL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Satellite Manager',
          maxLines: 2,
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white, fontSize: 14.0),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddSatelliteManagerOption(), // No condition here
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
          getDarpanNo();
          getloggedInNgoId();
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
          print('@@9' + darpan_nos.toString());
          _futureDataGethospitalForDDL =
              GetHospitalForDDL(district_code_login, state_code_login, userId);

        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget AddSatelliteManagerOption() {
    return Column(
      children: [
        Visibility(
          visible: AddSatelliteManagers,
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
                              'State:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${stateNames}',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Satellite Manager Registration',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Form for Camp Manager Registration
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5.0),
                      // Username Field
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller: _userNameControllerStatelliteMangerReg,
                            // Attach controller
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'User Name',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      // Red asterisk for required field
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter your name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Rounded border
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

                      // Gender Selection
                      Row(
                        children: [
                          Radio<int>(
                            value: 1,
                            groupValue: genderSatelliteManagerApi,
                            onChanged: (value) {
                              setState(() {
                                genderSatelliteManagerApi = value;
                              });
                            },
                          ),
                          Text('Male'),
                          Radio<int>(
                            value: 2,
                            groupValue: genderSatelliteManagerApi,
                            onChanged: (value) {
                              setState(() {
                                genderSatelliteManagerApi = value;
                              });
                            },
                          ),
                          Text('Female'),
                          Radio<int>(
                            value: 3,
                            groupValue: genderSatelliteManagerApi,
                            onChanged: (value) {
                              setState(() {
                                genderSatelliteManagerApi = value;
                              });
                            },
                          ),
                          Text('Transgender'),
                        ],
                      ),
                      SizedBox(height: 5.0),

                      // Mobile Number Field
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller:
                            _mobileNumberControllerStatelliteMangerReg,
                            // Attach controller
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Mobile No.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      // Red asterisk for required field
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter your mobile number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Rounded border
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
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
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller: _emailIdControllerStatelliteMangerReg,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Email ID', // Normal text
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black, // Normal label color
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Asterisk
                                      style: TextStyle(
                                        color: Colors.red, // Red color for *
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Rounded border
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0), // Blue when focused
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: FutureBuilder<List<DataGethospitalForDDL>>(
                          future: _futureDataGethospitalForDDL,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return Container(
                                width: double.infinity,  // Full width like a TextField
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'No data found',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            List<DataGethospitalForDDL> list =
                            snapshot.data.toList();

                            // Check if _selectedUser is null or not part of the list anymore
                            if (_dataGethospitalForDDL == null ||
                                !list.contains(_dataGethospitalForDDL)) {
                              _dataGethospitalForDDL =
                                  list.first; // Set the first item as default
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select hospital*',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    // Adjust height as needed
                                    width: double.infinity,
                                    // Ensures it takes full width
                                    child: DropdownButtonFormField<
                                        DataGethospitalForDDL>(
                                      value: _dataGethospitalForDDL,
                                      onChanged: (userc) {
                                        setState(() {
                                          _dataGethospitalForDDL = userc;
                                          gethospitalName =
                                              userc?.hName ?? '';
                                          gethospitalNameSrNOReg =
                                              userc?.hRegID ?? '';
                                          print(
                                              'getMAnagerNAme Year: $gethospitalName');
                                          print(
                                              'getmanagerSrNO: $gethospitalNameSrNOReg');
                                        });
                                      },
                                      items: list.map((user) {
                                        return DropdownMenuItem<
                                            DataGethospitalForDDL>(
                                          value: user,
                                          child: Text(user.hName,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      dropdownColor: Colors.white,
                                      style: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      // Address Field
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller: _addressControllerStatelliteMangerReg,
                            decoration: InputDecoration(
                              labelText: 'Address*',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Rounded border
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0), // Grey when enabled
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0), // Blue when focused
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0), // Better spacing
                            ),
                            maxLines: 3, // Allows multiline input
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

                      // Designation Field
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),

                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            controller:
                            _designationControllerStatelliteMangerReg,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Designation', // Normal text
                                  style: TextStyle(
                                    fontSize: 16, // Adjust size as needed
                                    color: Colors.black, // Normal label color
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' *', // Asterisk
                                      style: TextStyle(
                                        color: Colors.red, // Red color for *
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Rounded border
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0), // Blue when focused
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your designation';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

                      // Submit and Cancel Buttons
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // Even spacing
                          children: [
                            SizedBox(
                              width: 120, // Reduced button width
                              height: 40, // Reduced button height
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.send,
                                    color: Colors.white,
                                    size: 18), // Smaller icon
                                label: Text(
                                  'Submit',
                                  style:
                                  TextStyle(fontSize: 14), // Smaller text
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  // Button color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  // Smaller padding
                                  minimumSize: Size(120, 40),
                                  // Minimum size
                                  fixedSize: Size(120, 40),
                                  // Fixed width & height
                                  elevation: 3,
                                  // Reduced shadow effect
                                  shadowColor: Colors.black45,
                                  // Shadow color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Slightly rounded corners
                                  ),
                                ),
                                onPressed: () {

                                    print(
                                        "@@_SatteliteMAnagerRegistration--");
                                    _satelliteManagersRegistrationRedOption();
                                  // _spoRegistrationSubmit();
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            // Reduced spacing between buttons
                            SizedBox(
                              width: 120, // Reduced button width
                              height: 40, // Reduced button height
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.refresh,
                                    color: Colors.white,
                                    size: 18), // Smaller icon
                                label: Text(
                                  'Reset',
                                  style:
                                  TextStyle(fontSize: 14), // Smaller text
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  // Reset button color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  // Smaller padding
                                  minimumSize: Size(120, 40),
                                  // Minimum size
                                  fixedSize: Size(120, 40),
                                  // Fixed width & height
                                  elevation: 3,
                                  // Reduced shadow effect
                                  shadowColor: Colors.black45,
                                  // Shadow color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Slightly rounded corners
                                  ),
                                ),
                                onPressed: () {
                                  _resetFormSatelliteManager();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
  Future<void> _satelliteManagersRegistrationRedOption() async {
    // === Validation Checks ===

    if (_userNameControllerStatelliteMangerReg.text.trim().isEmpty) {
      Utils.showToast("Please enter the name.", false);
      return;
    }



    String mobile = _mobileNumberControllerStatelliteMangerReg.text.trim();
    if (mobile.isEmpty || mobile.length != 10 || !RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      Utils.showToast("Please enter a valid 10-digit mobile number.", false);
      return;
    }

    String email = _emailIdControllerStatelliteMangerReg.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      Utils.showToast("Please enter a valid email address.", false);
      return;
    }

    if (gethospitalNameSrNOReg == null || gethospitalNameSrNOReg.toString().isEmpty) {
      Utils.showToast("Please select a hospital.", false);
      return;
    }

    if (_addressControllerStatelliteMangerReg.text.trim().isEmpty) {
      Utils.showToast("Please enter address.", false);
      return;
    }

    if (_designationControllerStatelliteMangerReg.text.trim().isEmpty) {
      Utils.showToast("Please enter designation.", false);
      return;
    }



    if (userId == null || userId.isEmpty) {
      Utils.showToast("User ID is missing.", false);
      return;
    }

    if (entryby == null || entryby.isEmpty || int.tryParse(entryby) == null) {
      Utils.showToast("Invalid entry by value.", false);
      return;
    }

    // === Proceed with API Call ===
    Utils.showProgressDialog1(context);

    var response = await ApiController.satelliteManagerRegistration(
      _userNameControllerStatelliteMangerReg.text.trim(),
      genderSatelliteManagerApi,
      mobile,
      email,
      gethospitalNameSrNOReg.toString(),
      _addressControllerStatelliteMangerReg.text.trim(),
      _designationControllerStatelliteMangerReg.text.trim(),
      district_code_login,
      state_code_login,
      userId,
      int.parse(entryby),
      darpan_nos,
      ngoNames,
      stateNames,
      districtNames,
    );

    Utils.hideProgressDialog1(context);

    if (response != null && response.status) {
      Utils.showToast(response.message.toString(), true);
      print("@@Result message----satelliteManagerRegistration: " + response.message);
    } else {
      Utils.showToast(response?.message?.toString() ?? "Registration failed.", true);
    }
  }




  void _resetForm() {
    _formKey.currentState?.reset();
    _userNameController.clear();
    _mobileNumberController.clear();
    _emailIdController.clear();
    _addressController.clear();
    _designationController.clear();
    setState(() => gender = null);
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
  void _resetFormSatelliteManager() {
    _userNameControllerStatelliteMangerReg.clear();
    _mobileNumberControllerStatelliteMangerReg.clear();
    _emailIdControllerStatelliteMangerReg.clear();
    _addressControllerStatelliteMangerReg.clear();
    _designationControllerStatelliteMangerReg.clear();
    setState(() {
      gender = null; // Reset gender selection
    });
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
}
