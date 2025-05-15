import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/updateUSers/GetDataUpdatedUSers.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

import '../../database/SharedPrefs.dart';
import '../../model/dpmRegistration/updateUsers/GetDPM_Edit_UpdateUserDetail.dart';

class UpdateUserDPMMenu extends StatefulWidget {
  @override
  _UpdateUserDetailsScreenState createState() => _UpdateUserDetailsScreenState();
}

class _UpdateUserDetailsScreenState extends State<UpdateUserDPMMenu> {
  Future<List<DataGetDPM_Edit_UpdateUserDetail>> dataGetDPM_Edit_UpdateUserDetail;
  TextEditingController userIdController = TextEditingController();
String entryby,_chosenValue,
    districtNames,
    userId,
    stateNames,
    fullnameController;
  int status, district_code_login, state_code_login;
  String role_id;
  void updateUser() {
    String userId = userIdController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a User ID")),
      );
      return;
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetDataUpdatedUSers(),
        ),
      );
    }

    // TODO: Implement update user API call
    print("Updating user with ID: $userId");


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
      appBar: AppBar(title: Text("Update Users")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center Row contents
              children: [
                // Login Type and District in a Row
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5), // Margin for spacing
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20), // Space between Login Type and District
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
                            '${stateNames}', // Use actual districtNames variable here
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
                  margin: EdgeInsets.only(right: 10), // Right margin for spacing
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
                        '${districtNames}', // Use actual stateNames variable here
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // User ID Field
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 5),
                    SizedBox(
                      height: 50, // Adjust height as needed
                      child: TextField(
                        controller: userIdController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'Enter User ID',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: ' *', // Asterisk for required field
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter User ID',
                          // Border styles for enabled and focused states
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Grey border
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1), // Blue border when focused
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: SizedBox(
                        height: 40, // Same height
                        child: ElevatedButton(
                          onPressed: () {
                            print('Get button clicked');

                              updateUser();
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
                  ],
                ),
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
}
