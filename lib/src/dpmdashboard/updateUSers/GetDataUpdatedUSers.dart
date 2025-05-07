import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

import '../../database/SharedPrefs.dart';

class GetDataUpdatedUSers extends StatefulWidget {
  @override
  _GetDataUpdatedUSers createState() => _GetDataUpdatedUSers();
}

class _GetDataUpdatedUSers extends State<GetDataUpdatedUSers> {
  TextEditingController userIdController = TextEditingController();
  String entryby,_chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController;
  int status, district_code_login, state_code_login;
  String role_id,ngoNames;
  void updateUser() {
    String userId = userIdController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a User ID")),
      );
      return;
    }else{

    }

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
                                  style: TextStyle(color: Colors.grey, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red, fontSize: 16),
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
                                padding: EdgeInsets.symmetric(horizontal: 8), // control padding
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
                  SizedBox(height: 5),
             /*     Container(
                    margin:
                    EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: userIdController,
                        decoration: InputDecoration(
                          labelText: ngoNames.isNotEmpty
                              ? ngoNames
                              : 'Enter State',
                          // Conditional label
                          hintText: ngoNames.isNotEmpty
                              ? ''
                              : 'Please provide State',
                          // Hint text when label is empty
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // Ensures the label floats when focused or filled
                          filled: true,
                          // Add a background color
                          fillColor: Colors.white,

                          // Light background color to indicate non-editable state
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border when not focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border color when disabled
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 2),
                            // Border when focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          labelStyle: TextStyle(color: Colors.black
                            // Label color when the field is focused
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey, // Hint text color
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red, // Set the text color to red
                        ),
                        enabled: false,
                        // Makes the field non-editable
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter State';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),*/
                  SizedBox(height: 5),
               /*   Container(
                    margin:
                    EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: userIdController,
                        decoration: InputDecoration(
                          labelText: ngoNames.isNotEmpty
                              ? ngoNames
                              : 'Enter District',
                          // Conditional label
                          hintText: ngoNames.isNotEmpty
                              ? ''
                              : 'Please provide District',
                          // Hint text when label is empty
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // Ensures the label floats when focused or filled
                          filled: true,
                          // Add a background color
                          fillColor: Colors.white,

                          // Light background color to indicate non-editable state
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border when not focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border color when disabled
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 2),
                            // Border when focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          labelStyle: TextStyle(color: Colors.black
                            // Label color when the field is focused
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey, // Hint text color
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red, // Set the text color to red
                        ),
                        enabled: false,
                        // Makes the field non-editable
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter District';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'User Name',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter User Name',
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
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Orgnisation Name',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Orgnisation Name',
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
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Mobile No.',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Mobile No.',
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
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Email Id',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Email Id',
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
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50, // Adjust height as needed
                    child: TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        label: RichText(
                          text: TextSpan(
                            text: 'Address',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' *', // Asterisk for required field
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Address',
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
                  SizedBox(height: 5),
         /*         Container(
                    margin:
                    EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: userIdController,
                        decoration: InputDecoration(
                          labelText: ngoNames.isNotEmpty
                              ? ngoNames
                              : 'Enter Login Status',
                          // Conditional label
                          hintText: ngoNames.isNotEmpty
                              ? ''
                              : 'Please provide Login Status',
                          // Hint text when label is empty
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // Ensures the label floats when focused or filled
                          filled: true,
                          // Add a background color
                          fillColor: Colors.white,

                          // Light background color to indicate non-editable state
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border when not focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border color when disabled
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 2),
                            // Border when focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          labelStyle: TextStyle(color: Colors.black
                            // Label color when the field is focused
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey, // Hint text color
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red, // Set the text color to red
                        ),
                        enabled: false,
                        // Makes the field non-editable
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Login Status';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),*/
                  SizedBox(height: 5),
             /*     Container(
                    margin:
                    EdgeInsets.fromLTRB(5, 0, 5, 0), // Add margin here

                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: userIdController,
                        decoration: InputDecoration(
                          labelText: ngoNames.isNotEmpty
                              ? ngoNames
                              : 'Enter Application Status',
                          // Conditional label
                          hintText: ngoNames.isNotEmpty
                              ? ''
                              : 'Please provide Application Status',
                          // Hint text when label is empty
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // Ensures the label floats when focused or filled
                          filled: true,
                          // Add a background color
                          fillColor: Colors.white,

                          // Light background color to indicate non-editable state
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border when not focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                            // Border color when disabled
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 2),
                            // Border when focused
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners
                          ),
                          labelStyle: TextStyle(color: Colors.black
                            // Label color when the field is focused
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey, // Hint text color
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red, // Set the text color to red
                        ),
                        enabled: false,
                        // Makes the field non-editable
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Application Status';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),*/
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
