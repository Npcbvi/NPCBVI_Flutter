import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMEyeSchoolScreens.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMPatientPatientDisceaseInnerDataDisplay.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMReportScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrganValuebiggerFive.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMGovtPrivateOrganisationTypeData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRivateMEdicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMScreeningCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMsatteliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMCataractPatientView.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_MOUApprove.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetNewHospitalData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientAPprovedwithFinanceYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientPendingwithFinance.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMCongenitalPtosis.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMSquint.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMTraumaChildren.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmDashboardPatinetApproveDisesesViewClick/PatientapprovedSisesesViewclick.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningMonth.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetEyeScreening.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPMGH_clickAPProved.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionCornealBlindness.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionVRSurgery.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_Glaucoma.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_cataract.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisonregister_diabitic.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/dpmRegistration/DiseaseData/GetDiseaseData.dart';
import '../model/dpmRegistration/getDPM_NGOApprovedPending/GetDPM_NGOAPProved_pending.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DPMDashboard extends StatefulWidget {
  @override
  _DPMDashboard createState() => _DPMDashboard();
}

class _DPMDashboard extends State<DPMDashboard> {
  bool _isLoadings = false; // Flag to check if the API is already being called

  String oganisationTypeGovtPrivateDRopDown;
  String ngoApproveRevenuMOU, lowVisionDatas;
  String ngodependOrganbisatioSelectValue;
  int dropDownvalueOrgnbaistaionType = 0;
  int ngoApproveRevenueMOUValue = 0, lowVisionDataValue = 0;
  int ngodependOrganbisatioSelectValuessss = 0;
  bool dashboardviewReplace = false;
  String currentFinancialYear;
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController,
      _chosenValueLOWVision,
      _chosenEyeBank,
      _chosenValueLgoutOption;
  int status, district_code_login, state_code_login;
  String role_id;
  bool isLoadingApi = true;
  DPMDashboardParamsData dpmDashboardParamsDatass =
      new DPMDashboardParamsData();
  GetDPM_NGOApplication getDPM_NGOApplications = new GetDPM_NGOApplication();
  GetDPM_NGOApprovedPendingFields getDPM_NGOApprovedPendingFields =
      new GetDPM_NGOApprovedPendingFields();
  GetChangeAPsswordFields getchangePwd = new GetChangeAPsswordFields();
  GetSchoolEyeScreening_Registrations _getSchoolEyeScreening_Registrations =
      new GetSchoolEyeScreening_Registrations();
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
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<GetDiseaseData> diseaseList = [];
  bool NGOlistDropDownDisplayDatas = false;
  bool ngolistNewHosdpitalDropDown = false;
  bool ngoGovtPrivateOthereHosdpitalDataShow = false;
  bool organisationGovtPrivateSelectionAfter = false;
  bool ApproveRenveMOUDataShows = false;
  bool ngoApproveRevenueMOU = false;
  bool ngoEyeScreeningdataShow = false;
  bool dpmEyeScreeningSchoolDataShow = false;
  bool dpmEyeScreeningSchoolDataShowADDNewRecord = false;
  List<DataNGOAPPlicationDropDownDPm> ddataNGOAPPlicationDropDownDPm = [];
  int dpmAPPRoved_valueSendinAPi = 2; // for approved
  int dpmPending_valueSendinAPi = 1; //for Penfing
  bool NGO_APPorovedClickShowData = false;
  bool NGO_PendingClickShowData = false;
  bool GetDPM_GH_APPorovedClickShowData = false;
  bool GetDPM_GH_PendingClickShowData = false;
  int GetDPM_GH_APPoroved_valueSendinAPi = 2; // for approved
  int GetDPM_GH_Pending_valueSendinAPi = 1;

  bool GetDPM_PrivatePartitionPorovedClickShowData = false;
  bool DPM_PrivatePartitionP_PendingClickShowData = false;
  int DPM_PrivatePartitionP_APPoroved_valueSendinAPi = 2; // for approved
  int DPM_PrivatePartitionP_Pending_valueSendinAPi = 1;

  bool DPM_privateMEdicalCollegeApprovedData = false;
  bool DPM_privateMEdicalCollegePendingData = false;
  int DPM_privateMEdicalCollegeApprovedData_valueSendinAPi = 2; // for approved
  int DPM_privateMEdicalCollegePendingData_valueSendinAPi = 1;

  bool satelliteCentreShowData = false;

  bool ScreeningCamp = false;
  bool ScreeningCampOngoing = false;
  bool ScreeningCampComing = false;

  //Badh main use this
  bool PatientsAPProvedClickDataFinance = false;
  bool PatientsPendingClickData = false;
  int PatientsAPProvedClickDataFinance_valueSendinAPi = 2; // for approved
  int PatientsPendingClickData_valueSendinAPi = 1;

  String resultScreeningCampsCompleted = "Completed";
  String resultScreeningCampsOngoing = "Ongoing";
  String resultScreeningCampsComing = "Coming";

  bool chnagePAsswordView = false;
  TextEditingController _oldPasswordControllere = new TextEditingController();
  TextEditingController _newPasswordontrollere = new TextEditingController();
  TextEditingController _confirmnPasswordontrollere =
      new TextEditingController();
  Future<List<DataGetDPM_ScreeningYear>> _future;
  Future<List<DataGetDPM_ScreeningYear>> _futureCataract;
  Future<List<DataGetDPM_ScreeningYear>> _futureDiabetic;
  DataGetDPM_ScreeningYear _selectedUser;
  Future<List<DataGetDPM_ScreeningMonth>> _futureMonth;
  DataGetDPM_ScreeningMonth _selectedUserMonth;
  Future<List<DataGetDPM_EyeScreeningEdit>> _futureEyeScreeningEdit;
  TextEditingController _controllerNameofSchool = TextEditingController();
  TextEditingController _controllerAddressofSchool = TextEditingController();
  TextEditingController _controllerNameofPrincipal = TextEditingController();
  TextEditingController _controllerTeacherTrained = TextEditingController();
  TextEditingController _controllerNumberofchildrenscreening =
      TextEditingController();
  TextEditingController _controllerChildrendetectedwithRefractive =
      TextEditingController();
  TextEditingController _controllerNumberoffreeGlasses =
      TextEditingController();
  String getfyid;
  var month_id;
  bool LowVisionRegisterCatracts = false;
  bool patinetInnerPandingDataDisplay = false;
  String LowVisionRegisterDataShowsValue;
  int LowVisionRegisterDataShowsValuessss = 0;
  bool LowVisionRegisterGlaucoma = false;
  bool LowVisionRegisterDiabitic = false;
  Future<List<DataBindOrgan>> _futureBindOrgan;
  Future<List<DataBindOrganValuebiggerFive>>
      _futureDataBindOrganValuebiggerFive;
  DataBindOrgan _selectBindOrgniasation;
  DataBindOrganValuebiggerFive _selectBindOrgniasationBiggerFive;
  String bindOrganisationNAme,
      npcbNoCatract,
      npcbNoGlucom,
      npcbNoDiabitic,
      npcbNoCornealBlindness,
      npcbVRSurgery,
      npcbCongenitalPtosis,
      npcbTraumaChildren,
      npcbSquint;

  bool lowvisionGlucomaDataDispla = false;
  bool lowvisionDiabiticDataDispla = false;
  bool lowvisionCataractDataDispla = false;
  bool lowvisionCornealBlindnessDataDispla = false;
  bool lowvisionVRSurgeryDataDispla = false;
  bool lowvisionCongenitalPtosisDataDispla = false;
  bool LowVisionRegisterCornealBlindness = false;
  bool LowVisionRegisterVRSurgery = false;
  bool lowvisionTrauma = false;

  bool lowvisionSquint = false;
  String getYearGlucoma,
      getYearCatract,
      getYearDiabitic,
      getYearCornealBlindness,
      gerYearVRsurgery,
      gerYearCongenitalPtosis,
      gerYearTraumaChildren,
      gerYearSquint;

  bool showChildhoodBlindnessDropdown = false;
  final GlobalKey _dropdownKey = GlobalKey();

  bool LowVisionRegisterChildhoodCongenitalPtosiss = false;

  bool LowVisionRegisterChildhoodTrauma = false;

  bool LowVisionRegisterSquint = false;
  bool eyBankCollections = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dashboardviewReplace = true;
    _getDPMDashbnoardData();
    _future=getDPM_ScreeningYear();
    _futureMonth=getDPM_ScreeningMonth();
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

