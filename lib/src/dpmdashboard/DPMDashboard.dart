import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMEyeSchoolScreens.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMReportScreen.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrganValuebiggerFive.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMGovtPrivateOrganisationTypeData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRivateMEdicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMScreeningCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMsatteliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_MOUApprove.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetNewHospitalData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientAPprovedwithFinanceYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientPendingwithFinance.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
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
      npcbCongenitalPtosis;
  bool lowvisionGlucomaDataDispla = false;
  bool lowvisionDiabiticDataDispla = false;
  bool lowvisionCataractDataDispla = false;
  bool lowvisionCornealBlindnessDataDispla = false;
  bool lowvisionVRSurgeryDataDispla = false;
  bool lowvisionCongenitalPtosisDataDispla=false;
  bool LowVisionRegisterCornealBlindness = false;
  bool LowVisionRegisterVRSurgery = false;
  String getYearGlucoma,
      getYearCatract,
      getYearDiabitic,
      getYearCornealBlindness,
      gerYearVRsurgery,
      gerYearCongenitalPtosis;
  bool showChildhoodBlindnessDropdown = false;
  final GlobalKey _dropdownKey = GlobalKey();

  bool LowVisionRegisterChildhoodCongenitalPtosiss = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardviewReplace = true;
    _getDPMDashbnoardData();
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
                  /* dashboardviewReplace = false;
                  chnagePAsswordView = true;*/
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('@@dashboardviewReplace----display---');
                          //  Navigator.of(context).pop(context); // it deletes from top from stack previos screen
                          setState(() {
                            NGOlistDropDownDisplayDatas = false;

                            dashboardviewReplace = true;
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

                      SizedBox(width: 8.0), // Add spacing between widgets
                      Container(
                        width: 170.0,
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
                                'NGO Application',
                                'New Hospital',
                                'Govt/private/Other',
                                'Approve Renew MOU',
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
                                "Approve Application",
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
                                    LowVisionRegisterChildhoodCongenitalPtosiss =
                                        false;
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
                                'Cataract',
                                'Diabetic',
                                'Glaucoma',
                                'Corneal Blindness',
                                'VR Surgery',
                                'Childhood Blindness',
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
                                "Low Vision Register",
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
                                    print('@@NGO--1' + _chosenValueLOWVision);
                                  } else if (_chosenValueLOWVision ==
                                      "Diabetic") {
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
                                  } else if (_chosenValueLOWVision ==
                                      "Corneal Blindness") {
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
                                  } else if (_chosenValueLOWVision ==
                                      "VR Surgery") {
                                    print('@@Childhood--' +
                                        _chosenValueLOWVision);
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
                                      _showPopupMenuChildhoodBlindness();
                                    } else {
                                      print('@@Childhood--2' +
                                          _chosenValueLOWVision);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 8.0),
                      InkWell(
                        onTap: () {
                          print('@@EyeScreening----click here---');
                          setState(() {
                            dashboardviewReplace = false;
                            ngoEyeScreeningdataShow = true;
                            dashboardviewReplace = false;
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
                        },
                        child: Container(
                          width: 100.0,
                          child: Text(
                            'Eye Screening',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                                "Eye Blink",
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
                                  } else if (_chosenEyeBank == "Eye Donation") {
                                  } else if (_chosenEyeBank ==
                                      "Eyeball Collection Via Eye Bank") {}
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
            ),
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
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 25, 178, 238),
                                Color.fromARGB(255, 21, 236, 229)
                              ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                                      20, 10, 20.0, 0),
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
                                                      20, 10, 20.0, 0),
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 25, 178, 238),
                                      Color.fromARGB(255, 21, 236, 229)
                                    ],
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
                                                      20, 10, 20.0, 0),
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
                                                      20, 10, 20.0, 0),
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
                                        'NGO Application)',
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
                                          NGOlistDropDownDisplayDatas = false;
                                          LowVisionRegisterCatracts = false;
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
                    _buildHeaderCell('NGO Dapan No.'),
                    _buildHeaderCell('Member Name'),
                    _buildHeaderCell('Email'),
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataNGOAPPlicationDropDownDPm>>(
                future: ApiController.getDPM_NGOApplicationDropDown(
                    district_code_login, state_code_login),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Utils.getEmptyView("No data found");
                  } else {
                    List<DataNGOAPPlicationDropDownDPm> ddata = snapshot.data;
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
                              _buildDataCell(offer.name),
                              _buildDataCell(offer.darpanNo),
                              _buildDataCell(offer.memberName),
                              _buildDataCell(offer.emailid),
                              _buildDataCellViewBlue("Edit", () {
                                // Handle the edit action here
                                // For example, navigate to an edit screen or show a dialog
                                //  print('Edit clicked for item: ${offer.schoolName}');
                                //  Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                // Example: Navigate to an edit page with the selected item
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
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

  Widget NGOlistnewHospitalDropdownData() {
    return Column(
      children: [
        Visibility(
          visible: ngolistNewHosdpitalDropDown,
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
                        'Hospital list for Approval',
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
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('NGO Dapan No.'),
                    _buildHeaderCell('Ngo  Name'),
                    _buildHeaderCell('Hospital ID'),
                    _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetNewHospitalData>>(
                future: ApiController.getDPM_HospitalApproval(
                    district_code_login, state_code_login),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Utils.getEmptyView("No data found");
                  } else {
                    List<DataGetNewHospitalData> ddata = snapshot.data;
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
                              _buildDataCell(offer.darpanNo),
                              _buildDataCell(offer.name),
                              _buildDataCell(offer.hRegID),
                              _buildDataCell(offer.hName),
                              _buildDataCellViewBlue("Edit", () {
                                // Handle the edit action here
                                // For example, navigate to an edit screen or show a dialog
                                //  print('Edit clicked for item: ${offer.schoolName}');
                                //  Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                // Example: Navigate to an edit page with the selected item
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
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

  Widget NGOlistgovtPvtotherHospitalDropdownData() {
    return Column(
      children: [
        Visibility(
          visible: ngoGovtPrivateOthereHosdpitalDataShow,
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
              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
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
                      value: oganisationTypeGovtPrivateDRopDown,
                      //elevation: 5,
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
                          print('@@oganisationTypeGovtPrivateDRopDown--' +
                              oganisationTypeGovtPrivateDRopDown);
                          if (oganisationTypeGovtPrivateDRopDown ==
                              "Govt. District Hospital/Govt.MEdical College") {
                            dropDownvalueOrgnbaistaionType = 10;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                                oganisationTypeGovtPrivateDRopDown +
                                "-----" +
                                dropDownvalueOrgnbaistaionType.toString());
                          } else if (oganisationTypeGovtPrivateDRopDown ==
                              "CHC/Govt. Sub-Dist. Hospital") {
                            dropDownvalueOrgnbaistaionType = 11;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                                oganisationTypeGovtPrivateDRopDown +
                                "-----" +
                                dropDownvalueOrgnbaistaionType.toString());
                          } else if (oganisationTypeGovtPrivateDRopDown ==
                              "Private Practitioner") {
                            dropDownvalueOrgnbaistaionType = 12;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                                oganisationTypeGovtPrivateDRopDown +
                                "-----" +
                                dropDownvalueOrgnbaistaionType.toString());
                          } else if (oganisationTypeGovtPrivateDRopDown ==
                              "Private Medical College") {
                            dropDownvalueOrgnbaistaionType = 13;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                                oganisationTypeGovtPrivateDRopDown +
                                "-----" +
                                dropDownvalueOrgnbaistaionType.toString());
                          } else if (oganisationTypeGovtPrivateDRopDown ==
                              "Other(Institution not claiming fund from NPCBVI)") {
                            dropDownvalueOrgnbaistaionType = 14;
                            print('@@oganisationTypeGovtPrivateDRopDown--' +
                                oganisationTypeGovtPrivateDRopDown +
                                "-----" +
                                dropDownvalueOrgnbaistaionType.toString());
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
                        print('@@GovtPvtSubmit clkick------');
                        setState(() {
                          organisationGovtPrivateSelectionAfter = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: organisationGovtPrivateSelectionAfter,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('NGO Dapan No.'),
                          _buildHeaderCell('Ngo Name'),
                          _buildHeaderCell('Hospital ID'),
                          _buildHeaderCell('Hospital Name'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataDPMGovtPrivateOrganisationTypeData>>(
                      future: ApiController.getDPM_GovtPvtOther(
                          district_code_login,
                          state_code_login,
                          dropDownvalueOrgnbaistaionType),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataDPMGovtPrivateOrganisationTypeData> ddata =
                              snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
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
                                    _buildDataCell(offer.npcbNo),
                                    _buildDataCell(offer.oName),
                                    _buildDataCell(offer.nodalOfficerName),
                                    _buildDataCell(offer.emailId),
                                    _buildDataCellViewBlue("View", () {
                                      // Handle the edit action here
                                      // For example, navigate to an edit screen or show a dialog
                                      //  print('Edit clicked for item: ${offer.schoolName}');
                                      //  Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                      // Example: Navigate to an edit page with the selected item
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
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
    );
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
              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
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
                      value: ngoApproveRevenuMOU,
                      //elevation: 5,
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: ngodependOrganbisatioSelectValue,
                      //elevation: 5,
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
                        print('@@ApproveRevenueMOU-- clkick------');
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
                      child: Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Hospital Id'),
                          _buildHeaderCell('Hospital Name'),
                          _buildHeaderCell('Mobile'),
                          _buildHeaderCell('Email'),
                          _buildHeaderCell('From Date'),
                          _buildHeaderCell('To Date'),
                          _buildHeaderCell('Status'),
                          _buildHeaderCell('MOU'),
                          _buildHeaderCell('Action'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    FutureBuilder<List<DataGetDPM_MOUApprove>>(
                      future: ApiController.getDPM_MOUApprove(
                          district_code_login,
                          ngoApproveRevenueMOUValue,
                          ngodependOrganbisatioSelectValuessss),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<DataGetDPM_MOUApprove> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
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
                                    _buildDataCell(offer.hRegID),
                                    _buildDataCell(offer.hName),
                                    _buildDataCell(offer.mobile.toString()),
                                    _buildDataCell(offer.emailId),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.fromDate)),
                                    _buildDataCell(
                                        Utils.formatDateString(offer.toDate)),
                                    _buildDataCell(offer.vstatus.toString()),
                                    _buildDataCellViewBlue(offer.file, () {
                                      // Handle the edit action here
                                      // For example, navigate to an edit screen or show a dialog
                                      //  print('Edit clicked for item: ${offer.schoolName}');
                                      //  Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                      // Example: Navigate to an edit page with the selected item
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
                                    }),
                                    _buildDataCellViewBlue(" ", () {
                                      // Handle the edit action here
                                      // For example, navigate to an edit screen or show a dialog
                                      //  print('Edit clicked for item: ${offer.schoolName}');
                                      //  Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                      // Example: Navigate to an edit page with the selected item
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
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
    );
  }

  Widget ngolistEyeScreeningShowData() {
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
                          child: Text(
                            'School Eye Screening',
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
              // Horizontal Scrolling Header Row
              SizedBox(width: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('Year'),
                    _buildHeaderCell('Month'),
                    _buildHeaderCell('School name'),
                    _buildHeaderCell('Teacher Trained'),
                    _buildHeaderCell('Children screened'),
                    _buildHeaderCell(
                        'Children detected with Refractive Errors'),
                    _buildHeaderCell('Free Glasses Provided by Organization'),
                    _buildHeaderCell('Action'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetEyeScreening>>(
                future: ApiController.GetDPM_EyeScreening(
                    district_code_login, state_code_login, userId),
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
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDataCellSrNo(
                                  (ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.yearname),
                              _buildDataCell(offer.monthname),
                              _buildDataCell(offer.schoolName),
                              _buildDataCell(offer.schoolAddress),
                              _buildDataCell(offer.trainedTeacher.toString()),
                              _buildDataCell(offer.childScreen.toString()),
                              _buildDataCell(offer.childDetect.toString()),
                              _buildDataCell(offer.freeglass.toString()),
                              _buildDataCellViewBlue("Edit", () {
                                // Handle the edit action here
                                // For example, navigate to an edit screen or show a dialog
                                print(
                                    '@@Edit clicked for item: ${offer.schoolid}');
                                //   Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

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

                                /*  Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => DPMEyeSchoolScreens()),

                                 );*/
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
                                        child: TextField(
                                          controller: _controllerNameofSchool,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelText: offer.schoolName,
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                        child: TextField(
                                          controller:
                                              _controllerAddressofSchool,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelText: offer.schoolAddress,
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                        child: TextField(
                                          controller:
                                              _controllerNameofPrincipal,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelText: offer.principal,
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                          controller: _controllerTeacherTrained,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            hintText:
                                                offer.trainedTeacher.toString(),
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                          controller:
                                              _controllerNumberofchildrenscreening,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            hintText:
                                                offer.childScreen.toString(),
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                          controller:
                                              _controllerChildrendetectedwithRefractive,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            hintText:
                                                offer.childDetect.toString(),
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                          controller:
                                              _controllerNumberoffreeGlasses,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            hintText:
                                                offer.freeglass.toString(),
                                            // Assuming 'offer.schoolName' is a dynamic value
                                            labelStyle: TextStyle(
                                                color: Colors.blueGrey),
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
                                        child: Text('Update'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          print('@@I am clicking here--');
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

                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      developer.log('@@snapshot' + snapshot.data.toString());
                      print('@@snapshot___5: ');
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
                Column(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                controller: _controllerNameofSchool,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                controller: _controllerAddressofSchool,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                controller: _controllerNameofPrincipal,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                controller: _controllerNumberoffreeGlasses,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  // Assuming 'offer.schoolName' is a dynamic value

                                  // Color of the label
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
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
                                print('@@AADNEWRECORD Click Submit--');
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
                  // Horizontal Scrolling Header Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('Disease Name'),
                        _buildHeaderCell('Total'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataGetPatientAPprovedwithFinanceYear>>(
                    future: ApiController.GetDPM_Patients_Approved_finacne(
                        district_code_login,
                        state_code_login,
                        currentFinancialYear),
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
                        List<DataGetPatientAPprovedwithFinanceYear> ddata =
                            snapshot.data;
                        print('@@---ddata' + ddata.length.toString());
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
                                  _buildDataCell(offer.diseaseName),
                                  _buildDataCell(
                                      offer.totalApproPending.toString()),
                                  _buildDataCellViewBlue("View", () {
                                    // Handle the edit action here
                                    // For example, navigate to an edit screen or show a dialog
                                    print(
                                        '@@Edit clicked for item: ${offer.diseaseId}');
                                    //   Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                    showDiseaseApprovedPatintViewClick(offer.diseaseId);
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
            height: screenHeight * 0.7, // 70% of screen height
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Horizontal Scrolling Header Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('Disease Name'),
                        _buildHeaderCell('Total'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataGetPatientPendingwithFinance>>(
                    future: ApiController.GetDPM_Patients_Pending_finacne(
                        district_code_login,
                        state_code_login,
                        currentFinancialYear),
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
                        List<DataGetPatientPendingwithFinance> ddata =
                            snapshot.data;
                        print('@@---ddata' + ddata.length.toString());
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
                                  _buildDataCell(offer.diseaseName),
                                  _buildDataCell(
                                      offer.totalApproPending.toString()),
                                  _buildDataCellViewBlue("View", () {
                                    // Handle the edit action here
                                    // For example, navigate to an edit screen or show a dialog
                                    print(
                                        '@@Edit clicked for item: ${offer.diseaseName}');
                                    //   Utils.showToast('Edit clicked for item: ${offer.schoolName}', true);

                                    // Example: Navigate to an edit page with the selected item
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(offer: offer)));
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
                  // Horizontal Scrolling Header Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildHeaderCellSrNo('S.No.'),
                        _buildHeaderCell('NGO'),
                        _buildHeaderCell('Approved'),
                        _buildHeaderCell('Action'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<DataPatientapprovedSisesesViewclick>>(
                    future: ApiController.GetDPM_Patients_Approved_View(
                        district_code_login,
                        state_code_login,
                        currentFinancialYear,"",diseaseid),
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
                        List<DataPatientapprovedSisesesViewclick> ddata =
                            snapshot.data;
                        print('@@---ddata' + ddata.length.toString());
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
                                  _buildDataCell(offer.ngoname),
                                  _buildDataCell(
                                      offer.approved.toString()),
                                  _buildDataCellViewBlue("View", () {
                                    // Handle the edit action here
                                    // For example, navigate to an edit screen or show a dialog
                                    print("@@npcbNo==="+offer.npcbNo);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DPMReportScreen()));
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
                                        'NGO(s) (Approved)',
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
                                        //
                                        setState(() {
                                          dashboardviewReplace = true;
                                          NGO_APPorovedClickShowData = false;
                                          NGO_PendingClickShowData = false;
                                          // Navigator.of(context).pop(context); // it deletes from top from stack previos screen
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
                    _buildHeaderCell('NGO Name'),
                    _buildHeaderCell('Member Name'),
                    _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetDPM_NGOAPProved_pending>>(
                future: ApiController.getDPM_NGOAPProved_pendings(
                    district_code_login,
                    state_code_login,
                    dpmAPPRoved_valueSendinAPi),
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
                    List<DataGetDPM_NGOAPProved_pending> ddata = snapshot.data;
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
                              _buildDataCell(offer.name),
                              _buildDataCell(offer.memberName),
                              _buildDataCell(offer.hName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailid.toString()),
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

  Widget NGOClickPendingDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: NGO_PendingClickShowData,
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
                                        'NGO(s) (Approved)',
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
                                          NGO_PendingClickShowData = false;
                                          NGO_APPorovedClickShowData = false;
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
                    _buildHeaderCell('NGO Name'),
                    _buildHeaderCell('Member Name'),
                    _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),
                  ],
                ),
              ),
              Divider(color: Colors.blue, height: 1.0),
              // Data Rows
              FutureBuilder<List<DataGetDPM_NGOAPProved_pending>>(
                future: ApiController.getDPM_NGOAPProved_pendings(
                    district_code_login,
                    state_code_login,
                    dpmPending_valueSendinAPi),
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
                    List<DataGetDPM_NGOAPProved_pending> ddata = snapshot.data;
                    print('@@---ddata---' + ddata.length.toString());
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
                              _buildDataCell(offer.memberName),
                              _buildDataCell(offer.hName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
                              _buildDataCell(offer.mobile.toString()),
                              _buildDataCell(offer.emailid.toString()),
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
                                        'NGO(s) (Approved)',
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
                                          GetDPM_GH_PendingClickShowData =
                                              false;
                                          GetDPM_GH_APPorovedClickShowData =
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
                    _buildHeaderCell('NGO Name'),
                    _buildHeaderCell('Member Name'),
                    //  _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
                  } else {
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
                              // _buildDataCell(offer.hName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
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
                                        'NGO(s) (Approved)',
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
                                          GetDPM_GH_PendingClickShowData =
                                              false;
                                          GetDPM_GH_APPorovedClickShowData =
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
                    _buildHeaderCell('NGO Name'),
                    _buildHeaderCell('Member Name'),
                    // _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
                  } else {
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
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
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
                                        'Private Practitioners (Approved)',
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
                                          GetDPM_PrivatePartitionPorovedClickShowData =
                                              false;
                                          DPM_PrivatePartitionP_PendingClickShowData =
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
                    _buildHeaderCell('NGO Name'),
                    _buildHeaderCell('Member Name'),
                    //  _buildHeaderCell('Hospital Name'),
                    _buildHeaderCell('Address'),
                    _buildHeaderCell('Nodal Officer Name'),
                    _buildHeaderCell('Mobile No'),
                    _buildHeaderCell('Email Id'),
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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
                              _buildDataCell(offer.ngoName),
                              // _buildDataCell(offer.hName),
                              _buildDataCell(offer.address),
                              _buildDataCell(offer.nodalOfficerName),
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
                                        'Private Practitioner(s) (Pending)',
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
                                          GetDPM_PrivatePartitionPorovedClickShowData =
                                              false;
                                          DPM_PrivatePartitionP_PendingClickShowData =
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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
                                        'NGO(s) (Approved)',
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
                    DPM_privateMEdicalCollegeApprovedData_valueSendinAPi),
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
                  } else {
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data.isEmpty) {
                    return Utils.getEmptyView("No data found");
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

  Future<void> _SchoolEyeScreening_Registration() async {
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
                            print('Cataract Data for approval clicked');
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
                                'Cataract Data for approval',
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
                            print('@@Cataract Data for approval clicked');
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
                  future: _futureCataract,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    developer.log('@@snapshot' + snapshot.data.toString());
                    print('@@snapshot___5: ');
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
                              getYearCatract = userc.name;
                              getfyid = userc.fyid;
                              print('@@getYear--' + getYearCatract.toString());
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
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<Datalowvisionregister_cataract> ddata =
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

  Widget LowVisionRegisterDataShowGlaucoma() {
    return Column(
      children: [
        Visibility(
          visible: LowVisionRegisterGlaucoma,
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
                            print('Cataract Data for approval clicked');
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
                                'Glaucoma Data for approval',
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
                            print('@@Cataract Data for approval clicked');
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
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<Datalowvisionregister_Glaucoma> ddata =
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
                            print('Cataract Data for approval clicked');
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
                                'Glaucoma Data for approval',
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
                            print('@@Cataract Data for approval clicked');
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
              /* Center(
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
                    developer.log('@@snapshot: $list');

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
                                  npcbNoDiabitic = userbindOrgan?.npcbNo ?? '';
                                  print(
                                      '@@npcbNo-- click------' + npcbNoGlucom);
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
              ),*/
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
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Utils.getEmptyView("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
                          List<Datalowvisonregister_diabitic> ddata =
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
                          return Utils.getEmptyView("No data found");
                        } else {
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
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
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
        // Implement any action for Congenital Ptosis
        break;
      case 2:
        print("Selected: Intraocular Trauma in Children");
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
                              LowVisionRegisterDiabitic=false;
                              LowVisionRegisterGlaucoma=false;
                              LowVisionRegisterCornealBlindness=false;
                              LowVisionRegisterVRSurgery=false;
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
                          }else{
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
                      print('@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

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
                        print('@@LowVisionRegisterChildhoodCongenitalPtosiss_1: $lowVisionDataValue');

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
                      print('@@LowVisionRegisterChildhoodCongenitalPtosiss_11: $lowVisionDataValue');

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
                      print('@@LowVisionRegisterChildhoodCongenitalPtosiss_2: $lowVisionDataValue');

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
                      print('@@LowVisionRegisterChildhoodCongenitalPtosiss_3: $lowVisionDataValue');

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
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return Utils.getEmptyView("No data found");
                        } else {
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
