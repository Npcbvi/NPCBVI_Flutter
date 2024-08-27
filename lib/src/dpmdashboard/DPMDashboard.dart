import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMGovtPrivateOrganisationTypeData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRivateMEdicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMScreeningCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMsatteliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetNewHospitalData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientAPprovedwithFinanceYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientPendingwithFinance.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetEyeScreening.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPMGH_clickAPProved.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import '../model/dpmRegistration/DiseaseData/GetDiseaseData.dart';
import '../model/dpmRegistration/getDPM_NGOApprovedPending/GetDPM_NGOAPProved_pending.dart';

class DPMDashboard extends StatefulWidget {
  @override
  _DPMDashboard createState() => _DPMDashboard();
}

class _DPMDashboard extends State<DPMDashboard> {
  String oganisationTypeGovtPrivateDRopDown;
  String ngoApproveRevenuMOU;
  String ngodependOrganbisatioSelectValue;
  int dropDownvalueOrgnbaistaionType = 0;
  int ngoApproveRevenueMOUValue = 0;
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
          //print('@@fullnameController_1' + fullnameController.text);
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

    if (now.month >= 4) { // Financial year starts in April
      financialYear = '$currentYear-${nextYear.toString().substring(2)}';
    } else {
      financialYear = '${currentYear - 1}-${currentYear.toString().substring(2)}';
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
            itemBuilder: (context) =>
            [
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
                                  style: TextStyle(color: Colors.black),
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
                                  NGOlistDropDownDisplayDatas = true;
                                  ngolistNewHosdpitalDropDown = false;
                                  ngoGovtPrivateOthereHosdpitalDataShow = false;
                                  ngoApproveRevenueMOU = false;
                                } else if (_chosenValue == "New Hospital") {
                                  dashboardviewReplace = false;
                                  ngoApproveRevenueMOU = false;
                                  NGOlistDropDownDisplayDatas = false;
                                  ngoGovtPrivateOthereHosdpitalDataShow = false;
                                  ngolistNewHosdpitalDropDown = true;
                                } else if (_chosenValue ==
                                    "Govt/private/Other") {
                                  dashboardviewReplace = false;
                                  ngolistNewHosdpitalDropDown = false;
                                  NGOlistDropDownDisplayDatas = false;
                                  ngoApproveRevenueMOU = false;
                                  ngoGovtPrivateOthereHosdpitalDataShow = true;
                                }
                                if (_chosenValue == "Approve Renew MOU") {
                                  dashboardviewReplace = false;
                                  ngolistNewHosdpitalDropDown = false;
                                  NGOlistDropDownDisplayDatas = false;
                                  ngoApproveRevenueMOU = true;
                                  ngoGovtPrivateOthereHosdpitalDataShow = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 170.0,
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
                                  style: TextStyle(color: Colors.black),
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
                                  print('@@NGO--1' + _chosenValueLOWVision);
                                } else if (_chosenValueLOWVision ==
                                    "Diabetic") {} else
                                if (_chosenValueLOWVision ==
                                    "Glaucoma") {}
                              });
                            },
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
                                  style: TextStyle(color: Colors.black),
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
                                } else
                                if (_chosenEyeBank == "Eye Donation") {} else
                                if (_chosenEyeBank ==
                                    "Eyeball Collection Via Eye Bank") {}
                              });
                            },
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            child: Text(
                              'DPM',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
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
                                  child: Text('Patient(s) ($currentFinancialYear)',
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
                                                    NGO_PendingClickShowData=false;
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
                                                    NGO_APPorovedClickShowData=false;
                                                    NGO_PendingClickShowData =
                                                    true;
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
        //    PatientApprovedFinancneClickDisplayData(),
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
                          child: Text(
                            'Add New Record',
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
                                 print('@@Edit clicked for item: ${offer.schoolName}');
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
            width: screenWidth * 0.9,  // 90% of screen width
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
                        List<DataGetPatientAPprovedwithFinanceYear> ddata = snapshot.data;
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
                                  _buildDataCell(offer.diseaseName),
                                  _buildDataCell(offer.totalApproPending.toString()),
                                  _buildDataCellViewBlue("View", () {
                                    // Handle the edit action here
                                    // For example, navigate to an edit screen or show a dialog
                                    print('@@Edit clicked for item: ${offer.diseaseName}');
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
            width: screenWidth * 0.9,  // 90% of screen width
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
                        List<DataGetPatientPendingwithFinance> ddata = snapshot.data;
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
                                  _buildDataCell(offer.diseaseName),
                                  _buildDataCell(offer.totalApproPending.toString()),
                                  _buildDataCellViewBlue("View", () {
                                    // Handle the edit action here
                                    // For example, navigate to an edit screen or show a dialog
                                    print('@@Edit clicked for item: ${offer.diseaseName}');
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
                                          NGO_APPorovedClickShowData=false;
                                          NGO_PendingClickShowData=false;
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
                                          NGO_PendingClickShowData=false;
                                          NGO_APPorovedClickShowData=false;
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
                                          GetDPM_GH_PendingClickShowData=false;
                                          GetDPM_GH_APPorovedClickShowData=false;
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
                                          GetDPM_GH_PendingClickShowData=false;
                                          GetDPM_GH_APPorovedClickShowData=false;
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
                                          GetDPM_PrivatePartitionPorovedClickShowData=false;
                                          DPM_PrivatePartitionP_PendingClickShowData=false;
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
                                          GetDPM_PrivatePartitionPorovedClickShowData=false;
                                          DPM_PrivatePartitionP_PendingClickShowData=false;
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
                                          DPM_privateMEdicalCollegeApprovedData=false;
                                          DPM_privateMEdicalCollegePendingData=false;
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
                                          DPM_privateMEdicalCollegeApprovedData=false;
                                          DPM_privateMEdicalCollegePendingData=false;
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
                                          ScreeningCamp=false;
                                          ScreeningCampOngoing=false;
                                          ScreeningCampComing=false;
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
                    1001, 100, "2019-2020", "", resultScreeningCampsCompleted),
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
                                          ScreeningCamp=false;
                                          ScreeningCampOngoing=false;
                                          ScreeningCampComing=false;
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
                                          ScreeningCamp=false;
                                          ScreeningCampOngoing=false;
                                          ScreeningCampComing=false;
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
                                          satelliteCentreShowData=false;
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
