import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMEyeSchoolScreens.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningMonth.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankDonationApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeSurgeons.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/SPODashboardDPMClickView.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ApprovedclickPatients.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_DiseasewiseRecordsApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_Patients_Approved_View.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOApprovalClick.dart';
import 'package:mohfw_npcbvi/src/spo/ListNGOApprovalWidget.dart';
import 'package:mohfw_npcbvi/src/spo/ListNGOPendingWidget.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class SpoDashboard extends StatefulWidget {
  @override
  _SpoDashboard createState() => _SpoDashboard();
}

class _SpoDashboard extends State<SpoDashboard> {
  int statusApproved = 2;
  int statusPending = 1;
  DataDsiricst _selectedUserDistrict;
  int stateCodeSPO,
      disrtcCode,
      stateCodeDPM,
      stateCodeGovtPrivate,
      distCodeDPM,
      distCodeGovtPrivate;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  TextEditingController fullnameControllers = new TextEditingController();
  String _chosenValue, districtNames, userId, stateNames, _chosenValueMange;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
      new TextEditingController();
  GetChangeAPsswordFieldsss getchangePwds = new GetChangeAPsswordFieldsss();
  double cellWidth = 100.0; // Set desired width
  double cellHeight = 40.0; // Set desired height
  final GlobalKey _dropdownKey = GlobalKey();
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  bool ManageUSerNGOHospt = false;
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  DataGetDPM_ScreeningMonth _selectedUserMonth;
  int status, district_code_login, state_code_login;
  String role_id;
  bool isLoadingApi = true;
  bool ngoDashboardclicks = false;
  String currentFinancialYear;
  String _chosenValueLOWVision, _chosenEyeBank, _chosenValueLgoutOption;
  bool dashboardviewReplace = false;
  bool LsitNGO_APPorovedClickShowData = false;

  bool eyeBankApprovals = false;
  bool RegisteredEyesurgeonsEstimateTargetAllocations = false;
  bool SPOLcikONDPMMEnus = false;
  bool RegisteredEyesurgeon = false;

  bool eyeBankDonationApprovals = false;

  bool eyeBankCollections = false;
  String ngoCountApproved,
      ngoCountPending,
      totalPatientApproved,
      totalPatientPending,
      gH_CHC_Count,
      gH_CHC_Count_Pending,
      ppCount,
      ppCount_pending,
      pmcCount,
      pmcCountPending,
      campCompletedCount,
      campongoingCount,
      campCommingCount,
      campCount,
      satellitecentreCount,
      patientCount;
  String ngo_application_name;
  Future<List<EyeSurgeonsData>> _futures;
  bool isSubmitPressed = false; // Track button press

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardviewReplace = true;

