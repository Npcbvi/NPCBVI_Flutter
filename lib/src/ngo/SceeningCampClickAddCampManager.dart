import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class SceeningCampClickAddCampManager extends StatefulWidget {
  @override
  _SceeningCampClickAddCampManager createState() => _SceeningCampClickAddCampManager();
}

class _SceeningCampClickAddCampManager extends State<SceeningCampClickAddCampManager> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Camp Manager',
          maxLines: 2,
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white, fontSize: 14.0),),

      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddCampManager(), // No condition here
          ),
        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page

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
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget AddCampManager() {
    return Column(
      children: [
        Visibility(
          visible: CampManagerRegisterartions,
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
                  width: double.infinity,
                  // Full width

                  color: Colors.blue,
                  // Background color
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // Padding for spacing
                  child: Center(
                    child: Text(
                      'Camp Manager Registration',
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
                      // Username Field
                      SizedBox(height: 5.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(5,0,5,0),

                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          // Full width inside the container
                          child: TextFormField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'User Name',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
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
                      SizedBox(height: 5.0),

                      // Mobile Number Field
                      Container(
                        margin: EdgeInsets.fromLTRB(5,0,5,0),// Add margin here

                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          // Full width inside the container
                          child: TextFormField(
                            controller: _mobileNumberController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Mobile No.',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
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
                      Container(
                        margin: EdgeInsets.fromLTRB(5,0,5,0),

                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          // Full width inside the container
                          child: TextFormField(
                            controller: _emailIdController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Email ID',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
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

                      // Address Field
                      Container(
                        margin: EdgeInsets.fromLTRB(5,0,5,0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          // Full width inside the container
                          child: TextFormField(
                            maxLines: 1, // Allows multiline input
                            controller: _addressController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Address',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                            ),
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

                      Container(
                        margin: EdgeInsets.fromLTRB(5,0,5,0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          // Full width inside the container
                          child: TextFormField(
                            maxLines: 1, // Allows multiline input
                            controller: _designationController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Designation',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey, // Grey border when focused
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter your designation';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      // Designation Field

                      SizedBox(height: 10.0),

                      // Submit and Cancel Buttons
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                  // Process the form data
                                  print("@@_campManagerRegistration--");
                                  _campManagerRegistration();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Adjust radius as needed
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12), // Button padding
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check, color: Colors.white),
                                  // Check icon
                                  SizedBox(width: 8),
                                  // Space between icon and text
                                  Text('Submit'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Reset form fields
                                _resetForm();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Adjust radius as needed
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12), // Button padding
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.refresh, color: Colors.white),
                                  // Refresh icon
                                  SizedBox(width: 8),
                                  // Space between icon and text
                                  Text('Reset'),
                                ],
                              ),
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
  Future<void> _campManagerRegistration() async {
    // Field validations before calling the API

    if (_userNameController.text.trim().isEmpty) {
      Utils.showToast("Please enter the name.", false);
      return;
    }

    if (gender == null || gender.isEmpty) {
      Utils.showToast("Please select gender.", false);
      return;
    }

    String mobile = _mobileNumberController.text.trim();
    if (mobile.isEmpty || mobile.length != 10 || !RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      Utils.showToast("Please enter a valid 10-digit mobile number.", false);
      return;
    }

    String email = _emailIdController.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      Utils.showToast("Please enter a valid email address.", false);
      return;
    }

    if (_addressController.text.trim().isEmpty) {
      Utils.showToast("Please enter address.", false);
      return;
    }

    if (_designationController.text.trim().isEmpty) {
      Utils.showToast("Please enter designation.", false);
      return;
    }



    if (userId == null || userId.isEmpty) {
      Utils.showToast("User ID is missing.", false);
      return;
    }

    if (entryby == null || entryby.isEmpty || int.tryParse(entryby) == null) {
      Utils.showToast("Invalid entry by ID.", false);
      return;
    }

    // Proceed with API call after validation passes
    Utils.showProgressDialog1(context);

    var response = await ApiController.campManagerRegistration(
      _userNameController.text.trim(),
      gender,
      mobile,
      email,
      _addressController.text.trim(),
      _designationController.text.trim(),
      district_code_login,
      state_code_login,
      userId,
      int.parse(entryby),
      darpan_nos,
      "0",
      ngoNames,
      stateNames,
      districtNames,
      "0",
    );

    Utils.hideProgressDialog1(context);

    if (response != null && response.message == "Camp Manager Registered Successfully.") {
      Utils.showToast(response.message.toString(), true);
      print("@@Result message----Class: " + response.message);
    } else {
      Utils.showToast("Not created successfully", true);
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
  }
