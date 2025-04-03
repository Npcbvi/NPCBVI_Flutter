import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginsignup/LoginScreen.dart';

class CampDashboard extends StatefulWidget {
  @override
  _CampDashboard createState() => _CampDashboard();
}

class _CampDashboard extends State<CampDashboard> {
  String districtNames, userId, stateNames, fullnameController, role_id,_chosenValue;
  int status, district_code_login, state_code_login;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
  new TextEditingController();
  @override
  void initState() {
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
          //getentryby();
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
            icon: Icon(Icons.more_vert, color: Colors.black), // Menu icon color
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
                        print('@@NGO---Hospital--1 $_chosenValue');

                        //_showPopupMenu();
                      } else if (_chosenValue == "Update Patient") {

                      } else if (_chosenValue == "Screening Entry") {
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body:SingleChildScrollView(
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



}
