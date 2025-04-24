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
class SattelliteCenterClickStaelliteMangerEdit extends StatefulWidget {
  final String name;
  final String mobile;
  final String emailId;
  final String address;
  final String designation;

  const SattelliteCenterClickStaelliteMangerEdit({
    Key key,
     this.name,
     this.mobile,
     this.emailId,
     this.address,
     this.designation,
  }) : super(key: key);
  @override
  _SattelliteCenterClickStaelliteMangerEdit createState() => _SattelliteCenterClickStaelliteMangerEdit();
}

class _SattelliteCenterClickStaelliteMangerEdit extends State<SattelliteCenterClickStaelliteMangerEdit> {
  bool SatelliteManagerRegisterartionsEdit = true;

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
          child: EditSatelliteManager(), // No condition here
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

  Widget EditSatelliteManager() {
    return Column(
      children: [
        Visibility(
          visible: SatelliteManagerRegisterartionsEdit,
          // Change this to your actual condition
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        controller: _userNameControllerStatelliteMangerReg,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'User Name',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners for the border
                            borderSide: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name'; // Validation message if field is empty
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.0),

                      // Gender Selection
                      Text('Gender*'),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text('Male'),
                          Radio<String>(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text('Female'),
                          Radio<String>(
                            value: 'Transgender',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text('Transgender'),
                        ],
                      ),
                      SizedBox(height: 10.0),

                      // Mobile Number Field
                      TextFormField(
                        controller:
                        _mobileNumberControllerStatelliteMangerReg,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mobile No.',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your mobile number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners for the border
                            borderSide: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        // Ensures only numbers can be entered
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number'; // Validation message if field is empty
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit mobile number'; // Validation for 10-digit mobile number
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.0),

                      // Email ID Field
                      TextFormField(
                        controller: _emailIdControllerStatelliteMangerReg,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Email ID',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners for the border
                            borderSide: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        // Ensures keyboard is optimized for email input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'; // Validation for empty field
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address'; // Validation for valid email format
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.0),

                      // Address Field
                      TextFormField(
                        controller: _addressControllerStatelliteMangerReg,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Address',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners for the border
                            borderSide: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        maxLines: 3,
                        // Allows for multi-line input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address'; // Validation for empty field
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.0),

                      // Designation Field
                      TextFormField(
                        controller: _designationControllerStatelliteMangerReg,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Designation', // Label text
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk to indicate the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Red color for the asterisk
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your designation',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners for the border
                            borderSide: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your designation'; // Validation for empty field
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.0),

                      // Submit and Cancel Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {

                                // Process the form data
                                _SatelliteManagerRegistrationEdit();
                            },
                            child: Text('Submit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Reset form fields
                              _resetForm();
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
          ),
        ),
      ],
    );
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
  Future<void> _SatelliteManagerRegistrationEdit() async {
    print('@@Editclick of _SatelliteManagerRegistrationEdit List--');
      Utils.showProgressDialog1(context);

      var response = await ApiController.UpdateSatelliteManager(
          _userNameControllerStatelliteMangerReg.text.toString().trim(),
          gender,
          _mobileNumberControllerStatelliteMangerReg.text.toString().trim(),
          _emailIdControllerStatelliteMangerReg.text.toString().trim(),
          _addressControllerStatelliteMangerReg.text.toString().trim(),
          _designationControllerStatelliteMangerReg.text.toString().trim(),
          district_code_login,
          state_code_login,
          userId,
          int.parse(entryby),
          darpan_nos,
          "0",
          ngoNames,
          stateNames,
          districtNames,
          "0");

      Utils.hideProgressDialog1(context);

      // Check if the response is null before accessing properties
      if (response.status) {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----Class: " + response.message);

      }

  }

}
