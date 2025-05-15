import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../database/SharedPrefs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetDataUpdatedUSers extends StatefulWidget {
  @override
  _GetDataUpdatedUSers createState() => _GetDataUpdatedUSers();
}

class _GetDataUpdatedUSers extends State<GetDataUpdatedUSers> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController orgNameController = TextEditingController();
  TextEditingController applicationSattucController = TextEditingController();

  TextEditingController mobileNumberControlller = TextEditingController();
  TextEditingController EmailIdControlller = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController loginStatucController = TextEditingController();
  String
      selectedUserType; // <-- define this here, nullable for no initial selection
  List<Map<String, String>> userTypeList = [];
  List<String> userTypes = []; // your list of user types to populate dropdown
  String entryby,
      _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController;
  int status, district_code_login, state_code_login;
  String role_id, ngoNames,emaiId;

  void updateUser() {
    String userId = userIdController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a User ID")),
      );
      return;
    } else {}

    // TODO: Implement update user API call
    print("Updating user with ID: $userId");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User details updated successfully!")),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    print('@@calling everytime');
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update User Details")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Center Row contents
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
                              'DPM',
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
                            'State',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${stateNames}',
                            // Use actual districtNames variable here
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
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
                        'District',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${districtNames}',
                        // Use actual stateNames variable here
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // User ID TextField (takes 2 parts)
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: userIdController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'User Id ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter User Id *',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Get Data Button (takes 1 part)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Get button clicked');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8), // control padding
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.white),
                                    SizedBox(width: 6),
                                    Text('Get Data'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      // User ID TextField (takes 2 parts)
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: stateController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'State',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter State *',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      // Get Data Button (takes 1 part)
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: districtcontroller,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'District',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter District *',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'User Name',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter User Name',
                        // Border styles for enabled and focused states
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          // Blue border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: orgNameController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Orgnisation Name',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Orgnisation Name',
                        // Border styles for enabled and focused states
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          // Blue border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: mobileNumberControlller,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Mobile No.',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Mobile No.',
                        // Border styles for enabled and focused states
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          // Blue border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: EmailIdControlller,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Email Id',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Email Id',
                        // Border styles for enabled and focused states
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          // Blue border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  DropdownButtonFormField2<String>(
                    value: selectedUserType,
                    hint: const Text(
                      'Select User Type',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    isExpanded: true,
                    items: userTypeList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['type'],
                        child: Text(item['type']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedUserType = newValue;

                        // Find the matching map to get its status
                        final matchedItem = userTypeList.firstWhere(
                              (item) => item['type'] == newValue,
                          orElse: () => {'status': ''},
                        );

                      //  loginStatucController.text = matchedItem['status'];
                      //  print('@@selectedUserType: $selectedUserType');
                        // Check if status is "1" and set text accordingly
                        final statusValue = matchedItem['status'];
                        loginStatucController.text = statusValue == '1' ? 'Active' : 'InActive';

                        print('@@selectedUserType: $selectedUserType');
                        print('@@loginStatucController: ${loginStatucController.text}');
                        print('@@loginStatucController: ${loginStatucController.text}');
                      });
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
                      height: 30,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    ),
                  ),


                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Address',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Address',
                        // Border styles for enabled and focused states
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          // Blue border when focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      // User ID TextField (takes 2 parts)
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: loginStatucController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Login Status',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter Login Status *',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Get Data Button (takes 1 part)
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      // User ID TextField (takes 2 parts)
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: applicationSattucController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Application Status',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Enter Application Status *',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Get Data Button (takes 1 part)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUserData() {
    try {
      SharedPrefs.getUser().then((user) {
        setState(() {
          emaiId=user.emailId;
          EmailIdControlller.text=user.emailId;
          fullnameController = user.name;
          usernameController.text = user.name;
          districtNames = user.districtName;
          districtcontroller.text = user.districtName;
          stateNames = user.stateName;
          stateController.text = user.stateName;
          userId = user.userId;
          userIdController.text = user.userId;
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
          // ✅ API Call with required params
          fetchAndSetApplicationStatus();
          // Assuming you have userId available here
          fetchUserType();
          // Assuming you fetch the value from login or a previous screen
        });
      });
    } catch (e) {
      print(e);
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

/*  Future<void> fetchDPMOtherInfo({
     int stateId,
     int districtId,
     int role_id, String userid,
  }) async {
    const String url = 'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_otherinfo';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userid": userid,
          "stateid": stateId,
          "districtid": districtId,
          "role_id": role_id,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'][0];
          orgNameController.text = data['org_name'];
          applicationSattucController.text=data['applicationStatus'];
        } else {
          print('API returned no data or failed status.');
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }*/
  Future<void> fetchAndSetApplicationStatus() async {
    final applicationStatus = await fetchApplicationStatusFromApi(
        state_code_login, district_code_login, int.parse(role_id), userId);
    print('@@Received applicationStatus: $applicationStatus');
    setState(() {
      applicationSattucController.text = applicationStatus;
    });
  }

  Future<String> fetchApplicationStatusFromApi(
    int stateId,
    int districtId,
    int role_id,
    String userid,
  ) async {
    const String url =
        'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_otherinfo';

    final Map<String, dynamic> params = {
      "userid": userid,
      "stateid": stateId,
      "districtid": districtId,
      "role_id": role_id,
    };
    print('@@Calling API: $url');
    print('@@With parameters: ${jsonEncode(params)}');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params),
      );

      print('@@Response status code: ${response.statusCode}');
      print('@@Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Decoded JSON: $jsonResponse');

        if (jsonResponse['status'] == true &&
            jsonResponse['data'] != null &&
            jsonResponse['data'].isNotEmpty) {
          final data = jsonResponse['data'][0];
          print('@@org_name: ${data['org_name']}');
          print('@@applicationStatus: ${data['applicationStatus']}');

          orgNameController.text = data['org_name'];
          applicationSattucController.text = data['applicationStatus'];
          return data['applicationStatus'] ?? '';
        } else {
          print('API returned no data or failed status.');
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return ''; // default empty if failed
    } catch (e) {
      print('Error fetching application status: $e');
      return '';
    }
  }

  Future<void> fetchUserType() async {
    const String url =
        'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_UserType';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({}),
      );

      print('@@Response status get usertype: ${response.statusCode}');
      print('@@Response body usertype: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final List<dynamic> dataList = jsonResponse['data'];
          setState(() {
            userTypeList = dataList.map((item) => {
              'type': item['type'].toString(),
              'status': item['status'].toString(),
            }).toList();

            if (userTypeList.isNotEmpty) {
              selectedUserType = userTypeList[0]['type'];
             // loginStatucController.text = userTypeList[0]['status'];
// Set the login status based on default selection
              final statusValue = userTypeList[0]['status'];
              loginStatucController.text = statusValue == '1' ? 'Active' : 'InActive';

              print('@@Default selectedUserType: $selectedUserType');
              print('@@Default loginStatucController: ${loginStatucController.text}');
            }
          });
        } else {
          print('No data or status false in response');
        }
      } else {
        print('API call failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching user type: $e');
    }
  }

  @override
  void dispose() {
    applicationSattucController.dispose();
    super.dispose();
  }
}