  void _getDPMDashbnoardData() {
    getUserData();
    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog(context);
        try {
          final response = await ApiController.getDPM_Dashboard(
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
            color: Colors.white, // White background
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
                      NGOlistDropDownDisplayDatas = false;

                      dashboardviewReplace = true;
                      NGO_APPorovedClickShowData = false;
                      NGO_PendingClickShowData = false;
                      GetDPM_GH_APPorovedClickShowData = false;
                      GetDPM_GH_PendingClickShowData = false;
                      GetDPM_PrivatePartitionPorovedClickShowData = false;
                      DPM_PrivatePartitionP_PendingClickShowData = false;
                      DPM_privateMEdicalCollegeApprovedData = false;
                      DPM_privateMEdicalCollegePendingData = false;
                      ScreeningCamp = false;
                      ScreeningCampOngoing = false;
                      ScreeningCampComing = false;
                      satelliteCentreShowData = false;
                      ngoApproveRevenueMOU = false;

                      NGOlistDropDownDisplayDatas = false;
                      ngoGovtPrivateOthereHosdpitalDataShow = false;
                      ngolistNewHosdpitalDropDown = false;
                      LowVisionRegisterCatracts = false;
                      LowVisionRegisterGlaucoma = false;
                      LowVisionRegisterDiabitic = false;
                      LowVisionRegisterCornealBlindness = false;
                      LowVisionRegisterVRSurgery = false;
                      ngoEyeScreeningdataShow = false;
                      LowVisionRegisterChildhoodCongenitalPtosiss = false;
                      LowVisionRegisterChildhoodTrauma = false;
                      LowVisionRegisterSquint = false;
                      satelliteCentreShowData =
                      false;
                    });
                    Navigator.pop(context);
                  },
                ),

                _buildDropdownItem(
                  value: _chosenValue,
                  hint: 'Approve Application',
                  hintIcon: Icon(Icons.update, color: Colors.black), // Add an icon to the hint
                  items: [
                    {'value': 'NGO Application', 'icon': Icons.person},
                    {'value': 'New Hospital', 'icon': Icons.local_hospital},
                    {'value': 'Govt/private/Other', 'icon': Icons.business},
                    {'value': 'Approve Renew MOU', 'icon': Icons.refresh},


                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValue == "NGO Application") {
                        print('@@NGO--1' + _chosenValue);
                        dashboardviewReplace = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData =
                        false;
                        DPM_PrivatePartitionP_PendingClickShowData =
                        false;
                        DPM_privateMEdicalCollegeApprovedData =
                        false;
                        DPM_privateMEdicalCollegePendingData =
                        false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;
                        NGOlistDropDownDisplayDatas = true;
                        ngolistNewHosdpitalDropDown = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoApproveRevenueMOU = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = false;
                      } else if (_chosenValue == "New Hospital") {
                        dashboardviewReplace = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData =
                        false;
                        DPM_PrivatePartitionP_PendingClickShowData =
                        false;
                        DPM_privateMEdicalCollegeApprovedData =
                        false;
                        DPM_privateMEdicalCollegePendingData =
                        false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngolistNewHosdpitalDropDown = true;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = false;
                      } else if (_chosenValue ==
                          "Govt/private/Other") {
                        dashboardviewReplace = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData =
                        false;
                        DPM_PrivatePartitionP_PendingClickShowData =
                        false;
                        DPM_privateMEdicalCollegeApprovedData =
                        false;
                        DPM_privateMEdicalCollegePendingData =
                        false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;

                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        true;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = false;
                      }
                      if (_chosenValue == "Approve Renew MOU") {
                        dashboardviewReplace = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData =
                        false;
                        DPM_PrivatePartitionP_PendingClickShowData =
                        false;
                        DPM_privateMEdicalCollegeApprovedData =
                        false;
                        DPM_privateMEdicalCollegePendingData =
                        false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;

                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = true;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = false;
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  value: _chosenValueLOWVision,
                  hint: 'Low Vision Register',
                  hintIcon: Icon(Icons.local_hospital, color: Colors.black), // Add an icon to the hint
                  items: [
                    {'value': 'Cataract', 'icon': Icons.local_hospital},
                    // Add an icon here
                    {'value': 'Diabetic', 'icon': Icons.healing},
                    {'value': 'Glaucoma', 'icon': Icons.healing},
                    {'value': 'Corneal Blindness', 'icon': Icons.healing},
                    {'value': 'VR Surgery', 'icon': Icons.healing},
                    {'value': 'Childhood Blindness', 'icon': Icons.child_care},

                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueLOWVision = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValueLOWVision == "Cataract") {
                        _futureCataract = getDPM_ScreeningYear();
                        _futureBindOrgan = GetDPM_Bindorg();
                        _futureDataBindOrganValuebiggerFive =
                            GetDPM_Bindorg_New();
                        dashboardviewReplace = false;
                        LowVisionRegisterCatracts = true;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterSquint = false;
                        LowVisionRegisterChildhoodTrauma = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord =
                        false;
                        dpmEyeScreeningSchoolDataShow=false;
                        print('@@NGO--1' + _chosenValueLOWVision);
                      } else if (_chosenValueLOWVision ==
                          "Diabetic") {
                        dpmEyeScreeningSchoolDataShow=false;
                        _futureDiabetic = getDPM_ScreeningYear();
                        _futureBindOrgan = GetDPM_Bindorg();
                        dashboardviewReplace = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterDiabitic = true;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord =
                        false;
                      } else if (_chosenValueLOWVision ==
                          "Glaucoma") {
                        _future = getDPM_ScreeningYear();
                        _futureBindOrgan = GetDPM_Bindorg();
                        dashboardviewReplace = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = true;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord =
                        false;
                        dpmEyeScreeningSchoolDataShow=false;
                      } else if (_chosenValueLOWVision ==
                          "Corneal Blindness") {
                        dpmEyeScreeningSchoolDataShow=false;
                        _future = getDPM_ScreeningYear();
                        _futureBindOrgan = GetDPM_Bindorg();
                        dashboardviewReplace = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = true;
                        LowVisionRegisterVRSurgery = false;
                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord =
                        false;
                      } else if (_chosenValueLOWVision ==
                          "VR Surgery") {
                        print('@@Childhood--' +
                            _chosenValueLOWVision);
                        dpmEyeScreeningSchoolDataShow=false;
                        _future = getDPM_ScreeningYear();
                        _futureBindOrgan = GetDPM_Bindorg();
                        dashboardviewReplace = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = true;
                        ngolistNewHosdpitalDropDown = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoApproveRevenueMOU = false;
                        ngoGovtPrivateOthereHosdpitalDataShow =
                        false;
                        ngoEyeScreeningdataShow = false;
                        LowVisionRegisterChildhoodCongenitalPtosiss =
                        false;
                        LowVisionRegisterChildhoodTrauma = false;
                        LowVisionRegisterSquint = false;
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord =
                        false;
                      } else if (_chosenValueLOWVision ==
                          "Childhood Blindness") {
                        print('@@Childhood--' +
                            _chosenValueLOWVision);
                        if (_chosenValueLOWVision ==
                            "Childhood Blindness") {
                          print('@@Childhood--1' +
                              _chosenValueLOWVision);
                          dashboardviewReplace = false;
                          LowVisionRegisterCatracts = false;
                          LowVisionRegisterGlaucoma = false;
                          LowVisionRegisterDiabitic = false;
                          LowVisionRegisterCornealBlindness = false;
                          LowVisionRegisterVRSurgery = false;
                          ngolistNewHosdpitalDropDown = false;
                          NGOlistDropDownDisplayDatas = false;
                          ngoApproveRevenueMOU = false;
                          ngoGovtPrivateOthereHosdpitalDataShow =
                          false;
                          ngoEyeScreeningdataShow = false;
                          ngoEyeScreeningdataShow = false;
                          dpmEyeScreeningSchoolDataShowADDNewRecord =
                          false;
                          _showPopupMenuChildhoodBlindness();
                        } else {
                          print('@@Childhood--2' +
                              _chosenValueLOWVision);
                        }
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.remove_red_eye,
                  title: 'Eye Screening',
                  onTap: () {
                    setState(() {
                      dpmEyeScreeningSchoolDataShow=false;
                      dashboardviewReplace = false;
                      ngoEyeScreeningdataShow = true;
                      dpmEyeScreeningSchoolDataShowADDNewRecord =
                      false;
                      ngolistNewHosdpitalDropDown = false;
                      NGOlistDropDownDisplayDatas = false;
                      ngoApproveRevenueMOU = false;
                      ngoGovtPrivateOthereHosdpitalDataShow = false;
                      LowVisionRegisterCatracts = false;
                      LowVisionRegisterGlaucoma = false;
                      LowVisionRegisterDiabitic = false;
                      LowVisionRegisterCornealBlindness = false;
                      LowVisionRegisterVRSurgery = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildDropdownItem(
                  value: _chosenEyeBank,
                  hint: 'Eye Blink',
                  hintIcon: Icon(Icons.remove_red_eye), // Add an icon to the hint
                  items: [
                    {'value': 'Eye Bank Collection', 'icon': Icons.collections},
                    {'value': 'Eye Donation', 'icon': Icons.healing},
                    {
                      'value': 'Eyeball Collection Via Eye Bank',
                      'icon': Icons.add_circle_outline
                    },
                    {
                      'value': 'Eyeball Collection Via Eye Center',
                      'icon': Icons.center_focus_weak
                    },
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenEyeBank = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenEyeBank == "Eye Bank Collection") {
                        print('@@NGO--1' + _chosenEyeBank);

                      } else if (_chosenEyeBank == "Eye Donation") {

                      } else if (_chosenEyeBank ==
                          "Eyeball Collection Via Eye Bank") {
                        dashboardviewReplace = false;


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
                          'DPM',
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
                                    'District:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      child: Text(
                                    '${districtNames}',
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
                                                '@@---Patient(s) (2024-2025) APproved for Dialog');
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
                                        child: new Text(
                                            totalPatientApproved != null ? '${totalPatientApproved}' : '0',
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
                                            totalPatientPending != null ? '${totalPatientPending}' : '0',

                                          //  '${totalPatientPending}',
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
                                                    dashboardviewReplace =
                                                        false;
                                                    NGO_APPorovedClickShowData =
                                                        true;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
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
                                                    dashboardviewReplace =
                                                        false;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        true;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
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
                                                  ngoCountApproved != null ? '${ngoCountApproved}' : '0',

                                                //  '${ngoCountApproved}',
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
                                                  ngoCountPending != null ? '${ngoCountPending}' : '0',

                                                 // '${ngoCountPending}',
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;

                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;

                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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
                                                  gH_CHC_Count != null ? '${gH_CHC_Count}' : '0',

                                                  //'${gH_CHC_Count}',
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
                                                  gH_CHC_Count_Pending != null ? '${gH_CHC_Count_Pending}' : '0',


                                                  //'${gH_CHC_Count_Pending}',
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
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
                                                      '@@---Pending here work----1');

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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
                                                  ppCount != null ? '${ppCount}' : '0',

                                                 // '${ppCount}',
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
                                                  ppCount_pending != null ? '${ppCount_pending}' : '0',

                                              //    '${ppCount_pending}',
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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
                                                  pmcCount != null ? '${pmcCount}' : '0',

                                                  //'${pmcCount}',
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
                                                  ppCount_pending != null ? '${ppCount_pending}' : '0',


                                                //  '${ppCount_pending}',
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    ScreeningCamp = true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    ScreeningCampOngoing = true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampComing = false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    ScreeningCampComing = true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    satelliteCentreShowData =
                                                        false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
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
                                                  campCompletedCount != null ? '${campCompletedCount}' : '0',

                                                //  '${campCompletedCount}',
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
                                                  campongoingCount != null ? '${campongoingCount}' : '0',

                                                 // '${campongoingCount}',
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
                                                  campCommingCount != null ? '${campCommingCount}' : '0',

                                                 // '${campCommingCount}',
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

                                                  setState(() {
                                                    dashboardviewReplace =
                                                        false;
                                                    satelliteCentreShowData =
                                                        true;
                                                    NGO_APPorovedClickShowData =
                                                        false;
                                                    NGO_PendingClickShowData =
                                                        false;
                                                    GetDPM_GH_APPorovedClickShowData =
                                                        false;
                                                    GetDPM_GH_PendingClickShowData =
                                                        false;
                                                    GetDPM_PrivatePartitionPorovedClickShowData =
                                                        false;
                                                    DPM_PrivatePartitionP_PendingClickShowData =
                                                        false;
                                                    DPM_privateMEdicalCollegeApprovedData =
                                                        false;
                                                    DPM_privateMEdicalCollegePendingData =
                                                        false;
                                                    ScreeningCamp = false;
                                                    ScreeningCampOngoing =
                                                        false;
                                                    ScreeningCampComing = false;
                                                    ngoApproveRevenueMOU =
                                                        false;
                                                    NGOlistDropDownDisplayDatas =
                                                        false;
                                                    ngoGovtPrivateOthereHosdpitalDataShow =
                                                        false;
                                                    ngolistNewHosdpitalDropDown =
                                                        false;
                                                    LowVisionRegisterCatracts =
                                                        false;
                                                    LowVisionRegisterGlaucoma =
                                                        false;
                                                    LowVisionRegisterDiabitic =
                                                        false;
                                                    LowVisionRegisterCornealBlindness =
                                                        false;
                                                    LowVisionRegisterVRSurgery =
                                                        false;
                                                    ngoEyeScreeningdataShow =
                                                        false;
                                                  });
                                                },
                                                child: new Text(
                                                    satellitecentreCount != null ? '${satellitecentreCount}' : '0',

                                                  //  '${satellitecentreCount}',
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
                                                    patientCount != null ? '${patientCount}' : '0',

                                                   // '${patientCount}',
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
            NGOlistApplicationDropdownData(),
            NGOClickAprrovalDisplayDatas(),
            NGOClickPendingDisplayDatas(),
            DPMGetDPM_GHA_Click_prrovalDisplayDatas(),
            DPMGetDPM_GHA_Click_PendingDisplayDatas(),
            DPMGetDPM_PrivatePartitionAPProvalDisplayDatas(),
            DPM_PrivatePartitionPEndingDisplayDatas(),
            DPM_PrivateMedicalAPProvedDisplayDatas(),
            DPM_PrivateMedicalPendingDisplayDatas(),
            DPM_SatelliteCentreDisplayDatas(),
            DPM_GetDPM_ScreeningCampDisplayDatasCompleted(),
            DPM_GetDPM_ScreeningCampDisplayDatasOngoing(),
            DPM_GetDPM_ScreeningCampDisplayDatasComing(),
            // chnagePAsswordViews(),
            NGOlistnewHospitalDropdownData(),
            NGOlistgovtPvtotherHospitalDropdownData(),
            NGOlistApproveRevenuMOUDataShow(),
            ngolistEyeScreeningShowData(),
            DPMEyeScreenSchooRegisterData(),
            DPMEyeScreenSchooRegisterADDNewRecord(),
            LowVisionRegisterCatract(),
            LowVisionRegisterDataShowDiabitic(),
            LowVisionRegisterDataShowGlaucoma(),
            LowVisionRegisterDataShowCornealBlindness(),
            //    PatientApprovedFinancneClickDisplayData(),
            LowVisionRegisterDataShowVRSurgery(),
            LowVisionRegisterChildhoodCongenitalPtosis(),
            LowVisionRegisterChildhoodTraumas(),
            LowVisionRegisterSquints(),
            // ngowisePatientPendingInnerDisplayDataEidt(),
          ],
        ),
      ),
    );
  }

  Widget NGOlistApplicationDropdownData() {
    return Column(
      children: [
        Visibility(
          visible: NGOlistDropDownDisplayDatas,
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
                        'NGO list for Approval',
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
                    Container(
                      color: Colors.white70,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              'District: ${districtNames}',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              'State: ${stateNames}',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                dashboardviewReplace = true;
                                NGOlistDropDownDisplayDatas = false;
                                LowVisionRegisterCatracts = false;
                              });
                            },
                            child: Container(
                              width: 80.0,
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              // Adds 8.0 pixels of margin on all sides
                              child: Text(
                                'Back',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // Set font weight to bold
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0),
                    // Table Header Row
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('NGO Darpan No.'),
                        //_buildHeaderCell('Member Name'),
                       // _buildHeaderCell('Email'),
                        _buildHeaderCell('Action'), //comment for first sprint
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataNGOAPPlicationDropDownDPm>>(
                      future: ApiController.getDPM_NGOApplicationDropDown(
                         // 512, 36,
                          district_code_login, state_code_login),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data.isEmpty) {
                          return Center(
                            child: Text(
                              "No data found",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          List<DataNGOAPPlicationDropDownDPm> ddata =
                              snapshot.data;
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.darpanNo),
                                 // _buildDataCell(offer.memberName),
                                 // _buildDataCell(offer.emailid),
                                  //comment for first sprint
                                     _buildDataCellViewBlue("View Detail", () {
                                       _showDetailDialogNGOlistApprove(context, offer);
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
      ],
    );
  }
  void _showDetailDialogNGOlistApprove(BuildContext context, DataNGOAPPlicationDropDownDPm offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'NGO List for Approval',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              columnWidths: {
                0: FixedColumnWidth(120.0), // Label column width
                1: FlexColumnWidth(),      // Value column width
              },
              children: [
                _buildTableRow('Darpan No:', offer.darpanNo),
                _buildTableRow('Ngo Name:', offer.name),
                _buildTableRow('Member Name:', offer.memberName),
                _buildTableRow('Email:', offer.emailid),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget NGOlistnewHospitalDropdownData() {
    return Column(
      children: [
        Visibility(
          visible: ngolistNewHosdpitalDropDown,
          child: Column(
            children: [
              // Header Text
            Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_hospital, // Hospital icon
                  color: Colors.white,
                  size: 16, // Icon size
                ),
                SizedBox(width: 8), // Space between icon and text
                Text(
                  'Hospital List for Approval',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Larger font size for emphasis
                  ),
                ),
              ],
            ),
          ),

            SizedBox(height: 8.0),

              // Horizontal Scrolling for both Header and Data
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('NGO Dapan No.'),
                        //_buildHeaderCell('NGO Name'),
                        //_buildHeaderCell('Hospital ID'),
                       // _buildHeaderCell('Hospital Name'),
                        //comment for first sprint
                         _buildHeaderCell('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),

                    // Data Rows
                    FutureBuilder<List<DataGetNewHospitalData>>(
                      future: ApiController.getDPM_HospitalApproval(
                          district_code_login, state_code_login),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          // return Utils.getEmptyView("No data found");
                          return Center(
                            child: Text(
                              "No data found",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          List<DataGetNewHospitalData> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());

                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.darpanNo),
                                 // _buildDataCell(offer.name),
                                //  _buildDataCell(offer.hRegID),
                                //  _buildDataCell(offer.hName),
                                  //comment for first sprint
                                    _buildDataCellViewBlue("View Detail", () {
                                      _showDetailDialogHospitalDataApprove(context, offer);
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
      ],
    );
  }
  void _showDetailDialogHospitalDataApprove(BuildContext context, DataGetNewHospitalData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Hospital list for Approval',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              columnWidths: {
                0: FixedColumnWidth(120.0), // Label column width
                1: FlexColumnWidth(),      // Value column width
              },
              children: [
                _buildTableRow('Darpan No:', offer.darpanNo),
                _buildTableRow('Name:', offer.name),
                _buildTableRow('Hospital ID:', offer.hRegID),
                _buildTableRow('Hospital Name:', offer.hName),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
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
          child: Text(
            value ?? 'N/A',
          ),
        ),
      ],
    );
  }

  Widget NGOlistgovtPvtotherHospitalDropdownData() {
    return Column(
      children: [
        Visibility(
          visible: ngoGovtPrivateOthereHosdpitalDataShow,
          child: Column(
            children: [
              // Header Text
              Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Government / District Hospital list for Approval',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),

              // Dropdown for selecting organisation type
           /*   Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: oganisationTypeGovtPrivateDRopDown,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'Govt. District Hospital/Govt.MEdical College',
                        'CHC/Govt. Sub-Dist. Hospital',
                        'Private Practitioner',
                        'Private Medical College',
                        'Other(Institution not claiming fund from NPCBVI)',
                      ].map<DropdownMenuItem<String>>(
                          (String oganisationTypeGovtPrivateDRopDowns) {
                        return DropdownMenuItem<String>(
                          value: oganisationTypeGovtPrivateDRopDowns,
                          child: Text(
                            oganisationTypeGovtPrivateDRopDowns,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Organisation Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String oganisationTypeGovtPrivateDRopDownss) {
                        setState(() {
                          oganisationTypeGovtPrivateDRopDown =
                              oganisationTypeGovtPrivateDRopDownss;
                          updateDropDownSelection();
                        });
                      },
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: oganisationTypeGovtPrivateDRopDown,
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      items: [
                        'Govt. District Hospital/Govt. Medical College',
                        'CHC/Govt. Sub-Dist. Hospital',
                        'Private Practitioner',
                        'Private Medical College',
                        'Other (Institution not claiming fund from NPCBVI)',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                Icons.apartment, // You can use a specific icon for each type
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Organisation Type",
                        style: TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          oganisationTypeGovtPrivateDRopDown = newValue;
                          updateDropDownSelection();
                        });
                      },
                    ),
                  ),
                ),
              ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20.0, 0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      print("@@oganisationTypeGovtPrivateDRopDown--1 "+oganisationTypeGovtPrivateDRopDown);
                      if (oganisationTypeGovtPrivateDRopDown == null) {
                        Utils.showToast(
                            "Please Select oganisation Type !", false);
                      } else {
                        organisationGovtPrivateSelectionAfter = true;
                      }

                    });
                  },
                ),
              ),

              // Display data after submission
              Visibility(
                visible: organisationGovtPrivateSelectionAfter,
                child: Column(
                  children: [
                    // Horizontal Scroll for Headers and Data
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            children: [
                              _buildHeaderCellSrNo('S.No.'),
                              _buildHeaderCell('NGO Dapan No.'),
                            //  _buildHeaderCell('Ngo Name'),
                              //_buildHeaderCell('Hospital ID'),
                              //_buildHeaderCell('Hospital Name'),
                              //Comment for first sprint
                               _buildHeaderCell('Action'),
                            ],
                          ),
                          Divider(color: Colors.blue, height: 1.0),

                          // Data Rows
                          FutureBuilder<
                              List<DataDPMGovtPrivateOrganisationTypeData>>(
                            future: ApiController.getDPM_GovtPvtOther(
                                district_code_login,
                                state_code_login,
                                dropDownvalueOrgnbaistaionType),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Utils.getEmptyView(
                                    "Error: ${snapshot.error}");
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null ||
                                  snapshot.data.isEmpty) {
                                //  return Utils.getEmptyView("No data found");
                                return Center(
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              } else {
                                List<DataDPMGovtPrivateOrganisationTypeData>
                                    ddata = snapshot.data;
                                return Column(
                                  children: ddata.map((offer) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildDataCellSrNo(
                                            (ddata.indexOf(offer) + 1)
                                                .toString()),
                                        _buildDataCell(offer.npcbNo),
                                     //   _buildDataCell(offer.oName),
                                       // _buildDataCell(offer.nodalOfficerName),
                                        //_buildDataCell(offer.emailId),
                                        //Comment for first sprint
                                          _buildDataCellViewBlue("View Detail", () {
                                            _showDetailDialogGovernmentDistrictHospita(context, offer);

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
            ],
          ),
        ),
      ],
    );
  }

  void _showDetailDialogGovernmentDistrictHospita(BuildContext context, DataDPMGovtPrivateOrganisationTypeData offer) {
    print("Opening dialog for offer: ${offer.npcbNo}");
    print("Opening dialog for offer: ${offer.oName}");
    print("Opening dialog for offer: ${offer.nodalOfficerName}");
    print("Opening dialog for offer: ${offer.emailId}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Government / District Hospital list for Approval',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              columnWidths: {
                0: FixedColumnWidth(120.0), // Label column width
                1: FlexColumnWidth(),      // Value column width
              },
              children: [
                _buildTableRow('NPCB No:', offer.npcbNo),
                _buildTableRow('Organisation Name:', offer.oName),
                _buildTableRow('Member Name:', offer.nodalOfficerName),
                _buildTableRow('Email:', offer.emailId),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }


  void updateDropDownSelection() {
    if (oganisationTypeGovtPrivateDRopDown ==
        "Govt. District Hospital/Govt.MEdical College") {
      dropDownvalueOrgnbaistaionType = 10;
    } else if (oganisationTypeGovtPrivateDRopDown ==
        "CHC/Govt. Sub-Dist. Hospital") {
      dropDownvalueOrgnbaistaionType = 11;
    } else if (oganisationTypeGovtPrivateDRopDown == "Private Practitioner") {
      dropDownvalueOrgnbaistaionType = 12;
    } else if (oganisationTypeGovtPrivateDRopDown ==
        "Private Medical College") {
      dropDownvalueOrgnbaistaionType = 13;
    } else if (oganisationTypeGovtPrivateDRopDown ==
        "Other(Institution not claiming fund from NPCBVI)") {
      dropDownvalueOrgnbaistaionType = 14;
    }
    print(
        '@@oganisationTypeGovtPrivateDRopDown--$oganisationTypeGovtPrivateDRopDown'
        '-----$dropDownvalueOrgnbaistaionType');
  }

  Widget NGOlistApproveRevenuMOUDataShow() {
    return Column(
      children: [
        Visibility(
          visible: ngoApproveRevenueMOU,
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
                        child: Text(
                          'NGO/Private Practitioner/Private Medical College MOU List',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: ngoApproveRevenuMOU,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                        'Other(Institution not claiming fund from NPCBVI/GOVT/PRIVATE)',
                      ].map<DropdownMenuItem<String>>(
                          (String ngoApproveRevenueMOUs) {
                        return DropdownMenuItem<String>(
                          value: ngoApproveRevenueMOUs,
                          child: Text(
                            ngoApproveRevenueMOUs,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Organisation Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String ngoApproveRevenueMOUss) {
                        setState(() {
                          ngoApproveRevenuMOU = ngoApproveRevenueMOUss;
                          if (ngoApproveRevenuMOU == "NGOs") {
                            ngoApproveRevenueMOUValue = 5;
                          } else if (ngoApproveRevenuMOU ==
                              "Private Practitioner") {
                            ngoApproveRevenueMOUValue = 12;
                          } else if (ngoApproveRevenuMOU ==
                              "Private Medical College") {
                            ngoApproveRevenueMOUValue = 13;
                          } else if (ngoApproveRevenuMOU ==
                              "Other(Institution not claiming fund from NPCBVI/GOVT/PRIVATE)") {
                            ngoApproveRevenueMOUValue = 14;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: ngodependOrganbisatioSelectValue,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'Pending for Renew',
                        'Expired',
                        'Renew Approve',
                      ].map<DropdownMenuItem<String>>(
                          (String ngoApproveRevenueMOUs) {
                        return DropdownMenuItem<String>(
                          value: ngoApproveRevenueMOUs,
                          child: Text(
                            ngoApproveRevenueMOUs,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Pending for Renew",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String ngodependOrganbisatioSelectValuess) {
                        setState(() {
                          ngodependOrganbisatioSelectValue =
                              ngodependOrganbisatioSelectValuess;

                          if (ngodependOrganbisatioSelectValue ==
                              "Pending for Renew") {
                            ngodependOrganbisatioSelectValuessss = 1;
                          } else if (ngodependOrganbisatioSelectValue ==
                              "Expired") {
                            ngodependOrganbisatioSelectValuessss = 3;
                          } else if (ngodependOrganbisatioSelectValue ==
                              "Renew Approve") {
                            ngodependOrganbisatioSelectValuessss = 4;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(

                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        print('@@ApproveRevenueMOU-- clkick------'+ ngoApproveRevenuMOU+"---"+ngodependOrganbisatioSelectValue);
                        setState(() {
                          ApproveRenveMOUDataShows = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
      Visibility(
        visible: ApproveRenveMOUDataShows,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('Hospital Id'),
                     /* _buildHeaderCell('Hospital Name'),
                      _buildHeaderCell('Mobile'),
                      _buildHeaderCell('Email'),
                      _buildHeaderCell('From Date'),
                      _buildHeaderCell('To Date'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('MOU'),*/
                      //comment for first sprint
                      _buildHeaderCell('Action'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  FutureBuilder<List<DataGetDPM_MOUApprove>>(
                    future: ApiController.getDPM_MOUApprove(
                        district_code_login,
                        ngoApproveRevenueMOUValue,
                        ngodependOrganbisatioSelectValuessss),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data.isEmpty) {
                        // Display "No data found" message on the left side
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        List<DataGetDPM_MOUApprove> ddata = snapshot.data;
                        print('@@---ddata: ${ddata.length}');
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
                                /*  _buildDataCell(offer.hName),
                                  _buildDataCell(offer.mobile.toString()),
                                  _buildDataCell(offer.emailId),
                                  _buildDataCell(
                                      Utils.formatDateString(offer.fromDate)),
                                  _buildDataCell(
                                      Utils.formatDateString(offer.toDate)),
                                  _buildDataCell(offer.vstatus.toString()),
                                  _buildDataCellViewBlue(offer.file, () {
                                    // Handle the view/download action here
                                  }),*/
                                  //comment for first sprint
                                   _buildDataCellViewBlue("View Detail", () {
                                     _showDetailDialogMOU(context, offer);
                              }),
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


            ],
          ),
        ),
      ],
    );
  }
  void _showDetailDialogMOU(BuildContext context, DataGetDPM_MOUApprove offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'MOU Approval Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableRows('Hospital Id:', offer.hRegID),
                SizedBox(height: 8),
                _buildTableRows('Hospital Name:', offer.hName),
                SizedBox(height: 8),
                _buildTableRows('Mobile:', offer.mobile.toString()),
                SizedBox(height: 8),
                _buildTableRows('Email ID:', offer.emailId),
                SizedBox(height: 8),
                _buildTableRows(
                    'From Date:', Utils.formatDateString(offer.fromDate)),
                SizedBox(height: 8),
                _buildTableRows(
                    'To Date:', Utils.formatDateString(offer.toDate)),
                SizedBox(height: 8),
                _buildTableRows('Status:', offer.vstatus.toString()),
                SizedBox(height: 8),
                _buildDataCellViewBlue(offer.file, () {
                  // Handle the view/download action here
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableRows(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value ?? 'N/A',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

 /* Widget ngolistEyeScreeningShowData() {
    return Column(
      children: [
        Visibility(
          visible: ngoEyeScreeningdataShow,
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
                          child: GestureDetector(
                            onTap: () {
                              // Handle the tap event here
                              print('@@Add New Record clicked');

                              // Update state and perform actions
                              setState(() {
                                // Update the future values to fetch data
                                _future = getDPM_ScreeningYear();
                                _futureMonth = getDPM_ScreeningMonth();

                                // Update boolean flags to control UI visibility
                                ngoEyeScreeningdataShow = true;
                                dpmEyeScreeningSchoolDataShowADDNewRecord =
                                false;
                              });
                            },
                            child: Text(
                              'School Eye Screening',
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

                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the tap event here
                              print('@@Add New Record clicked');

                              // Update state and perform actions
                              setState(() {
                                // Update the future values to fetch data
                                _future = getDPM_ScreeningYear();
                                _futureMonth = getDPM_ScreeningMonth();

                                // Update boolean flags to control UI visibility
                                ngoEyeScreeningdataShow = false;
                                dpmEyeScreeningSchoolDataShowADDNewRecord =
                                    true;
                              });
                            },
                            child: Text(
                              'Add New Record',
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
              // Single horizontal scrolling view containing both header and data
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    // Horizontal Scrolling Header Row
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('Year'),
                        _buildHeaderCell('Month'),
                        _buildHeaderCell('School name'),
                        _buildHeaderCell('Teacher Trained'),
                        _buildHeaderCell('Children screened'),
                        _buildHeaderCell(
                            'Children detected with Refractive Errors'),
                        _buildHeaderCell(
                            'Free Glasses Provided by Organization'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows

                    FutureBuilder<List<DataGetEyeScreening>>(
                      future: ApiController.GetDPM_EyeScreening(
                          district_code_login, state_code_login, userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataGetEyeScreening> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.yearname),
                                  _buildDataCell(offer.monthname),
                                  _buildDataCell(offer.schoolName),
                                  //  _buildDataCell(offer.schoolAddress),
                                  _buildDataCell(
                                      offer.trainedTeacher.toString()),
                                  _buildDataCell(offer.childScreen.toString()),
                                  _buildDataCell(offer.childDetect.toString()),
                                  _buildDataCell(offer.freeglass.toString()),
                                  _buildDataCellViewBlue("Edit", () {
                                    // Handle the edit action here
                                    print(
                                        '@@Edit clicked for item: ${offer.schoolid}');
                                    SharedPrefs.storeSharedValues(
                                        AppConstant.schoolid,
                                        offer.schoolid.toString());
                                    setState(() {
                                      _future = getDPM_ScreeningYear();
                                      _futureMonth = getDPM_ScreeningMonth();
                                      _futureEyeScreeningEdit =
                                          ApiController.getDPM_EyeScreeningEdit(
                                              district_code_login,
                                              state_code_login,
                                              userId);
                                      ngoEyeScreeningdataShow = false;
                                      dpmEyeScreeningSchoolDataShow = true;
                                    });
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
      ],
    );
  }*/
  Widget ngolistEyeScreeningShowData() {
    return Column(
      children: [
        Visibility(
          visible: ngoEyeScreeningdataShow,
          child: Column(
            children: [
            Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                      print('@@School Eye Screening clicked');
                      setState(() {
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = true;

                        // Reset other flags here
                        DPM_privateMEdicalCollegePendingData = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData = false;
                        DPM_PrivatePartitionP_PendingClickShowData = false;
                        DPM_privateMEdicalCollegeApprovedData = false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoGovtPrivateOthereHosdpitalDataShow = false;
                        ngolistNewHosdpitalDropDown = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.school, color: Colors.white), // Icon for 'School Eye Screening'
                        SizedBox(width: 8), // Space between icon and text
                        Expanded(
                          child: Text(
                            'School Eye Screening',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                      print('@@Add New Record clicked');
                      setState(() {
                        _future = getDPM_ScreeningYear();
                        _futureMonth = getDPM_ScreeningMonth();
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = true;

                        // Reset other flags here
                        DPM_privateMEdicalCollegePendingData = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData = false;
                        DPM_PrivatePartitionP_PendingClickShowData = false;
                        DPM_privateMEdicalCollegeApprovedData = false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoGovtPrivateOthereHosdpitalDataShow = false;
                        ngolistNewHosdpitalDropDown = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                      children: [
                        Icon(Icons.add_circle, color: Colors.white), // Icon for 'Add New Record'
                        SizedBox(width: 8), // Space between icon and text
                        Expanded(
                          child: Text(
                            'Add New Record',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [

                        _buildHeaderCellSrNoEyeScreen('S.No.'),
                        //_buildHeaderCell('Year'),
                        //_buildHeaderCell('Month'),
                        _buildHeaderCellEyeScreen('School name'),
                        //_buildHeaderCell('Teacher Trained'),
                        //_buildHeaderCell('Children screened'),
                       // _buildHeaderCell('Children detected with Refractive Errors'),
                       // _buildHeaderCell('Free Glasses Provided by Organization'),
                        _buildHeaderCellEyeScreen('Action'),
                        _buildHeaderCellEyeScreen('Update'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetEyeScreening>>(
                      future: _fetchDataWithProgressDialog(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataGetEyeScreening> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNoEyScreen((ddata.indexOf(offer) + 1).toString()),
                                //  _buildDataCell(offer.yearname),
                               //   _buildDataCell(offer.monthname),
                                  _buildDataCellEyeScreen(offer.schoolName),
                                 // _buildDataCell(offer.trainedTeacher.toString()),
                               //   _buildDataCell(offer.childScreen.toString()),
                                 // _buildDataCell(offer.childDetect.toString()),
                                  //_buildDataCell(offer.freeglass.toString()),
                                  _buildDataCellViewBlueEyeScreen("View", () {
                                _showDetailDialogEyeScreening(context, offer);
                              }),

                                  _buildDataCellViewBlueEyeScreen("Edit", () async {
                              // Check if API call is already in progress
                              if (_isLoadings) return;

                              print('@@Edit clicked for item: afterviewDetails ${offer.schoolid}');

                              // Set flag to true to block multiple API calls
                              setState(() {
                              _isLoadings = true;
                              });

                              try {
                              // Store shared values
                              await SharedPrefs.storeSharedValues(AppConstant.schoolid, offer.schoolid.toString());

                              // Hit APIs once
                             // _future = getDPM_ScreeningYear();
                             // _futureMonth = getDPM_ScreeningMonth();
                              _futureEyeScreeningEdit = ApiController.getDPM_EyeScreeningEdit(
                              district_code_login, state_code_login, userId);

                              // Set flags for showing data
                              setState(() {
                              ngoEyeScreeningdataShow = false;
                              dpmEyeScreeningSchoolDataShow = true;
                              });
                              } catch (e) {
                              print('Error: $e');
                              } finally {
                              // Reset flag after completion
                              setState(() {
                              _isLoadings = false;
                              });
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
      ],
    );
  }

  void _showDetailDialogEyeScreening(BuildContext context, DataGetEyeScreening offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Eye Screening Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          contentPadding: EdgeInsets.all(16.0), // Add padding for better readability
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling if the table is wide
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Field',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(cells: [
                  DataCell(Text('Year Name:')),
                  DataCell(Text(offer.yearname ?? 'N/A')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Month Name:')),
                  DataCell(Text(offer.monthname ?? 'N/A')),
                ]),
                DataRow(cells: [
                  DataCell(Text('School Name:')),
                  DataCell(Text(offer.schoolName ?? 'N/A')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Address:')),
                  DataCell(Text(offer.schoolAddress ?? 'N/A')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Trained Teacher:')),
                  DataCell(Text(offer.trainedTeacher.toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Child Screened:')),
                  DataCell(Text(offer.childScreen.toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Child Detected:')),
                  DataCell(Text(offer.childDetect.toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Free Glasses:')),
                  DataCell(Text(offer.freeglass.toString())),
                ]),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTableRowss(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }


// This is where you manually handle the progress dialog
  Future<List<DataGetEyeScreening>> _fetchDataWithProgressDialog(BuildContext context) async {
    try {
      // Show the progress dialog before the API call
      Utils.showProgressDialog(context);

      // Perform the actual API call
      List<DataGetEyeScreening> response = await ApiController.GetDPM_EyeScreening(district_code_login, state_code_login, userId);

      // Dismiss the progress dialog after the API call completes
      Utils.hideProgressDialog(context);

      return response;
    } catch (e) {
      // Dismiss the progress dialog if an error occurs
      Utils.hideProgressDialog(context);
      rethrow;
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

  Future<List<DataGetDPM_ScreeningMonth>> getDPM_ScreeningMonth() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_ScreeningMonth'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final GetDPM_ScreeningMonth getDPM_ScreeningMonth =
          GetDPM_ScreeningMonth.fromJson(json);

      return getDPM_ScreeningMonth.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Widget DPMEyeScreenSchooRegisterData() {
    return Column(
      children: [
        Visibility(
          visible: dpmEyeScreeningSchoolDataShow,
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
                          'School Eye Screening',
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
                Center(
                  child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      List list = snapshot.data
                          .map<DataGetDPM_ScreeningYear>((district) {
                        return district;
                      }).toList();
                      if (_selectedUser == null ||
                          list.contains(_selectedUser) == false) {
                        _selectedUser = list.first;
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Select year:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Added space between label and dropdown
                            DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                              onChanged: (userc) => setState(() {
                                _selectedUser = userc;
                                var getYear = int.parse(
                                    userc.name.replaceAll(RegExp(r'\D'), ''));
                                getfyid = userc.fyid;
                                print('@@getYear--' + getYear.toString());
                                print('@@getfyidSelected here----' +
                                    getfyid.toString());
                                ;
                              }),
                              value: _selectedUser,
                              items: [
                                ...snapshot.data.map(
                                  (user) => DropdownMenuItem(
                                    value: user,
                                    child: Text(
                                      '${user.name}',
                                      style: TextStyle(
                                          fontSize:
                                              16), // Text style inside dropdown
                                    ),
                                  ),
                                ),
                              ],
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
                                fillColor: Colors.blue[
                                    50], // Background color of the dropdown box
                              ),
                              dropdownColor: Colors.blue[50],
                              // Background color of the dropdown menu
                              style: TextStyle(color: Colors.black),
                              // Style of the selected item
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.blue), // Dropdown icon style
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: FutureBuilder<List<DataGetDPM_ScreeningMonth>>(
                    future: _futureMonth,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      List list = snapshot.data
                          .map<DataGetDPM_ScreeningMonth>((district) {
                        return district;
                      }).toList();
                      if (_selectedUserMonth == null ||
                          list.contains(_selectedUserMonth) == false) {
                        _selectedUserMonth = list.first;
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Select Month:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Added space between label and dropdown
                            DropdownButtonFormField<DataGetDPM_ScreeningMonth>(
                              onChanged: (user) => setState(() {
                                _selectedUserMonth = user;
                                var getYear = ((user.monthname).toString());
                                month_id = ((user.monthId).toString());
                                print('@@month_id--' + getYear.toString());
                                print('@@month_id--' + month_id.toString());
                              }),
                              value: _selectedUserMonth,
                              items: [
                                ...snapshot.data.map(
                                  (user) => DropdownMenuItem(
                                    value: user,
                                    child: Text(
                                      '${user.monthname}',
                                      style: TextStyle(
                                          fontSize:
                                              16), // Text style inside dropdown
                                    ),
                                  ),
                                ),
                              ],
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
                                fillColor: Colors.blue[
                                    50], // Background color of the dropdown box
                              ),
                              dropdownColor: Colors.blue[50],
                              // Background color of the dropdown menu
                              style: TextStyle(color: Colors.black),
                              // Style of the selected item
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.blue), // Dropdown icon style
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Additional content can go here, such as a horizontal scrolling header row
                FutureBuilder<List<DataGetDPM_EyeScreeningEdit>>(
                  future: _futureEyeScreeningEdit,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Utils.getEmptyView("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data.isEmpty) {
                      return Utils.getEmptyView("No data found");
                    } else {
                      List<DataGetDPM_EyeScreeningEdit> ddata = snapshot.data;
                      print('@@---DataGetDPM_EyeScreeningEdit' +
                          ddata.length.toString());

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ddata.length,
                        itemBuilder: (context, index) {
                          DataGetDPM_EyeScreeningEdit offer = ddata[index];
                          print('@@---DataGetDPM_EyeScreeningEdit--values' +
                              offer.schoolName.toString());

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child:  TextField(
                                    controller: _controllerNameofSchool,
                                    decoration: InputDecoration(
                                      labelText: 'Enter School Name',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.schoolName,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _controllerAddressofSchool,
                                    decoration: InputDecoration(
                                      labelText: 'Enter School address',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.schoolAddress,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),

                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _controllerNameofPrincipal,
                                    decoration: InputDecoration(
                                      labelText: 'Enter principal name',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.principal,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),



                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color of the container
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    // Rounded corners
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _controllerTeacherTrained,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Trainer Teacher',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.trainedTeacher.toString(),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),

                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'School Eye Screening',
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color of the container
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    // Rounded corners
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller:
                                        _controllerNumberofchildrenscreening,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Child Screen',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.childScreen.toString(),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),


                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color of the container
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    // Rounded corners
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller:
                                        _controllerChildrendetectedwithRefractive,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Child Detect',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.childDetect.toString(),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color of the container
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                    // Rounded corners
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller:
                                        _controllerNumberoffreeGlasses,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Free Glasses ',
                                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                                      hintText: offer.freeglass.toString(),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: ElevatedButton(
                                        child: Text('Update'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          print('@@Edit Wala Click=afterviewDetails');

                                          _SchoolEyeScreening_Registration();
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: ElevatedButton(
                                        child: Text('Reset'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          _controllerNameofSchool.clear();
                                          _controllerAddressofSchool.clear();
                                          _controllerNameofPrincipal.clear();
                                          _controllerTeacherTrained.clear();
                                          _controllerNumberofchildrenscreening
                                              .clear();
                                          _controllerChildrendetectedwithRefractive
                                              .clear();
                                          _controllerNumberoffreeGlasses
                                              .clear();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _SchoolEyeScreening_Registration() async {
    print('@@Edit Wala Click=');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";

    _getSchoolEyeScreening_Registrations.yearid = int.tryParse(getfyid) ?? 0;
    _getSchoolEyeScreening_Registrations.monthid = int.tryParse(month_id) ?? 0;
    _getSchoolEyeScreening_Registrations.entry_by = userId;
    _getSchoolEyeScreening_Registrations.status = 1; // for update
    _getSchoolEyeScreening_Registrations.school_name =
        _controllerNameofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.school_address =
        _controllerAddressofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.principal =
        _controllerNameofPrincipal.text.trim();

    print('@@I am clicking here--3');

    try {
      _getSchoolEyeScreening_Registrations.trained_teacher =
          int.parse(_controllerTeacherTrained.text.trim());
      _getSchoolEyeScreening_Registrations.child_screen =
          int.parse(_controllerNumberofchildrenscreening.text.trim());
      _getSchoolEyeScreening_Registrations.child_detect =
          int.parse(_controllerChildrendetectedwithRefractive.text.trim());
      _getSchoolEyeScreening_Registrations.freeglass =
          int.parse(_controllerNumberoffreeGlasses.text.trim());
      _getSchoolEyeScreening_Registrations.schoolid = int.parse(schoolidSaved);
      _getSchoolEyeScreening_Registrations.district_code = district_code_login;
      _getSchoolEyeScreening_Registrations.state_code = state_code_login;
      print('@@I am clicking here--20' +
          (_controllerTeacherTrained.text.toString()));
    } catch (e) {
      Utils.showToast(
          "Please ensure all numerical inputs are valid numbers!", false);
      return;
    }

    // Validation checks
    if (_getSchoolEyeScreening_Registrations.school_name.isEmpty) {
      Utils.showToast("Please enter School Name!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.school_address.isEmpty) {
      Utils.showToast("Please enter School Address!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.principal.isEmpty) {
      Utils.showToast("Please enter Name of Principal!", false);
      return;
    }

    // Validation for numerical inputs
    if (_getSchoolEyeScreening_Registrations.trained_teacher <= 0) {
      Utils.showToast(
          "Please enter a valid number for Trained teacher!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_screen <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of children screening!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_detect <= 0) {
      Utils.showToast(
          "Please enter a valid number for Children detected with Refractive Errors!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.freeglass <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of free Glasses!", false);
      return;
    }

    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog1(context);
        ApiController.getSchoolEyeScreening_Registration(
            _getSchoolEyeScreening_Registrations)
            .then((response) async {
          Utils.hideProgressDialog1(context);
          print('@@I am clicking here--8' + response.toString());
          if (response.status) {
            Utils.showToast(response.message, true);
            _controllerNameofSchool.clear();
            _controllerAddressofSchool.clear();
            _controllerNameofPrincipal.clear();
            _controllerTeacherTrained.clear();
            _controllerNumberofchildrenscreening.clear();
            _controllerChildrendetectedwithRefractive.clear();
            _controllerNumberoffreeGlasses.clear();
          } else {
            Utils.showToast(response.message, false);
          }
        });
      } else {
        Utils.showToast(AppConstant.noInternet, false);
      }
    });
  }



  Widget DPMEyeScreenSchooRegisterADDNewRecord() {
    return Column(
      children: [
        Visibility(
          visible: dpmEyeScreeningSchoolDataShowADDNewRecord,
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
                          'School Eye Screening',
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
            Center(
              child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.data == null || snapshot.data.isEmpty) {
                    return const Text(
                      'No data found',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    );
                  }

                  List<DataGetDPM_ScreeningYear> list = snapshot.data;

                  if (_selectedUser == null || !list.contains(_selectedUser)) {
                    _selectedUser = null; // Remove default selection
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                      hint: const Text(
                        'Select Year',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ), // Hint text
                      onChanged: (userc) => setState(() {
                        _selectedUser = userc;
                        var getYear = int.parse(userc.name.replaceAll(RegExp(r'\D'), ''));
                        getfyid = userc.fyid;
                        print('@@getYear--' + getYear.toString());
                        print('@@getfyidSelected here----' + getfyid.toString());
                      }),
                      value: _selectedUser,
                      items: list.map(
                            (user) => DropdownMenuItem(
                          value: user,
                          child: Text(
                            user.name,
                            style: const TextStyle(fontSize: 16), // Style for dropdown items
                          ),
                        ),
                      ).toList(),
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50], // Light blue background color
                      ),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black), // Selected text style
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                    ),
                  );
                },
              ),
            ),

              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningMonth>>(
                  future: _futureMonth,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data == null || snapshot.data.isEmpty) {
                      return const Text(
                        'No data found',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      );
                    }

                    List<DataGetDPM_ScreeningMonth> list = snapshot.data;

                    if (_selectedUserMonth == null || !list.contains(_selectedUserMonth)) {
                      _selectedUserMonth = null; // Remove default selection
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: DropdownButtonFormField<DataGetDPM_ScreeningMonth>(
                        hint: const Text(
                          'Select Month',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ), // Hint text
                        onChanged: (user) => setState(() {
                          _selectedUserMonth = user;
                          var getYear = user.monthname.toString();
                          month_id = user.monthId.toString();
                          print('@@monthname--' + getYear.toString());
                          print('@@month_id--' + month_id.toString());
                        }),
                        value: _selectedUserMonth,
                        items: list.map(
                              (user) => DropdownMenuItem(
                            value: user,
                            child: Text(
                              user.monthname,
                              style: const TextStyle(fontSize: 16), // Style for dropdown items
                            ),
                          ),
                        ).toList(),
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50], // Light blue background color
                        ),
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black), // Selected text style
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                      ),
                    );
                  },
                ),
              ),

              Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child:  TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter School Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter School address',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),

                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter principal name',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),



                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color of the container
                          borderRadius:
                          BorderRadius.circular(10.0),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Trainer Teacher',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),

                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'School Eye Screening',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color of the container
                          borderRadius:
                          BorderRadius.circular(10.0),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Child Screen',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),


                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color of the container
                          borderRadius:
                          BorderRadius.circular(10.0),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Child Detect',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color of the container
                          borderRadius:
                          BorderRadius.circular(10.0),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextField(

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Free Glasses ',
                            floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label fixed
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: ElevatedButton(
                              child: Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                print('@@_SchoolEyeScreening_RegistrationADDnewRecord Click Submit--');
                                _SchoolEyeScreening_RegistrationADDnewRecord();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: ElevatedButton(
                              child: Text('Reset'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                _controllerNameofSchool.clear();
                                _controllerAddressofSchool.clear();
                                _controllerNameofPrincipal.clear();
                                _controllerTeacherTrained.clear();
                                _controllerNumberofchildrenscreening.clear();
                                _controllerChildrendetectedwithRefractive
                                    .clear();
                                _controllerNumberoffreeGlasses.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                // Additional content can go here, such as a horizontal scrolling header row
                /* FutureBuilder<List<DataGetDPM_EyeScreeningEdit>>(
                  future: _futureEyeScreeningEdit,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Utils.getEmptyView("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data.isEmpty) {
                      return Utils.getEmptyView("No data found");
                    } else {
                      List<DataGetDPM_EyeScreeningEdit> ddata = snapshot.data;
                      print('@@---DataGetDPM_EyeScreeningEdit' +
                          ddata.length.toString());

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ddata.length,
                        itemBuilder: (context, index) {
                          DataGetDPM_EyeScreeningEdit offer = ddata[index];
                          print('@@---DataGetDPM_EyeScreeningEdit--values' +
                              offer.schoolName.toString());

                          return Column(
                            children: [
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'School name *',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller:_controllerNameofSchool,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Address of School*',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller:_controllerAddressofSchool,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Name of Principal*',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller:_controllerNameofPrincipal,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Teacher Trained in screening for refractive errors *',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:_controllerTeacherTrained,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,

                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'School Eye Screening',
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
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Number of children screening *',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:_controllerNumberofchildrenscreening,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,

                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Children detected with Refractive Errors *',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:_controllerChildrendetectedwithRefractive,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,

                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // First TextField with flex: 1
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Number of free Glasses *',
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16.0,
                                              // Adjust font size as needed
                                              fontWeight: FontWeight
                                                  .bold, // Make the text bold if needed
                                            ),
                                          ),
                                        )),
                                  ),
                                  // Second TextField with flex: 2
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // Background color of the container
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:_controllerNumberoffreeGlasses,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,

                                            // Assuming 'offer.schoolName' is a dynamic value

                                            // Color of the label
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0), // Rounded border
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical:
                                                12.0), // Padding inside the TextField
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: ElevatedButton(
                                        child: Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          print('@@AADNEWRECORD Click Submit--');
                                          _SchoolEyeScreening_RegistrationADDnewRecord();

                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: ElevatedButton(
                                        child: Text('Reset'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          _controllerNameofSchool.clear();
                                          _controllerAddressofSchool.clear();
                                          _controllerNameofPrincipal.clear();
                                          _controllerTeacherTrained.clear();
                                          _controllerNumberofchildrenscreening.clear();
                                          _controllerChildrendetectedwithRefractive.clear();
                                          _controllerNumberoffreeGlasses.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }



  void showDiseaseDialogApprovedPatintFinance() {
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
                  // Horizontal Scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [

                            _buildHeaderCellSrNoDiseaseData('S.No.'),
                            _buildHeaderCellDiseaseData('Disease Name'),
                            _buildHeaderCellSrNoDiseaseDataTotal('Total'),
                            _buildHeaderCellDiseaseDataAction('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<
                            List<DataGetPatientAPprovedwithFinanceYear>>(
                          future:
                              ApiController.GetDPM_Patients_Approved_finacne(
                            district_code_login,
                            state_code_login,
                            currentFinancialYear,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                              // Align "No data found" message to the left
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                              );
                            } else {
                              List<DataGetPatientAPprovedwithFinanceYear>
                                  ddata = snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNoDiseaseData(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCellDiseaseData(offer.diseaseName),
                                      _buildDataCellDiseaseTotal(
                                          offer.totalApproPending.toString()),
                                      _buildDataCellViewBlueDiseaseDataAction("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.diseaseId}');
                                        showDiseaseApprovedPatintViewClick(
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

  void showDiseaseDialogPendingPatintFinance() {
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
            height: screenHeight * 0.8, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal scrolling for both Header and Data Rows
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            _buildHeaderCellSrNoDiseaseData('S.No.'),
                            _buildHeaderCellDiseaseData('Disease Name'),
                            _buildHeaderCellSrNoDiseaseDataTotal('Total'),
                            _buildHeaderCellDiseaseDataAction('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<List<DataGetPatientPendingwithFinance>>(
                          future: ApiController.GetDPM_Patients_Pending_finacne(
                            district_code_login,
                            state_code_login,
                            currentFinancialYear,
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
                              List<DataGetPatientPendingwithFinance> ddata =
                                  snapshot.data;
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNoDiseaseData(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCellDiseaseData(offer.diseaseName),
                                      _buildDataCellDiseaseTotal(
                                          offer.totalApproPending.toString()),
                                      _buildDataCellViewBlueDiseaseDataAction("View", () {
                                        print(
                                            '@@Edit clicked for item: ${offer.diseaseName}');
                                        showDiseasePatintPendingClickFlow(
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

  void showDiseaseApprovedPatintViewClick(int diseaseid) {
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
                            _buildHeaderCellSrNoDiseaseData('S.No.'),
                            _buildHeaderCellDiseaseData('NGO'),
                            _buildHeaderCellSrNoDiseaseDataTotal('Total'),
                            _buildHeaderCellDiseaseDataAction('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<
                            List<DataPatientapprovedSisesesViewclick>>(
                          future: ApiController.GetDPM_Patients_Approved_View(
                            district_code_login,
                            state_code_login,
                            currentFinancialYear,
                            "",
                            diseaseid,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Utils.getEmptyView(
                                  "Error: ${snapshot.error}");
                            }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                              // Return a TextField displaying 'No data found'
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(fontSize: 16, color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            } else {
                              List<DataPatientapprovedSisesesViewclick> ddata =
                                  snapshot.data;
                              print('@@---ddata: ' + ddata.length.toString());
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNoDiseaseData(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCellDiseaseData(offer.ngoname),
                                      _buildDataCellDiseaseTotal(offer.approved.toString()),
                                      _buildDataCellViewBlueDiseaseDataAction("View", () {
                                        print("@@npcbNo: " + offer.npcbNo);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DPMReportScreen(),
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

  void showDiseasePatintPendingClickFlow(int diseaseid) {
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
                            _buildHeaderCellSrNoDiseaseData('S.No.'),
                            _buildHeaderCellDiseaseData('NGO'),
                            _buildHeaderCellSrNoDiseaseDataTotal('Total'),
                            _buildHeaderCellDiseaseDataAction('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),
                        // Data Rows
                        FutureBuilder<
                            List<DataPatientapprovedSisesesViewclick>>(
                          future: ApiController.GetDPM_Patients_Approved_View(
                              district_code_login,
                             state_code_login,
                             currentFinancialYear,
                              "",
                              diseaseid,
                         /* 30,3, "2022-2023", "",diseaseid*/),
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
                              List<DataPatientapprovedSisesesViewclick> ddata =
                                  snapshot.data;
                              print('@@---ddata: ' + ddata.length.toString());
                              return Column(
                                children: ddata.map((offer) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildDataCellSrNoDiseaseData(
                                          (ddata.indexOf(offer) + 1)
                                              .toString()),
                                      _buildDataCellDiseaseData(offer.ngoname),
                                      _buildDataCellDiseaseTotal(offer.approved.toString()),
                                      _buildDataCellViewBlueDiseaseDataAction("View", () {
                                        print(
                                            "@@Different TypeShowData--here===");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DPMPatientPatientDisceaseInnerDataDisplay(),
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

  /// here we are showing the NGO Data on DPm Dashboard.
  Widget NGOClickAprrovalDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: NGO_APPorovedClickShowData,
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
                         /* Text('District:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text(districtNames,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text('State:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text(stateNames,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),*/
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            padding: EdgeInsets.all(8.0), // Added padding for inner spacing
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1), // Light red background
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                              border: Border.all(color: Colors.red, width: 1), // Optional border
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.approval, // Icon representing approval
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8), // Spacing between icon and text
                                Text(
                                  'NGO(s) (Approved)',
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold, // Enhanced for better emphasis
                                    fontSize: 16, // Slightly increased font size for readability
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                dashboardviewReplace = true;
                                NGO_APPorovedClickShowData = false;
                                NGO_PendingClickShowData = false;
                              });
                            },
                            child: Container(
                              width: 100.0, // Slightly increased for better button visibility
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Added padding for a better click area
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1), // Light red background for visual cue
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                                border: Border.all(color: Colors.red, width: 1), // Thin border for definition
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back, // Back arrow icon
                                    color: Colors.red,
                                    size: 16, // Adjust icon size for balance
                                  ),
                                  SizedBox(width: 5), // Spacing between icon and text
                                  Text(
                                    'Back',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold, // Enhanced emphasis
                                      fontSize: 14, // Adjusted font size for better readability
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    // Data Table Header
                    Row(
                      children: [

                        _buildHeaderCellSrNoDiseaseData('S.No.'),
                        _buildHeaderCell('NGO Name'),
                       /* _buildHeaderCell('Member Name'),
                        _buildHeaderCell('Hospital Name'),
                        _buildHeaderCell('Address'),
                        _buildHeaderCell('Nodal Officer Name'),
                        _buildHeaderCell('Mobile No'),
                        _buildHeaderCell('Email Id'),*/
                    _buildHeaderCell('Action'), //comment for first sprint
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetDPM_NGOAPProved_pending>>(
                      future: ApiController.getDPM_NGOAPProved_pendings(
                          district_code_login,
                          state_code_login,
                          dpmAPPRoved_valueSendinAPi),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataGetDPM_NGOAPProved_pending> ddata =
                              snapshot.data;
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNoDiseaseData(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.name),
                                  /*_buildDataCell(offer.memberName),
                                  _buildDataCell(offer.hName),
                                  _buildDataCell(offer.address),
                                  _buildDataCell(offer.nodalOfficerName),
                                  _buildDataCell(offer.mobile.toString()),
                                  _buildDataCell(offer.emailid.toString()),*/
                                  _buildDataCellViewBlue("View Detail", () {
                                    _showDetailDialogNGOsApprovedClick(context, offer);
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
      ],
    );
  }
  void _showDetailDialogNGOsApprovedClick(
      BuildContext context, DataGetDPM_NGOAPProved_pending offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "NGO Detail",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 1),
              columnWidths: {
                0: FixedColumnWidth(120), // Adjust column width
                1: FlexColumnWidth(),
              },
              children: [
                _buildTableRow("Name", offer.name),
                _buildTableRow("Member Name", offer.memberName),
                _buildTableRow("Hospital Name", offer.hName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailid.toString()),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Widget NGOClickPendingDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: NGO_PendingClickShowData,
          child: Column(
            children: [
              // Combined Header and Data Rows
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    // Header Row with District and State Information
                    Container(
                      color: Colors.white70,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                     /*     Text('District:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text(districtNames,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text('State:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Text(stateNames,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),*/
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            padding: EdgeInsets.all(8.0), // Added padding for inner spacing
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1), // Light orange background
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                              border: Border.all(color: Colors.orange, width: 1), // Thin orange border
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.hourglass_top, // Icon to represent "Pending" status
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8), // Spacing between icon and text
                                Text(
                                  'NGO(s) (Pending)',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold, // Enhanced emphasis
                                    fontSize: 14, // Increased font size for better readability
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                dashboardviewReplace = true;
                                NGO_PendingClickShowData = false;
                                NGO_APPorovedClickShowData = false;
                              });
                            },
                            child: Container(
                              width: 100.0, // Adjusted width for better visibility
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Added padding for better click area
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1), // Light red background
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                                border: Border.all(color: Colors.red, width: 1), // Thin red border
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back, // Back arrow icon
                                    color: Colors.red,
                                    size: 16, // Adjust icon size
                                  ),
                                  SizedBox(width: 5), // Spacing between icon and text
                                  Text(
                                    'Back',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold, // Bold for emphasis
                                      fontSize: 14, // Adjusted font size for better readability
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    // Table Header
                    Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('NGO Name'),
            /*            _buildHeaderCell('Member Name'),
                        _buildHeaderCell('Hospital Name'),
                        _buildHeaderCell('Address'),
                        _buildHeaderCell('Nodal Officer Name'),
                        _buildHeaderCell('Mobile No'),
                        _buildHeaderCell('Email Id'),*/
                        _buildHeaderCell('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),

                    // Data Rows
                    FutureBuilder<List<DataGetDPM_NGOAPProved_pending>>(
                      future: ApiController.getDPM_NGOAPProved_pendings(
                        district_code_login,
                        state_code_login,
                        dpmPending_valueSendinAPi,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Return a TextField displaying 'No data found'
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }  else {
                          List<DataGetDPM_NGOAPProved_pending> ddata =
                              snapshot.data;
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.name),
                              /*    _buildDataCell(offer.memberName),
                                  _buildDataCell(offer.hName),
                                  _buildDataCell(offer.address),
                                  _buildDataCell(offer.nodalOfficerName),
                                  _buildDataCell(offer.mobile.toString()),
                                  _buildDataCell(offer.emailid.toString()),*/
                                  _buildDataCellViewBlue("View Detail", () {
                                    _showDetailDialogNGOsPendingClick(context, offer);
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
      ],
    );
  }
  void _showDetailDialogNGOsPendingClick(
      BuildContext context, DataGetDPM_NGOAPProved_pending offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "NGO Detail",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 1),
              columnWidths: {
                0: FixedColumnWidth(120), // Adjust column width
                1: FlexColumnWidth(),
              },
              children: [
                _buildTableRow("Name", offer.name),
                _buildTableRow("Member Name", offer.memberName),
                _buildTableRow("Hospital Name", offer.hName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailid.toString()),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// here we are showing the GovtPrivateHospital Dat aon DPm Dashboard.
  Widget DPMGetDPM_GHA_Click_prrovalDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: GetDPM_GH_APPorovedClickShowData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                            /*        Container(
                                        child: Text(
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    ),*/
                                Container(
                                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                padding: EdgeInsets.all(10),
                                width: 160.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(color: Colors.red, width: 1.5),
                                ),
                                child: Text(
                                  'Govt. / CHC / Other Hospitals (Approved)',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        setState(() {
                                          dashboardviewReplace = true;
                                          GetDPM_GH_PendingClickShowData = false;
                                          GetDPM_GH_APPorovedClickShowData = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          border: Border.all(color: Colors.red, width: 1.5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Back',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('NGO Name'),
             /*       _buildHeaderCell('Member Name'),
                    //  _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),*/
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DatagetDPMGH_clickAPProved>>(
                future: ApiController.getDPM_GetDPM_GHAPProved_pendings(
                    district_code_login,
                    state_code_login,
                    GetDPM_GH_APPoroved_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  }  else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DatagetDPMGH_clickAPProved> ddata = snapshot.data;
                    print('@@---getDPM_GetDPM_GHAPProved_pendings' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                              /*  _buildDataCell(offer.ngoName),
                              // _buildDataCell(offer.hName),
                            _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),*/
                              _buildDataCellViewBlue("View Detail", () {
                                _showDetailDialogGovtCHCHospitalClick(context, offer);
                              }),
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
  }
  void _showDetailDialogGovtCHCHospitalClick(BuildContext context, DatagetDPMGH_clickAPProved offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hospital Details"),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableHeader("Field"),
                    _buildTableHeader("Value"),
                  ],
                ),
                _buildTableRow("Organization Name", offer.oName),
                _buildTableRow("NGO Name", offer.ngoName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId ?? "N/A"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }


  Widget DPMGetDPM_GHA_Click_PendingDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: GetDPM_GH_PendingClickShowData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                              /*      Container(
                                        child: Text(
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    ),*/
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                padding: EdgeInsets.all(10),
                                width: 180.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(color: Colors.red, width: 1.5),
                                ),
                                child: Center(
                                  child: Text(
                                    'GOVT.CHC Hospital (Pending)',
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                      width: 10,
                                    ),
                      InkWell(
                        onTap: () {
                          print('@@back Pressed----display---');
                          setState(() {
                            dashboardviewReplace = true;
                            GetDPM_GH_PendingClickShowData = false;
                            GetDPM_GH_APPorovedClickShowData = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Back',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('NGO Name'),
                 /*   _buildHeaderCell('Member Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),*/
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DatagetDPMGH_clickAPProved>>(
                future: ApiController.getDPM_GetDPM_GHAPProved_pendings(
                    district_code_login,
                    state_code_login,
                    GetDPM_GH_Pending_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DatagetDPMGH_clickAPProved> ddata = snapshot.data;
                    print('@@---getDPM_GetDPM_GHAPProved_pendings' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                              _buildDataCell(offer.ngoName),
                              //_buildDataCell(offer.hName),
                             /* _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),*/
    _buildDataCellViewBlueDiseaseDataAction('View Detail', () {
      _showDetailDialogGHCCHCPendingHospital(context, offer);
    }),
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
  }

  void _showDetailDialogGHCCHCPendingHospital(BuildContext context, DatagetDPMGH_clickAPProved offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pending Hospital Details"),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableHeader("Field"),
                    _buildTableHeader("Value"),
                  ],
                ),
                _buildTableRow("Organization Name", offer.oName),
                _buildTableRow("NGO Name", offer.ngoName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId ?? "N/A"),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }







  /// here we are showing the PrivatePartition Dat aon DPm Dashboard.

  Widget DPMGetDPM_PrivatePartitionAPProvalDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: GetDPM_PrivatePartitionPorovedClickShowData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                              /*      Container(
                                        child: Text(
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    ),*/
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.red.withOpacity(0.1), // Light red background
                                        border: Border.all(color: Colors.red, width: 1), // Red border
                                      ),
                                      child: Text(
                                        'Private Practitioners (Approved)',
                                        style: TextStyle(
                                          fontSize: 14, // Set a font size for better readability
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis, // Handle text overflow
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        setState(() {
                                          dashboardviewReplace = true;
                                          GetDPM_PrivatePartitionPorovedClickShowData = false;
                                          DPM_PrivatePartitionP_PendingClickShowData = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1), // Light red background
                                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                          border: Border.all(color: Colors.red, width: 1), // Red border
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center, // Center the content
                                          children: [
                                           // Space between the icon and text
                                            Text(
                                              'Back',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('NGO Name'),
                    //_buildHeaderCell('Member Name'),
                    //  _buildHeaderCell('Hospital Name'),
              /*      _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),*/
                    _buildHeaderCellDiseaseDataAction('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetDPM_PrivatePartition>>(
                future: ApiController.getDPM_PrivatePartition(
                    district_code_login,
                    state_code_login,
                    DPM_PrivatePartitionP_APPoroved_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  } else {
                    List<DataGetDPM_PrivatePartition> ddata = snapshot.data;
                    print('@@---getDPM_GetDPM_GHAPProved_pendings' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                              //_buildDataCell(offer.ngoName),
                              // _buildDataCell(offer.hName),
                            /*  _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),*/
                              _buildDataCellViewBlueDiseaseDataAction('View Detail', () {
                                _showDetailDialogPrivatePractitionerApproval(context, offer);
                              }),
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
  }

  void _showDetailDialogPrivatePractitionerApproval(
      BuildContext context, DataGetDPM_PrivatePartition offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Private Practitioner Approval Details"),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableHeader("Field"),
                    _buildTableHeader("Value"),
                  ],
                ),
                _buildTableRow("Organization Name", offer.oName),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId ?? "N/A"),
                // Add more fields as necessary
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }


  Widget DPM_PrivatePartitionPEndingDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: DPM_PrivatePartitionP_PendingClickShowData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                  /*  Container(
                                        child: Text(
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    ),*/
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.red.withOpacity(0.1), // Light red background
                                        border: Border.all(color: Colors.red, width: 1), // Red border
                                      ),
                                      child: Text(
                                        'Private Practitioner(s) (Pending)',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis, // Handles text overflow gracefully
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        setState(() {
                                          dashboardviewReplace = true;
                                          GetDPM_PrivatePartitionPorovedClickShowData = false;
                                          DPM_PrivatePartitionP_PendingClickShowData = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red, // Red background for the button
                                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                        ),
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white, // White text for contrast
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),

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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation'),
                    //_buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                  /*  _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),*/
                    _buildHeaderCellDiseaseDataAction('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetDPM_PrivatePartition>>(
                future: ApiController.getDPM_PrivatePartition(
                    district_code_login,
                    state_code_login,
                    DPM_PrivatePartitionP_Pending_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  } else {
                    List<DataGetDPM_PrivatePartition> ddata = snapshot.data;
                    print('@@---DataGetDPM_PrivatePartition' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                            /*  _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),*/
                              _buildDataCellViewBlueDiseaseDataAction('View Detail', () {
                                _showDetailDialogPrivatePractitionerPending(context, offer);
                              }),
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
  }
  void _showDetailDialogPrivatePractitionerPending(
      BuildContext context, DataGetDPM_PrivatePartition offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Private Practitioner Pending Details"),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableHeader("Field"),
                    _buildTableHeader("Value"),
                  ],
                ),
                _buildTableRow("Organization Name", offer.oName),
                _buildTableRow("Nodal Officer", offer.nodalOfficerName),
                _buildTableRow("Address", offer.address),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId ?? "N/A"),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }



  /// here we are showing the PrivateMedical Datq aon DPm Dashboard.
  Widget DPM_PrivateMedicalAPProvedDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: DPM_privateMEdicalCollegeApprovedData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                   /* Container(
                                        child: Text(
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    ),*/
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                padding: EdgeInsets.all(12),
                                width: 180.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(color: Colors.red, width: 1.5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Private Practitioner(s) (Approved)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                      width: 10,
                                    ),
                              InkWell(
                                onTap: () {
                                  print('@@back Pressed----display---');
                                  setState(() {
                                    dashboardviewReplace = true;
                                    DPM_privateMEdicalCollegeApprovedData = false;
                                    DPM_privateMEdicalCollegePendingData = false;
                                  });
                                },
                                child: Container(
                                  width: 100.0,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Back',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
            /*        _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),*/
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMRivateMEdicalColleges>>(
                future: ApiController.GetDPM_PrivateMedicalColleges(
                    district_code_login,
                    state_code_login,
                    DPM_privateMEdicalCollegeApprovedData_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DataDPMRivateMEdicalColleges> ddata = snapshot.data;
                    print('@@---DataDPMRivateMEdicalColleges' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                       /*       _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),*/
                              _buildDataCellViewBlueDiseaseDataAction('View Detail', () {
                               // _showDetailDialogPrivateMedicalAPProved(context, offer);
                              }),
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
  }




  Widget DPM_PrivateMedicalPendingDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: DPM_privateMEdicalCollegePendingData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width: 150.0,
                                      child: Text(
                                        'Private Medical College(s) (Pending)',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                                        setState(() {
                                          dashboardviewReplace = true;
                                          DPM_privateMEdicalCollegeApprovedData =
                                              false;
                                          DPM_privateMEdicalCollegePendingData =
                                              false;
                                        });
                                      },
                                      child: Container(
                                        width: 80.0,
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
                    _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMRivateMEdicalColleges>>(
                future: ApiController.GetDPM_PrivateMedicalColleges(
                    district_code_login,
                    state_code_login,
                    DPM_privateMEdicalCollegePendingData_valueSendinAPi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DataDPMRivateMEdicalColleges> ddata = snapshot.data;
                    print('@@---DataDPMRivateMEdicalColleges--' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.oName),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),
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
  }

  /// here we are showing the ScreeningCampDisplay Data aon DPm Dashboard.
  Widget DPM_GetDPM_ScreeningCampDisplayDatasCompleted() {
    return Column(
      children: [
        Visibility(
          visible: ScreeningCamp,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width: 150.0,
                                      child: Text(
                                        'Screening Camp(s)',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                                        setState(() {
                                          dashboardviewReplace = true;
                                          ScreeningCamp = false;
                                          ScreeningCampOngoing = false;
                                          ScreeningCampComing = false;
                                        });
                                      },
                                      child: Container(
                                        width: 80.0,
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
                    _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMScreeningCamp>>(
                future: ApiController.GetDPM_ScreeningCamp(1001, 100,
                    currentFinancialYear, "", resultScreeningCampsCompleted),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  } else {
                    List<DataDPMScreeningCamp> ddata = snapshot.data;
                    print('@@---DataDPMScreeningCamp--' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.campname),
                              _buildDataCell(offer.ngoName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),
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
  }

  Widget DPM_GetDPM_ScreeningCampDisplayDatasOngoing() {
    return Column(
      children: [
        Visibility(
          visible: ScreeningCampOngoing,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width: 150.0,
                                      child: Text(
                                        'Screening Camp(s)',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                                        setState(() {
                                          dashboardviewReplace = true;
                                          ScreeningCamp = false;
                                          ScreeningCampOngoing = false;
                                          ScreeningCampComing = false;
                                        });
                                      },
                                      child: Container(
                                        width: 80.0,
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
                    _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMScreeningCamp>>(
                future: ApiController.GetDPM_ScreeningCamp(
                    district_code_login,
                    state_code_login,
                    "2019-2020",
                    "",
                    resultScreeningCampsOngoing),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DataDPMScreeningCamp> ddata = snapshot.data;
                    print('@@---DataDPMScreeningCamp--' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.campname),
                              _buildDataCell(offer.ngoName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),
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
  }

  Widget DPM_GetDPM_ScreeningCampDisplayDatasComing() {
    return Column(
      children: [
        Visibility(
          visible: ScreeningCampComing,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width: 150.0,
                                      child: Text(
                                        'Screening Camp(s)',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                                        setState(() {
                                          dashboardviewReplace = true;
                                          ScreeningCamp = false;
                                          ScreeningCampOngoing = false;
                                          ScreeningCampComing = false;
                                        });
                                      },
                                      child: Container(
                                        width: 80.0,
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
                    _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMScreeningCamp>>(
                future: ApiController.GetDPM_ScreeningCamp(
                    district_code_login,
                    state_code_login,
                    "2019-2020",
                    "",
                    resultScreeningCampsComing),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  }else {
                    List<DataDPMScreeningCamp> ddata = snapshot.data;
                    print('@@---DataDPMScreeningCamp--' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.campname),
                              _buildDataCell(offer.ngoName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),
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
  }

  /// here we are showing the SatelliteCentre Data aon DPm Dashboard.
  Widget DPM_SatelliteCentreDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: satelliteCentreShowData,
          child: Column(
            children: [
              // Horizontal Scrolling Header Row
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
                                      'District:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      '${districtNames}',
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width: 150.0,
                                      child: Text(
                                        'Satellite Centre',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('@@back Pressed----display---');
                                        //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                                        setState(() {
                                          dashboardviewReplace = true;
                                          satelliteCentreShowData = false;
                                        });
                                      },
                                      child: Container(
                                        width: 80.0,
                                        child: Text(
                                          'Back',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Organisation Name'),
                    _buildHeaderCell('Nodal Officer Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Hospital Address'),
                    _buildHeaderCell('Contact No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataDPMsatteliteCenter>>(
                future: ApiController.GetDPM_SatelliteCentre(
                    district_code_login, state_code_login),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // Align "No data found" message to the left
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    );
                  } else {
                    List<DataDPMsatteliteCenter> ddata = snapshot.data;
                    print('@@---DataDPMsatteliteCenter--' +
                        ddata.length.toString());
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.name),
                              _buildDataCell(offer.smanagername),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailId.toString()),
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
  }
  Widget _buildHeaderCellSrNoEyeScreen(String text) {
    return Container(
      height: 35,
      width: 50, // Fixed width to ensure horizontal scrolling
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildHeaderCellEyeScreen(String text) {
    return Container(
      height: 35,
      width: 90, // Fixed width to ensure horizontal scrolling
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
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }


  Widget _buildHeaderCellSrNo(String text) {
    return Container(
      height: 35,
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
      height: 35,
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
  Widget _buildDataCellEyeScreen(String text) {
    return Container(
      height: 35,
      width: 90,
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
          maxLines: 3,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildDataCell(String text) {
    return Container(
      height: 35,
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
          maxLines: 3,
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
        height: 35,
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
  Widget _buildDataCellViewBlueEyeScreen(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 35,
        width: 90,
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
              fontSize: 14, // Set font size to 16 pixels
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNoEyScreen(String text) {
    return Container(
      height: 35,
      width: 50, //
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildDataCellSrNo(String text) {
    return Container(
      height: 35,
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



  //related disease Data view
  Widget _buildHeaderCellSrNoDiseaseData(String text) {
    return Container(
      height: 35,
      width: 40, // Fixed width to ensure horizontal scrolling
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildHeaderCellDiseaseData(String text) {
    return Container(
      height: 35,
      width: 90, // Fixed width to ensure horizontal scrolling
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
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildHeaderCellSrNoDiseaseDataTotal(String text) {
    return Container(
      height: 35,
        width: 40,
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildHeaderCellDiseaseDataAction(String text) {
    return Container(
      height: 35,
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
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellSrNoDiseaseData(String text) {
    return Container(
      height: 35,
        width: 40,
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildDataCellDiseaseData(String text) {
    return Container(
      height: 35,
      width: 90,
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
          maxLines: 3,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }
  Widget _buildDataCellDiseaseTotal(String text) {
    return Container(
      height: 35,
      width: 40, // Fixed width to ensure horizontal scrolling
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
            fontSize: 14, // Set font size to 16 pixels
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlueDiseaseDataAction(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 35,
        width: 80,
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
              fontSize: 14, // Set font size to 16 pixels
            ),
          ),
        ),
      ),
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
    getchangePwd.userid = userId;
    getchangePwd.oldPassword = _oldPasswordControllere.text.toString().trim();
    getchangePwd.newPassword = _newPasswordontrollere.text.toString().trim();
    getchangePwd.confirmPassword =
        _confirmnPasswordontrollere.text.toString().trim();
    print('@@EntryPoimt heres---22' +
        getchangePwd.oldPassword +
        getchangePwd.confirmPassword);

    print('@@EntryPoimt heres---2' +
        getchangePwd.userid +
        getchangePwd.oldPassword +
        getchangePwd.newPassword +
        getchangePwd.confirmPassword);
    if (getchangePwd.oldPassword.isEmpty) {
      Utils.showToast("Please enter old Password !", false);
      return;
    }
    if (getchangePwd.newPassword.isEmpty) {
      Utils.showToast("Please enter new Password !", false);
      return;
    }
    if (getchangePwd.confirmPassword.isEmpty) {
      Utils.showToast("Please enter confirm Password !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.changePAssword(getchangePwd).then((response) async {
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


  Future<void> _SchoolEyeScreening_RegistrationADDnewRecord() async {
    print('@@I am clicking here--1');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";

    _getSchoolEyeScreening_Registrations.yearid = int.tryParse(getfyid) ?? 0;
    _getSchoolEyeScreening_Registrations.monthid = int.tryParse(month_id) ?? 0;
    _getSchoolEyeScreening_Registrations.entry_by = userId;
    _getSchoolEyeScreening_Registrations.status = 1; // for update
    _getSchoolEyeScreening_Registrations.school_name =
        _controllerNameofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.school_address =
        _controllerAddressofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.principal =
        _controllerNameofPrincipal.text.trim();

    print('@@I am clicking here--3');

    try {
      _getSchoolEyeScreening_Registrations.trained_teacher =
          int.parse(_controllerTeacherTrained.text.trim());
      _getSchoolEyeScreening_Registrations.child_screen =
          int.parse(_controllerNumberofchildrenscreening.text.trim());
      _getSchoolEyeScreening_Registrations.child_detect =
          int.parse(_controllerChildrendetectedwithRefractive.text.trim());
      _getSchoolEyeScreening_Registrations.freeglass =
          int.parse(_controllerNumberoffreeGlasses.text.trim());
      _getSchoolEyeScreening_Registrations.schoolid = 0;
      _getSchoolEyeScreening_Registrations.district_code = district_code_login;
      _getSchoolEyeScreening_Registrations.state_code = state_code_login;
      print('@@I am clicking here--20' +
          (_controllerTeacherTrained.text.toString()));
    } catch (e) {
      Utils.showToast(
          "Please ensure all numerical inputs are valid numbers!", false);
      return;
    }

    // Validation checks
    if (_getSchoolEyeScreening_Registrations.school_name.isEmpty) {
      Utils.showToast("Please enter School Name!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.school_address.isEmpty) {
      Utils.showToast("Please enter School Address!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.principal.isEmpty) {
      Utils.showToast("Please enter Name of Principal!", false);
      return;
    }

    // Validation for numerical inputs
    if (_getSchoolEyeScreening_Registrations.trained_teacher <= 0) {
      Utils.showToast(
          "Please enter a valid number for Trained teacher!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_screen <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of children screening!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_detect <= 0) {
      Utils.showToast(
          "Please enter a valid number for Children detected with Refractive Errors!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.freeglass <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of free Glasses!", false);
      return;
    }

    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog1(context);
        ApiController.getSchoolEyeScreening_Registration(
                _getSchoolEyeScreening_Registrations)
            .then((response) async {
          Utils.hideProgressDialog1(context);
          print('@@I am clicking here--8' + response.toString());
          if (response.status) {
            Utils.showToast(response.message, true);
            _controllerNameofSchool.clear();
            _controllerAddressofSchool.clear();
            _controllerNameofPrincipal.clear();
            _controllerTeacherTrained.clear();
            _controllerNumberofchildrenscreening.clear();
            _controllerChildrendetectedwithRefractive.clear();
            _controllerNumberoffreeGlasses.clear();
          } else {
            Utils.showToast(response.message, false);
          }
        });
      } else {
        Utils.showToast(AppConstant.noInternet, false);
      }
    });
  }

  Widget LowVisionRegisterCatract() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterCatracts,
          child: Column(
            children: [
            Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cataract Data for Approval Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Cataract Data for approval clicked');
                      // Add your functionality here
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.approval, color: Colors.blue), // Approval icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Cataract Data for Approval',
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between buttons
                // Back Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Back button clicked');
                      setState(() {
                        dashboardviewReplace = true;

                        // Reset necessary flags
                        DPM_privateMEdicalCollegePendingData = false;
                        NGO_APPorovedClickShowData = false;
                        NGO_PendingClickShowData = false;
                        GetDPM_GH_APPorovedClickShowData = false;
                        GetDPM_GH_PendingClickShowData = false;
                        GetDPM_PrivatePartitionPorovedClickShowData = false;
                        DPM_PrivatePartitionP_PendingClickShowData = false;
                        DPM_privateMEdicalCollegeApprovedData = false;
                        ScreeningCamp = false;
                        ScreeningCampOngoing = false;
                        ScreeningCampComing = false;
                        satelliteCentreShowData = false;
                        ngoApproveRevenueMOU = false;
                        NGOlistDropDownDisplayDatas = false;
                        ngoGovtPrivateOthereHosdpitalDataShow = false;
                        ngolistNewHosdpitalDropDown = false;
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterCornealBlindness = false;
                        LowVisionRegisterVRSurgery = false;
                        ngoEyeScreeningdataShow = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.blue), // Back icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


            // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
        Center(
          child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
            future: _futureCataract,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data == null || snapshot.data.isEmpty) {
                return const Text(
                  'No data found',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                );
              }

              List<DataGetDPM_ScreeningYear> list = snapshot.data;

              if (_selectedUser == null || !list.contains(_selectedUser)) {
                _selectedUser = null; // Remove default selection
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                  hint: const Text(
                    'Select Year',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ), // Hint text when nothing is selected
                  onChanged: (user) => setState(() {
                    _selectedUser = user;
                    getYearCatract = user.name;
                    getfyid = user.fyid;
                    print('@@getYear--' + getYearCatract.toString());
                    print('@@getfyidSelected here----' + getfyid.toString());
                  }),
                  value: _selectedUser,
                  items: list.map(
                        (user) => DropdownMenuItem(
                      value: user,
                      child: Text(
                        user.name,
                        style: const TextStyle(fontSize: 16), // Dropdown item text style
                      ),
                    ),
                  ).toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50], // Background color of dropdown box
                  ),
                  dropdownColor: Colors.blue[50], // Background color of dropdown menu
                  style: const TextStyle(color: Colors.black), // Selected item text style
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                ),
              );
            },
          ),
        ),

        Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    // Background color of the dropdown box
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.black,
                      value: lowVisionDatas,
                      style: TextStyle(color: Colors.black),
                      // Style of the selected item
                      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                      dropdownColor: Colors.blue[50],
                      // Background color of the dropdown menu
                      items: [
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            // Add padding here
                            child: Text(
                              lowVisionRegistry,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        // Add padding to hint text as well
                        child: Text(
                          "Select Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onChanged: (String lowVisionData) {
                        // Updated to accept nullable String
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          switch (lowVisionDatas) {
                            case "NGOs":
                              lowVisionDataValue = 5;
                              break;
                            case "Private Practitioner":
                              lowVisionDataValue = 12;
                              _futureDataBindOrganValuebiggerFive =
                                  GetDPM_Bindorg_New();
                              break;
                            case "Private Medical College":
                              lowVisionDataValue = 13;
                              _futureDataBindOrganValuebiggerFive =
                                  GetDPM_Bindorg_New();
                              break;
                            default:
                              lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print('@@snapshot___5: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCatract = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@lowvisionCataractDataDispla-- click------');
                        setState(() {
                          lowvisionCataractDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionCataractDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align content to the start
                        children: [
                          // Header Row
                          Row(
                            children: [
                              _buildHeaderCellSrNo('S.No.'),
                              _buildHeaderCell('Patient Id'),
                              _buildHeaderCell('Name of Person'),
                              _buildHeaderCell('Mobile No.'),
                              _buildHeaderCell('DOB'),
                              _buildHeaderCell('Gender'),
                              _buildHeaderCell('Organisation Date'),
                              _buildHeaderCell('Operated type'),
                              _buildHeaderCell('NGO'),
                              //Comment for first sprint
                              /*_buildHeaderCell('Action'),*/
                            ],
                          ),
                          Divider(color: Colors.blue, height: 1.0),

                          // Data Rows
                          FutureBuilder<List<Datalowvisionregister_cataract>>(
                            future: ApiController.getDPM_Cataract(
                              district_code_login,
                              state_code_login,
                              npcbNoCatract,
                              getYearCatract,
                              lowVisionDataValue,
                            ),
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
                                // Show 'No data found' message directly under S.No.
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 8.0),
                                  // Adjust padding for alignment
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              } else {
                                List<Datalowvisionregister_cataract> ddata =
                                    snapshot.data;

                                print('@@---ddata: ' +
                                    lowVisionDataValue.toString());
                                return Column(
                                  children: ddata.map((offer) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildDataCellSrNo(
                                            (ddata.indexOf(offer) + 1)
                                                .toString()),
                                        _buildDataCell(offer.pUniqueID),
                                        _buildDataCell(offer.name),
                                        _buildDataCell(offer.mobile.toString()),
                                        _buildDataCell(
                                            Utils.formatDateString(offer.dob)),
                                        _buildDataCell(offer.gender),
                                        _buildDataCell(offer.addressLine1),
                                        _buildDataCell(Utils.formatDateString(
                                            offer.operatedOn)),
                                        _buildDataCell(
                                            offer.ngoName.toString()),
                                        //Comment for first sprint
                                      /*  _buildDataCellViewBlue("View", () {
                                          // Handle the view action here
                                        }),*/
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
            ],
          ),
        ),
      ],
    );
  }

  Widget LowVisionRegisterDataShowGlaucoma() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterGlaucoma,
          child: Column(
            children: [
            Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Glaucoma Data for Approval Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Glaucoma Data for approval clicked');
                      // Add your functionality here
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility, color: Colors.blue), // Approval icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Glaucoma Data for Approval',
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between buttons
                // Back Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Back button clicked');
                      setState(() {
                        dashboardviewReplace = true;

                        // Reset flags
                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterCornealBlindness = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.blue), // Back icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


            // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              getYearGlucoma = userc.name;
                              getfyid = userc.fyid;
                              print('@@getYearGlucoma--' +
                                  getYearGlucoma.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    // Background color of the dropdown box
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.black,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print('@@snapshot___5: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbNoGlucom = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoGlucom = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoGlucom = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoGlucom = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@lowvisionGlucomaDataDispla-- click------');
                        setState(() {
                          lowvisionGlucomaDataDispla = true;
                          ngoEyeScreeningdataShow = false;

                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionGlucomaDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          // Header Row
                          Row(
                            children: [
                              _buildHeaderCellSrNo('S.No.'),
                              _buildHeaderCell('Patient Id'),
                              _buildHeaderCell('Name of Person'),
                              _buildHeaderCell('Mobile No.'),
                              _buildHeaderCell('DOB'),
                              _buildHeaderCell('Gender'),
                              _buildHeaderCell('Organisation Date'),
                              _buildHeaderCell('Operated type'),
                              _buildHeaderCell('NGO'),
                              _buildHeaderCell('Action'),
                            ],
                          ),
                          Divider(color: Colors.blue, height: 1.0),

                          // Data Rows
                          FutureBuilder<List<Datalowvisionregister_Glaucoma>>(
                            future: ApiController.getDPM_Glaucoma(
                              district_code_login,
                              state_code_login,
                              npcbNoGlucom,
                              getYearGlucoma,
                              lowVisionDataValue,
                            ),
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
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              } else {
                                List<Datalowvisionregister_Glaucoma> ddata =
                                    snapshot.data;

                                print('@@---ddata: ' +
                                    lowVisionDataValue.toString());
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDataCellSrNo(
                                              (ddata.indexOf(offer) + 1)
                                                  .toString()),
                                          _buildDataCell(offer.pUniqueID),
                                          _buildDataCell(offer.name),
                                          _buildDataCell(
                                              offer.mobile.toString()),
                                          _buildDataCell(Utils.formatDateString(
                                              offer.dob)),
                                          _buildDataCell(offer.gender),
                                          _buildDataCell(offer.addressLine1),
                                          _buildDataCell(Utils.formatDateString(
                                              offer.operatedOn)),
                                          _buildDataCell(
                                              offer.ngoName.toString()),
                                          _buildDataCellViewBlue("View", () {
                                            // Handle the view action here
                                            // Example: Navigate to a details page with the selected item
                                          }),
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
            ],
          ),
        ),
      ],
    );
  }

  //pending here
  Widget LowVisionRegisterDataShowDiabitic() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterDiabitic,
          child: Column(
            children: [
            Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Diabetic Data for Approval Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Diabetic Data for approval clicked');
                      // Handle actions here
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for better contrast
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // Shadow color
                            blurRadius: 4, // Shadow blur radius
                            offset: Offset(2, 2), // Shadow offset
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.approval, color: Colors.blue), // Approval icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Diabetic Data for Approval',
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between the two buttons
                // Back Button
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print('Back button clicked');
                      setState(() {
                        dashboardviewReplace = true;

                        LowVisionRegisterCatracts = false;
                        LowVisionRegisterDiabitic = false;
                        LowVisionRegisterGlaucoma = false;
                        LowVisionRegisterCornealBlindness = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for better contrast
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // Shadow color
                            blurRadius: 4, // Shadow blur radius
                            offset: Offset(2, 2), // Shadow offset
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.blue), // Back icon
                          SizedBox(width: 8), // Space between icon and text
                          Expanded(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


            // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _futureDiabetic,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (usercn) => setState(() {
                              _selectedUser = usercn;
                              getYearDiabitic = usercn.name;
                              getfyid = usercn.fyid;
                              print('@@getYearDiabitic--' +
                                  getYearDiabitic.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              // Background color of the dropdown box
              border: Border.all(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                focusColor: Colors.black,
                value: lowVisionDatas,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                items: <String>[
                  'NGOs',
                  'Private Practitioner',
                  'Private Medical College',
                ].map<DropdownMenuItem<String>>((String lowVisionRegistry) {
                  return DropdownMenuItem<String>(
                    value: lowVisionRegistry,
                    child: Text(
                      lowVisionRegistry,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  "Select Type",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (String lowVisionData) {
                  setState(() {
                    lowVisionDatas = lowVisionData;

                    if (lowVisionDatas == "NGOs") {
                      lowVisionDataValue = 5;
                    } else if (lowVisionDatas == "Private Practitioner") {
                      lowVisionDataValue = 12;
                      _futureDataBindOrganValuebiggerFive = GetDPM_Bindorg_New();
                    } else if (lowVisionData == "Private Medical College") {
                      lowVisionDataValue = 13;
                      _futureDataBindOrganValuebiggerFive = GetDPM_Bindorg_New();
                    } else {
                      lowVisionDataValue = 0;
                    }
                  });
                },
              ),
            ),
          ),
        ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print('@@snapshot___5: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbNoDiabitic =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoDiabitic =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoDiabitic =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoDiabitic =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@lowvisionDiabiticDataDispla-- click------');
                        setState(() {
                          lowvisionDiabiticDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionDiabiticDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          // Header Row
                          Row(
                            children: [
                              _buildHeaderCellSrNo('S.No.'),
                              _buildHeaderCell('Patient Id'),
                              _buildHeaderCell('Name of Person'),
                              _buildHeaderCell('Mobile No.'),
                              _buildHeaderCell('DOB'),
                              _buildHeaderCell('Gender'),
                              _buildHeaderCell('Organisation Date'),
                              _buildHeaderCell('Operated type'),
                              _buildHeaderCell('NGO'),
                              _buildHeaderCell('Action'),
                            ],
                          ),
                          Divider(color: Colors.blue, height: 1.0),

                          // Data Rows
                          FutureBuilder<List<Datalowvisonregister_diabitic>>(
                            future: ApiController.getDPM_Daiabetic(
                              district_code_login,
                              state_code_login,
                              npcbNoDiabitic,
                              getYearDiabitic,
                              lowVisionDataValue,
                            ),
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
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              } else {
                                List<Datalowvisonregister_diabitic> ddata =
                                    snapshot.data;

                                print('@@---ddata: ' +
                                    lowVisionDataValue.toString());
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: ddata.map((offer) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDataCellSrNo(
                                              (ddata.indexOf(offer) + 1)
                                                  .toString()),
                                          _buildDataCell(offer.pUniqueID),
                                          _buildDataCell(offer.name),
                                          _buildDataCell(
                                              offer.mobile.toString()),
                                          _buildDataCell(Utils.formatDateString(
                                              offer.dob)),
                                          _buildDataCell(offer.gender),
                                          _buildDataCell(offer.addressLine1),
                                          _buildDataCell(Utils.formatDateString(
                                              offer.operatedOn)),
                                          _buildDataCell(
                                              offer.ngoName.toString()),
                                          _buildDataCellViewBlue("View", () {
                                            // Handle the view action here
                                            // Example: Navigate to a details page with the selected item
                                          }),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget LowVisionRegisterDataShowCornealBlindness() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterCornealBlindness,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print(
                                'LowVisionRegisterCornealBlindness Data for approval clicked');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Corneal Blindness Data for approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print(
                                '@@Corneal Blindness  Data for approval clicked');
                            setState(() {
                              dashboardviewReplace = true;

                              LowVisionRegisterCatracts = false;
                              LowVisionRegisterDiabitic = false;
                              LowVisionRegisterGlaucoma = false;
                              LowVisionRegisterCornealBlindness = false;
                            });

                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,fontWeight: FontWeight.bold), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              getYearCornealBlindness = userc.name;
                              getfyid = userc.fyid;
                              print('@@getYearCornealBlindness--' +
                                  getYearDiabitic.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    // Background color of the dropdown box
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.black,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print('@@snapshot___5: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbNoCornealBlindness =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCornealBlindness =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCornealBlindness =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbNoCornealBlindness =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCornealBlindnessDataDispla-- click------');
                        setState(() {
                          lowvisionCornealBlindnessDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionCornealBlindnessDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DatalowvisionCornealBlindness>>(
                      future: ApiController.getDPM_CornealBlindness(
                        district_code_login,
                        state_code_login,
                        npcbNoCornealBlindness,
                        getYearCornealBlindness,
                        lowVisionDataValue,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DatalowvisionCornealBlindness> ddata =
                              snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.ngoName.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget LowVisionRegisterDataShowVRSurgery() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterVRSurgery,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print(
                                'LowVisionRegisterVRSurgery Data for approval clicked');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'VR Surgery Data for approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print(
                                '@@VR Surgery Data for approval Data for approval clicked');
                            setState(() {
                              dashboardviewReplace = true;

                              LowVisionRegisterCatracts = false;
                              LowVisionRegisterDiabitic = false;
                              LowVisionRegisterGlaucoma = false;
                              LowVisionRegisterCornealBlindness = false;
                              LowVisionRegisterVRSurgery = false;
                            });

                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,fontWeight: FontWeight.bold), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              gerYearVRsurgery = userc.name;
                              getfyid = userc.fyid;
                              print('@@gerYearVRsurgery--' +
                                  gerYearVRsurgery.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Blue background color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.black,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print('@@snapshot___5: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbVRSurgery = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbVRSurgery = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbVRSurgery = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbVRSurgery = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCornealBlindnessDataDispla-- click------');
                        setState(() {
                          lowvisionVRSurgeryDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionVRSurgeryDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DatalowvisionVRSurgery>>(
                      future: ApiController.getDPM_VRSurgery(
                        district_code_login,
                        state_code_login,
                        npcbVRSurgery,
                        gerYearVRsurgery,
                        lowVisionDataValue,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        }else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DatalowvisionVRSurgery> ddata = snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.ngoName.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }

  Future<List<DataBindOrgan>> GetDPM_Bindorg() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg'),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode({
          "district_code": district_code_login,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final BindOrgan bindOrgan = BindOrgan.fromJson(json);
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

  Future<List<DataBindOrganValuebiggerFive>> GetDPM_Bindorg_New() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg_New'),
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: jsonEncode({
          "district_code": district_code_login,
          "organisationType": lowVisionDataValue,
        }),
      );
      print("@@GetDPM_Bindorg_New--bodyprint--:" +
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/GetDPM_Bindorg_New" +
          lowVisionDataValue.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final BindOrganValuebiggerFive bindOrganValuebiggerFive =
            BindOrganValuebiggerFive.fromJson(json);
        if (bindOrganValuebiggerFive.status) {
          print('@@bindOrganValuebiggerFive: ' +
              bindOrganValuebiggerFive.message);
        }
        return bindOrganValuebiggerFive.data;
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

  void _showPopupMenuChildhoodBlindness() async {
    final RenderBox dropdownRenderBox =
        _dropdownKey.currentContext.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;

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
          child: Text("Congenital Ptosis"),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text("Intraocular Trauma in Children"),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Text("Retinoblastoma"),
        ),
        PopupMenuItem<int>(
          value: 4,
          child: Text("Retinopathy of Prematurity"),
        ),
        PopupMenuItem<int>(
          value: 5,
          child: Text("Squint"),
        ),
      ],
      elevation: 8.0,
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleMenuSelection(selectedValue); // Handling the click event
      }
    });
  }

// Function to handle the selected value
  void _handleMenuSelection(int value) {
    switch (value) {
      case 1:
        print("@@Selected: Congenital Ptosis");
        _future = getDPM_ScreeningYear();
        _futureBindOrgan = GetDPM_Bindorg();
        dashboardviewReplace = false;
        LowVisionRegisterChildhoodCongenitalPtosiss = true;
        LowVisionRegisterChildhoodTrauma = false;
        LowVisionRegisterSquint = false;
        // Implement any action for Congenital Ptosis
        break;
      case 2:
        print("Selected: Intraocular Trauma in Children");
        print("@@Selected: Congenital Ptosis");
        _future = getDPM_ScreeningYear();
        _futureBindOrgan = GetDPM_Bindorg();
        dashboardviewReplace = false;
        LowVisionRegisterChildhoodCongenitalPtosiss = false;
        LowVisionRegisterChildhoodTrauma = true;
        LowVisionRegisterSquint = false;
        // Implement any action for Intraocular Trauma
        break;
      case 3:
        print("Selected: Retinoblastoma");
        // Implement any action for Retinoblastoma
        break;
      case 4:
        print("Selected: Retinopathy of Prematurity");
        // Implement any action for Retinopathy of Prematurity
        break;
      case 5:
        print("Selected: Squint");
        // Implement any action for Squint
        print("Selected: Intraocular Trauma in Children");
        print("@@Selected: Congenital Ptosis");
        _future = getDPM_ScreeningYear();
        _futureBindOrgan = GetDPM_Bindorg();
        dashboardviewReplace = false;
        LowVisionRegisterChildhoodCongenitalPtosiss = false;
        LowVisionRegisterChildhoodTrauma = false;
        LowVisionRegisterSquint = true;
        break;
      default:
        print("Unknown selection");
    }
  }

  Widget LowVisionRegisterChildhoodCongenitalPtosis() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterChildhoodCongenitalPtosiss,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print(
                                'Congenital Ptosis Data for approval clicked');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Congenital Ptosis Data for approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('@@Congenital Ptosis clicked');
                            setState(() {
                              dashboardviewReplace = true;

                              LowVisionRegisterCatracts = false;
                              LowVisionRegisterDiabitic = false;
                              LowVisionRegisterGlaucoma = false;
                              LowVisionRegisterCornealBlindness = false;
                              LowVisionRegisterVRSurgery = false;
                            });

                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              gerYearCongenitalPtosis = userc.name;
                              getfyid = userc.fyid;
                              print('@@gerYearCongenitalPtosis--' +
                                  gerYearCongenitalPtosis.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbCongenitalPtosis =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        print(
                            '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_11: $lowVisionDataValue');

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbCongenitalPtosis =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_2: $lowVisionDataValue');

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_3: $lowVisionDataValue');

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbCongenitalPtosis =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbCongenitalPtosis =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCongenitalPtosisDataDispla-- click------');
                        setState(() {
                          lowvisionCongenitalPtosisDataDispla = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionCongenitalPtosisDataDispla)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataGetDPMCongenitalPtosis>>(
                      future: ApiController.getDPM_CongenitalPtosis(
                        district_code_login,
                        state_code_login,
                        npcbCongenitalPtosis,
                        gerYearCongenitalPtosis,
                        lowVisionDataValue,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DataGetDPMCongenitalPtosis> ddata =
                              snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.ngoName.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget LowVisionRegisterChildhoodTraumas() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterChildhoodTrauma,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('Trauma in Children Data for approval');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Trauma in Children Data for approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('@@Trauma in Children');
                            setState(() {
                              dashboardviewReplace = true;

                              LowVisionRegisterCatracts = false;
                              LowVisionRegisterDiabitic = false;
                              LowVisionRegisterGlaucoma = false;
                              LowVisionRegisterCornealBlindness = false;
                              LowVisionRegisterVRSurgery = false;
                              LowVisionRegisterChildhoodCongenitalPtosiss =
                                  false;
                            });

                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              gerYearTraumaChildren = userc.name;
                              getfyid = userc.fyid;
                              print('@@gerYearCongenitalPtosis--' +
                                  gerYearTraumaChildren.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        print(
                            '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_11: $lowVisionDataValue');

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_2: $lowVisionDataValue');

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_3: $lowVisionDataValue');

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCongenitalPtosisDataDispla-- click------');
                        setState(() {
                          lowvisionTrauma = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionTrauma)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataGetDPMTraumaChildren>>(
                      future: ApiController.getDPM_Trauma(
                        district_code_login,
                        state_code_login,
                        npcbTraumaChildren,
                        gerYearTraumaChildren,
                        lowVisionDataValue,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DataGetDPMTraumaChildren> ddata = snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.ngoName.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget LowVisionRegisterSquints() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterSquint,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('Squint in Children Data for approval');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Squint Data for approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('@@Squint in Children');
                            setState(() {
                              dashboardviewReplace = true;

                              LowVisionRegisterCatracts = false;
                              LowVisionRegisterDiabitic = false;
                              LowVisionRegisterGlaucoma = false;
                              LowVisionRegisterCornealBlindness = false;
                              LowVisionRegisterVRSurgery = false;
                              LowVisionRegisterChildhoodCongenitalPtosiss =
                                  false;
                              LowVisionRegisterChildhoodTrauma = false;
                            });

                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              gerYearSquint = userc.name;
                              getfyid = userc.fyid;
                              print('@@gerYearCongenitalPtosis--' +
                                  gerYearTraumaChildren.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        print(
                            '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_11: $lowVisionDataValue');

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_2: $lowVisionDataValue');

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_3: $lowVisionDataValue');

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCongenitalPtosisDataDispla-- click------');
                        setState(() {
                          lowvisionSquint = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionSquint)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataGetDPMSquint>>(
                      future: ApiController.getDPM_Squintapproval(
                        493,
                        0,
                        npcbSquint,
                        "4", //desfault send as per kamal
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DataGetDPMSquint> ddata = snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.campId.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget eyBankCollection() {
    return Column(
      children: [
        Visibility(
          visible: eyBankCollections,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle approval action
                            print('Eye Bank Collection--');
                            // You can also navigate or update some data here
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Blue background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              // Use Alignment.centerLeft, Alignment.centerRight, etc. for other alignments
                              child: Text(
                                'Eye Bank Collection Data For DPM Approval',
                                style: TextStyle(
                                    color: Colors.white), // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Scrolling Header Row
              Center(
                child: FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());

                    List list =
                        snapshot.data.map<DataGetDPM_ScreeningYear>((district) {
                      return district;
                    }).toList();
                    if (_selectedUser == null ||
                        list.contains(_selectedUser) == false) {
                      _selectedUser = list.first;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select year:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Added space between label and dropdown
                          DropdownButtonFormField<DataGetDPM_ScreeningYear>(
                            onChanged: (userc) => setState(() {
                              _selectedUser = userc;
                              gerYearSquint = userc.name;
                              getfyid = userc.fyid;
                              print('@@gerYearCongenitalPtosis--' +
                                  gerYearTraumaChildren.toString());
                              print('@@getfyidSelected here----' +
                                  getfyid.toString());
                              ;
                            }),
                            value: _selectedUser,
                            items: [
                              ...snapshot.data.map(
                                (user) => DropdownMenuItem(
                                  value: user,
                                  child: Text(
                                    '${user.name}',
                                    style: TextStyle(
                                        fontSize:
                                            16), // Text style inside dropdown
                                  ),
                                ),
                              ),
                            ],
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
                              fillColor: Colors.blue[
                                  50], // Background color of the dropdown box
                            ),
                            dropdownColor: Colors.blue[50],
                            // Background color of the dropdown menu
                            style: TextStyle(color: Colors.black),
                            // Style of the selected item
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blue), // Dropdown icon style
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: lowVisionDatas,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: <String>[
                        'NGOs',
                        'Private Practitioner',
                        'Private Medical College',
                      ].map<DropdownMenuItem<String>>(
                          (String lowVisionRegistry) {
                        return DropdownMenuItem<String>(
                          value: lowVisionRegistry,
                          child: Text(
                            lowVisionRegistry,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select Type",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String lowVisionData) {
                        setState(() {
                          lowVisionDatas = lowVisionData;

                          if (lowVisionDatas == "NGOs") {
                            lowVisionDataValue = 5;
                          } else if (lowVisionDatas == "Private Practitioner") {
                            lowVisionDataValue = 12;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else if (lowVisionData ==
                              "Private Medical College") {
                            lowVisionDataValue = 13;
                            _futureDataBindOrganValuebiggerFive =
                                GetDPM_Bindorg_New();
                          } else {
                            lowVisionDataValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),

              if (lowVisionDataValue == 5)
                Center(
                  child: FutureBuilder<List<DataBindOrgan>>(
                    future: _futureBindOrgan,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      List<DataBindOrgan> list = snapshot.data;
                      developer.log('@@snapshot___5: $list');
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                      if (_selectBindOrgniasation == null ||
                          !list.contains(_selectBindOrgniasation)) {
                        _selectBindOrgniasation =
                            list.isNotEmpty ? list.first : null;
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<DataBindOrgan>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasation = userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.name ?? '';
                                    npcbTraumaChildren =
                                        userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasation,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<DataBindOrgan>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.name,

                                      maxLines: 2,
                                      // Set max lines to 2
                                      overflow: TextOverflow.ellipsis,
                                      // Handle overflow
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 12)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        print(
                            '@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_11: $lowVisionDataValue');

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 13)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Only show CircularProgressIndicator if the connection is still waiting
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // Once data is available, check the list
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_2: $lowVisionDataValue');

                      // If no data is found, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown if there's no data
                                items: [],
                                // Provide an empty list
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Select first item if not already selected
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }
                      print(
                          '@@LowVisionRegisterChildhoodCongenitalPtosiss_3: $lowVisionDataValue');

                      // Render the dropdown with available data
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                )
              else if (lowVisionDataValue == 0)
                Center(
                  child: FutureBuilder<List<DataBindOrganValuebiggerFive>>(
                    future: _futureDataBindOrganValuebiggerFive,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Show CircularProgressIndicator only while loading (waiting for data)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      // List from the snapshot
                      List<DataBindOrganValuebiggerFive> list = snapshot.data;

                      // If the list is empty or null, show an empty dropdown with a message
                      if (list == null || list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                          child: Column(
                            children: [
                              const Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: null,
                                // Disable dropdown when no data
                                items: [],
                                // Empty list as no items are available
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                hint: const Text('No items available'),
                                disabledHint: const Text('No items to select'),
                              ),
                            ],
                          ),
                        );
                      }

                      // If an item is not selected, select the first one by default
                      if (_selectBindOrgniasationBiggerFive == null ||
                          !list.contains(_selectBindOrgniasationBiggerFive)) {
                        _selectBindOrgniasationBiggerFive =
                            list.isNotEmpty ? list.first : null;
                      }

                      // Render dropdown with data if available
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Select:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<
                                  DataBindOrganValuebiggerFive>(
                                onChanged: (userbindOrgan) {
                                  setState(() {
                                    _selectBindOrgniasationBiggerFive =
                                        userbindOrgan;
                                    bindOrganisationNAme =
                                        userbindOrgan?.oName ?? '';
                                    npcbSquint = userbindOrgan?.npcbNo ?? '';
                                  });
                                },
                                value: _selectBindOrgniasationBiggerFive,
                                items: list.map((userbindorgansa) {
                                  return DropdownMenuItem<
                                      DataBindOrganValuebiggerFive>(
                                    value: userbindorgansa,
                                    child: Text(
                                      userbindorgansa.oName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        ),
                      );
                    },
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            '@@lowvisionCongenitalPtosisDataDispla-- click------');
                        setState(() {
                          lowvisionSquint = true;
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              if (lowvisionSquint)
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Patient Id'),
                          _buildHeaderCell('Name of Person'),
                          _buildHeaderCell('Mobile No.'),
                          _buildHeaderCell('DOB'),
                          _buildHeaderCell('Gender'),
                          _buildHeaderCell('Organisation Date'),
                          _buildHeaderCell('Operated type'),
                          _buildHeaderCell('NGO'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataGetDPMSquint>>(
                      future: ApiController.getDPM_Squintapproval(
                        493,
                        0,
                        npcbSquint,
                        "4", //desfault send as per kamal
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          );
                        }else {
                          List<DataGetDPMSquint> ddata = snapshot.data;

                          print('@@---ddata: ' + lowVisionDataValue.toString());
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: ddata.map((offer) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDataCellSrNo(
                                        (ddata.indexOf(offer) + 1).toString()),
                                    _buildDataCell(offer.pUniqueID),
                                    _buildDataCell(offer.name),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.dob)),
                                    _buildDataCell((offer.gender)),
                                    _buildDataCell((offer.addressLine1)),
                                    _buildDataCell(Utils.formatDateString(
                                        offer.operatedOn)),
                                    _buildDataCell(offer.campId.toString()),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the view action here
                                      // Example: Navigate to a details page with the selected item
                                    }),
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
            ],
          ),
        ),
      ],
    );
  }
  Future<void> showLogoutDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
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
                logoutUserStatic();  // Call the logout function
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

class DPMDashboardParamsData {
  int districtidDPM;
  int stateidDPM;
  int old_districtidDPM;
  String useridDPM;
  String roleidDPM;
  int statusDPM;
  String financialYearDPM;
}

class GetDPM_NGOApplication {
  int district_code;
  int state_code;
}

class GetDPM_NGOApprovedPendingFields {
  int district_code;
  int state_code;
  int status;
}

class GetChangeAPsswordFields {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}

class GetSchoolEyeScreening_Registrations {
  int status;
  String principal;
  int monthid;
  int yearid;
  String entry_by;
  int trained_teacher;
  int child_screen;
  int child_detect;
  int freeglass;
  String school_name;
  String school_address;
  int schoolid;
  int district_code;
  int state_code;
}
