import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
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
      eyeBankById,
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
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: _formKey,
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
                        // Designation Field
                        Container(
                          margin: EdgeInsets.fromLTRB(5,0,5,0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            // Full width inside the container
                            child: TextFormField(
                              controller: _designationController,
                              decoration: InputDecoration(
                                labelText: 'Designation',
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                hintText: 'Enter your designation',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0),

                        // Submit and Cancel Buttons
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    // Process the form data
                                    print("@@_campManagerRegistration--");
                                    _campManagerRegistration();
                                  }
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _campManagerRegistration() async {
    if (_formKey.currentState.validate()) {
      Utils.showProgressDialog1(context);

      var response = await ApiController.campManagerRegistration(
          _userNameController.text.toString().trim(),
          gender,
          _mobileNumberController.text.toString().trim(),
          _emailIdController.text.toString().trim(),
          _addressController.text.toString().trim(),
          _designationController.text.toString().trim(),
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
      if (response.message == "Camp Manager Registered Successfully.") {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----Class: " + response.message);

    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
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
  }
