import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/AddEyeBankNGO/AddEyeBank.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/DoctorlinkedwithHospital.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetAllNgoService.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetDoctorDetailsById.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/HospitallinkedwithNGO.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ManageDoctor.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/UploadedMOU/UploadMOUNGO.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/distictNgODashboard/NGODashboards.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/dropwdonHospitalBased/DropDownHospitalSelected.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/GetHospitalList.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/ViewClickHospitalDetails.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/GetCampManagerDetailsByIdEditData.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/NgoCampMangerList.dart';
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
  String role_id, darpan_nos, entryby, ngoNames;
  bool ngoDashboardDatas = false;
  String selectedHospitalName = ''; // String to save the selected value's name
  String selectedHRegID;
  String storedValueHospitalID;

  bool EyeBankApplication = false;
  bool ngoCampManagerLists = false;
  bool CampManagerRegisterartions = true; // This should be based on your logic
  String userName = '';
  String mobileNumber = '';
  String emailId = '';
  String address = '';
  String designation = '';
  String gender = 'Male'; // Default gender
  final _formKey = GlobalKey<FormState>();

  // Controllers for TextFormFields
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailIdController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _designationController = TextEditingController();

  // Gender state variable
  bool CampManagerRegisterartionsEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    getUserData();

    ngoDashboardclicks = true;
    EyeBankApplication = false;
    ngoCampManagerLists = false;
    CampManagerRegisterartions = false;
    CampManagerRegisterartionsEdit=false;
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
          getentryby();
          ngoName();
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

  Future<void> ngoName() async {
    // Use await to get the actual value from SharedPrefs
    ngoNames =
        await SharedPrefs.getStoreSharedValue(AppConstant.ngoName) as String;

    if (ngoNames != null) {
      print("ngoNames Number: $ngoNames");
    } else {
      print("No ngoNames found in shared preferences.");
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
        ManageUSerNGOHospt = true;
        ngoDashboardclicks = false;
        EyeBankApplication = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;
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
        print("@@Camp Manager");
        _future = getDPM_ScreeningYear();
        EyeBankApplication = false;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = true;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;

        break;
      case 2:
        print("@@Screeniong Camp");
        _future = getDPM_ScreeningYear();
        EyeBankApplication = true;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;
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
        EyeBankApplication = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;
        break;
      case 2:
        print("@@Satellite Center");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = true;
        EyeBankApplication = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;
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
                        setState(() {
                          print('@@dashboardviewReplace----display---');
                          _future = getDPM_ScreeningYear();
                          ngoDashboardclicks = true;
                          ManageUSerNGOHospt = false;
                          EyeBankApplication = false;
                          ngoCampManagerLists = false;
                          CampManagerRegisterartions = false;
                          CampManagerRegisterartionsEdit=false;
                        });
                      }),
                      SizedBox(width: 8.0),
                      _buildDropdown(),
                      SizedBox(width: 8.0),
                      _buildNavigationButton('Add Eye Bank', () {
                        print('@@Add Eye Bank Clicked');
                        setState(() {
                          EyeBankApplication = true;
                          ngoDashboardclicks = false;
                          ManageUSerNGOHospt = false;
                          ngoCampManagerLists = false;
                          CampManagerRegisterartions = false;
                          CampManagerRegisterartionsEdit=false;
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),
            _buildUserInfo(),
            LowVisionRegisterNgoHopsital(),
            ngoDashboardclick(),
            EyeBankApplicationNgo(),
            ngoCampManagerList(),
            AddCampManager(),
            EditCampManager(),
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

  Widget _buildUserInfoItem(
      String label, String value, Color labelColor, Color valueColor) {
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

/*  Widget LowVisionRegisterNgoHopsital() {
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
                              overflow:
                              TextOverflow.ellipsis, // Handle text overflow
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
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
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetHospitalList>>(
                future: ApiController.getHospitalList(
                    darpan_nos, district_code_login, userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Utils.getEmptyView("No data found");
                  } else {
                    List<DataGetHospitalList> ddata = snapshot.data;
                    print('@@---ddata' + ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              if(offer.status == 'Approved')
                                _buildViewMAnageDoctorUploadMOUUI()
                              else
                                if (offer.status == 'Pending')
                                  _buildEditMAnageDoctorUploadMOUUI()
                                else
                                  _buildEdit()
                              */ /* _buildDataCellViewBlue("Edit", () {
                                // Handle the edit action here
                                // For example, navigate to an edit screen or show a dialog
                                print(
                                    '@@Edit clicked for item: ');
                                //   Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);



                              }),*/ /*
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
    );
  }*/
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

                              setState(() {});
                            },
                            child: Text(
                              'Add New Hospital',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontWeight: FontWeight.w800, // Text weight
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle text overflow
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
                                    // Store locally
                                    _buildViewManageDoctorUploadMOUUI(
                                        offer.hRegID) // Pass hospitalId
                                  else if (offer.status == 'Pending')
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

  Widget EyeBankApplicationNgo() {
    return Column(
      children: [
        Visibility(
          visible: EyeBankApplication,
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
                            'Eye Bank Application',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                        _buildHeaderCell('Eye Bank ID'),
                        _buildHeaderCell('Eye Bank Name'),
                        _buildHeaderCell('Member Name'),
                        _buildHeaderCell('Email'),
                        _buildHeaderCell('Status'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataAddEyeBank>>(
                      future: ApiController.getEyeBankDonationList(
                          state_code_login, district_code_login, userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataAddEyeBank> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.eyeBankUniqueID),
                                  _buildDataCell(offer.eyebankName),
                                  _buildDataCell(offer.officername),
                                  _buildDataCell(offer.emailid),
                                  _buildDataCell(offer.status.toString()),
                                  if (offer.status == 'Approved')
                                    // Store locally
                                    _buildMAnageEyeDonationMOUUI()
                                  else if (offer.status == 'Pending')
                                    _buildMAnageEyeDonationMOUUI()
                                  else
                                    _buildMAnageEyeDonationMOUUI(),
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

  Widget ngoCampManagerList() {
    return Column(
      children: [
        Visibility(
          visible: ngoCampManagerLists,
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
                            'CAMP MANAGER DETAILS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: _addCampManager,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Add Camp Manager',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        _buildHeaderCell('NGO Name'),
                        _buildHeaderCell('User Id'),
                        _buildHeaderCell('Officer Name'),
                        _buildHeaderCell('Mobile Number'),
                        _buildHeaderCell('Email id'),
                        _buildHeaderCell('Address'),
                        _buildHeaderCell('Designation'),
                        _buildHeaderCell('Update/Block'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataNgoCampMangerList>>(
                      future: ApiController.getCampManagerList(
                          state_code_login, district_code_login, entryby),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataNgoCampMangerList> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.managerName),
                                  _buildDataCell(offer.userId),
                                  _buildDataCell(offer.managerName),
                                  _buildDataCell(offer.mobile),
                                  _buildDataCell(offer.emailId.toString()),
                                  _buildDataCell(offer.address.toString()),
                                  _buildDataCell(offer.designation.toString()),
                                  _buildEditCampMabgerList(
                                      int.parse(offer.srNo))
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

  void _addCampManager() {
    // Handle the tap event here
    print('Add Camp Manager tapped!');
    setState(() {
      ManageUSerNGOHospt = false;
      ngoDashboardclicks = false;
      EyeBankApplication = false;
      ngoCampManagerLists = false;
      CampManagerRegisterartions = true;
      CampManagerRegisterartionsEdit=false;
    });
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
                if (dropDownTwoSelcted == 6)
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
                                    getYearNgoHopital,
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
                                    List<DataNGODashboards> ddata =
                                        snapshot.data;

                                    return Column(
                                      children: ddata.map((offer) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                              getYearNgoHopital,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                if (dropDownTwoSelcted == 8)
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
                              getYearNgoHopital,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
        ));
  }

  Widget _buildMAnageEyeDonationMOUUI() {
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
                print('MOU pressed');
              },
              child: Text(
                'MOU',
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
                print('Manage Eye Donation');
              },
              child: Text(
                'Manage Eye Donation',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            // Separator "||"
          ],
        ));
  }

  Widget _buildMAnageEDITDELETE() {
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
                print('MOU pressed');
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
                print('Manage Eye Donation');
              },
              child: Text(
                'Delete',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            // Separator "||"
          ],
        ));
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
        ));
  }

  Widget _buildEditCampMabgerList(int sR_No) {
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
            _buildButton('Edit', () async {
              print('View pressed');

              try {
                // Call the API to view camp manager details
                GetCampManagerDetailsByIdEditData
                    getCampManagerDetailsByIdEditDatas =
                    await ApiController.getCampManagerDetailsById(
                  sR_No,
                  entryby, // Assuming `userId` is the correct entryBy parameter
                );

                // Check if the response is not null and status is true
                if (getCampManagerDetailsByIdEditDatas != null &&
                    getCampManagerDetailsByIdEditDatas.status) {
                  print(getCampManagerDetailsByIdEditDatas
                      .message); // Success message
                  getCampManagerDetailsByIdEditDatas.data.forEach((manager) {
                    print('Manager Name: ${manager.managerName}');
                    // Initialize the controllers with the provided values
                    _userNameController = TextEditingController(text: manager.managerName);
                    _mobileNumberController = TextEditingController(text: manager.mobile);
                    _emailIdController = TextEditingController(text: manager.emailId);
                    _addressController = TextEditingController(text: manager.address);
                    _designationController = TextEditingController(text: manager.designation);
                    // Access other fields as needed
                    setState(() {
                      CampManagerRegisterartionsEdit = true;
                      ManageUSerNGOHospt = false;
                      ngoDashboardclicks = false;
                      EyeBankApplication = false;
                      ngoCampManagerLists = false;
                      CampManagerRegisterartions = false;

                    });
                  });

                  // Prepare documents for display

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
          ],
        ));
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
              _storeHRegID(hospitalId);
              // Call the API to view hospital details and documents
              ViewClickHospitalDetails viewClickHospitalDetails =
                  await viewHospitalDetails(
                darpan_nos,
                hospitalId,
                district_code_login,
                userId,
              );

              // Check if the response status is true and hospitalDetails is not empty
              if (viewClickHospitalDetails.status &&
                  viewClickHospitalDetails.data.hospitalDetails.isNotEmpty) {
                HospitalDetailsDataViewClickHospitalDetails details =
                    viewClickHospitalDetails.data.hospitalDetails[0];

                print('@@fff1--' + details.toString());

                // Prepare documents for display
                List<HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails>
                    documents = viewClickHospitalDetails.data.hospitalDocuments;

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
            print('@@fff1--Manage' + darpan_nos);
            print('@@fff1--Manage' + hospitalId);
            print('@@fff1--Manage' + district_code_login.toString());
            print('@@fff1--Manage' + userId);
            print('Manage Doctor pressed');
            _showNgoManageDoctore(hospitalId, district_code_login);

            // Logic for managing doctors
          }),
          _buildSeparator(),
          _buildButton('Upload MoU', () {
            print('@@Upload MoU pressed');
            _showNgoGetUploadedMouList(
                hospitalId, district_code_login, int.parse(role_id));

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
    List<HospitalDocumentsHospitalDetailsDataViewClickHospitalDetails>
        documents,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'NGO Application Details',
            textAlign: TextAlign.center, // Optional: center the title text
            style: TextStyle(
              fontWeight: FontWeight.bold, // Optional: styling
              color: Colors.white, // Set title text color to blue
            ), // Optional: styling
          ),
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
                                  '1. Minimum 3 years of experience certificate: ${doc.file1}',
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
                                  '2. Society/Charitable public trust registration certificate: ${doc.file2}',
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
                  ] else ...[
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
                print('@@NextClick HIDget---' + selectedHRegID);
                _fetchAndShowHospitalData(context, selectedHRegID);
                //  _buildNExtClickHospitallinkedwithNGO(selectedHRegID);
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _storeHRegID(String hRegID) async {
    // Ensure hRegID is not null or empty
    if (hRegID == null || hRegID.isEmpty) {
      print('hRegID is null or empty. Cannot store it.');
      return;
    }

    setState(() {
      selectedHRegID = hRegID;

      // Store the hospital ID in shared preferences
      SharedPrefs.storeSharedValues(
        AppConstant.hospitalId,
        selectedHRegID,
      );
    });

    // Retrieve the stored value to verify it's been saved correctly
    storedValueHospitalID =
        await SharedPrefs.getStoreSharedValue(AppConstant.hospitalId);

    // Check if the retrieved value matches the stored value
    if (storedValueHospitalID == selectedHRegID) {
      print('Successfully stored and retrieved hRegID: $storedValueHospitalID');
    } else {
      print(
          'Error: Stored value does not match. Expected: $selectedHRegID, Got: $storedValueHospitalID');
    }

    // Print the stored hRegID
    print('Stored hRegID: $selectedHRegID');
  }

  TableRow _buildTableRowtwo(String label, String value) {
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
  TableRow _buildTableRow(String label, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: 80),
          // Set max height for the label
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
          constraints: BoxConstraints(maxHeight: 80),
          // Set max height for the value
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

  TableRow _buildTableRowth(String label, String value, String values) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            // Remove max height for better text display
            child: Text(
              label,
              maxLines: 5, // Set max lines for the label
              overflow: TextOverflow.ellipsis, // Handle overflow
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500, // Make label bolder
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            // Remove max height for better text display
            child: Text(
              value.isNotEmpty ? value : 'N/A',
              // Use isNotEmpty for additional checks
              maxLines: 5, // Set max lines for the value
              overflow: TextOverflow.ellipsis, // Handle overflow
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            // Remove max height for better text display
            child: Text(
              values.isNotEmpty ? values : 'N/A',
              // Use isNotEmpty for additional checks
              maxLines: 5, // Set max lines for the value
              overflow: TextOverflow.ellipsis, // Handle overflow
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
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
      ViewClickHospitalDetails data =
          ViewClickHospitalDetails.fromJson(responseData);

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
    String hospitalId,
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
        "hospitalId": hospitalId,
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

  Future<void> _fetchAndShowHospitalData(
      BuildContext context, String hospitalId) async {
    try {
      HospitallinkedwithNGO hospitalData = await getHospitalData(hospitalId);

      if (hospitalData.status) {
        // Show the dialog with the received data
        _showDialogWithData(context, hospitalData);
      } else {
        Utils.showToast("No hospital details found or an error occurred", true);
      }
    } catch (e) {
      print('Error: $e');
      Utils.showToast(
          "Failed to fetch hospital details. Please try again later.", true);
    }
  }

  void _showDialogWithData(BuildContext context, HospitallinkedwithNGO data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'Hospital(s) linked with NGO',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to blue
              ), // Optional: styling
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 2000),
              // Set max height for the dialog content
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(60.0),
                      1: FixedColumnWidth(300.0), // Adjust as needed
                    },
                    children: [
                      _buildTableRow(
                          'Darpan No.', data.data.hospitalData[0].darpanNo),
                      _buildTableRow(
                          'Hospital Name', data.data.hospitalData[0].hName),
                      _buildTableRow('Officer Name',
                          data.data.hospitalData[0].nodalOfficerName),
                      _buildTableRow(
                          'Mobile No.', data.data.hospitalData[0].mobile),
                      _buildTableRow(
                          'Email ID', data.data.hospitalData[0].emailId),
                      _buildTableRow(
                          'Address', data.data.hospitalData[0].address),
                      _buildTableRow(
                          'District', data.data.hospitalData[0].districtName),
                      _buildTableRow(
                          'State', data.data.hospitalData[0].stateName),
                      _buildTableRow('Pin Code',
                          data.data.hospitalData[0].pincode.toString()),
                      _buildTableRow(
                          'Fax No.', data.data.hospitalData[0].fax.toString()),
                    ],
                  ),
                  SizedBox(height: 10), // Add some space between the tables
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      'List of Equipment',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(40.0),
                      1: FlexColumnWidth(60),
                      2: FlexColumnWidth(20),
                    },
                    children: [
                      _buildTableRowth(
                          'S.No', 'Equipment Name', 'Number of Equipment'),
                      for (int i = 0;
                          i < data.data.hospitalEquipmentList.length;
                          i++)
                        _buildTableRowth(
                          (i + 1).toString(),
                          data.data.hospitalEquipmentList[i].name,
                          data.data.hospitalEquipmentList[i].noOfEquipment
                              .toString(),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('@@fromshareValueGet--' + storedValueHospitalID);
                // Handle any additional logic for the Next button
                //  _storeHRegID(hospitalId);

                showDoctorlinkedwithHospital(context, storedValueHospitalID);
              },
              child: Text('Next'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Previous'),
            ),
          ],
        );
      },
    );
  }

  void showDoctorlinkedwithHospital(BuildContext context, String hospitalId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'Doctor(s) linked with Hospita',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to blue
              ), // Optional: styling
            ),
          ),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Combined Horizontal Scrolling for Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('Doctor ID'),
                            _buildHeaderCell('Doctor Name'),
                            _buildHeaderCell('Mobile No.'),
                            _buildHeaderCell('Email ID'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<DataDoctorlinkedwithHospital>>(
                          future: ApiController.getDoctorlinkedwithHospital(
                              hospitalId),
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
                              List<DataDoctorlinkedwithHospital> ddata =
                                  snapshot.data;
                              print('@@---ddata: ' + ddata.length.toString());
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.mcIID),
                                      _buildDataCell(offer.dName.toString()),
                                      _buildDataCell(offer.mobile.toString()),
                                      _buildDataCell(offer.emailId.toString()),
                                      _buildDataCellViewBlue("View", () async {
                                        print(
                                            "@@Doctor Details: " + offer.mcIID);
                                        print('@@fromshareValueGet--' +
                                            storedValueHospitalID);

                                        List<DataGetDoctorDetailsById>
                                            doctorDetails = await ApiController
                                                .getDoctorDetailsById(
                                                    storedValueHospitalID,
                                                    offer.mcIID);

                                        // Show doctor details dialog if data is available
                                        if (doctorDetails.isNotEmpty) {
                                          _showDoctorDetailsDialog(
                                              context, doctorDetails[0]);
                                        } else {
                                          Utils.showToast(
                                              "No details found for this doctor.",
                                              true);
                                        }
                                      }),
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDoctorDetailsDialog(
      BuildContext context, DataGetDoctorDetailsById doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'Doctor Details',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to blue
              ), // Optional: styling
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('MCI ID', doctor.mcIID),
                _buildDetailRow('Hospital Name', 'test eye care'),
                // Replace with real data if available
                _buildDetailRow('Doctor Name', doctor.dName),
                _buildDetailRow('Gender', doctor.gender ?? 'N/A'),
                // Replace with real data
                _buildDetailRow('DOB', doctor.dob ?? 'N/A'),
                // Replace with real data
                _buildDetailRow('Mobile Number', doctor.mobile ?? 'N/A'),
                _buildDetailRow('Email ID', doctor.emailId ?? 'N/A'),
                _buildDetailRow('District Name', doctor.districtName ?? 'N/A'),
                // Replace with real data
                _buildDetailRow('State Name', doctor.stateName ?? 'N/A'),
                // Replace with real data
                _buildDetailRow('Pin Code', doctor.pincode ?? 'N/A'),
                // Replace with real data
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Next'),
              onPressed: () async {
                // Navigator.of(context).pop();
                List<DataGetAllNgoService> doctorDetails =
                    await ApiController.getAllNgoService(userId);

                // Show doctor details dialog if data is available
                if (doctorDetails.isNotEmpty) {
                  _showNgoServiceDetailsDialog();
                } else {
                  Utils.showToast("No details found for this doctor.", true);
                }
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNgoServiceDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'NGO Application Details',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to white
              ),
            ),
          ),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // Horizontal scrolling for both Header and Data Rows
                  Row(
                    children: [
                      // Header Row
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('Component'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataGetAllNgoService>>(
                    future: ApiController.getAllNgoService(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Utils.getEmptyView("No data found");
                      } else {
                        List<DataGetAllNgoService> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(
                              children: [
                                _buildDataCellSrNo(
                                    (ddata.indexOf(offer) + 1).toString()),
                                _buildDataCell(offer.name),
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNgoManageDoctore(String hospitalId, int districtId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'Doctors Detail',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to white
              ),
            ),
          ),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // Horizontal scrolling for both Header and Data Rows
                  Row(
                    children: [
                      // Header Row
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('MCI ID'),
                      _buildHeaderCell('Hospital Id'),
                      _buildHeaderCell('Doctor Name'),
                      _buildHeaderCell('Mobile No.'),
                      _buildHeaderCell('Email ID'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('Action'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataManageDoctor>>(
                    future: ApiController.getDoctorListByHId(
                      hospitalId,
                      districtId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Utils.getEmptyView("No data found");
                      } else {
                        List<DataManageDoctor> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(
                              children: [
                                _buildDataCellSrNo(
                                    (ddata.indexOf(offer) + 1).toString()),
                                _buildDataCell(offer.mcIID),
                                _buildDataCell(offer.hRegID),
                                _buildDataCell(offer.dName),
                                _buildDataCell(offer.mobile),
                                _buildDataCell(offer.emailId),
                                _buildDataCell(offer.status),
                                /* if (offer.status == 'Approved')
                                // Store locally
                                  _buildMAnageEDITDELETE(
                                     */ /* offer.hRegID*/ /*) // Pass hospitalId
                                else
                                  if (offer.status == 'Pending')
                                    _buildMAnageEDITDELETE()
                                  else
                                    _buildMAnageEDITDELETE(),
*/
                                _buildDataCellViewBlue("View", () async {
                                  print('@@Pending work---'); // Pass hospitalId
                                }),
                                /*  if (offer.status == 'Approved')
                                // Store locally
                                  _buildMAnageEDITDELETE(
                                      ) // Pass hospitalId
                                else
                                  if (offer.status == 'Pending')
                                    _buildMAnageEDITDELETE()
                                  else
                                    _buildMAnageEDITDELETE(),*/
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNgoGetUploadedMouList(
      String hospitalId, int districtId, int userRoleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            // Make title container span the full width
            padding: const EdgeInsets.only(bottom: 8.0),
            // Optional: padding for spacing
            child: Text(
              'Uploaded MOU',
              textAlign: TextAlign.center, // Optional: center the title text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Optional: styling
                color: Colors.white, // Set title text color to white
              ),
            ),
          ),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // Horizontal scrolling for both Header and Data Rows
                  Row(
                    children: [
                      // Header Row
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('Id'),
                      _buildHeaderCell('From Date'),
                      _buildHeaderCell('To Date'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('MOU'),
                      _buildHeaderCell('Action'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataUploadMOUNGO>>(
                    future: ApiController.getUploadedMouList(
                        hospitalId, districtId, userRoleId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Utils.getEmptyView("No data found");
                      } else {
                        List<DataUploadMOUNGO> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(
                              children: [
                                _buildDataCellSrNo(
                                    (ddata.indexOf(offer) + 1).toString()),
                                _buildDataCell(offer.hRegID),
                                _buildDataCell(
                                    Utils.formatDateString(offer.fromDate)),
                                _buildDataCell(
                                    Utils.formatDateString(offer.toDate)),
                                _buildDataCell(offer.name),
                                _buildDataCell(offer.file),
                                if (offer.vstatus == '3')
                                  _buildDataCell('Download'),
                                _buildDataCellViewBlue("RENEW", () async {
                                  print("@@Doctor Details: ");

                                  // Show doctor details dialog if data is available
                                }),
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'N/A', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  TableRow _buildTableRowthree(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }

// Widget for Camp Manager Registration Form
  // Function to reset form fields
  void _resetForm() {
    _userNameController.clear();
    _mobileNumberController.clear();
    _emailIdController.clear();
    _addressController.clear();
    _designationController.clear();
    setState(() {
      gender = null; // Reset gender selection
    });
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
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Camp Manager Registration',
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _userNameController, // Attach controller
                          decoration: InputDecoration(
                            labelText: 'User Name*',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

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
                        SizedBox(height: 16.0),

                        // Mobile Number Field
                        TextFormField(
                          controller: _mobileNumberController,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Mobile No.*',
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
                        SizedBox(height: 16.0),

                        // Email ID Field
                        TextFormField(
                          controller: _emailIdController, // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Email ID*',
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
                        SizedBox(height: 16.0),

                        // Address Field
                        TextFormField(
                          controller: _addressController, // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Address*',
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

                        // Designation Field
                        TextFormField(
                          controller: _designationController,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Designation',
                          ),
                        ),
                        SizedBox(height: 16.0),

                        // Submit and Cancel Buttons
                        Row(
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget EditCampManager() {
    return Column(
      children: [
        Visibility(
          visible: CampManagerRegisterartionsEdit, // Change this to your actual condition
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
                          'Camp Manager Registration',
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                            labelText: 'User Name*',
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

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
                        SizedBox(height: 16.0),

                        // Mobile Number Field
                        TextFormField(
                          controller: _mobileNumberController,
                          decoration: InputDecoration(
                            labelText: 'Mobile No.*',
                            hintText: 'Enter your mobile number',
                            border: OutlineInputBorder(),
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
                        SizedBox(height: 16.0),

                        // Email ID Field
                        TextFormField(
                          controller: _emailIdController,
                          decoration: InputDecoration(
                            labelText: 'Email ID*',
                            hintText: 'Enter your email address',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

                        // Address Field
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Address*',
                            hintText: 'Enter your address',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

                        // Designation Field
                        TextFormField(
                          controller: _designationController,
                          decoration: InputDecoration(
                            labelText: 'Designation',
                            hintText: 'Enter your designation',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        // Submit and Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  // Process the form data
                                  _campManagerRegistrationEdit();
                                }
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
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }

// API call method for Camp Manager Registration
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
        EyeBankApplication = true;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = true;
        CampManagerRegisterartions = false;
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }
  Future<void> _campManagerRegistrationEdit() async {
    if (_formKey.currentState.validate()) {
      Utils.showProgressDialog1(context);

      var response = await ApiController.updateCampManager(
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
      if (response.message == "Camp Manager Details Updated Successfully.") {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----Class: " + response.message);
        EyeBankApplication = false;
        ngoDashboardclicks = false;

        ManageUSerNGOHospt = false;
        ngoCampManagerLists = true;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit=false;
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }
}

class GetChangeAPsswordFieldss {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}