    _getSPOashbnoardData();
    _futures = ApiController.getSPO_RegisteredEyesurgeonList(100, "NPCBTT");
  }

  void _getSPOashbnoardData() {
    getUserData();
    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog(context);
        try {
          final response = await ApiController.getSPO_dashboard(
              district_code_login,
              state_code_login,
              569,
              userId,
              role_id,
              status,
              currentFinancialYear);
          Utils.hideProgressDialog(context);
          if (response.status) {
            setState(() {
              ngoCountApproved = response.data.ngoCount;
              ngoCountPending = response.data.ngoPendingCount;
              totalPatientApproved = response.data.totalPatientApproved;
              totalPatientPending = response.data.totalPatientPending;
              gH_CHC_Count = response.data.gHCHCCount;
              gH_CHC_Count_Pending = response.data.gHCHCCountPending;
              ppCount = response.data.ppCount;
              ppCount_pending = response.data.ppCountPending;
              pmcCount = response.data.pmcCount;
              pmcCountPending = response.data.pmcCountPending;
              campCompletedCount = response.data.campCompletedCount;
              campongoingCount = response.data.campongoingCount;
              campCommingCount = response.data.campCommingCount;
              campCount = response.data.campCount;
              satellitecentreCount = response.data.satellitecentreCount;
              patientCount = response.data.patientCount;
              print('@@After Api hit===' +
                  ngoCountApproved +
                  "====" +
                  ngoCountPending);
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = response.message;
            });
            Utils.showToast(response.message, true);
          }
        } catch (e) {
          setState(() {
            _isLoading = false;
            _hasError = true;
            _errorMessage = e.toString();
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = AppConstant.noInternet;
        });
        Utils.showToast(AppConstant.noInternet, true);
      }
    });
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

  String getCurrentFinancialYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int nextYear = currentYear + 1;
    String financialYear;

    if (now.month >= 4) {
      // Financial year starts in April
      financialYear = '$currentYear-${nextYear.toString().substring(2)}';
    } else {
      financialYear =
          '${currentYear - 1}-${currentYear.toString().substring(2)}';
    }

    return financialYear;
  }

  @override
  Widget build(BuildContext context) {
    currentFinancialYear = getCurrentFinancialYear();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Welcome ' + '${fullnameController}',
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
                    Icon(Icons.lock),
                    SizedBox(width: 10),
                    Text("Change Password")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.book),
                    SizedBox(width: 10),
                    Text("User Manual")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text("Logout")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                _showChangePasswordDialog();
              } else if (value == 2) {
                // Implement User Manual action
              } else if (value == 3) {
                setState(() {
                  showLogoutDialog();

                  /* dashboardviewReplace = false;
                  chnagePAsswordView = true;*/
                });
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: 100.0,  // Set the width of the drawer
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(8.0), // Reduce the margin to decrease space// Set the margin here
            child: ListView(
              children: [

                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    setState(() {
                      dashboardviewReplace = true;
                      SPOLcikONDPMMEnus = false;
                      RegisteredEyesurgeon = false;
                      RegisteredEyesurgeonsEstimateTargetAllocations=false;
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.assignment,
                  title: 'DPMs',
                  onTap: () {
                    setState(() {
                      dashboardviewReplace = false;
                      SPOLcikONDPMMEnus = true;
                      RegisteredEyesurgeon = false;
                      RegisteredEyesurgeonsEstimateTargetAllocations=false;
                      eyeBankApprovals=false;
                      eyeBankDonationApprovals=false;
                      eyeBankCollections=false;
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  value: _chosenValue,
                  hint: 'Update',
                  hintIcon: Icon(Icons.update, color: Colors.black), // Add an icon to the hint
                  items: [
                    {'value': 'Eye surgeons', 'icon': Icons.person},
                    {'value': 'Estimate Target Allocation', 'icon': Icons.assignment},
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValue == "Eye surgeons") {
                        print('@@NGO--1' + _chosenValue);
                        dashboardviewReplace = false;
                        SPOLcikONDPMMEnus = false;
                        RegisteredEyesurgeon = true;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=false;
                      } else if (_chosenValue ==
                          "Estimate Target Allocation") {
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=true;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=false;
                      }
                    });
                  },
                ),
                _buildDropdownItem(
                  value: _chosenValueLOWVision,
                  hint: 'Eye Bank Approval',
                  hintIcon: Icon(Icons.local_hospital, color: Colors.black), // Add an icon to the hint
                  items: [
                    {'value': 'Eye Bank', 'icon': Icons.local_hospital},
                    // Add an icon here
                    {'value': 'Eye Donation', 'icon': Icons.healing},
                    // Add an icon here
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueLOWVision = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValueLOWVision == "Eye Bank") {
                        print('@@NGO--1' + _chosenValueLOWVision);
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=false;
                        eyeBankApprovals=true;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=false;
                      } else if (_chosenValueLOWVision ==
                          "Eye Donation") {
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=false;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=true;
                        eyeBankCollections=false;
                      }
                    });
                  },
                ),
                _buildDropdownItem(
                  value: _chosenEyeBank,
                  hint: 'Application(s)',
                  hintIcon: Icon(Icons.apps, color: Colors.black), // Add an icon to the hint
                  items: [
                    {'value': 'Eye Bank Collection', 'icon': Icons.collections},
                    {'value': 'Eye Donation', 'icon': Icons.healing},
                    {
                      'value': 'Eyeball Collection Via Eye Bank',
                      'icon': Icons.add_circle_outline
                    },
                    {
                      'value': 'Eyeball Collection Via Eye Donation Center',
                      'icon': Icons.center_focus_weak
                    },
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenEyeBank = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenEyeBank == "Eye Bank Collection") {
                        print('@@NGO--1' + _chosenEyeBank);
                        dashboardviewReplace = false;
                        eyeBankApprovals=false;
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=false;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=true;
                      } else if (_chosenEyeBank == "Eye Donation") {
                        dashboardviewReplace = false;
                        eyeBankApprovals=false;
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=false;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=true;
                      } else if (_chosenEyeBank ==
                          "Eyeball Collection Via Eye Bank") {
                        dashboardviewReplace = false;
                        eyeBankApprovals=false;
                        dashboardviewReplace = false;
                        RegisteredEyesurgeon = false;
                        RegisteredEyesurgeonsEstimateTargetAllocations=false;
                        eyeBankApprovals=false;
                        eyeBankDonationApprovals=false;
                        eyeBankCollections=true;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('@@SpoDashboardview----display---');
                          //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                          setState(() {
                            dashboardviewReplace = true;
                            SPOLcikONDPMMEnus = false;
                            RegisteredEyesurgeon = false;
                            RegisteredEyesurgeonsEstimateTargetAllocations=false;
                          });
                        },
                        child: Container(
                          width: 80.0,
                          child: Text(
                            'Dashboard',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          print('@@DPMClickSPo----display---');
                          //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                          setState(() {
                            dashboardviewReplace = false;
                            SPOLcikONDPMMEnus = true;
                            RegisteredEyesurgeon = false;
                            RegisteredEyesurgeonsEstimateTargetAllocations=false;
                            eyeBankApprovals=false;
                            eyeBankDonationApprovals=false;
                            eyeBankCollections=false;
                          });
                        },
                        child: Container(
                          width: 80.0,
                          child: Text(
                            'DPMs',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.0), // Add spacing between widgets
                      Container(
                        width: 190.0,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenValue,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Eye surgeons',
                                'Estimate Target Allocation',

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
                                "Update",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValue = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenValue == "Eye surgeons") {
                                    print('@@NGO--1' + _chosenValue);
                                    dashboardviewReplace = false;
                                    SPOLcikONDPMMEnus = false;
                                    RegisteredEyesurgeon = true;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=false;
                                  } else if (_chosenValue ==
                                      "Estimate Target Allocation") {
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=true;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=false;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),


                      Container(
                        width: 170.0,
                        key: _dropdownKey,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenValueLOWVision,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Eye Bank',
                                'Eye Donation',

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
                                "Eye Bank Approval",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValueLOWVision = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenValueLOWVision == "Eye Bank") {
                                    print('@@NGO--1' + _chosenValueLOWVision);
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=false;
                                    eyeBankApprovals=true;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=false;
                                  } else if (_chosenValueLOWVision ==
                                      "Eye Donation") {
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=false;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=true;
                                    eyeBankCollections=false;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 8.0),
                      Container(
                        width: 300,
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: DropdownButtonHideUnderline(

                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenEyeBank,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: <String>[
                                'Eye Bank Collection',
                                'Eye Donation',
                                'Eyeball Collection Via Eye Bank',
                                'Eyeball Collection Via Eye Donation Center',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Application(s)",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenEyeBank = value;
                                  //  print('@@spinnerChooseValue--' + _chosenValue);
                                  if (_chosenEyeBank == "Eye Bank Collection") {
                                    print('@@NGO--1' + _chosenEyeBank);
                                    dashboardviewReplace = false;
                                    eyeBankApprovals=false;
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=false;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=true;
                                  } else if (_chosenEyeBank == "Eye Donation") {
                                    dashboardviewReplace = false;
                                    eyeBankApprovals=false;
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=false;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=true;
                                  } else if (_chosenEyeBank ==
                                      "Eyeball Collection Via Eye Bank") {
                                    dashboardviewReplace = false;
                                    eyeBankApprovals=false;
                                    dashboardviewReplace = false;
                                    RegisteredEyesurgeon = false;
                                    RegisteredEyesurgeonsEstimateTargetAllocations=false;
                                    eyeBankApprovals=false;
                                    eyeBankDonationApprovals=false;
                                    eyeBankCollections=true;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Shown Captcha value to user
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              print('Text clicked!');
                              // Add your desired action here, e.g., navigation, alert, etc.
                            },
                            child: Text(
                              'PNJA Dashboard:',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                            child: Text(
                          'Login Type:',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            child: Text(
                          'STATE PROGRAM OFFICER',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        )),
                        const SizedBox(
                          width: 10,
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Shown Captcha value to user
                                  Container(
                                      child: Text(
                                    'Login ID:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      child: Text(
                                    '${userId}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Container(
                                      child: Text(
                                    'State :',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      child: Text(
                                    '${stateNames}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                                ],
                              ),
                            ),
                          ),
                        ),

                        //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: dashboardviewReplace,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Container(
                            height: 160,
                            width: double.infinity,
                            decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFF78CA0), // #f78ca0 at 0%
                                Color(0xFFF9748F), // #f9748f at 19%
                                Color(0xFFFD868C), // #fd868c at 60%
                                Color(0xFFFE9A8B), // #fe9a8b at 100%
                              ],
                              stops: [
                                0.0,
                                0.19,
                                0.6,
                                1.0
                              ], // Define the color stops
                            )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      'Patient(s) ($currentFinancialYear)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Divider(color: Colors.grey, height: 1.0),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20.0, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                '@@---ApprovedPatient(s) (2024-2025) APproved par Dialog');
                                            showDiseaseDialogApprovedPatintFinance();
                                          },
                                          child: new Text(
                                            'Approved',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20.0, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                '@@---Patient(s) (2024-2025) Pending for Dialog');
                                            showDiseaseDialogPendingPatintFinance();
                                          },
                                          child: new Text('Pending',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20.0, 0),
                                        child: new Text('$totalPatientApproved',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20.0, 0),
                                        child: new Text(
                                            '${totalPatientPending}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    colors: [
                                      Color(0xFF16D9E3), // #16d9e3 at 0%
                                      Color(0xFF30C7EC), // #30c7ec at 47%
                                      Color(0xFF46AEF7), // #46aef7 at 100%
                                    ],
                                    stops: [0.0, 0.47, 1.0],
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('NGO(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print('@@---NGOsAPProved--1');

                                                  setState(() {
                                                    showDiseaseDialogNGOApproved();
                                                  });

                                                  // GetDPM_NGOApprovedPending();
                                                },
                                                child: new Text('Approved',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---ngo_PendingTask--1');

                                                  setState(() {
                                                    showDiseaseDialogNGOPending();
                                                  });

                                                  // GetDPM_NGOApprovedPending();
                                                },
                                                child: new Text('Pending',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${ngoCountApproved}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${ngoCountPending}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xFF0BA360), // #0ba360 at 0%
                                      Color(0xFF3CBA92), // #3cba92 at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            'Government Hospital(s)/CHC(s)/Other',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Government_approved--1');

                                                  setState(() {});
                                                },
                                                child: new Text('Approved',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Government_Pending--1');

                                                  setState(() {});
                                                },
                                                child: new Text('Pending',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text('${gH_CHC_Count}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${gH_CHC_Count_Pending}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFFBF7DFF), // #bf7dff at 0%
                                      Color(0xFF5DA7F1), // #5da7f1 at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Private Practitioner(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---GetDPM_PrivatePartitionPorovedClickShowData--1');

                                                  setState(() {});

                                                  // GetDPM_NGOApprovedPending();
                                                },
                                                child: new Text('Approved',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Pending here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Pending',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text('${ppCount}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${ppCount_pending}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFFE465F3), // #e465f3 at 0%
                                      Color(0xFFF5576C), // #f5576c at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            'Private Medical College(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---APProved here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Approved',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---DPM_privateMEdicalCollegePendingData here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Pending',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text('${pmcCount}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${ppCount_pending}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      Color(0xFF667EEA), // #667eea at 0%
                                      Color(0xFF764BA2), // #764ba2 at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Screening Camp(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Screening here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Completed',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Screening here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Ongoing',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---Screening here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text('Coming',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${campCompletedCount}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${campongoingCount}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20.0, 0),
                                              child: new Text(
                                                  '${campCommingCount}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFFFFC91E), // #ffc91e at 0%
                                      Color(0xFFFF7249), // #ff7249 at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Satellite Centre(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      '@@---satelliteCentreShowData here work----1');

                                                  setState(() {});
                                                },
                                                child: new Text(
                                                    '${satellitecentreCount}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Utils.showToast(
                                                      "Due to large amount of data",
                                                      true);
                                                },
                                                child: new Text('more..',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF2B5876), // #2b5876 at 0%
                                      Color(0xFF4E4376), // #4e4376 at 100%
                                    ],
                                    stops: [0.0, 1.0], // Define the color stops
                                  )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Total Patient(s)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Divider(color: Colors.grey, height: 1.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Utils.showToast(
                                                      "Due to large amount of data",
                                                      true);
                                                },
                                                child: new Text(
                                                    '${patientCount}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20.0, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Utils.showToast(
                                                      "Due to large amount of data",
                                                      true);
                                                },
                                                child: new Text('more..',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                              child: new Text(
                                  'Disease-wise Patient Statistics( Since FY: $currentFinancialYear )',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                              child: new Text(
                                  'Disease-wise Registered Patient(Since FY: $currentFinancialYear',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SPOLcikONDPMMEnu(),
            RegisteredEyesurgeons(),
            RegisteredEyesurgeonsEstimateTargetAllocation(),
            eyeBankApproval(),
            eyeBankDonationApproval(),
            eyeBankCollection(),
            //   ListGetSPO_DistrictNgoApproval_(),
            // ngowisePatientPendingInnerDisplayDataEidt(),
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
                  border: OutlineInputBorder(
                    // Adds a border around the TextField
                    borderRadius: BorderRadius.circular(12),
                    // Optional: Makes the border rounded
                    borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width:
                            1.0), // Optional: Sets the border color and width
                  ),
                ),
                controller: _oldPasswordControllere,
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _newPasswordontrollere,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    // Adds a border around the TextField
                    borderRadius: BorderRadius.circular(12),
                    // Optional: Makes the border rounded
                    borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width:
                            1.0), // Optional: Sets the border color and width
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmnPasswordontrollere,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    // Adds a border around the TextField
                    borderRadius: BorderRadius.circular(12),
                    // Optional: Makes the border rounded
                    borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width:
                            1.0), // Optional: Sets the border color and width
                  ),
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
          ApiController.sPOchangePAssword(getchangePwds).then((response) async {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
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
                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
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
                            onChanged: (userc) {
                              setState(() {
                                _selectedUser = userc;
                                getYearNgoHopital = userc?.name ?? '';
                                getfyidNgoHospital = userc?.fyid ?? '';
                                print(
                                    '@@getYearNgoHopital-- $getYearNgoHopital');
                                print(
                                    '@@getfyidNgoHospital here---- $getfyidNgoHospital');
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
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
                            icon:
                                Icon(Icons.arrow_drop_down, color: Colors.blue),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10.0, 0),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(12), // Padding inside the container
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    // Blue border
                    borderRadius: BorderRadius.circular(5.0),
                    // Rounded corners
                    color: Colors.white, // Background color (optional)
                  ),
                  child: Text(
                    stateNames, // Replace with your text content
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 16, // Text size
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(12), // Padding inside the container
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    // Blue border
                    borderRadius: BorderRadius.circular(5.0),
                    // Rounded corners
                    color: Colors.white, // Background color (optional)
                  ),
                  child: Text(
                    districtNames, // Replace with your text content
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 16, // Text size
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.blue.shade200,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _chosenValueMange,
                      style: TextStyle(color: Colors.black),
                      // Text color
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue, width: 2.0), // Border color
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0), // Border color when focused
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'All',
                        hintStyle:
                            TextStyle(color: Colors.black), // Hint text color
                      ),
                      items: <String>[
                        'Hospitals',
                        'Camps',
                        'Satellite Centres',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black), // Item text color
                          ),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValueMange =
                              value ?? 'All'; // Default to 'All' if null
                          if (_chosenValueMange == "Hospitals") {
                            print('@@NGO--1' + _chosenValueMange);
                          } else if (_chosenValueMange == "Camps") {
                            // Handle Camps selection
                          } else if (_chosenValueMange == "Satellite Centres") {
                            // Handle Satellite Centres selection
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        '@@lowvisionCornealBlindnessDataDispla-- click------');
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
                          snapshot.data.map((district) {
                        return district;
                      }).toList();

                      if (_selectedUser == null ||
                          !list.contains(_selectedUser)) {
                        _selectedUser = list.first;
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Submit button clicked');
                      setState(() {
                        // Add any additional logic here if needed
                      });
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
          child: DropdownButtonFormField<String>(
            value: _chosenValueMange,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                _chosenValueMange = value ?? 'All';
                // Add logic to handle different selections if needed
                print('Selected: $_chosenValueMange');
              });
            },
          ),
        ),
      ),
    );
  }

  Widget SPOLcikONDPMMEnu() {
    return Column(
      children: [
        Visibility(
          visible: SPOLcikONDPMMEnus,
          child: Column(
            children: [
              // Horizontal Scrolling for both Header and Data Rows
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    // Top Info Bar
                    Container(
                      color: Colors.white70,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 250.0,
                            child: const Text(
                              'District Programme Manager Details',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),

                    // Data Table Header
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('District'),
                        _buildHeaderCell('User ID'),
                        _buildHeaderCell('Name'),
                        _buildHeaderCell('Address'),
                        _buildHeaderCell('Mobile No.'),
                        _buildHeaderCell('Email ID'),
                        _buildHeaderCell('Status'),
                        _buildHeaderCellACtiveDeactive('Activate/Deactivate'),
                        //in comment next sprint
                        // _buildHeaderCell('Select'),
                      ],
                    ),
                    const Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<SPODashboardDPMClickViewData>>(
                      future: ApiController.getSPO_DPM_View(state_code_login),
                      builder: (context, snapshot) {
                        // Show progress dialog when the request is in progress
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Show the progress dialog
                          Utils.showProgressDialog(context);
                        } else {
                          // Dismiss the progress dialog once the data is fetched
                          if (snapshot.connectionState !=
                              ConnectionState.waiting) {
                            Utils.hideProgressDialog(context);
                          }
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Error: ${snapshot.error}"),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                _buildDataCell('No data found'),
                              ],
                            ),
                          );
                        } else {
                          List<SPODashboardDPMClickViewData> ddata =
                              snapshot.data;
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.districtName ?? 'N/A'),
                                  // Handle null
                                  _buildDataCell(offer.userId ?? 'N/A'),
                                  // Add field if necessary
                                  _buildDataCell(offer.name ?? 'N/A'),
                                  _buildDataCell(offer.address ?? 'N/A'),
                                  _buildDataCell(
                                      offer.mobile?.toString() ?? 'N/A'),
                                  _buildDataCell(
                                      offer.emailId?.toString() ?? 'N/A'),
                                  _buildDataCell(
                                      offer.status?.toString() ?? 'N/A'),
                                  _buildRadioCell(offer),
                                  //in comment next sprint
                                  /*  _buildHeaderCell('Select'),*/
                                  // Add Radio Button Cell
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

  Widget _buildHeaderCellACtiveDeactive(String text) {
    return Container(
      height: 40,
      width: 250, // Fixed width to ensure horizontal scrolling
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

// Method to build a text input cell in each row
  // Method to create an editable text field
  // Editable Text Field Method
  Widget createEditableTextField(/*String initialValue*/) {
    // Ensure initialValue is not null
    // final safeValue = initialValue ?? '';

    // Initialize controller with non-null value
    final controller = TextEditingController(/*text: safeValue*/);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter value',
          ),
        ),
      ),
    );
  }

  Widget createButton({
    String text,
    VoidCallback onPressed,
    Color color = Colors.blue,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      // Define the function to be called when the button is pressed
      style: ElevatedButton.styleFrom(
        primary: color, // Background color
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 12), // Button padding
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor), // Text color
      ),
    );
  }

  Widget RegisteredEyesurgeons() {
    return Column(
      children: [
        Visibility(
          visible: RegisteredEyesurgeon,
          child: Column(
            children: [
              // Top Info Bar
              Container(
                color: Colors.white70,
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Registered Eye Surgeon',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Data Rows
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildDataCellSrNoeyeSereonsss('S.No.'),
                        _buildDataCellSrNoeyeSereonsss('Action'),
                        _buildDataCellSrNoeyeSereonsss('In Government Sector'),
                        _buildDataCellSrNoeyeSereonsss('In NGO Sector'),
                        _buildDataCellSrNoeyeSereonsss(
                            'In Private Medical College'),
                        _buildDataCellSrNoeyeSereonsss(
                            'In Private Practitioner'),
                      ],
                    ),
                    const Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<EyeSurgeonsData>>(
                      future: _futures, // Cached future
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          Utils.showProgressDialog(context);
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          Utils.hideProgressDialog(context);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Error: ${snapshot.error}"),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                _buildDataCellSrNoeyeSereonsss('No data found'),
                          );
                        }

                        Utils.hideProgressDialog(context);

                        List<EyeSurgeonsData> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(
                              children: [
                                _buildDataCellSrNoeyeSereonsss(
                                    (ddata.indexOf(offer) + 1).toString()),
                                SizedBox(
                                  height: 60,
                                  width: 150,
                                  child: createButton(
                                    text: 'Submit',
                                    onPressed: () {
                                      Utils.showToast("Next Sprint add!", true);
                                    },
                                  ),
                                ),
                                _buildEditableDataCell(
                                  offer.totalGov.toString(),
                                  onChanged: (value) {
                                    print('@@Edited value: $value');
                                  },
                                ),
                                _buildEditableDataCell(
                                  offer.totalngo.toString(),
                                  onChanged: (value) {
                                    print('@@Edited value: $value');
                                  },
                                ),
                                _buildEditableDataCell(
                                  offer.totalPMC.toString(),
                                  onChanged: (value) {
                                    print('@@Edited value: $value');
                                  },
                                ),
                                _buildEditableDataCell(
                                  offer.totalPP.toString(),
                                  onChanged: (value) {
                                    print('@@Edited value: $value');
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        );
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

  Widget RegisteredEyesurgeonsEstimateTargetAllocation() {
    return Column(
      children: [
        Visibility(
          visible: RegisteredEyesurgeonsEstimateTargetAllocations,
          child: Column(
            children: [
              // Top Info Bar
              Container(
                color: Colors.white70,
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Complete in Next Sprint due to\n website error!',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Data Rows
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataCellSrNoeyeSereonsSrNo(String text) {
    return Container(
      height: 60,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNoeyeSereonss(String text) {
    return Container(
      height: cellHeight,
      width: cellWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNoeyeSereons(/*String text*/) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          "",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNoeyeSereonsss(String text) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildEditableDataCell(String initialValue,
      {Function(String) onChanged}) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        // Set keyboard type to number
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allow only digits
        ],
        onChanged: onChanged,
        // Callback to handle changes if needed
        decoration: const InputDecoration(
          border: InputBorder.none, // Remove default border
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

// Method to create button inside a DataCell

// New method to build the radio button cell
  // Updated method to build the radio button cell with 'status' logic
  Widget _buildRadioCell(SPODashboardDPMClickViewData offer) {
    return Container(
      height: 80,
      width: 250, // Fixed width for consistency
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<String>(
            value: 'Activate',
            groupValue: offer.status == '1' ? 'Activate' : 'Deactivate',
            // If status is 1, activate is selected
            onChanged: (String newValue) {
              offer.status = '1'; // Change status to '1' for Activate
            },
          ),
          const Text('Activate'), // Label for the radio button
          Radio<String>(
            value: 'Deactivate',
            groupValue: offer.status == '0' ? 'Deactivate' : 'Activate',
            // If status is 0, deactivate is selected
            onChanged: (String newValue) {
              offer.status = '0'; // Change status to '0' for Deactivate
            },
          ),
          const Text('Deactivate'), // Label for the radio button
        ],
      ),
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

  Widget eyeBankApproval() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: eyeBankApprovals,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 40,
                      color: Colors.blue,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: const Text(
                            'District Programme Manager Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select District:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: FutureBuilder<List<DataDsiricst>>(
                              future: _getDistrictData(29),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                // Logging for debugging
                                developer.log('@@snapshot: ${snapshot.data}');

                                List<DataDsiricst> districtList = snapshot.data;

                                // Ensure selected district is in the list, otherwise select the first
                                if (_selectedUserDistrict == null ||
                                    !districtList
                                        .contains(_selectedUserDistrict)) {
                                  _selectedUserDistrict =
                                      districtList.isNotEmpty
                                          ? districtList.first
                                          : null;
                                }

                                return DropdownButtonFormField<DataDsiricst>(
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
                                  onChanged: (districtUser) {
                                    setState(() {
                                      _selectedUserDistrict = districtUser;
                                      distCodeDPM = int.parse(
                                          districtUser.districtCode.toString());
                                      print(
                                          '@@@Districtuser: ${districtUser.districtName}');
                                    });
                                  },
                                  value: _selectedUserDistrict,
                                  items: districtList
                                      .map<DropdownMenuItem<DataDsiricst>>(
                                          (DataDsiricst district) {
                                    return DropdownMenuItem<DataDsiricst>(
                                      value: district,
                                      child: Text(district.districtName),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isSubmitPressed = true; // Mark as submit pressed
                            });
                            print('@@DPMMMM Hit here-----Api---------');
                          }),
                    ),

                    // Display SingleChildScrollView only if submit is pressed and district is selected
                    if (isSubmitPressed && _selectedUserDistrict != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildDataCellSrNo('S.No.'),
                                _buildDataCell('Id'),
                                _buildDataCell('Eye Bank Name'),
                                _buildDataCell('Member Name'),
                                _buildDataCell('Email'),
                              ],
                            ),
                            const Divider(color: Colors.blue, height: 1.0),
                            //eyeBankingRole_id=15 in case of Eye Bank Static send
                            FutureBuilder<List<EyeBankApprovalDataData>>(
                              future: ApiController
                                  .getSPO_EyeBankApplicationApproval(0, 15,
                                      state_code_login, district_code_login),
                              builder: (context, snapshot) {
                                // Show progress dialog when the request is in progress
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  Utils.showProgressDialog(context);
                                } else {
                                  if (snapshot.connectionState !=
                                      ConnectionState.waiting) {
                                    Utils.hideProgressDialog(context);
                                  }
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Error: ${snapshot.error}"),
                                    ),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        _buildDataCell('No data found'),
                                      ],
                                    ),
                                  );
                                } else {
                                  List<EyeBankApprovalDataData> ddata =
                                      snapshot.data;
                                  return Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDataCellSrNo(
                                              (ddata.indexOf(offer) + 1)
                                                  .toString()),
                                          _buildDataCell(
                                              offer.eyeBankUniqueID ?? 'N/A'),
                                          _buildDataCell(
                                              offer.eyebankName ?? 'N/A'),
                                          _buildDataCell(
                                              offer.officername ?? 'N/A'),
                                          _buildDataCell(
                                              offer.emailid?.toString() ??
                                                  'N/A'),
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
          ),
        ],
      ),
    );
  }

  Widget eyeBankDonationApproval() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: eyeBankDonationApprovals,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 40,
                      color: Colors.blue,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: const Text(
                            'Eye Donation Application(s) for Approval',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select District:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: FutureBuilder<List<DataDsiricst>>(
                              future: _getDistrictData(29),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                // Logging for debugging
                                developer.log('@@snapshot: ${snapshot.data}');

                                List<DataDsiricst> districtList = snapshot.data;

                                // Ensure selected district is in the list, otherwise select the first
                                if (_selectedUserDistrict == null ||
                                    !districtList
                                        .contains(_selectedUserDistrict)) {
                                  _selectedUserDistrict =
                                      districtList.isNotEmpty
                                          ? districtList.first
                                          : null;
                                }

                                return DropdownButtonFormField<DataDsiricst>(
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
                                  onChanged: (districtUser) {
                                    setState(() {
                                      _selectedUserDistrict = districtUser;
                                      distCodeDPM = int.parse(
                                          districtUser.districtCode.toString());
                                      print(
                                          '@@@Districtuser: ${districtUser.districtName}');
                                    });
                                  },
                                  value: _selectedUserDistrict,
                                  items: districtList
                                      .map<DropdownMenuItem<DataDsiricst>>(
                                          (DataDsiricst district) {
                                    return DropdownMenuItem<DataDsiricst>(
                                      value: district,
                                      child: Text(district.districtName),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isSubmitPressed = true; // Mark as submit pressed
                            });
                            print('@@DPMMMM Hit here-----Api---------');
                          }),
                    ),

                    // Display SingleChildScrollView only if submit is pressed and district is selected
                    if (isSubmitPressed && _selectedUserDistrict != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildDataCellSrNo('S.No.'),
                                _buildDataCell('Id'),
                                _buildDataCell('Eye Bank Name'),
                                _buildDataCell('Member Name'),
                                _buildDataCell('Email'),
                              ],
                            ),
                            const Divider(color: Colors.blue, height: 1.0),
                            //eyeBankingRole_id=16 in case of Eye Donation Static send
                            FutureBuilder<List<EyeBankDonationApprovalData>>(
                              future: ApiController
                                  .getSPO_EyeDonationApplicationApproval(
                                      0, 16, 29, 630),
                              builder: (context, snapshot) {
                                // Show progress dialog when the request is in progress
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  Utils.showProgressDialog(context);
                                } else {
                                  if (snapshot.connectionState !=
                                      ConnectionState.waiting) {
                                    Utils.hideProgressDialog(context);
                                  }
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Error: ${snapshot.error}"),
                                    ),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        _buildDataCell('No data found'),
                                      ],
                                    ),
                                  );
                                } else {
                                  List<EyeBankDonationApprovalData> ddata =
                                      snapshot.data;
                                  return Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDataCellSrNo(
                                              (ddata.indexOf(offer) + 1)
                                                  .toString()),
                                          _buildDataCell(
                                              offer.eyeBankUniqueID ?? 'N/A'),
                                          _buildDataCell(
                                              offer.eyebankName ?? 'N/A'),
                                          _buildDataCell(
                                              offer.officername ?? 'N/A'),
                                          _buildDataCell(
                                              offer.emailid?.toString() ??
                                                  'N/A'),
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
          ),
        ],
      ),
    );
  }

  Widget eyeBankCollection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: eyeBankCollections,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 40,
                      color: Colors.blue,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: const Text(
                            'Complet in next Sprint!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),

                    /* Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select District:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: FutureBuilder<List<DataDsiricst>>(
                              future: _getDistrictData(29),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                // Logging for debugging
                                developer.log('@@snapshot: ${snapshot.data}');

                                List<DataDsiricst> districtList = snapshot.data;

                                // Ensure selected district is in the list, otherwise select the first
                                if (_selectedUserDistrict == null || !districtList.contains(_selectedUserDistrict)) {
                                  _selectedUserDistrict = districtList.isNotEmpty ? districtList.first : null;
                                }

                                return DropdownButtonFormField<DataDsiricst>(
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
                                  onChanged: (districtUser) {
                                    setState(() {
                                      _selectedUserDistrict = districtUser;
                                      distCodeDPM = int.parse(districtUser.districtCode.toString());
                                      print('@@@Districtuser: ${districtUser.districtName}');
                                    });
                                  },
                                  value: _selectedUserDistrict,
                                  items: districtList.map<DropdownMenuItem<DataDsiricst>>((DataDsiricst district) {
                                    return DropdownMenuItem<DataDsiricst>(
                                      value: district,
                                      child: Text(district.districtName),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isSubmitPressed = true; // Mark as submit pressed
                            });
                            print('@@DPMMMM Hit here-----Api---------');
                          }
                      ),
                    ),

                    if (isSubmitPressed && _selectedUserDistrict != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildDataCellSrNo('S.No.'),
                                _buildDataCell('Id'),
                                _buildDataCell('Eye Bank Name'),
                                _buildDataCell('Member Name'),
                                _buildDataCell('Email'),
                              ],
                            ),
                            const Divider(color: Colors.blue, height: 1.0),
                            //eyeBankingRole_id=16 in case of Eye Donation Static send
                            FutureBuilder<List<EyeBankDonationApprovalData>>(
                              future: ApiController.getSPO_EyeDonationApplicationApproval(0,16,29,630),
                              builder: (context, snapshot) {
                                // Show progress dialog when the request is in progress
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  Utils.showProgressDialog(context);
                                } else {
                                  if (snapshot.connectionState != ConnectionState.waiting) {
                                    Utils.hideProgressDialog(context);
                                  }
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Error: ${snapshot.error}"),
                                    ),
                                  );
                                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        _buildDataCell('No data found'),
                                      ],
                                    ),
                                  );
                                } else {
                                  List<EyeBankDonationApprovalData> ddata = snapshot.data;
                                  return Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDataCellSrNo((ddata.indexOf(offer) + 1).toString()),
                                          _buildDataCell(offer.eyeBankUniqueID ?? 'N/A'),
                                          _buildDataCell(offer.eyebankName ?? 'N/A'),
                                          _buildDataCell(offer.officername ?? 'N/A'),
                                          _buildDataCell(offer.emailid?.toString() ?? 'N/A'),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DataDsiricst>> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel = DashboardDistrictModel();

    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"state_code": stateCode});
      Dio dio = Dio();
      response1 = await dio.post(
        "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/ListDistrict",
        data: body,
        options: Options(
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );
      print("@@Response--Api" + body.toString());
      dashboardDistrictModel =
          DashboardDistrictModel.fromJson(json.decode(response1.data));
      if (dashboardDistrictModel.status) {
        print("@@dashboardDistrictModel----getting of size +++--" +
            dashboardDistrictModel.data.length.toString());
      } else {
        print("@@no data---" + dashboardDistrictModel.data.length.toString());
      }
      return dashboardDistrictModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }
  }

  void showDiseaseDialogApprovedPatintFinance() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('District-wise Records (Approved)'),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal Scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('District Name'),
                            _buildHeaderCell('Total'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<ApprovedclickPatientsData>>(
                          future: ApiController.getSPO_PatientApproval(
                            //568, 33, "2024-2025", statusApproved,
                            district_code_login, state_code_login,
                            currentFinancialYear, statusApproved,
                          ),
                          builder: (context, snapshot) {
                            // Show loader while waiting for response
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              Utils.showProgressDialog(context);
                            } else {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                Utils.hideProgressDialog(context);
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<ApprovedclickPatientsData> ddata =
                                  snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.districtName),
                                      _buildDataCell(
                                          offer.totalCount.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.districtName}');
                                        // You can add further actions here if needed
                                        showDiseaseApprovedPatintViewClick();
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

  void showDiseaseApprovedPatintViewClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('Disease-wise Records (Approved)'),
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
                            _buildHeaderCell('NGO'),
                            _buildHeaderCell('Approved'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<
                            List<GetSPO_DiseasewiseRecordsApprovalData>>(
                          future:
                              ApiController.getSPO_DiseasewiseRecordsApproval(
                            /*   district_code_login,
                            state_code_login,
                            currentFinancialYear,
                            "",
                            diseaseid,*/
                            // 568, 33, "2024-2025", statusApproved,
                            district_code_login, state_code_login,
                            currentFinancialYear, statusApproved,
                          ),
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
                              List<GetSPO_DiseasewiseRecordsApprovalData>
                                  ddata = snapshot.data;
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
                                      _buildDataCell(offer.diseaseName),
                                      _buildDataCell(
                                          offer.totalApproPending.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print("@@npcbNo: " +
                                            offer.diseaseId.toString());
                                        showDiseaseGetSPO_Patients_Approved_View(
                                            offer.diseaseId);
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

  void showDiseasePendingPatintViewClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('Disease-wise Records(Pending)'),
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
                            _buildHeaderCell('NGO'),
                            _buildHeaderCell('Approved'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<
                            List<GetSPO_DiseasewiseRecordsApprovalData>>(
                          future:
                              ApiController.getSPO_DiseasewiseRecordsApproval(
                            /*   district_code_login,
                            state_code_login,
                            currentFinancialYear,
                            "",
                            diseaseid,*/
                            // 568, 33, "2024-2025", statusPending, in case of pending
                            district_code_login, state_code_login,
                            currentFinancialYear, statusPending,
                          ),
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
                              List<GetSPO_DiseasewiseRecordsApprovalData>
                                  ddata = snapshot.data;
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
                                      _buildDataCell(offer.diseaseName),
                                      _buildDataCell(
                                          offer.totalApproPending.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print("@@npcbNo: " +
                                            offer.diseaseId.toString());
                                        showDiseaseGetSPO_Patients_Pending_View(
                                            offer.diseaseId);
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

  void showDiseaseGetSPO_Patients_Approved_View(int diseaseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('Disease Data'),
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
                            _buildHeaderCell('NGO'),
                            _buildHeaderCell('Approved'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<GetSPO_Patients_Approved_ViewData>>(
                          future: ApiController.getSPO_Patients_Approved_View(
                            /*   district_code_login,
                            state_code_login,
                            currentFinancialYear,
                            "",
                            diseaseid,*/
                            //     568, 33, "2024-2025", statusApproved,diseaseId,
                            district_code_login, state_code_login,
                            currentFinancialYear, statusApproved, diseaseId,
                          ),
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
                              List<GetSPO_Patients_Approved_ViewData> ddata =
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
                                      _buildDataCell(offer.ngoname),
                                      _buildDataCell(offer.total.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print("@@npcbNo: " +
                                            offer.ngoname.toString());
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

  void showDiseaseGetSPO_Patients_Pending_View(int diseaseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('NGO-wise Records (Pending)'),
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
                            _buildHeaderCell('NGO'),
                            _buildHeaderCell('Approved'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<GetSPO_Patients_Approved_ViewData>>(
                          future: ApiController.getSPO_Patients_Approved_View(
                            district_code_login,
                            state_code_login,
                            currentFinancialYear,
                            statusPending,
                            diseaseId,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              // Return a TextField displaying 'No data found'
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            } else {
                              List<GetSPO_Patients_Approved_ViewData> ddata =
                                  snapshot.data;
                              print('@@---ddata: ${ddata.length}');
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.ngoname),
                                      _buildDataCell(offer.total.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print("@@npcbNo: ${offer.ngoname}");
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

  void showDiseaseDialogPendingPatintFinance() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('District-wise Records (Pending)'),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal Scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('District Name'),
                            _buildHeaderCell('Total'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<ApprovedclickPatientsData>>(
                          future: ApiController.getSPO_PatientApproval(
                            //568, 33, "2024-2025", 1,// in case of pending rest same

                            district_code_login, state_code_login,
                            currentFinancialYear, statusPending,
                          ),
                          builder: (context, snapshot) {
                            // Show loader while waiting for response
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              Utils.showProgressDialog(context);
                            } else {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                Utils.hideProgressDialog(context);
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<ApprovedclickPatientsData> ddata =
                                  snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.districtName),
                                      _buildDataCell(
                                          offer.totalCount.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.districtName}');
                                        // You can add further actions here if needed
                                        showDiseasePendingPatintViewClick();
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

//here click of NGO(s) approved
  void showDiseaseDialogNGOApproved() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('District-wise NGO(s) (Approved))'),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal Scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('District'),
                            _buildHeaderCell('Total'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<NGOApprovalClickData>>(
                          future: ApiController.getSPO_DistrictNgoApproval(
                            568, 33, "2024-2025", statusApproved,
                            //district_code_login, state_code_login, currentFinancialYear, statusApproved,
                          ),
                          builder: (context, snapshot) {
                            // Show loader while waiting for response
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              Utils.showProgressDialog(context);
                            } else {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                Utils.hideProgressDialog(context);
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<NGOApprovalClickData> ddata = snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.districtName),
                                      _buildDataCell(
                                          offer.countstate.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.districtName}');
                                        // Example Usage
                                        // Close the dialog before navigating
                                        Navigator.of(context).pop();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListNGOApprovalWidget(
                                                    districtName:
                                                        offer.districtName),
                                          ),
                                        );
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

  // here click of NGO(s) approved
  void showDiseaseDialogNGOPending() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen size
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text('District-wise NGO(s) (Pending)'),
          content: Container(
            width: screenWidth * 0.9, // 90% of screen width
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal Scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('District'),
                            _buildHeaderCell('Total'),
                            _buildHeaderCell('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<NGOApprovalClickData>>(
                          future: ApiController.getSPO_DistrictNgoApproval(
                              568, 33, "2024-2025", statusPending
                              //district_code_login, state_code_login, currentFinancialYear, statusApproved,

                              ),
                          builder: (context, snapshot) {
                            // Show loader while waiting for response
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              Utils.showProgressDialog(context);
                            } else {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                Utils.hideProgressDialog(context);
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return Utils.getEmptyView("No data found");
                            } else {
                              List<NGOApprovalClickData> ddata = snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNo(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCell(offer.districtName),
                                      _buildDataCell(
                                          offer.countstate.toString()),
                                      _buildDataCellViewBlue("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.districtName}');
                                        // Example Usage
                                        // Close the dialog before navigating
                                        Navigator.of(context).pop();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListNGOPendingWidget(
                                                    districtName:
                                                        offer.districtName),
                                          ),
                                        );
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
    double size = 14.0; // You can set a consistent size for both the icon and text

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0), // Reduce the vertical padding
      title: Row(
        children: [
          Icon(icon, color: Colors.black, size: size), // Set icon size
          SizedBox(width: 8.0,height: 4.0,), // Add space between the icon and the text
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: size,
              fontWeight: FontWeight.normal,  // Explicitly set fontWeight to normal
            ),
          )

        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDropdownItem({
    String value,
    String hint,
    List<Map<String, dynamic>> items, // List of maps to hold both item text and icon data
    Function(String) onChanged,
    Icon hintIcon, // Make hintIcon nullable
  }) {
    double size = 14.0; // Consistent size for both text and icon

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0), // Remove extra padding
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          style: TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          items: items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Row(
                children: [
                  Icon(
                    item['icon'], // Icon from the map
                    color: Colors.black,
                    size: size, // Set icon size
                  ),
                  SizedBox(width: 8.0), // Add space between the icon and text
                  Text(
                    item['value'],
                    style: TextStyle(color: Colors.black, fontSize: size), // Set text size
                  ),
                ],
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
            children: [
              hintIcon, // Only add the icon if it's not null
              SizedBox(width: 8.0), // Add space between the icon and hint text
              Text(
                hint,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ],
          )
              : Text(
            hint,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }





}

class GetChangeAPsswordFieldsss {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}
