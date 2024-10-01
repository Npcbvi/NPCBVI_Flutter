import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/HospitallinkedwithNGO.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/distictNgODashboard/NGODashboards.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/dropwdonHospitalBased/DropDownHospitalSelected.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/GetHospitalList.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/ViewClickHospitalDetails.dart';
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
  int dropDownTwoSelcted = 0;
  TextEditingController fullnameControllers = new TextEditingController();
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      _chosenValueMange,
      _chosenValueMangeTwo;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
  new TextEditingController();
  GetChangeAPsswordFieldss getchangePwds = new GetChangeAPsswordFieldss();

  final GlobalKey _dropdownKey = GlobalKey();
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  bool ManageUSerNGOHospt = false;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  Future<List<DataDropDownHospitalSelected>>
  _futureDataDropDownHospitalSelected;
  DataGetDPM_ScreeningYear _selectedUser;
  DataGetDPM_ScreeningMonth _selectedUserMonth;
  bool selectionBasedHospital = false;
  bool ngoDashboardclicks = false;
  Future<List<DataDropDownHospitalSelected>> dataDropDownHospitalSelected;
  DataDropDownHospitalSelected _selectHospitalSelected;
  String hospitalNameFetch, reghospitalNameFetch;
  int status, district_code_login, state_code_login;
  String role_id, darpan_nos;
  bool ngoDashboardDatas = false;
  String selectedHospitalName = ''; // String to save the selected value's name
  String hosID;
  String selectedHRegID; // This will store the selected hRegID
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();

    ngoDashboardclicks = true;
    _future = getDPM_ScreeningYear();
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
          getDarpanNo();
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

