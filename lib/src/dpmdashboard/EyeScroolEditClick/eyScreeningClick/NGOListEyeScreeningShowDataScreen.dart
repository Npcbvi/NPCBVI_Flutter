import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/EyeScroolEditClick/EyeScreeningForm.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/EyeScroolEditClick/eyScreeningClick/AddNewRecordclickScreen.dart';
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

import 'SchoolEyeScreeningEditScreen.dart';
class NGOListEyeScreeningShowDataScreen extends StatefulWidget {
  const NGOListEyeScreeningShowDataScreen({Key key}) : super(key: key);

  @override
  State<NGOListEyeScreeningShowDataScreen> createState() =>
      _NGOListEyeScreeningShowDataScreenState();
}

class _NGOListEyeScreeningShowDataScreenState
    extends State<NGOListEyeScreeningShowDataScreen> {
  String npcbNo;


  bool _isLoadings = false; // Flag to check if the API is already being called
  GlobalKey _dropdownKeyApplications =
  GlobalKey(); // Add this at the top of your widget
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
  bool dpmEyeScreeningSchoolDataShow = false;
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

  String resultScreeningCampsCompleted = "Completed";
  String resultScreeningCampsOngoing = "Onging";
  String resultScreeningCampsComing = "Comming";

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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
          _futureData = _fetchDataWithProgressDialog();
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
        title: const Text('NGO Eye Screening List',
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
            ngolistEyeScreeningShowData(),


          ],
        ),
      ),
    );
  }


  Widget ngolistEyeScreeningShowData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('@@School Eye Screening clicked');
                      setState(() {
                        ngoEyeScreeningdataShow = false;
                        dpmEyeScreeningSchoolDataShowADDNewRecord = true;
                        _resetAllOtherFlags();
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.school, color: Colors.white),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'School Eye Screening',
                            maxLines: 2,
                            style: const TextStyle(
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('@@Add New Record clicked');
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewRecordclickScreen(),
                          ),
                        ).then((_) {
                          setState(() {
                            _futureData = _fetchDataWithProgressDialog(); // Refresh data after coming back
                          });
                        });
                        _resetAllOtherFlags();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.add_circle, color: Colors.white),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Add New Record',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<DataGetEyeScreening>>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Utils.getEmptyView("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Utils.getEmptyView("No data found");
              } else {
                List<DataGetEyeScreening> ddata = snapshot.data;
                return Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildHeaderCellSrNoDiseaseData('S.No.', context),
                          _buildHeaderCell('School name'),
                          _buildHeaderCellNGOActionSmallShow('Action'),
                          _buildHeaderCellNGOActionSmallShow('Update'),
                        ],
                      ),
                      Column(
                        children: ddata.map((offer) {
                          return Row(
                            children: [
                              _buildDataCellSrNoDiseaseData(
                                (ddata.indexOf(offer) + 1).toString(),
                              ),
                              _buildDataCell(offer.schoolName),
                              _buildDataCellViewBlueSmasllShow("View", () {
                                _showDetailDialogEyeScreening(context, offer);
                              }),
                              _buildDataCellViewBlueSmasllShow("Edit", () async {
                                if (_isLoadings) return;

                                setState(() {
                                  _isLoadings = true;
                                });

                                try {
                                  await SharedPrefs.storeSharedValues(
                                    AppConstant.schoolid,
                                    offer.schoolid.toString(),
                                  );

                                  // Fetch eye screening edit data
                                  List<DataGetDPM_EyeScreeningEdit> result =
                                  await ApiController.getDPM_EyeScreeningEdit(
                                    district_code_login,
                                    state_code_login,
                                    userId,
                                  );

                                  if (result != null && result.isNotEmpty) {
                                    // Pass the first item (or filter by schoolid if needed)
                                    DataGetDPM_EyeScreeningEdit selectedData = result.first;

                                    if (selectedData != null) {
                                     /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SchoolEyeScreeningEditScreen(editData: selectedData),
                                        ),
                                      );*/
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SchoolEyeScreeningEditScreen(editData: selectedData),
                                        ),
                                      ).then((_) {
                                        setState(() {
                                          _futureData = _fetchDataWithProgressDialog(); // Refresh data after coming back
                                        });
                                      });

                                    } else {
                                      Utils.showToast("No matching data found", false);
                                    }
                                  } else {
                                    Utils.showToast("No data received from API", false);
                                  }
                                } catch (e) {
                                  print('Edit Error: $e');
                                  Utils.showToast("Something went wrong while fetching data", false);
                                } finally {
                                  setState(() {
                                    _isLoadings = false;
                                  });
                                }
                              }),

                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }



  void _showDetailDialogEyeScreening(BuildContext context, DataGetEyeScreening offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('School Details'),
        content: Text('School Name: ${offer.schoolName}'),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
  Future<List<DataGetEyeScreening>> _fetchDataWithProgressDialog(
      ) async {
    try {
      // Show the progress dialog before the API call
      Utils.showProgressDialog(context);

      // Perform the actual API call
      List<DataGetEyeScreening> response =
      await ApiController.GetDPM_EyeScreening(
          district_code_login, state_code_login, userId);

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





  Widget _buildHeaderCell(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }





  Widget _buildDataCell(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.04, // Scales with screen width
          ),
        ),
      ),
    );
  }


  Widget _buildDataCellViewBlueSmasllShow(String text, VoidCallback onTap) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 35,
        width: screenWidth * 0.18, // 30% of screen width for adaptability
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.1, color: Colors.black), // Top border

            bottom:
            BorderSide(width: 0.1, color: Colors.black), // Bottom border
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.blue,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellNGOActionSmallShow(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.18, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04, // Scales with screen width
          ),
        ),
      ),
    );
  }




  //related disease Data view
  Widget _buildHeaderCellSrNoDiseaseData(String text, BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
          // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.035, // Scales with screen width
          ),
        ),
      ),
    );
  }



  Widget _buildDataCellSrNoDiseaseData(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        // Aligns text to the left
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.03, // Scales with screen width
          ),
        ),
      ),
    );
  }


  void _resetAllOtherFlags() {

  }


}

