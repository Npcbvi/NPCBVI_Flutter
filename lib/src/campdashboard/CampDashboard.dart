import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginsignup/LoginScreen.dart';
import 'package:http/http.dart' as http;

import '../model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'CampAddPatient.dart';

class CampDashboard extends StatefulWidget {
  final dynamic responseResult;

  const CampDashboard({Key key, this.responseResult}) : super(key: key); // Or use a specific type if you know it
  @override
  _CampDashboard createState() => _CampDashboard();
}

class _CampDashboard extends State<CampDashboard> {
  bool ngoDashboardDatas = false;
  int dropDownTwoSelcted = 0;
  bool selectionCampHospital = false;

  String districtNames, userId, stateNames, fullnameController, role_id,_chosenValue,
      getYearNgoHopital, getfyidNgoHospital;
  int status, district_code_login, state_code_login;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
  new TextEditingController();
  bool ngoDashboardclicks = false;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  String hospitalNameFetch, reghospitalNameFetch,_chosenValueMangeTwo,ngoid;


  @override
  void initState() {
    super.initState();
    getUserData();
    _future = getDPM_ScreeningYear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ngoDashboardDatas = true;
        ngoDashboardclicks = true;
      });
    });
  }

  Future<void> getUserData() async {
    try {
      final storedNgoId = await SharedPrefs.getStoreSharedValue(AppConstant.ngoid); // get ngoid from shared prefs

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
          //getentryby();
          // getloggedInNgoId();
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());

          print('@@storedNgoId ' + storedNgoId.toString());
          // Assuming you fetch the value from login or a previous screen
          String reportingPlace =
              fullnameController; // Replace with actual value
         // _reportingPlaceController.text = reportingPlace;
        });
      });
    } catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Welcome ' + '${fullnameController}',
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
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.black), // Black icon
                    SizedBox(width: 10),
                    Text(
                      "Change Password",
                      style: TextStyle(color: Colors.black), // Black text
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.book, color: Colors.black), // Black icon
                    SizedBox(width: 10),
                    Text(
                      "User Manual",
                      style: TextStyle(color: Colors.black), // Black text
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black), // Black icon
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.black), // Black text
                    ),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            // White background
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                _showChangePasswordDialog();
              } else if (value == 2) {
                // Implement User Manual action
              } else if (value == 3) {
                setState(() {
                  showLogoutDialog();
                });
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.white), // Menu icon color
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
            margin: EdgeInsets.all(8.0), // Set the margin here
            child: ListView(
              children: [


                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    setState(() {
                      print('@@dashboardviewReplace----display---');

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
                        print('@@Camp---Add Patient--1 $_chosenValue');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CampAddPatient()),
                        );
                        //_showPopupMenu();
                      } else if (_chosenValue == "Update Patient") {

                      } else if (_chosenValue == "Screening Entry") {
                      }
                    });

                  //  Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body:SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Login Type & District Container
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5), // Adds spacing on both sides
                    child: Row(
                      children: [
                        _buildInfoColumn("Login Type", "Camp Manager"),
                        SizedBox(width: 5),
                        _buildInfoColumn("District", districtNames),
                      ],
                    ),
                  ),

                  SizedBox(width: 5), // Space between columns

                  // State Container
                  _buildInfoColumn("State", stateNames),


                  SizedBox(width: 5), // Space between columns

                  // Login ID Container
                  _buildInfoColumn("Login Id", userId),
                ],
              ),
            ),
            ngoDashboardclick(),
          ],
        ),
      ),
    );
  }
  /// A helper function to create reusable labeled text columns.
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
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Old Password',
                ),
                controller: _oldPasswordControllere,
                obscureText: true,
              ),
              TextField(
                controller: _newPasswordontrollere,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
              TextField(
                controller: _confirmnPasswordontrollere,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
             //   _submitchangePAsswordApi();
                // Implement your password change logic here
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
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
    List<Map<String, dynamic>> items, // List of maps with text and icon
    Function(String) onChanged,
    Icon hintIcon, // Hint Icon (nullable)
    double dropdownWidth = 120.0, // Width of the dropdown
  }) {
    double textSize = 14.0; // Smaller text size for dropdown items

    return Container(
      width: dropdownWidth, // Custom width
      padding: EdgeInsets.symmetric(horizontal: 8), // Padding for better styling

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: key,
          value: value,
          style: TextStyle(color: Colors.black, fontSize: textSize), // Smaller text
          dropdownColor: Colors.white,
          isExpanded: true, // Ensure text fits within the box
          items: items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4), // Reduce vertical padding
                child: Row(
                  children: [
                    Icon(item['icon'], color: Colors.black, size: textSize), // Smaller icon
                    SizedBox(width: 8.0), // Space between icon and text
                    Text(item['value'], style: TextStyle(color: Colors.black, fontSize: textSize)),
                  ],
                ),
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
            children: [
              hintIcon, // Only add if not null
              SizedBox(width: 8.0), // Space
              Text(hint, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: textSize)),
            ],
          )
              : Text(hint, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: textSize)),
          onChanged: onChanged,
        ),
      ),
    );
  }
  Widget ngoDashboardclick() {
    return Row(
      children: [
        Visibility(
          visible: ngoDashboardclicks,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0), // Match the hospital dropdown
                  child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }

                      List<DataGetDPM_ScreeningYear> list = snapshot.data;
                      if (_selectedUser == null || !list.contains(_selectedUser)) {
                        _selectedUser = null;
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_selectedUser == null || !list.contains(_selectedUser)) {
                          setState(() {
                            _selectedUser = list.first;
                            getYearNgoHopital = _selectedUser.name;
                            getfyidNgoHospital = _selectedUser.fyid;
                          });
                        }
                      });

                      return SizedBox(
                        height: 50, // Match height
                        child: DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                          value: _selectedUser,
                          isExpanded: true,
                          onChanged: (userc) {
                            setState(() {
                              _selectedUser = userc;
                              getYearNgoHopital = userc?.name ?? '';
                              getfyidNgoHospital = userc?.fyid ?? '';
                            });
                          },
                          items: list.map((user) {
                            return DropdownMenuItem<DataGetDPM_ScreeningYear>(
                              value: user,
                              child: Text(
                                user.name,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                          buttonStyleData: ButtonStyleData(
                            height: 50,

                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            offset: const Offset(0, -3),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),


                SizedBox(height: 5),
                buildDropdownHospitalType(),
                SizedBox(height: 5),
                //buildDropdownHospitalTypeHospialSelect(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Validate if a dropdown value is selected
                      // Show a validation message if no value is selected
                      // No validation, proceed with the action
                      print('@@Get button clicked');
                      setState(() {
                        ngoDashboardclicks = true;
                        ngoDashboardDatas = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15), // Rounded corners
                      ),
                      elevation: 5, // Adds a shadow effect
                    ),
                    icon: Icon(Icons.cloud_download, size: 20), // Download icon
                    label: Text(
                      'Get Data',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                if (dropDownTwoSelcted == 0)
                  Visibility(
                    visible: dropDownTwoSelcted == 0 && ngoDashboardDatas,
                    // Only show if the condition is met
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
                                  'Total number of patients (${hospitalNameFetch ?? "All"})',
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
                              // Data Rows
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (dropDownTwoSelcted == 6)
                  Visibility(
                    visible: dropDownTwoSelcted == 6 && ngoDashboardDatas,
                    // Only show if the condition is met
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
                                  'Total number of patients (${hospitalNameFetch ?? "Camps"})',
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
                              // Data Rows
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                if (dropDownTwoSelcted == 9)
                  Visibility(
                    visible: ngoDashboardDatas,
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
                                  'Patients registered in Camps',
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
// Data Rows
                      ],
                    ),
                  ),
                if (dropDownTwoSelcted == 8)
                  Visibility(
                    visible: ngoDashboardDatas,
                    // Only show the table when ngoDashboardDatas is true
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
                                  'Patients registered in Satellite Centres',
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
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
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
  Widget buildDropdownHospitalType() {

    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: SizedBox(
        height: 50,
        child: DropdownButtonFormField2<String>(
          value: _chosenValueMangeTwo,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
            hintText: 'All',
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          buttonStyleData: ButtonStyleData(
            height: 50,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            offset: const Offset(0, -3),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          ),
          items: <String>['Hospitals', 'Camps', 'Satellite Centres'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (String value) {
            setState(() {

              _chosenValueMangeTwo = value ?? 'All';
              print('@@_chosenValueMangeTwo-- $_chosenValueMangeTwo');

              switch (_chosenValueMangeTwo) {
                case 'Hospitals':
                  dropDownTwoSelcted = 6;
                  selectionCampHospital = true;
                //  _futureDataDropDownHospitalSelected = GetHospitalNgoForDDL();
                  break;
                case 'Camps':
                  dropDownTwoSelcted = 9;
                  selectionCampHospital = false;
                  ngoDashboardDatas = false;
                  break;
                case 'Satellite Centres':
                  dropDownTwoSelcted = 8;
                  selectionCampHospital = false;
                  ngoDashboardDatas = false;
                  break;
                case 'All':
                  dropDownTwoSelcted = 0;
                  selectionCampHospital = true;
                  ngoDashboardDatas = true;
               //   _futureDataDropDownHospitalSelected = GetHospitalNgoForDDL();
                  break;
              }
            });
          },
        ),
      ),
    );
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
}