// Ensure this method is async
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

  Future<List<DataDropDownHospitalSelected>> GetHospitalNgoForDDL() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetHospitalNgoForDDL'),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode({
          "stateid": state_code_login,
          "districtid": district_code_login,
          "userId": userId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final DropDownHospitalSelected bindOrgan =
        DropDownHospitalSelected.fromJson(json);
        if (bindOrgan.status) {
          print('@@bindOrgan: ' + bindOrgan.message);
        }
        return bindOrgan.data;
      } else {
        // Handle the error if response status is not 200
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  void _showPopupMenu() async {
    final RenderBox dropdownRenderBox =
    _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
    Overlay
        .of(context)
        ?.context
        .findRenderObject() as RenderBox;

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
        ManageUSerNGOHospt = true;
        ngoDashboardclicks = false;
        _future = getDPM_ScreeningYear();


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
    Overlay
        .of(context)
        ?.context
        .findRenderObject() as RenderBox;

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
        ManageUSerNGOHospt = true;
        _future = getDPM_ScreeningYear();

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
    Overlay
        .of(context)
        ?.context
        .findRenderObject() as RenderBox;

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
          'Welcome ${fullnameController}',
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) =>
            [
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
                        setState(() {
                          print('@@dashboardviewReplace----display---');
                          _future = getDPM_ScreeningYear();
                          ngoDashboardclicks = true;
                          ManageUSerNGOHospt = false;
                        });
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
            ngoDashboardclick(),

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
            key: _dropdownKey,
            // Assign the key here
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
              _buildUserInfoItem(
                  'Login Type:', 'District NGO', Colors.black, Colors.red),
              _buildUserInfoItem('Login Id:', userId, Colors.black, Colors.red),
              _buildUserInfoItem(
                  'District:', districtNames, Colors.black, Colors.red),
              _buildUserInfoItem(
                  'State:', stateNames, Colors.black, Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(String label, String value, Color labelColor,
      Color valueColor) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
        Text(value,
            style: TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Hospitals List',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the tap event here
                              print('@@Add New Record clicked');

                              setState(() {

                              });
                            },
                            child: Text(
                              'Add New Hospital',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontWeight: FontWeight.w800, // Text weight
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Handle text overflow
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Horizontal Scrolling Table with Header and Data
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('Hospital ID'),
                        _buildHeaderCell('Hospital Name'),
                        _buildHeaderCell('Mobile No.'),
                        _buildHeaderCell('Email ID'),
                        _buildHeaderCell('Equipment'),
                        _buildHeaderCell('Doctors'),
                        _buildHeaderCell('MOU'),
                        _buildHeaderCell('Status'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetHospitalList>>(
                      future: ApiController.getHospitalList(
                          darpan_nos, district_code_login, userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataGetHospitalList> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.hRegID),
                                  _buildDataCell(offer.hName),
                                  _buildDataCell(offer.mobile),
                                  _buildDataCell(offer.emailId),
                                  _buildDataCell(offer.eqCount.toString()),
                                  _buildDataCell(offer.drcount.toString()),
                                  _buildDataCell(offer.moucount.toString()),
                                  _buildDataCell(offer.status.toString()),
                                  if (offer.status == 'Approved')

                                    _buildViewManageDoctorUploadMOUUI(
                                        offer.hRegID)
                                  // Pass hospitalId
                                  else
                                    if (offer.status == 'Pending')
                                      _buildEditMAnageDoctorUploadMOUUI()
                                    else
                                      _buildEdit(),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  void _storeHRegID(String hRegID) {
    setState(() {
      selectedHRegID = hRegID;
    });
    print('Stored hRegID: $selectedHRegID');
  }
  Widget buildInfoContainer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildDropdownHospitalType() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: 300,
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.blue.shade200),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _chosenValueMangeTwo,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'All',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  items: <String>['Hospitals', 'Camps', 'Satellite Centres']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueMangeTwo = value ?? 'All';
                      switch (_chosenValueMangeTwo) {
                        case 'Hospitals':
                          dropDownTwoSelcted = 6;
                          selectionBasedHospital = true;
                          _futureDataDropDownHospitalSelected =
                              GetHospitalNgoForDDL();
                          break;
                        case 'Camps':
                          dropDownTwoSelcted = 9;
                          selectionBasedHospital = false;
                          ngoDashboardDatas = false;
                          break;
                        case 'Satellite Centres':
                          dropDownTwoSelcted = 8;
                          selectionBasedHospital = false;
                          ngoDashboardDatas = false;
                          break;
                        default:
                          dropDownTwoSelcted = 0;
                          selectionBasedHospital = false;
                          ngoDashboardDatas = false;
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Show the second dropdown only if the selected value is "Hospitals"
                if (dropDownTwoSelcted == 6)
                  FutureBuilder<List<DataDropDownHospitalSelected>>(
                    future: _futureDataDropDownHospitalSelected,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      List<DataDropDownHospitalSelected> list =
                          snapshot.data ?? [];

                      // Handle case when the list is null or empty
                      if (list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: const Text(
                            'No data found',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        );
                      }

                      // Set the first item as default if none is selected
                      if (_selectHospitalSelected == null ||
                          !list.contains(_selectHospitalSelected)) {
                        _selectHospitalSelected = list.first;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select Hospital:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataDropDownHospitalSelected>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectHospitalSelected = userbindOrgan;
                                    hospitalNameFetch =
                                        userbindOrgan?.hName ?? '';
                                    reghospitalNameFetch =
                                        userbindOrgan?.hRegID ?? '';
                                  });
                                },
                                value: _selectHospitalSelected,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataDropDownHospitalSelected>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.hName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                dropdownColor: Colors.blue[50],
                                style: const TextStyle(color: Colors.black),
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ));
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

                      List<DataGetDPM_ScreeningYear> list =
                      snapshot.data.toList();

                      // Check if _selectedUser is null or not part of the list anymore
                      if (_selectedUser == null ||
                          !list.contains(_selectedUser)) {
                        _selectedUser =
                            list.first; // Set the first item as default
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select year:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                              value: _selectedUser,
                              onChanged: (userc) {
                                setState(() {
                                  _selectedUser = userc;
                                  getYearNgoHopital = userc?.name ?? '';
                                  getfyidNgoHospital = userc?.fyid ?? '';
                                  print('Selected Year: $getYearNgoHopital');
                                  print('FYID: $getfyidNgoHospital');
                                });
                              },
                              items: list.map((user) {
                                return DropdownMenuItem<
                                    DataGetDPM_ScreeningYear>(
                                  value: user,
                                  child: Text(user.name,
                                      style: TextStyle(fontSize: 16)),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              dropdownColor: Colors.blue[50],
                              style: TextStyle(color: Colors.black),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),
                buildInfoContainer(stateNames),
                SizedBox(height: 10),
                buildInfoContainer(districtNames),
                SizedBox(height: 10),
                buildDropdownHospitalType(),
                SizedBox(height: 10),
                //buildDropdownHospitalTypeHospialSelect(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Get button clicked');
                      setState(() {
                        // Update ngoDashboardDatas based on dropDownTwoSelcted value
                        // if (dropDownTwoSelcted == 6) {
                        ngoDashboardDatas = true;
                        /*   } else {
                          ngoDashboardDatas = false;
                        }*/
                      });
                    },
                    child: Text('Get Data'),
                  ),
                ),
                if(dropDownTwoSelcted == 6)
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
                                  'Total number of patients (${hospitalNameFetch})',
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
                              // Header Row
                              Row(
                                children: [
                                  _buildHeaderCell('Disease Type'),
                                  _buildHeaderCell('Registered'),
                                  _buildHeaderCell('Operated'),
                                ],
                              ),
                              Divider(color: Colors.blue, height: 1.0),
                              // Data Rows
                              FutureBuilder<List<DataNGODashboards>>(
                                future: ApiController.getNGODashboard(
                                    int.parse(role_id),
                                    district_code_login,
                                    state_code_login,
                                    userId,
                                    "2024-2025",
                                    dropDownTwoSelcted,
                                    reghospitalNameFetch),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Utils.getEmptyView(
                                        "Error: ${snapshot.error}");
                                  } else if (!snapshot.hasData ||
                                      snapshot.data.isEmpty) {
                                    return Utils.getEmptyView("No data found");
                                  } else {
                                    List<DataNGODashboards> ddata = snapshot
                                        .data;

                                    return Column(
                                      children: ddata.map((offer) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            _buildDataCell(offer.status),
                                            _buildDataCell(offer.registered),
                                            _buildDataCell(offer.operated),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                if(dropDownTwoSelcted == 9)
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildHeaderCell('Disease Type'),
                              _buildHeaderCell('Registered'),
                              _buildHeaderCell('Operated'),
                            ],
                          ),
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<DataNGODashboards>>(
                          future: ApiController.getNGODashboard(
                              int.parse(role_id),
                              district_code_login,
                              state_code_login,
                              userId,
                              "2024-2025",
                              dropDownTwoSelcted,
                              reghospitalNameFetch),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<DataNGODashboards> ddata = snapshot.data;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: ddata.map((offer) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      // Aligning to start for better control
                                      children: [
                                        _buildDataCell(offer.status),
                                        _buildDataCell(offer.registered),
                                        _buildDataCell(offer.operated),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                if(dropDownTwoSelcted == 8)
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildHeaderCell('Disease Type'),
                              _buildHeaderCell('Registered'),
                              _buildHeaderCell('Operated'),
                            ],
                          ),
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<DataNGODashboards>>(
                          future: ApiController.getNGODashboard(
                              int.parse(role_id),
                              district_code_login,
                              state_code_login,
                              userId,
                              "2024-2025",
                              dropDownTwoSelcted,
                              reghospitalNameFetch),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<DataNGODashboards> ddata = snapshot.data;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: ddata.map((offer) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      // Aligning to start for better control
                                      children: [
                                        _buildDataCell(offer.status),
                                        _buildDataCell(offer.registered),
                                        _buildDataCell(offer.operated),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
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

  Widget NGODashboardData() {
    return Column(
      children: [
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
                        'Total number of patients (${_selectHospitalSelected})',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Combined Horizontal Scrolling for Header and Data
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        _buildHeaderCell('Disease Type'),
                        _buildHeaderCell('Registered'),
                        _buildHeaderCell('Operated'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataNGODashboards>>(
                      future: ApiController.getNGODashboard(
                          int.parse(role_id),
                          district_code_login,
                          state_code_login,
                          userId,
                          "2024-2025",
                          dropDownTwoSelcted,
                          "0"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataNGODashboards> ddata = snapshot.data;

                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildDataCell(offer.status),
                                  _buildDataCell(offer.registered),
                                  _buildDataCell(offer.operated),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildHeaderCellSrNo(String text) {
    return Container(
      height: 40,
      width: 80, // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      //   padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      height: 40,
      width: 150, // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      //   padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      height: 80,
      width: 150,
      // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.1,
        ),
      ),
      // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlue(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNo(String text) {
    return Container(
      height: 80,
      width: 80, //
      // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.1,
        ),
      ),
      // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /* Widget _buildViewManageDoctorUploadMOUUI(String hospitalId) {
    return Container(
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('View', () async {
            print('View pressed');
            print('@@fff1--' + darpan_nos);
            print('@@fff1--' + hospitalId);
            print('@@fff1--' + district_code_login.toString());
            print('@@fff1--' + userId);

            try {
              // Call the API to view hospital details
              List<HospitalDetailsDataViewClickHospitalDetails> hospitalDetails = await viewHospitalDetails(
                "UP_2018_0184013",
                "H201963364948",
                district_code_login,
                userId,
              );

              // Check if hospitalDetails is not empty
              if (hospitalDetails.isNotEmpty) {
                HospitalDetailsDataViewClickHospitalDetails details = hospitalDetails[0];

                print('@@fff1--' + details.toString());



                // Call the dialog function with the fetched data

                _showDialogTableFormViewClickData(
                  darpanNo: details.darpanNo,
                  panNumber: details.panNo,
                  ngoName: details.ngoName,
                  memberName: details.name,
                  emailId: details.emailid,
                  mobileNumber: details.mobile,
                  address: details.address,
                  district: details.districtName,
                  state: details.stateName,

                );

              } else {
                Utils.showToast("No hospital details found or an error occurred", true);
              }
            } catch (e) {
              print('Error fetching hospital details: $e');
              Utils.showToast("Failed to fetch hospital details. Please try again later.", true);
            }
          }),
          _buildSeparator(),
          _buildButton('Manage Doctor', () {
            print('Manage Doctor pressed');
            // Logic for managing doctors
          }),
          _buildSeparator(),
          _buildButton('Upload MoU', () {
            print('Upload MoU pressed');
            // Logic for uploading MoU
          }),
        ],
      ),
    );
  }*/


  Widget _buildButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSeparator() {
    return Text(
      '||',
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    );
  }


  Widget _buildEditMAnageDoctorUploadMOUUI() {
    return Container(
        height: 80,
        width: 200,
        // Fixed width to ensure horizontal scrolling
        decoration: BoxDecoration(
          color: Colors.white, // Background color for header cells
          border: Border.all(
            width: 0.1,
          ),
        ),
        // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // Spaces the buttons evenly
          children: [
            // "View" Text Button
            GestureDetector(
              onTap: () {
                print('View pressed');
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            // Separator "||"
            Text(
              '||',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            // "Manage Doctor" Text Button
            GestureDetector(
              onTap: () {
                print('Manage Doctor pressed');
              },
              child: Text(
                'Manage Doctor',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            // Separator "||"
            Text(
              '||',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            // "Upload MoU" Text Button
            GestureDetector(
              onTap: () {
                print('Upload MoU pressed');
              },
              child: Text(
                'Upload MoU',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildEdit() {
    return Container(
        height: 80,
        width: 200,
        // Fixed width to ensure horizontal scrolling
        decoration: BoxDecoration(
          color: Colors.white, // Background color for header cells
          border: Border.all(
            width: 0.1,
          ),
        ),
        // padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // Spaces the buttons evenly
          children: [
            // "View" Text Button
            GestureDetector(
              onTap: () {
                print('View pressed');
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            // Separator "||"

          ],
        )
    );
  }

  Widget _buildViewManageDoctorUploadMOUUI(String hospitalId) {

    return Container(
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('View', () async {
            print('View pressed');
            print('@@fff1--' + darpan_nos);
            print('@@fff1--' + hospitalId);
            print('@@fff1--' + district_code_login.toString());
            print('@@fff1--' + userId);

            try {
              // Call the API to view hospital details and documents
              //getHospitalID();
              _storeHRegID(hospitalId); // Store hRegID when button is clicked
              print('@@hospButton clicked with hRegID: $hospitalId');
              ViewClickHospitalDetails viewClickHospitalDetails = await viewHospitalDetails(
                "UP_2018_0184013",
                hospitalId,
                district_code_login,
                userId,
              );

              // Check if the response status is true and hospitalDetails is not empty
              if (viewClickHospitalDetails.status &&
                  viewClickHospitalDetails.data.hospitalDetails.isNotEmpty) {
                HospitalDetailsDataViewClickHospitalDetails details = viewClickHospitalDetails
                    .data.hospitalDetails[0];

                print('@@fff1--' + details.toString());

                // Prepare documents for display
                List<
                    HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails> documents = viewClickHospitalDetails
                    .data.hospitalDocuments;

                // Call the dialog function with the fetched data
                _showDialogTableFormViewClickData(
                  darpanNo: details.darpanNo,
                  panNumber: details.panNo,
                  ngoName: details.ngoName,
                  memberName: details.name,
                  emailId: details.emailid,
                  mobileNumber: details.mobile,
                  address: details.address,
                  district: details.districtName,
                  state: details.stateName,
                  documents: documents,
                );
              } else {
                Utils.showToast(
                    "No hospital details found or an error occurred", true);
              }
            } catch (e) {
              print('Error fetching hospital details: $e');
              Utils.showToast(
                  "Failed to fetch hospital details. Please try again later.",
                  true);
            }
          }),
          _buildSeparator(),
          _buildButton('Manage Doctor', () {
            print('Manage Doctor pressed');
            // Logic for managing doctors
          }),
          _buildSeparator(),
          _buildButton('Upload MoU', () {
            print('Upload MoU pressed');
            // Logic for uploading MoU
          }),
        ],
      ),
    );
  }

  void _showDialogTableFormViewClickData({
    String darpanNo,
    String panNumber,
    String ngoName,
    String memberName,
    String emailId,
    String mobileNumber,
    String address,
    String district,
    String state,
    List<
        HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails> documents,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('NGO Application Details'),
          content: SingleChildScrollView(
            child: Container(
              width: 800, // Set width as per your requirement
              constraints: BoxConstraints(maxHeight: 600), // Adjust max height
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimal height
                children: [
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(65.0), // Width for labels
                      1: FixedColumnWidth(800.0), // Width for values
                    },
                    children: [
                      _buildTableRow('Darpan No.', darpanNo),
                      _buildTableRow('PAN Number', panNumber),
                      _buildTableRow('NGO Name', ngoName),
                      _buildTableRow('Member Name', memberName),
                      _buildTableRow('Email ID', emailId),
                      _buildTableRow('Mobile Number', mobileNumber),
                      _buildTableRow('Address', address),
                      _buildTableRow('District', district),
                      _buildTableRow('State', state),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      'List of documents to be verified',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Loop through documents and display them
                  if (documents != null && documents.isNotEmpty) ...[
                    Column(
                      children: [
                        for (var doc in documents)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            // Adjust padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Align text to the start
                              children: [
                                Text(
                                  '1. Minimum 3 years of experience certificate: ${doc
                                      .file1}',
                                  maxLines: 4,
                                  // Set max lines for file1
                                  overflow: TextOverflow.ellipsis,
                                  // Handle overflow
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Add some spacing between the texts
                                Text(
                                  '2. Society/Charitable public trust registration certificate: ${doc
                                      .file2}',
                                  maxLines: 4,
                                  // Set max lines for file2
                                  overflow: TextOverflow.ellipsis,
                                  // Handle overflow
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                  ] else
                    ...[
                      Text(
                        'No documents available.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Add your 'Next' button action here
                print('@@Next');
                print('@@NexthosID----'+hosID.toString());
                // _buildNExtClickHospitallinkedwithNGO(hosID);
              },
              child: Text('Next'),
            ),
          ],

        );
      },
    );
  }
  Future<void> getHospitalID() async {
    hosID = await SharedPrefs.getStoreSharedValue(AppConstant.hospitalId);
    print("@@@@NexthosID-------"+hosID);
  }

  Widget _buildNExtClickHospitallinkedwithNGO(String hospitalId) {
    return Container(
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('View', () async {

            print('View pressed');
            print('@@fff1--' + darpan_nos);
            print('@@fff1--' + hospitalId);
            print('@@fff1--' + district_code_login.toString());
            print('@@fff1--' + userId);

            try {
              // Call the API to view hospital details and documents
              HospitallinkedwithNGO hospitallinkedwithNGO = await getHospitalData(
                "UP_2018_0184013",
                hospitalId,
                district_code_login,
                userId,
              );

              // Check if the response status is true and hospitalDetails is not empty
              if (hospitallinkedwithNGO.status &&
                  hospitallinkedwithNGO.data.hospitalEquipmentList.isNotEmpty) {
                HospitalDatalinkedwithNGO details = hospitallinkedwithNGO.data
                    .hospitalData[0];

                print('@@fff1--' + details.toString());

                // Prepare documents for display
                List<HospitalEquipmentList> documents = hospitallinkedwithNGO
                    .data.hospitalEquipmentList;

                // Call the dialog function with the fetched data
                _showDialogNExtClickHospitallinkedwithNGO(
                  darpanNo: details.darpanNo,
                  panNumber: details.hName,
                  ngoName: details.nodalOfficerName,
                  memberName: details.mobile,
                  emailId: details.emailId,
                  mobileNumber: details.address,
                  address: details.districtName,
                  district: details.stateName,
                  state: details.pincode.toString(),
                  fax: details.fax,
                  documents: documents,
                );
              } else {
                Utils.showToast(
                    "No hospital details found or an error occurred", true);
              }
            } catch (e) {
              print('Error fetching hospital details: $e');
              Utils.showToast(
                  "Failed to fetch hospital details. Please try again later.",
                  true);
            }
          }),
          _buildSeparator(),
          _buildButton('Manage Doctor', () {
            print('Manage Doctor pressed');
            // Logic for managing doctors
          }),
          _buildSeparator(),
          _buildButton('Upload MoU', () {
            print('Upload MoU pressed');
            // Logic for uploading MoU
          }),
        ],
      ),
    );
  }

  void _showDialogNExtClickHospitallinkedwithNGO({
    String darpanNo,
    String panNumber,
    String ngoName,
    String memberName,
    String emailId,
    String mobileNumber,
    String address,
    String district,
    String state,
    int fax,

    List<HospitalEquipmentList> documents,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('NGO Application Details'),
          content: SingleChildScrollView(
            child: Container(
              width: 800, // Set width as per your requirement
              constraints: BoxConstraints(maxHeight: 600), // Adjust max height
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimal height
                children: [
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(65.0), // Width for labels
                      1: FixedColumnWidth(800.0), // Width for values
                    },
                    children: [
                      _buildTableRow('Darpan No.', darpanNo),
                      _buildTableRow('PAN Number', panNumber),
                      _buildTableRow('NGO Name', ngoName),
                      _buildTableRow('Member Name', memberName),
                      _buildTableRow('Email ID', emailId),
                      _buildTableRow('Mobile Number', mobileNumber),
                      _buildTableRow('Address', address),
                      _buildTableRow('District', district),
                      _buildTableRow('State', state),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      'List of documents to be verified',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Loop through documents and display them
                  if (documents != null && documents.isNotEmpty) ...[
                    Column(
                      children: [
                        for (var i = 0; i < documents.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              ],
                            ),
                          ),
                      ],
                    )
                  ] else
                    ...[
                      Text(
                        'No documents available.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Add your 'Next' button action here
                print('@@Next');
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildSeparatortwo() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.grey,
    );
  }

  Widget _buildButtontwo(String text, Function onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

// Helper function to create table rows
  TableRow _buildTableRowo(String label, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: 80), // Set max height for the label
          child: Text(
            label,
            maxLines: 3, // Set max lines for the label
            overflow: TextOverflow.ellipsis, // Handle overflow
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: 80), // Set max height for the value
          child: Text(
            value ?? 'N/A', // Use the passed variable
            maxLines: 3, // Set max lines for the value
            overflow: TextOverflow.ellipsis, // Handle overflow
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ]);
  }





  static Future<ViewClickHospitalDetails> viewHospitalDetails(
      String darpanNo,
      String hospitalId,
      int districtId,
      String userId,
      ) async {
    print("@@GetHospitalList - Initiating request");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return ViewClickHospitalDetails(message: "No internet", status: false);
    }

    try {
      // Define the URL and headers
      final url = "${ApiConstants.baseUrl}${ApiConstants.VeiwHospitalDetails}";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "darpanNo": darpanNo,
        "hospitalId": hospitalId,
        "districtId": districtId,
        "userId": userId,
      });
      print("@@GetHospitalList - Request Body: $body");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetHospitalList - API Response: ${response.data}");

      // Parse the response
      var responseData = json.decode(response.data);
      ViewClickHospitalDetails data = ViewClickHospitalDetails.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the entire ViewClickHospitalDetails object
        return data; // Return the whole object instead of just the hospital details
      } else {
        Utils.showToast(data.message, true);
        return ViewClickHospitalDetails(message: data.message, status: false);
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return ViewClickHospitalDetails(message: "Error occurred", status: false);
    }
  }

  static Future<HospitallinkedwithNGO> getHospitalData(
      String darpanNo,
      String hospitalId,
      int districtId,
      String userId,
      ) async {
    print("@@HospitallinkedwithNGO - Initiating request");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return HospitallinkedwithNGO(message: "No internet", status: false);
    }

    try {
      // Define the URL and headers
      final url = "${ApiConstants.baseUrl}${ApiConstants.GetHospitalData}";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "darpanNo": darpanNo,
        "hospitalId": hospitalId,
        "districtId": districtId,
        "userId": userId,
      });
      print("@@HospitallinkedwithNGO - Request Body: $body");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@HospitallinkedwithNGO - API Response: ${response.data}");

      // Parse the response
      var responseData = json.decode(response.data);
      HospitallinkedwithNGO data = HospitallinkedwithNGO.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the entire ViewClickHospitalDetails object
        return data; // Return the whole object instead of just the hospital details
      } else {
        Utils.showToast(data.message, true);
        return HospitallinkedwithNGO(message: data.message, status: false);
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return HospitallinkedwithNGO(message: "Error occurred", status: false);
    }
  }

}


class GetChangeAPsswordFieldss {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}
