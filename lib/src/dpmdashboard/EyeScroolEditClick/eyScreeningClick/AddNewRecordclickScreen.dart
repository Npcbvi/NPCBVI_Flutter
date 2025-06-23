import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/EyeScroolEditClick/EyeScreeningForm.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/EyeScroolEditClick/eyScreeningClick/NGOListEyeScreeningShowDataScreen.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apihandler/ApiController.dart';
import '../../../database/SharedPrefs.dart';
import '../../../model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import '../../../model/dpmRegistration/eyescreening/GetDPM_ScreeningMonth.dart';
import '../../../model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import '../../../model/dpmRegistration/eyescreening/GetEyeScreening.dart';
import '../../../utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class AddNewRecordclickScreen extends StatefulWidget {

  @override
  State<AddNewRecordclickScreen> createState() =>
      _AddNewRecordclickScreen();
}

class _AddNewRecordclickScreen
    extends State<AddNewRecordclickScreen> {
  String npcbNo;



  String oganisationTypeGovtPrivateDRopDown,
      oganisationTypeGovtPrivateDRopDownApplications,
      oganisationTypeGovtDistrictHospitalApplicationsViews;
  String ngoApproveRevenuMOU, lowVisionDatas;
  String ngodependOrganbisatioSelectValue;
  int dropDownvalueOrgnbaistaionType = 0;
  int dropDownvalueOrgnbaistaionTypeApplications = 0;
  int ngoApproveRevenueMOUValue = 0,
      lowVisionDataValue = 0;
  int ngodependOrganbisatioSelectValuessss = 0;
  bool dashboardviewReplace = false;
  String currentFinancialYear,entryby;
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController,
      _chosenValueLOWVision,
      _chosenEyeBank,
      _chhoseApplication;
  int status, district_code_login, state_code_login;
  String role_id;
  bool isLoadingApi = true;

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
  bool NGOlistDropDownDisplayDatas = false;
  bool ngolistNewHosdpitalDropDown = false;
  bool ngoGovtPrivateOthereHosdpitalDataShow = false;
  bool organisationGovtPrivateSelectionAfter = false;
  bool organisationGovtPrivateSelectionAfterApplications = false;
  bool ApproveRenveMOUDataShows = false;
  bool ngoApproveRevenueMOU = false;
  bool ngoEyeScreeningdataShow = false;
  bool dpmEyeScreeningSchoolDataShowADDNewRecord = false;
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


  bool chnagePAsswordView = false;

  Future<List<DataGetDPM_ScreeningYear>> _future;
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
  String month_id;
  bool LowVisionRegisterCatracts = false;
  bool patinetInnerPandingDataDisplay = false;
  String LowVisionRegisterDataShowsValue;
  int LowVisionRegisterDataShowsValuessss = 0;
  bool LowVisionRegisterGlaucoma = false;
  bool LowVisionRegisterDiabitic = false;

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
  GetSchoolEyeScreening_RegistrationsNewAddReord _getSchoolEyeScreening_Registrations =
  new GetSchoolEyeScreening_RegistrationsNewAddReord();

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

  bool NGOApplicationApplicationsViews = false;
  bool GovtDistrictHospitalApplicationsViews = false;

  final _formKey = GlobalKey<FormState>();

  int trained_teachers, child_screens, child_detects, freeglasss;
  double sharedFontSize = 14.0;
  Color sharedFontColor = Colors.black;

  FontWeight sharedFontWeight = FontWeight.normal;

  Future<List<DataGetEyeScreening>> _futureData;


  @override
  void initState() {
    super.initState();
    getUserData();
    _future = getDPM_ScreeningYear();
    _futureMonth = getDPM_ScreeningMonth();
    // Set the controller with passed data

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
// ✅ Only call after all data is available
        });
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Eye Screening New Record',
        maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),),

        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal scrolling row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width, // Full screen width
                alignment: Alignment.center,              // Center contents
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Also add this
                  children: [
                    // Login Type and District in a Row
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Login Type:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                const Text(
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
                              const Text(
                                'State:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                stateNames ?? '',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'District:',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            districtNames ?? '',
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),



            const SizedBox(height: 10),

            // Your main screen data
            DPMEyeScreenSchooRegisterADDNewRecord(),


          ],
        ),
      ),
    );
  }


  Widget DPMEyeScreenSchooRegisterADDNewRecord() {
    return Column(
      children: [
        SingleChildScrollView(
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

                    List<DataGetDPM_ScreeningYear> list = snapshot.data ?? [];

                    // Ensure the selected user is valid and in the list
                    if (_selectedUser == null ||
                        !list.contains(_selectedUser)) {
                      _selectedUser = list.first;
                      getfyid = _selectedUser?.fyid ?? 0;
                      print(
                          '@@_selectedUser set by default to: ${_selectedUser
                              ?.name}');
                      print('@@getfyid__1__First time Get: $getfyid');
                    }
                    // ✅ Insert hint at top

                    /* if (_selectedUser == null || !list.contains(_selectedUser)) {
                      _selectedUser = list.first;
                      print('@@_selectedUserDistrict--' + _selectedUser.toString());
                      getfyid = int.parse(_selectedUser.fyid.toString() ?? "0");
                      print('@@getfyid__1' + getfyid);
                    }*/
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0.0, 0),
                      child:
                      DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                        hint: const Text(
                          'Select Year',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        onChanged: (userc) {
                          setState(() {
                            _selectedUser = userc;
                            var getYear = int.parse(userc?.name);
                            getfyid = userc?.fyid ?? 0;
                            print('@@getYear--$getYear');
                            print('@@getfyidSelected here----$getfyid');
                          });
                        },
                        value: _selectedUser,
                        items: list.map((user) {
                          return DropdownMenuItem<DataGetDPM_ScreeningYear>(
                            value: user,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                user.name,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          offset: const Offset(0, -3),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 50, // Set consistent height
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0), // ADD THIS

                          decoration: BoxDecoration(
                            color: Colors.white, // Visible background
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          overlayColor:
                          MaterialStateProperty.all(Colors.blue[100]),
                        ),
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
                        ),
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

                    List<DataGetDPM_ScreeningMonth> list =
                        snapshot.data ?? [];

                    if (_selectedUserMonth == null ||
                        !list.contains(_selectedUserMonth)) {
                      //   _selectedUserMonth = null; // Remove default selection
                      _selectedUserMonth = list.first;
                      month_id =
                          (_selectedUserMonth?.monthId ?? 0).toString();
                      print(
                          '@@_selectedUser set by default to: ${_selectedUserMonth
                              ?.monthId}');
                      print('@@getfyid__1__First time Get: $month_id');
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0.0, 0),

                      child:
                      DropdownButtonFormField2<DataGetDPM_ScreeningMonth>(
                        hint: const Text(
                          'Select Month',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        onChanged: (user) {
                          setState(() {
                            _selectedUserMonth = user;
                            var getYear = user?.monthname ?? '';
                            month_id = user?.monthId?.toString() ?? '';
                            print('@@monthname--$getYear');
                            print('@@month_id--$month_id');
                          });
                        },
                        value: _selectedUserMonth,
                        items: list.map((user) {
                          return DropdownMenuItem<DataGetDPM_ScreeningMonth>(
                            value: user,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                user.monthname,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          offset: const Offset(0, -3),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 50, // Set consistent height
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0), // ADD THIS

                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          overlayColor:
                          MaterialStateProperty.all(Colors.white),
                        ),
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                    controller: _controllerNameofSchool,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter School Name ',
                          style: TextStyle(
                            color: Colors.black, // Label color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk in red
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter School Name', // Dynamic hint text

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter School Address ',
                          style: TextStyle(
                            color: Colors.black, // Label color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk in red
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter School Address ', // Dynamic hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter Principal Name ',
                          style: TextStyle(
                            color: Colors.black, // Label color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk in red
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter Principal Name', // Dynamic hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                    controller: _controllerTeacherTrained,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter Trainer Teacher ',
                          style: TextStyle(
                            color: Colors.black, // Default text color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // Keeps the label fixed
                      hintText: 'Enter Trainer Teacher ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                      RichText(
                        text: TextSpan(
                          text: 'Screening Details ',
                          style: TextStyle(
                            color: Colors.white, // Default text color
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0,
                          ),
                          children: [
                            TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Colors.red, // Asterisk color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                  height: 50, // Set the height of the container
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
                    controller: _controllerNumberofchildrenscreening,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter Child Screen ',
                          style: TextStyle(
                            color: Colors.black, // Default text color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // Keeps label fixed
                      hintText: 'Enter Child Screen ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                    controller: _controllerChildrendetectedwithRefractive,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter Child Detect ',
                          style: TextStyle(
                            color: Colors.black, // Default text color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // Keeps label fixed
                      hintText: 'Enter Child Detect ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0),
                child: Container(
                  height: 50, // Set the height of the container
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
                    controller: _controllerNumberoffreeGlasses,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Enter Free Glasses ',
                          style: TextStyle(
                            color: Colors.black, // Default label text color
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red, // Asterisk color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // Keeps label fixed
                      hintText: 'Enter Free Glasses ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                      child: ElevatedButton.icon(
                        // ✅ Used ElevatedButton.icon
                        icon: Icon(Icons.send, color: Colors.white),
                        // ✅ Added Send Icon
                        label: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          print(
                              '@@_SchoolEyeScreening_RegistrationADDnewRecord Click Submit--');
                          _SchoolEyeScreening_RegistrationADDnewRecord();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: ElevatedButton.icon(
                        // ✅ Used ElevatedButton.icon
                        icon: Icon(Icons.refresh, color: Colors.white),
                        // ✅ Added Reset Icon
                        label: Text('Reset'),
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
              )
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




  Future<void> _SchoolEyeScreening_RegistrationADDnewRecord() async {
    print('@@I am clicking here--1__10121');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print('@@I am clicking here--1__10121' + schoolidSaved);
    _getSchoolEyeScreening_Registrations.yearid = int.tryParse(getfyid) ?? 0;
    print('@@Year ID: ${_getSchoolEyeScreening_Registrations.yearid}');

    _getSchoolEyeScreening_Registrations.monthid = 1; // static pass here now
    print('@@Month ID: ${_getSchoolEyeScreening_Registrations.monthid}');
    _getSchoolEyeScreening_Registrations.entry_by = userId;
    _getSchoolEyeScreening_Registrations.status = 1; // for update
    _getSchoolEyeScreening_Registrations.school_name =
        _controllerNameofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.school_address =
        _controllerAddressofSchool.text.trim();
    _getSchoolEyeScreening_Registrations.principal =
        _controllerNameofPrincipal.text.trim();

    print('@@I am clicking here--3');

    // Safely parse integers with tryParse()
    int trained_teachers =
        int.tryParse(_controllerTeacherTrained.text.trim()) ?? -1;
    int child_screens =
        int.tryParse(_controllerNumberofchildrenscreening.text.trim()) ?? -1;
    int child_detects =
        int.tryParse(_controllerChildrendetectedwithRefractive.text.trim()) ??
            -1;
    int freeglasss =
        int.tryParse(_controllerNumberoffreeGlasses.text.trim()) ?? -1;

    _getSchoolEyeScreening_Registrations.trained_teacher = trained_teachers;

    _getSchoolEyeScreening_Registrations.child_screen = child_screens;
    _getSchoolEyeScreening_Registrations.child_detect = child_detects;
    _getSchoolEyeScreening_Registrations.freeglass = freeglasss;
    _getSchoolEyeScreening_Registrations.schoolid = 0;
    _getSchoolEyeScreening_Registrations.district_code = district_code_login;
    _getSchoolEyeScreening_Registrations.state_code = state_code_login;

    print('@@I am clicking here--20');

    // Validation checks for empty text fields
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
    if (trained_teachers <= 0) {
      Utils.showToast(
          "Please enter a valid number for Trained teachers!", false);
      return;
    }
    if (child_screens <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of children screened!",
          false);
      return;
    }
    if (child_detects <= 0) {
      Utils.showToast(
          "Please enter a valid number for Children detected with Refractive Errors!",
          false);
      return;
    }
    if (freeglasss <= 0) {
      Utils.showToast(
          "Please enter a valid number for Number of free Glasses!", false);
      return;
    }

    // Check for network availability before sending data
    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog1(context);
        ApiController.getSchoolEyeScreening_RegistrationsAddNewReord(
            _getSchoolEyeScreening_Registrations)
            .then((response) async {
          Utils.hideProgressDialog1(context);
          print('@@I am clicking here--8 ' + response.toString());

          if (response.status) {
            Utils.showToast(response.message, true);

            setState(() {
              // Clear input fields after successful submission
              _controllerNameofSchool.clear();
              _controllerAddressofSchool.clear();
              _controllerNameofPrincipal.clear();
              _controllerTeacherTrained.clear();
              _controllerNumberofchildrenscreening.clear();
              _controllerChildrendetectedwithRefractive.clear();
              _controllerNumberoffreeGlasses.clear();


              print(
                  '@@ Step 9: Input fields cleared after successful submission');
              // Navigate and remove all previous screens
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NGOListEyeScreeningShowDataScreen(),
                ),
                    (Route<dynamic> route) => false, // Removes all previous routes
              );
            });
          } else {
            Utils.showToast(response.message, false);
          }
        });
      } else {
        Utils.showToast(AppConstant.noInternet, false);
      }
    });
  }


  void _resetAllOtherFlags() {

  }

}
class GetSchoolEyeScreening_RegistrationsNewAddReord {
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