import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningMonth.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
class NgoDashboard extends StatefulWidget {
  @override
  _NgoDashboard createState() => _NgoDashboard();
}

class _NgoDashboard extends State<NgoDashboard> {
  TextEditingController fullnameControllers = new TextEditingController();
  String _chosenValue,districtNames,userId,stateNames;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
  new TextEditingController();
  GetChangeAPsswordFieldss getchangePwds = new GetChangeAPsswordFieldss();

  final GlobalKey _dropdownKey = GlobalKey();
  String _chosenValueLOWVision = "Manage Users";
  String fullnameController,getYearNgoHopital,getfyidNgoHospital;
  bool ManageUSerNGOHospt = false;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  DataGetDPM_ScreeningMonth _selectedUserMonth;

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
          districtNames= user.districtName;
          stateNames=user.stateName;
          userId= user.userId;
          print('@@-0----2'+user.name);
          print('@@-0----3'+fullnameController);
        });
      });
    } catch (e) {
      print(e);
    }
  }


  void _showPopupMenu() async {
    final RenderBox dropdownRenderBox =
    _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
    Overlay.of(context)?.context.findRenderObject() as RenderBox;

    // Check if both render boxes are not null
    if (dropdownRenderBox == null || overlayRenderBox == null) {
      return;
    }

    final RelativeRect position = RelativeRect.fromRect(
      dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
      Offset.zero & overlayRenderBox.size,
    );

    await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Text("Add Ngo Hospital"),
        ),
        // Add more PopupMenuItem if needed
      ],
      elevation: 8.0,
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleMenuSelection(selectedValue);
      }
    });
  }
  void _handleMenuSelection(int value) {
    switch (value) {
      case 1:
        print("@@Add Ngo Hospital");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        break;

    // Add more cases as needed
      default:
        print("Unknown selection");
    }
  }

  void _showPopupMenuScreeningCamp() async {
    final RenderBox dropdownRenderBox =
    _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
    Overlay.of(context)?.context.findRenderObject() as RenderBox;

    // Check if both render boxes are not null
    if (dropdownRenderBox == null || overlayRenderBox == null) {
      return;
    }

    final RelativeRect position = RelativeRect.fromRect(
      dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
      Offset.zero & overlayRenderBox.size,
    );

    await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Text("Camp Manager"),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text("Screening Camp"),
        ),
        // Add more PopupMenuItem if needed
      ],
      elevation: 8.0,
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleMenuSelectionScreeninCamp(selectedValue);
      }
    });
  }
  void _handleMenuSelectionScreeninCamp(int value) {
    switch (value) {
      case 1:
        print("@@Add Ngo Hospital");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        break;
      case 2:
        print("@@Screeniong Camp");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        break;
    // Add more cases as needed
      default:
        print("Unknown selection");
    }
  }

  void _showPopupMenuSatteliteCenter() async {
    final RenderBox dropdownRenderBox =
    _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
    Overlay.of(context)?.context.findRenderObject() as RenderBox;

    // Check if both render boxes are not null
    if (dropdownRenderBox == null || overlayRenderBox == null) {
      return;
    }

    final RelativeRect position = RelativeRect.fromRect(
      dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
      Offset.zero & overlayRenderBox.size,
    );

    await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Text("Satellite Manager"),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text("Satellite Center"),
        ),
        // Add more PopupMenuItem if needed
      ],
      elevation: 8.0,
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleMenuSelectionSatelliteCamp(selectedValue);
      }
    });
  }
  void _handleMenuSelectionSatelliteCamp(int value) {
    switch (value) {
      case 1:
        print("@@Satellite Camp");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        break;
      case 2:
        print("@@Satellite Center");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        break;
    // Add more cases as needed
      default:
        print("Unknown selection");
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
          'Welcome ${fullnameController}', // Assuming fullnameController has .text
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
                  _showChangePasswordDialog();
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
                        print('@@dashboardviewReplace----display---');
                        setState(() {});
                      }),
                      SizedBox(width: 8.0),
                      _buildDropdown(),
                      SizedBox(width: 8.0),
                      _buildNavigationButton('Add Eye Bank', () {
                        print('@@Add Eye Bank Clicked');
                        setState(() {});
                      }),
                    ],
                  ),
                ),
              ),
            ),
            _buildUserInfo(),
            LowVisionRegisterNgoHopsital(),
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

  Widget _buildDropdown() {
    return Container(
      width: 170.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue.shade200,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: _dropdownKey, // Assign the key here
            focusColor: Colors.white,
            value: _chosenValue,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.white,
            items: <String>[
              'NGO Hospital',
              'Screening Camp',
              'Sattelite Center',
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
              "Manage Users",
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
                if (_chosenValue == "NGO Hospital") {
                  print('@@NGO---Hospital--1 $_chosenValue');
                  _showPopupMenu();
                } else if (_chosenValue == "Screening Camp") {
                  print('@@Screening--1 $_chosenValue');
                  _showPopupMenuScreeningCamp();
                } else if (_chosenValue == "Sattelite Center") {
                  print('@@Sattelite--1 $_chosenValue');
                  _showPopupMenuSatteliteCenter();
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
              _buildUserInfoItem('Login Type:', 'District NGO', Colors.black, Colors.red),
              _buildUserInfoItem('Login Id:', userId, Colors.black, Colors.red),
              _buildUserInfoItem('District:', districtNames, Colors.black, Colors.red),
              _buildUserInfoItem('State:', stateNames, Colors.black, Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(String label, String value, Color labelColor, Color valueColor) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: labelColor, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
        Text(value, style: TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
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
                _submitchangePAsswordApi();
                // Implement your password change logic here
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _submitchangePAsswordApi() async {
    print('@@EntryPoimt heres');
    getchangePwds.userid = userId;
    getchangePwds.oldPassword = _oldPasswordControllere.text.toString().trim();
    getchangePwds.newPassword = _newPasswordontrollere.text.toString().trim();
    getchangePwds.confirmPassword =
        _confirmnPasswordontrollere.text.toString().trim();
    print('@@EntryPoimt heres---22' +
        getchangePwds.oldPassword +
        getchangePwds.confirmPassword);

    print('@@EntryPoimt heres---2' +
        getchangePwds.userid +
        getchangePwds.oldPassword +
        getchangePwds.newPassword +
        getchangePwds.confirmPassword);
    if (getchangePwds.oldPassword.isEmpty) {
      Utils.showToast("Please enter old Password !", false);
      return;
    }
    if (getchangePwds.newPassword.isEmpty) {
      Utils.showToast("Please enter new Password !", false);
      return;
    }
    if (getchangePwds.confirmPassword.isEmpty) {
      Utils.showToast("Please enter confirm Password !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.ngochangePAssword(getchangePwds).then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@response_loginScreen ---' + response.toString());
            if (response != null && response.status) {
              Utils.showToast(response.message, true);
              Navigator.of(context).pop(); // Close the dialog
            } else {
              Utils.showToast(response.message, true);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }
  Widget LowVisionRegisterNgoHopsital() {
    return Column(
      children: [
        Visibility(
          visible: ManageUSerNGOHospt,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            print('Hospitals List');
                            // Handle the action here (e.g., navigate to a new screen)
                          },

                          child: Text(
                            'Hospitals List',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            print('@@Congenital Ptosis clicked');
                            setState(() {
                              // Add any additional logic needed here
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Back',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.0),

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

                    var list = snapshot.data;
                    if (_selectedUser == null || !list.contains(_selectedUser)) {
                      _selectedUser = list.isNotEmpty ? list.first : null;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select year:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) {
                              setState(() {
                                _selectedUser = userc;
                                getYearNgoHopital = userc?.name ?? '';
                                getfyidNgoHospital = userc?.fyid ?? '';
                                print('@@getYearNgoHopital-- $getYearNgoHopital');
                                print('@@getfyidNgoHospital here---- $getfyidNgoHospital');
                              });
                            },
                            value: _selectedUser,
                            items: list.map((user) {
                              return DropdownMenuItem<DataGetDPM_ScreeningYear>(
                                value: user,
                                child: Text(
                                  user.name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            dropdownColor: Colors.blue[50],
                            style: TextStyle(color: Colors.black),
                            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 8.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print('@@lowvisionCornealBlindnessDataDispla-- click------');
                    setState(() {
                      // Add any additional logic needed here
                    });
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}
class GetChangeAPsswordFieldss {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}
