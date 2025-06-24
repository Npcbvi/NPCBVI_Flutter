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
class SchoolEyeScreeningEditScreen extends StatefulWidget {
  final DataGetDPM_EyeScreeningEdit editData;

  const SchoolEyeScreeningEditScreen({Key key,  this.editData}) : super(key: key);
  @override
  State<SchoolEyeScreeningEditScreen> createState() =>
      _NGOListEyeScreeningShowDataScreenState();
}

class _NGOListEyeScreeningShowDataScreenState
    extends State<SchoolEyeScreeningEditScreen> {
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
  GetSchoolEyeScreening_RegistrationsNew _getSchoolEyeScreening_Registrations =
  new GetSchoolEyeScreening_RegistrationsNew();

  @override
  void initState() {
    super.initState();
    getUserData();
    _future = getDPM_ScreeningYear();
    _futureMonth = getDPM_ScreeningMonth();
    // Set the controller with passed data
    _controllerNameofSchool.text = widget.editData.schoolName ?? '';
    _controllerAddressofSchool.text=widget.editData.schoolAddress ?? '';
     _controllerNameofPrincipal .text=widget.editData.principal ?? '';
     _controllerTeacherTrained .text=widget.editData.trainedTeacher.toString() ?? '';
     _controllerNumberofchildrenscreening .text=widget.editData.childScreen.toString()  ?? '';
     _controllerChildrendetectedwithRefractive .text=widget.editData.childDetect.toString()  ?? '';
     _controllerNumberoffreeGlasses.text=widget.editData.freeglass.toString()  ?? '';
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
        title: const Text('School Eye Screening Update',
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
            DPMEyeScreenSchooRegisterData(),


          ],
        ),
      ),
    );
  }


  Widget DPMEyeScreenSchooRegisterData() {
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
              SizedBox(height: 5),
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
                      _selectedUser = null; // Remove default selection
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_selectedUser == null || !list.contains(_selectedUser)) {
                        setState(() {
                          _selectedUser = list.first;
                          getfyid = _selectedUser.fyid;

                        });
                      }
                    });

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
                      child:
                      DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                        hint: const Text(
                          'Select Year',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        onChanged: (userc) {
                          setState(() {
                            _selectedUser = userc;
                            var getYear = int.parse(
                                userc?.name.replaceAll(RegExp(r'\D'), '') ??
                                    '0');
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          offset: const Offset(0, -3),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 50, // Set consistent height
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
              SizedBox(height: 5),
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
                      _selectedUserMonth = null; // Remove default selection
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_selectedUserMonth == null || !list.contains(_selectedUserMonth)) {
                        setState(() {
                          _selectedUserMonth = list.first;
                          month_id = _selectedUserMonth.monthId?.toString() ?? '';
                        });
                      }
                    });
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 0),
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          offset: const Offset(0, -3),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 50, // Set consistent height
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
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerNameofSchool,
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Name of School',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter Name of School',
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerAddressofSchool,
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Address of School*',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter Address of School*',
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerNameofPrincipal,
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Name of Principal',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter Name of Principal',
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerTeacherTrained,
                  keyboardType: TextInputType.number, // ✅ Shows number keypad
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // ✅ Only allows digits
                  ],
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Teacher Trained in screening for refractive errors ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'EnterTeacher Trained in screening for refractive errors *',
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
              Container(
                width: double.infinity,
                // Full width
                color: Colors.blue,
                // Background color
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                // Padding for spacing
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Space between text and button
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Screening Details',
                        // Added spacing between words
                        maxLines: 2,
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerNumberofchildrenscreening,
                  keyboardType: TextInputType.number, // ✅ Shows number keypad
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // ✅ Only allows digits
                  ],
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Number of children screening ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter Number of children screening *',
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerChildrendetectedwithRefractive,
                  keyboardType: TextInputType.number, // ✅ Shows number keypad
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // ✅ Only allows digits
                  ],
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Children detected with Refractive Errors  ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Children detected with Refractive Errors *',
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: _controllerNumberoffreeGlasses,
                  keyboardType: TextInputType.number, // ✅ Shows number keypad
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // ✅ Only allows digits
                  ],
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Number of free Glasses ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' *', // Asterisk for required field
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Number of free Glasses  *',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@Update clicked');
                        setState(() {
                          _SchoolEyeScreening_Registration();
                        });
                      },
                      child: Text('Update'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print('@@Reset clicked');
                        setState(() {
                          _controllerNameofSchool.clear();
                          _controllerAddressofSchool.clear();
                          _controllerNameofPrincipal.clear();
                          _controllerTeacherTrained.clear();
                          _controllerNumberofchildrenscreening.clear();
                          _controllerChildrendetectedwithRefractive.clear();
                          _controllerNumberoffreeGlasses.clear();
                        });
                      },
                      child: Text('Reset'),
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






  void _resetAllOtherFlags() {

  }
  Future<void> _SchoolEyeScreening_Registration() async {
    print('@@ Step 1: Edit Clicked');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";

    print('@@ Step 2: Fetched School ID - $schoolidSaved');

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

    print('@@ Step 3: Basic school details assigned');

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

    print('@@ Step 4: Numerical values parsed successfully');
    print(
        '@@ Step 4.1: Trained Teacher - ${_getSchoolEyeScreening_Registrations
            .trained_teacher}');
    print(
        '@@ Step 4.2: Children Screened - ${_getSchoolEyeScreening_Registrations
            .child_screen}');
    print(
        '@@ Step 4.3: Children Detected - ${_getSchoolEyeScreening_Registrations
            .child_detect}');
    print(
        '@@ Step 4.4: Free Glasses - ${_getSchoolEyeScreening_Registrations
            .freeglass}');

    // Validation checks
    if (_getSchoolEyeScreening_Registrations.school_name.isEmpty) {
      print('@@ Error: School Name is empty');
      Utils.showToast("Please enter School Name!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.school_address.isEmpty) {
      print('@@ Error: School Address is empty');
      Utils.showToast("Please enter School Address!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.principal.isEmpty) {
      print('@@ Error: Principal Name is empty');
      Utils.showToast("Please enter Name of Principal!", false);
      return;
    }

    // Validation for numerical inputs
    if (_getSchoolEyeScreening_Registrations.trained_teacher <= 0) {
      print('@@ Error: Invalid Trained Teacher count');
      Utils.showToast(
          "Please enter a valid number for Trained teacher!", false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_screen <= 0) {
      print('@@ Error: Invalid Number of Children Screening');
      Utils.showToast(
          "Please enter a valid number for Number of children screening!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.child_detect <= 0) {
      print('@@ Error: Invalid Children Detected count');
      Utils.showToast(
          "Please enter a valid number for Children detected with Refractive Errors!",
          false);
      return;
    }
    if (_getSchoolEyeScreening_Registrations.freeglass <= 0) {
      print('@@ Error: Invalid Free Glasses count');
      Utils.showToast(
          "Please enter a valid number for Number of free Glasses!", false);
      return;
    }

    print('@@ Step 5: All validations passed, checking network availability');

    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        print('@@ Step 6: Network Available, showing progress dialog');
        Utils.showProgressDialog1(context);

        ApiController.getSchoolEyeScreening_Registrations(
            _getSchoolEyeScreening_Registrations)
            .then((response) async {
          Utils.hideProgressDialog1(context);
          print('@@ Step 7: API Response Received - ${response.toString()}');

          if (response.status) {
            print('@@ Step 8: Success - ${response.message}');
            Utils.showToast(response.message, true);
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
          } else {
            print('@@ Step 8: Failed - ${response.message}');
            Utils.showToast(response.message, false);
          }
        });
      } else {
        print('@@ Step 6: No Internet Connection');
        Utils.showToast(AppConstant.noInternet, false);
      }
    });
  }

}
class GetSchoolEyeScreening_RegistrationsNew {
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
