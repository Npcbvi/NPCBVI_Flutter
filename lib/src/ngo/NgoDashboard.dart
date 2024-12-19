import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardDistrictModel.dart';
import 'package:mohfw_npcbvi/src/model/GetHospitalForDDL/GethospitalForDDL.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/city/GetCity.dart';
import 'package:mohfw_npcbvi/src/model/city/GetVillage.dart';
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
import 'package:mohfw_npcbvi/src/model/districtngowork/screeningcamp/ScreeningCampList.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/ScreeningCampManager.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningMonth.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/GetSatelliteManagerById.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/CenterOfficeNameSatelliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/GetSatelliteCenterList.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../model/DashboardStateModel.dart';
import '../model/GetHospitalForDDL/GethospitalForDDL.dart';

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

  Future<List<DataScreeningCampManager>> _manger;
  Future<List<DataDropDownHospitalSelected>>
      _futureDataDropDownHospitalSelected;
  DataGetDPM_ScreeningYear _selectedUser;
  DataScreeningCampManager _mangerUser;
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
  final _formKey1 = GlobalKey<FormState>();
  final _formKeySatelliteManger = GlobalKey<FormState>();
  final _formKeySatelliteMangerEditClick = GlobalKey<FormState>();
  String locationTypeValues = 'Urban';

  // Controllers for TextFormFields
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailIdController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _designationController = TextEditingController();

  // Gender state variable
  bool CampManagerRegisterartionsEdit = false;
  bool SatelliteManagerRegisterartionsEdit = false;

  bool ngoScreeningCampListss = false;
  bool AddScreeningCamps = false;
  String _selectedDateText = 'Start Date *'; // Initially set to "From Date"

  String _selectedDateTextToDate = 'End Date*';
  String getMAnagerNAme;
  int getmanagerSrNO;
  bool isVisibleDitrictGovt = false;
  Future<List<Data>> _futureState;
  Data _selectedUserState;
  DataDsiricst _selectedUserDistrict;
  int stateCodeSPO,
      disrtcCode,
      stateCodeDPM,
      stateCodeGovtPrivate,
      distCodeDPM,
      distCodeGovtPrivate;
  String CodeSPO,
      codeDPM,
      CodeGovtPrivate,
      distNameDPM,
      distNameDPMs_distictValues;

  TextEditingController _nGONameController = TextEditingController();
  TextEditingController _campNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addresssController = TextEditingController();
  TextEditingController _Pincodecontroller = TextEditingController();
  Future<List<DataGetCity>> _futureCity;
  DataGetCity _selectedUserCity;

  Future<List<DataGetVillage>> _futureVillage;
  DataGetVillage _selectedUserVillage;
  int valuetype = 0;

  bool ngoSATELLITECENTREMANAGERLists = false;
  bool AddSatelliteManagers = false;

  // Controllers for TextFormFields
  TextEditingController _userNameControllerStatelliteManger =
      TextEditingController();
  TextEditingController _mobileNumberControllerStatelliteManger =
      TextEditingController();
  TextEditingController _emailIdControllerStatelliteManger =
      TextEditingController();
  TextEditingController _addressControllerStatelliteManger =
      TextEditingController();
  TextEditingController _designationControllerStatelliteManger =
      TextEditingController();
  TextEditingController _hospitalControllerStatelliteManger =
      TextEditingController();

  TextEditingController _userNameControllerStatelliteMangerReg =
      TextEditingController();
  TextEditingController _mobileNumberControllerStatelliteMangerReg =
      TextEditingController();
  TextEditingController _emailIdControllerStatelliteMangerReg =
      TextEditingController();
  TextEditingController _addressControllerStatelliteMangerReg =
      TextEditingController();
  TextEditingController _designationControllerStatelliteMangerReg =
      TextEditingController();
  TextEditingController _hospitalControllerStatelliteMangerReg =
      TextEditingController();

  Future<List<DataGethospitalForDDL>> _futureDataGethospitalForDDL;
  DataGethospitalForDDL _dataGethospitalForDDL;

  Future<List<DataCenterOfficeNameSatelliteCenter>> _futureCenterOfficerName;
  DataCenterOfficeNameSatelliteCenter _dataCenterOfficeNameSatelliteCenter;

  String gethospitalName,
      getCenterOfficerName,
      gethospitalNameSrNORegRedOption,
      gethospitalNameRegRedOption;
  String gethospitalNameSrNOReg;
  int getCenterOfficerNameSRNo;
  int genderSatelliteManagerApi; // 1 for Male, 2 for Female, 3 for Transgender
  int genderSatelliteCenterApi;
  bool satelliteCenterMenuListdisplay = false;
  bool AddSatelliteCenterRedOptionFields = false;
  final _formKeySatelliteCneterO = GlobalKey<FormState>();

  TextEditingController _userSatelliteCentreNameRegCenter =
      TextEditingController();
  TextEditingController _mobileNumberControllerStatelliteMangerRegCenter =
      TextEditingController();
  TextEditingController _emailIdControllerStatelliteMangerRegCenter =
      TextEditingController();
  TextEditingController _addressControllerStatelliteMangerRegCenter =
      TextEditingController();
  TextEditingController _designationControllerStatelliteMangerRegCenter =
      TextEditingController();
  TextEditingController _hospitalControllerStatelliteMangerRegCenter =
      TextEditingController();
  Future<List<DataGetHospitalList>> _hospitalListFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page

    getUserData();
// Cache the Future to avoid redundant API calls

    ngoDashboardclicks = true;
    EyeBankApplication = false;
    ngoCampManagerLists = false;
    CampManagerRegisterartions = false;
    CampManagerRegisterartionsEdit = false;
    SatelliteManagerRegisterartionsEdit = false;
    ngoScreeningCampListss = false;
    AddScreeningCamps = false;
    ngoSATELLITECENTREMANAGERLists = false;
    _future = getDPM_ScreeningYear();
    _manger = getCampManager(district_code_login, entryby);
    _futureCity = _getCity(district_code_login);
    _futureVillage = _getVillage(district_code_login, state_code_login, 10011);
    AddSatelliteManagers = false;
    satelliteCenterMenuListdisplay = false;
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
    // Wait until the widget tree has stabilized
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final BuildContext dropdownContext = _dropdownKey.currentContext;

      if (dropdownContext == null) {
        print("Dropdown context is null. Retrying...");
        return;
      }

      final RenderBox dropdownRenderBox =
          dropdownContext.findRenderObject() as RenderBox;
      final RenderBox overlayRenderBox =
          Overlay.of(context)?.context.findRenderObject() as RenderBox;

      // Ensure both render boxes are not null
      if (dropdownRenderBox == null || overlayRenderBox == null) {
        print("RenderBox is null. Cannot display menu.");
        return;
      }

      final RelativeRect position = RelativeRect.fromRect(
        dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
        Offset.zero & overlayRenderBox.size,
      );

      // Show the popup menu
      final selectedValue = await showMenu<int>(
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
      );

      // Handle menu selection
      if (selectedValue != null) {
        // Close the drawer if it's open
        Navigator.of(context).pop(); // Closes the drawer

        // Call the handler for menu selection
        _handleMenuSelection(selectedValue);
      }
    });
  }

  void _handleMenuSelection(int value) {
    switch (value) {
      case 1:
        print("@@Add Ngo Hospital");
        _hospitalListFuture = ApiController.getHospitalList(
          darpan_nos,
          district_code_login,
          userId,
        );
        ManageUSerNGOHospt = true;
        ngoDashboardclicks = false;
        EyeBankApplication = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;
        _future = getDPM_ScreeningYear();
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = false;
        AddSatelliteCenterRedOptionFields = false;

        break;

      // Add more cases as needed
      default:
        print("Unknown selection");
    }
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
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = false;
        AddSatelliteCenterRedOptionFields = false;
        Navigator.pop(context);

        break;
      case 2:
        print("@@Screeniong Camp");
        _future = getDPM_ScreeningYear();
        EyeBankApplication = false;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = true;
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = false;
        AddSatelliteCenterRedOptionFields = false;
        Navigator.pop(context);

        break;
      // Add more cases as needed
      default:
        print("Unknown selection");
    }
  }

  void _showPopupMenuScreeningCamp() async {
    // Ensure the dropdown and overlay render boxes are valid
    final RenderBox dropdownRenderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;

    if (dropdownRenderBox == null || overlayRenderBox == null) {
      print("RenderBox or OverlayRenderBox is null");
      return; // Safely exit if null
    }

    // Calculate the position for the popup menu
    final RelativeRect position = RelativeRect.fromRect(
      dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
      Offset.zero & overlayRenderBox.size,
    );

    // Show the popup menu
    await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Text("Camp Manager"),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text("Screening Camp"),
        ),
      ],
      elevation: 8.0,
    ).then((selectedValue) {
      if (selectedValue != null) {
        _handleMenuSelectionScreeninCamp(selectedValue);
      }
    });
  }

  void _showPopupMenuSatelliteCenter() async {
    // Ensure the dropdown and overlay render boxes are valid
    final RenderBox dropdownRenderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;

    if (dropdownRenderBox == null || overlayRenderBox == null) {
      print("RenderBox or OverlayRenderBox is null");
      return; // Safely exit if null
    }

    // Calculate the position for the popup menu
    final RelativeRect position = RelativeRect.fromRect(
      dropdownRenderBox.localToGlobal(Offset.zero) & dropdownRenderBox.size,
      Offset.zero & overlayRenderBox.size,
    );

    // Show the popup menu
    await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Text("Satellite Manager"),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text("Satellite Center"),
        ),
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
        print("@@Satellite Manger Camp");

        _future = getDPM_ScreeningYear();
        EyeBankApplication = false;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = true;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = false;
        AddSatelliteCenterRedOptionFields = false;

        break;
      case 2:
        print("@@Satellite Center");
        _future = getDPM_ScreeningYear();
        ManageUSerNGOHospt = false;
        EyeBankApplication = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;
        ngoDashboardclicks = false;
        ngoScreeningCampListss = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = true;
        AddSatelliteCenterRedOptionFields = false;

        break;
      // Add more cases as needed
      default:
        print("Unknown selection");
    }
  }

  Future<List<DataGethospitalForDDL>> GetHospitalForDDL(
      int districtid, int stateId, String userId) async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      // Prepare the request body as a Map
      Map<String, dynamic> body = {
        'districtid': districtid,
        'stateId': stateId,
        'userId': userId, // Add user ID to the body
      };

      try {
        // Send POST request with the body encoded as JSON
        final response = await http.post(
          Uri.parse(
              'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetHospitalForDDL'),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
          },
          body: jsonEncode(body), // Encode the body as JSON
        );
        // Print the URL and request parameters
        print('@@URL:' +
            "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetHospitalForDDL");
        print('@@Params: ${jsonEncode(body)}');
        // Check if the response is successful
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          final GethospitalForDDL dashboardStateModel =
              GethospitalForDDL.fromJson(json);
          print('@@Params: ${dashboardStateModel.data.toString()}');
          return dashboardStateModel.data;
        } else {
          // Handle the case when the server responds with an error
          Utils.showToast('Error: ${response.statusCode}', true);
          return null;
        }
      } catch (e) {
        // Handle potential JSON decoding or other unexpected errors
        Utils.showToast('An error occurred: $e', true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataCenterOfficeNameSatelliteCenter>> getSatelliteManager(
      int stateId, int districtid, String entryBy) async {
    print("@@getSatelliteManager--check for officeerName" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSatelliteManager;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtid,
        "entryBy": entryBy,
      });
      print("@@getSatelliteManager--bodyprint--: ${body.toString()}");
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

      print("@@getSatelliteManager--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      CenterOfficeNameSatelliteCenter data =
          CenterOfficeNameSatelliteCenter.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);

      return [];
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

  Future<List<DataScreeningCampManager>> getCampManager(
      int districtid, String entryBy) async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      // Prepare the request body as a Map
      Map<String, dynamic> body = {
        'districtid': districtid,
        'entryBy': entryBy, // Add user ID to the body
      };

      // Send POST request with the body encoded as JSON
      final response = await http.post(
        Uri.parse(
            'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCampManager'),
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: jsonEncode(body), // Encode the body as JSON
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final ScreeningCampManager dashboardStateModel =
            ScreeningCampManager.fromJson(json);
        return dashboardStateModel.data;
      } else {
        // Handle the case when the server responds with an error
        Utils.showToast('Error: ${response.statusCode}', true);
        return null;
      }
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
            color: Colors.white,
            // White background
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
          width: 100.0, // Set the width of the drawer
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(8.0), // Set the margin here
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    setState(() {
                      print('@@dashboardviewReplace----display---');
                      _future = getDPM_ScreeningYear();
                      ngoDashboardclicks = true;
                      ManageUSerNGOHospt = false;
                      EyeBankApplication = false;
                      ngoCampManagerLists = false;
                      CampManagerRegisterartions = false;
                      CampManagerRegisterartionsEdit = false;
                      SatelliteManagerRegisterartionsEdit = false;
                      satelliteCenterMenuListdisplay = false;
                      ngoScreeningCampListss = false;
                      AddScreeningCamps = false;
                      ngoSATELLITECENTREMANAGERLists = false;
                      AddSatelliteManagers = false;
                      satelliteCenterMenuListdisplay = false;
                      AddSatelliteCenterRedOptionFields = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                _buildDropdown(),
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Add Eye Bank',
                  onTap: () {
                    setState(() {
                      print('@@dashboardviewReplace----display---');
                      EyeBankApplication = true;
                      ngoDashboardclicks = false;
                      ManageUSerNGOHospt = false;
                      ngoCampManagerLists = false;
                      CampManagerRegisterartions = false;
                      CampManagerRegisterartionsEdit = false;
                      SatelliteManagerRegisterartionsEdit = false;
                      ngoScreeningCampListss = false;
                      AddScreeningCamps = false;
                      ngoSATELLITECENTREMANAGERLists = false;
                      AddSatelliteManagers = false;
                      satelliteCenterMenuListdisplay = false;
                      AddSatelliteCenterRedOptionFields = false;
                    });
                    Navigator.pop(context);
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
              width: double.infinity,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
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
                          CampManagerRegisterartionsEdit = false;
                          SatelliteManagerRegisterartionsEdit = false;
                          satelliteCenterMenuListdisplay = false;
                          ngoScreeningCampListss = false;
                          AddScreeningCamps = false;
                          ngoSATELLITECENTREMANAGERLists = false;
                          AddSatelliteManagers = false;
                          satelliteCenterMenuListdisplay = false;
                          AddSatelliteCenterRedOptionFields = false;
                        });
                      }),
                     */ /* SizedBox(width: 5.0),
                      _buildDropdown(),*/ /*
                      SizedBox(width: 5.0),
                      _buildNavigationButton('Add Eye Bank', () {
                        print('@@Add Eye Bank Clicked');
                        setState(() {
                          EyeBankApplication = true;
                          ngoDashboardclicks = false;
                          ManageUSerNGOHospt = false;
                          ngoCampManagerLists = false;
                          CampManagerRegisterartions = false;
                          CampManagerRegisterartionsEdit = false;
                          SatelliteManagerRegisterartionsEdit = false;

                          ngoScreeningCampListss = false;
                          AddScreeningCamps = false;
                          ngoSATELLITECENTREMANAGERLists = false;
                          AddSatelliteManagers = false;
                          satelliteCenterMenuListdisplay = false;
                          AddSatelliteCenterRedOptionFields = false;
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),*/
            _buildUserInfo(),
            LowVisionRegisterNgoHopsital(),
            ngoDashboardclick(),
            EyeBankApplicationNgo(),
            ngoCampManagerList(),
            AddCampManager(),
            EditCampManager(),
            ngoScreeningCampList(),
            AddScreeningCamp(),
            ngoSATELLITECENTREMANAGERList(),
            AddSatelliteManagerOption(),
            EditSatelliteManager(),
            satelliteCenterMenuList(),
            AddSatelliteCenterRedOptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.withOpacity(0.3),
      // Splash color on click
      highlightColor: Colors.blue.withOpacity(0.1),
      // Highlight color while clicking
      borderRadius: BorderRadius.circular(10),
      // Optional: Add rounded corners to the InkWell
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        // Adjust the padding as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // Match the InkWell's borderRadius
          color: Colors
              .transparent, // Transparent background, as InkWell adds its own splash
        ),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      width: 150.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white, // Dropdown background color
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: _dropdownKey,
            // Ensure the key is defined and used correctly
            focusColor: Colors.white,
            value: _chosenValue,
            style: TextStyle(color: Colors.white),
            // Style for text in dropdown
            iconEnabledColor: Colors.white,
            // Color of dropdown arrow icon
            items: <String>[
              'NGO Hospital',
              'Screening Camp',
              'Satellite Center',
            ].map<DropdownMenuItem<String>>((String value) {
              // Define the icon for each value
              Icon icon;
              if (value == 'NGO Hospital') {
                icon = Icon(Icons.local_hospital, color: Colors.black);
              } else if (value == 'Screening Camp') {
                icon = Icon(Icons.local_activity, color: Colors.black);
              } else if (value == 'Satellite Center') {
                icon = Icon(Icons.satellite, color: Colors.black);
              } else {
                icon = Icon(Icons.help, color: Colors.black); // Default icon
              }

              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    icon, // The icon for each item
                    SizedBox(width: 10), // Space between icon and text
                    Text(
                      value,
                      overflow: TextOverflow.ellipsis, // Handle text overflow
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
            hint: Text(
              "Manage Users", // Placeholder text when nothing is selected
              overflow: TextOverflow.ellipsis, // Handle text overflow
              style: TextStyle(
                color: Colors.black,
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
                } else if (_chosenValue == "Satellite Center") {
                  print('@@Sattelite--1 $_chosenValue');
                  _showPopupMenuSatelliteCenter();
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
          child: Column(
            children: [
              Row(
                children: [
                  _buildUserInfoItem(
                      'Login Type:', 'District NGO', Colors.black, Colors.red),
                  _buildUserInfoItem(
                      'Login Id:', userId, Colors.black, Colors.red),
                ],
              ),
              Row(
                children: [
                  _buildUserInfoItem(
                      'District:', districtNames, Colors.black, Colors.red),
                  _buildUserInfoItem(
                      'State:', stateNames, Colors.black, Colors.red),
                ],
              ),
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
              SizedBox(height: 10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Spaced out both items
                    children: [
                      Align(
                        alignment: Alignment.centerLeft, // Align to the left
                        child: Text(
                          'Hospitals List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Slightly larger font size
                            fontWeight:
                                FontWeight.w500, // Bold text for prominence
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight, // Align to the right
                        child: GestureDetector(
                          onTap: () {
                            // Handle the tap event here

                            // Add your logic here for adding a new hospital
                            setState(() {
                              print('@@Add New Record clicked');
                              Utils.showToast(
                                  "Complete this in Next Sprint", true);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            // Add padding to the container
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              // Background color of the button
                              borderRadius: BorderRadius.circular(12),
                              // Rounded corners for the button
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 2), // Slight shadow below the button
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              // Make the row fit the content
                              children: [
                                Icon(
                                  Icons.add, // Icon for adding a new hospital
                                  color: Colors.white,
                                  size: 20, // Adjust icon size
                                ),
                                SizedBox(width: 8),
                                // Space between icon and text
                                Text(
                                  'Add New Hospital',
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontWeight: FontWeight.w500, // Text weight
                                    fontSize: 18, // Slightly smaller font size
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Handle text overflow
                                ),
                              ],
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
                        /*  _buildHeaderCell('Mobile No.'),
                        _buildHeaderCell('Email ID'),
                        _buildHeaderCell('Equipment'),
                        _buildHeaderCell('Doctors'),
                        _buildHeaderCell('MOU'),
                        _buildHeaderCell('Status'),*/
                        _buildHeaderCellAction('View Details'),
                        // _buildHeaderCellActionMOU('Action'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetHospitalList>>(
                      future: _hospitalListFuture, // Use cached Future
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
                                  /* _buildDataCell(offer.mobile),
                                  _buildDataCell(offer.emailId),
                                  _buildDataCell(offer.eqCount.toString()),
                                  _buildDataCell(offer.drcount.toString()),
                                  _buildDataCell(offer.moucount.toString()),
                                  _buildDataCell(offer.status.toString()),*/
                                  _buildDataCellViewBlue("View Detail", () {
                                    // Show the dialog with hospital details when the "View Detail" button is pressed
                                    _showHospitalDetailsDialogNGOHospital(
                                        offer);
                                  }),
                                  /* if (offer.status == 'Approved')
                                  // Store locally
                                    _buildViewManageDoctorUploadMOUUI(
                                        offer.hRegID) // Pass hospitalId
                                  else
                                    if (offer.status == 'Pending')
                                      _buildEditMAnageDoctorUploadMOUUI()
                                    else
                                      _buildEdit(),*/
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

// Function to show the hospital details in a dialog
  void _showHospitalDetailsDialogNGOHospital(DataGetHospitalList hospital) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hospital Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  border: TableBorder.all(color: Colors.black, width: 1),
                  children: [
                    _buildTableRowNGO("Hospital ID", hospital.hRegID),
                    _buildTableRowNGO("Hospital Name", hospital.hName),
                    _buildTableRowNGO("Mobile", hospital.mobile),
                    _buildTableRowNGO("Email", hospital.emailId),
                    _buildTableRowNGO(
                        "Equipment Count", hospital.eqCount.toString()),
                    _buildTableRowNGO(
                        "Doctor Count", hospital.drcount.toString()),
                    _buildTableRowNGO(
                        "MOU Count", hospital.moucount.toString()),
                    _buildTableRowNGO("Status", hospital.status),
                    // Add a row for the buttons section with two children (key, value)
                    TableRow(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ), // Placeholder for the "key"
                        ),
                        // Apply a SingleChildScrollView with horizontal scroll direction
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            // Aligning buttons to the right
                            children: [
                              hospital.status == 'Approved'
                                  ? _buildViewManageDoctorUploadMOUUINGO(
                                      hospital.hRegID)
                                  : hospital.status == 'Pending'
                                      ? _buildEditMAnageDoctorUploadMOUUINGO()
                                      : _buildEditNGO(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

// Helper method to create a row for the table
  TableRow _buildTableRowNGO(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
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
              SizedBox(width: 10.0),
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
                        _buildHeaderCellAction('Action'),
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
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          // Align "No data found" message to the left
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No data found",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          );
                        } else {
                          List<DataAddEyeBank> ddata = snapshot.data;
                          print('@@---ddata: ${ddata.length}');

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
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700, // Background color
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                      offset: Offset(0, 4), // Subtle shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title Text
                    Flexible(
                      child: Text(
                        'CAMP MANAGER DETAILS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Add Camp Manager Button
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: _addCampManager,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        label: Text(
                          'Add Camp Manager',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          // Button background color
                          onPrimary: Colors.white,
                          // Text and icon color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12.0),
                          shadowColor: Colors.black.withOpacity(0.2),
                          elevation: 4.0, // Button shadow elevation
                        ),
                      ),
                    ),
                  ],
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
                        /*  _buildHeaderCell('Officer Name'),
                        _buildHeaderCell('Mobile Number'),
                        _buildHeaderCell('Email id'),
                        _buildHeaderCell('Address'),
                        _buildHeaderCell('Designation'),
                        _buildHeaderCellUpdateandBlock('Update/Block'),*/
                        _buildHeaderCellAction('View Details'),
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
                        } else if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data.isEmpty) {
                          // Show "No data found" when data is empty or null
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                "No data found",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                            ),
                          );
                        } else {
                          List<DataNgoCampMangerList> ddata = snapshot.data;
                          print('@@---ddata: ${ddata.length}');
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.managerName),
                                  _buildDataCell(offer.userId),
                                  /*  _buildDataCell(offer.managerName),
                                  _buildDataCell(offer.mobile),
                                  _buildDataCell(offer.emailId.toString()),
                                  _buildDataCell(offer.address.toString()),
                                  _buildDataCell(offer.designation.toString()),*/
                                  _buildDataCellViewBlue("View Detail", () {
                                    // Show the dialog with hospital details when the "View Detail" button is pressed
                                    _showDetailsDialogCAMPMANAGERDETAILS(offer);
                                  }),
                                  /*  _buildEditCampMabgerList(
                                      int.parse(offer.srNo)),
*/
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

  void _showDetailsDialogCAMPMANAGERDETAILS(DataNgoCampMangerList offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Details of ${offer.managerName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Table
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(150.0), // Fixed width for column 1
                      1: FlexColumnWidth(), // Flexible width for column 2
                    },
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                    children: [
                      _buildTableRowNGO('S.No.', offer.srNo),
                      _buildTableRowNGO('NGO Name', offer.managerName),
                      _buildTableRowNGO('User ID', offer.userId),
                      _buildTableRowNGO('Officer Name', offer.managerName),
                      _buildTableRowNGO('Mobile Number', offer.mobile),
                      _buildTableRowNGO('Email ID', offer.emailId),
                      _buildTableRowNGO('Address', offer.address),
                      _buildTableRowNGO('Designation', offer.designation),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Editable Section
                  Container(
                    height: 80,
                    width: double.infinity, // Adjust width as needed
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('Edit', () async {
                          print('Edit pressed');
                          try {
                            GetCampManagerDetailsByIdEditData details =
                                await ApiController.getCampManagerDetailsById(
                              int.parse(offer.srNo),
                              entryby,
                            );

                            if (details != null && details.status) {
                              details.data.forEach((manager) {
                                print('Manager Name: ${manager.managerName}');
                                // Initialize controllers with fetched details
                                _userNameController = TextEditingController(
                                    text: manager.managerName);
                                _mobileNumberController =
                                    TextEditingController(text: manager.mobile);
                                _emailIdController = TextEditingController(
                                    text: manager.emailId);
                                _addressController = TextEditingController(
                                    text: manager.address);
                                _designationController = TextEditingController(
                                    text: manager.designation);

                                setState(() {
                                  print('@@click on Edit');
                                  CampManagerRegisterartionsEdit = true;
                                  SatelliteManagerRegisterartionsEdit = false;

                                  ManageUSerNGOHospt = false;
                                  ngoDashboardclicks = false;
                                  EyeBankApplication = false;
                                  ngoCampManagerLists = false;
                                  CampManagerRegisterartions = false;
                                  ngoScreeningCampListss = false;
                                  AddScreeningCamps = false;
                                  ngoSATELLITECENTREMANAGERLists = false;
                                  AddSatelliteManagers = false;
                                  satelliteCenterMenuListdisplay = false;
                                  AddSatelliteCenterRedOptionFields = false;
                                });
                              });
                            } else {
                              Utils.showToast(
                                  "No details found or an error occurred",
                                  true);
                            }
                          } catch (e) {
                            print('Error: $e');
                            Utils.showToast(
                                "Failed to fetch details. Please try again.",
                                true);
                          }
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Close Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Helper method to build table rows

// Helper method for button

// Helper to create table rows

// Helper to create table rows
  TableRow _buildTableRow(String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            key,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
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
                    _userNameController =
                        TextEditingController(text: manager.managerName);
                    _mobileNumberController =
                        TextEditingController(text: manager.mobile);
                    _emailIdController =
                        TextEditingController(text: manager.emailId);
                    _addressController =
                        TextEditingController(text: manager.address);
                    _designationController =
                        TextEditingController(text: manager.designation);
                    // Access other fields as needed
                    setState(() {
                      CampManagerRegisterartionsEdit = true;
                      SatelliteManagerRegisterartionsEdit = false;

                      ManageUSerNGOHospt = false;
                      ngoDashboardclicks = false;
                      EyeBankApplication = false;
                      ngoCampManagerLists = false;
                      CampManagerRegisterartions = false;
                      ngoScreeningCampListss = false;
                      AddScreeningCamps = false;
                      ngoSATELLITECENTREMANAGERLists = false;
                      AddSatelliteManagers = false;
                      satelliteCenterMenuListdisplay = false;
                      AddSatelliteCenterRedOptionFields = false;
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

  void _addCampManager() {
    // Handle the tap event here
    print('Add Camp Manager tapped!');
    setState(() {
      ManageUSerNGOHospt = false;
      ngoDashboardclicks = false;
      EyeBankApplication = false;
      ngoCampManagerLists = false;
      CampManagerRegisterartions = true;
      CampManagerRegisterartionsEdit = false;
      SatelliteManagerRegisterartionsEdit = false;

      ngoScreeningCampListss = false;
      AddScreeningCamps = false;
      ngoSATELLITECENTREMANAGERLists = false;
      AddSatelliteManagers = false;
      satelliteCenterMenuListdisplay = false;
      AddSatelliteCenterRedOptionFields = false;
    });
  }

  void _addScreeningCampManager() {
    // Handle the tap event here
    print('@@AddScreening camp clicked--');
    setState(() {
      ManageUSerNGOHospt = false;
      ngoDashboardclicks = false;
      EyeBankApplication = false;
      ngoCampManagerLists = false;
      CampManagerRegisterartions = false;
      SatelliteManagerRegisterartionsEdit = false;

      CampManagerRegisterartionsEdit = false;
      ngoScreeningCampListss = false;
      AddScreeningCamps = true;
      _manger = getCampManager(district_code_login, entryby);
      _futureState = _getStatesDAta();
      ngoSATELLITECENTREMANAGERLists = false;
      AddSatelliteManagers = false;
      satelliteCenterMenuListdisplay = false;
      AddSatelliteCenterRedOptionFields = false;
    });
  }

  void _addSatelliteCenterManager() {
    // Handle the tap event here
    print('@@AddSattelliteCenterclicked--');
    setState(() {
      ManageUSerNGOHospt = false;
      ngoDashboardclicks = false;
      EyeBankApplication = false;
      ngoCampManagerLists = false;
      CampManagerRegisterartions = false;
      CampManagerRegisterartionsEdit = false;
      SatelliteManagerRegisterartionsEdit = false;

      ngoScreeningCampListss = false;
      AddScreeningCamps = false;
      _futureState = _getStatesDAta();
      ngoSATELLITECENTREMANAGERLists = false;
      AddSatelliteManagers = true;
      _futureDataGethospitalForDDL =
          GetHospitalForDDL(district_code_login, state_code_login, userId);
      satelliteCenterMenuListdisplay = false;
      AddSatelliteCenterRedOptionFields = false;
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
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
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
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                FutureBuilder<List<DataGetDPM_ScreeningYear>>(
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
                      _selectedUser = null; // Set the first item as default
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300, // Consistent width with the container
                            child: DropdownButtonFormField<
                                DataGetDPM_ScreeningYear>(
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
                              hint: Text(
                                'Please Select year',
                                style: TextStyle(
                                  color: Colors.grey,
                                  // Light gray color for the hint
                                  fontSize: 16,
                                ),
                              ),
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
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 8),
                buildInfoContainer(stateNames),
                SizedBox(height: 8),
                buildInfoContainer(districtNames),
                SizedBox(height: 8),
                buildDropdownHospitalType(),
                SizedBox(height: 8),
                //buildDropdownHospitalTypeHospialSelect(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (getYearNgoHopital != null && dropDownTwoSelcted > 0) {
                        // Replace 'Specific Value' with the condition you want to check
                        print('@@Condition met: Get button clicked' +
                            getYearNgoHopital.toString() +
                            dropDownTwoSelcted.toString());
                        setState(() {
                          ngoDashboardDatas =
                              true; // Update based on the condition
                        });
                      } else {
                        print('@@Condition not met or no selection made' +
                            getYearNgoHopital.toString() +
                            dropDownTwoSelcted.toString());
                        Utils.showToast(
                            "Need to select Select year & DropDown Selction!",
                            true);
                      }
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
                                  _buildHeaderCellDiseaseType('Disease Type'),
                                  _buildHeaderCellDiseaseType('Registered'),
                                  _buildHeaderCellDiseaseType('Operated'),
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
                                  reghospitalNameFetch,
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
                                    return Row(
                                      children: [
                                        Spacer(),
                                        // Pushes "No data found" to the right
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text(
                                            "No data found",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    List<DataNGODashboards> ddata =
                                        snapshot.data;

                                    return Column(
                                      children: ddata.map((offer) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            _buildDataCellDissesValue(
                                                offer.status),
                                            _buildDataCellDissesValue(
                                                offer.registered),
                                            _buildDataCellDissesValue(
                                                offer.operated),
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
                            reghospitalNameFetch,
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
                              // Display "No data found" on the right side
                              return Row(
                                children: [
                                  Spacer(),
                                  // Pushes "No data found" to the right
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      "No data found",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              List<DataNGODashboards> ddata = snapshot.data;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
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
                    // Only show the table when ngoDashboardDatas is true
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
                            reghospitalNameFetch,
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
                              // If data is empty, show 'No data found' message
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                    child: Text("No data found",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue))),
                              );
                            } else {
                              List<DataNGODashboards> ddata = snapshot.data;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
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
                        _buildHeaderCellDiseaseType('Disease Type'),
                        _buildHeaderCellDiseaseType('Registered'),
                        _buildHeaderCellDiseaseType('Operated'),
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
                                  _buildDataCellDissesValue(offer.status),
                                  _buildDataCellDissesValue(offer.registered),
                                  _buildDataCellDissesValue(offer.operated),
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
      height: 30,
      width: 60, // Fixed width to ensure horizontal scrolling
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

  Widget _buildHeaderCellDiseaseType(String text) {
    return Container(
      height: 35,
      width: 110, // Fixed width to ensure horizontal scrolling
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

  Widget _buildDataCellDissesValue(String text) {
    return Container(
      height: 35,
      width: 110,
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

  Widget _buildHeaderCell(String text) {
    return Container(
      height: 30,
      width: 100, // Fixed width to ensure horizontal scrolling
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
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellAction(String text) {
    return Container(
      height: 30,
      width: 100,
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

  Widget _buildHeaderCellActionMOU(String text) {
    return Container(
      height: 30,
      width: 160,
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

  Widget _buildHeaderCellUpdateandBlock(String text) {
    return Container(
      height: 30,
      width: 60, // Fixed width to ensure horizontal scrolling
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
      height: 40,
      width: 100,
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
        height: 40,
        width: 100,
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
      height: 40,
      width: 60,
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

  Widget _buildCAMPMAnageEDITDELETE() {
    return Container(
      height: 100, // Increase height to accommodate vertical buttons
      width: 60, // Fixed width
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the container
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Even spacing between buttons
        children: [
          // "Edit" Button
          GestureDetector(
            onTap: () {
              print('Edit pressed');
            },
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          // Separator (optional)
          Text(
            '||',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          // "Delete" Button
          GestureDetector(
            onTap: () {
              print('Delete pressed');
            },
            child: Text(
              'Delete',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSatelliteManagerEditBlocked(int sR_No) {
    return Container(
      height: 80,
      width: 200, // Fixed width to ensure horizontal scrolling
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(width: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('Edit', () async {
            print('@@Edit Ka click');

            try {
              // Call the API to view camp manager details
              GetSatelliteManagerById getSatelliteManagerByIds =
                  await ApiController.getSatelliteManagerById(
                sR_No,
                entryby, // Assuming `entryby` is correct
              );

              if (getSatelliteManagerByIds != null &&
                  getSatelliteManagerByIds.status) {
                print(getSatelliteManagerByIds.message); // Success message

                if (getSatelliteManagerByIds.data != null) {
                  final manager = getSatelliteManagerByIds.data.first;

                  print('@@Manager Name: ${manager.name}');

                  // Update controllers instead of reinitializing them
                  setState(() {
                    print('@@Edit Ka click');
                    _userNameControllerStatelliteMangerReg.text =
                        manager.name ?? '';
                    _mobileNumberControllerStatelliteMangerReg.text =
                        manager.mobile ?? '';
                    _emailIdControllerStatelliteMangerReg.text =
                        manager.emailId ?? '';
                    _addressControllerStatelliteMangerReg.text =
                        manager.address ?? '';
                    _designationControllerStatelliteMangerReg.text =
                        manager.designation ?? '';

                    SatelliteManagerRegisterartionsEdit = true;
                    CampManagerRegisterartionsEdit = false;
                    ManageUSerNGOHospt = false;
                    ngoDashboardclicks = false;
                    EyeBankApplication = false;
                    ngoCampManagerLists = false;
                    CampManagerRegisterartions = false;
                    ngoScreeningCampListss = false;
                    AddScreeningCamps = false;
                    ngoSATELLITECENTREMANAGERLists = false;
                    AddSatelliteManagers = false;
                    satelliteCenterMenuListdisplay = false;
                    AddSatelliteCenterRedOptionFields = false;
                  });
                } else {
                  Utils.showToast("No satellite manager details found", true);
                }
              } else {
                Utils.showToast(
                    "Error: ${getSatelliteManagerByIds.message}", true);
              }
            } catch (e) {
              print('Error fetching satellite manager details: $e');
              Utils.showToast(
                  "Failed to fetch satellite manager details. Please try again later.",
                  true);
            }
          }),
         /* Text(
            '||',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),*/
          GestureDetector(
            onTap: () {
              print('Manage Eye Donation Blocked');
            },
            child: Text(
              'Blocked',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewManageDoctorUploadMOUUI(String hospitalId) {
    return Container(
      height: 40,
      width: 160,
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

  Widget _buildEditMAnageDoctorUploadMOUUI() {
    return Container(
        height: 40,
        width: 160,
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

  Widget _buildEdit() {
    return Container(
        height: 40,
        width: 160,
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

  Widget _buildViewManageDoctorUploadMOUUINGO(String hospitalId) {
    return Container(
      height: 120, // Increase height for the vertical layout
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align buttons to the left
        children: [
          SizedBox(height: 5),
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
          SizedBox(height: 5),
          //_buildSeparator(),
          _buildButton('Manage Doctor', () {
            print('@@fff1--Manage' + darpan_nos);
            print('@@fff1--Manage' + hospitalId);
            print('@@fff1--Manage' + district_code_login.toString());
            print('@@fff1--Manage' + userId);
            print('Manage Doctor pressed');
            _showNgoManageDoctore(hospitalId, district_code_login);

            // Logic for managing doctors
          }),
          //_buildSeparator(),
          SizedBox(height: 5),
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

  Widget _buildEditMAnageDoctorUploadMOUUINGO() {
    return Container(
      height: 120, // Increase height for the vertical layout
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align buttons to the left
        children: [
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              print('View pressed');
            },
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          // Separator "||"
          /* Text(
            '||',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),*/
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
          SizedBox(height: 5),
          // Separator "||"
          /*  Text(
            '||',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),*/
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
      ),
    );
  }

  Widget _buildEditNGO() {
    return Container(
      height: 60, // Adjusted height for vertical layout
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align button to the left
        children: [
          GestureDetector(
            onTap: () {
              print('View pressed');
            },
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
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

  void _resetFormSatelliteManager() {
    _userNameControllerStatelliteMangerReg.clear();
    _mobileNumberControllerStatelliteMangerReg.clear();
    _emailIdControllerStatelliteMangerReg.clear();
    _addressControllerStatelliteMangerReg.clear();
    _designationControllerStatelliteMangerReg.clear();
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group_add,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Camp Manager Registration',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            letterSpacing: 1.2,
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
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'User Name',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

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
                        SizedBox(height: 10.0),

                        // Mobile Number Field
                        TextFormField(
                          controller: _mobileNumberController,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Mobile No.',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
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

                        SizedBox(height: 10.0),

                        // Email ID Field
                        TextFormField(
                          controller: _emailIdController,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Email ID',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
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

                        SizedBox(height: 10.0),

                        // Address Field
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          maxLines: 3, // Allows multiline input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),
                        // Designation Field
                        TextFormField(
                          controller: _designationController,
                          decoration: InputDecoration(
                            labelText: 'Designation',
                            labelStyle: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Enter your designation',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0),

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
          visible: CampManagerRegisterartionsEdit,
          // Change this to your actual condition
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_ind,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Camp Manager Registration',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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

  Widget AddScreeningCamp() {
    return Column(
      children: [
        Visibility(
          visible: AddScreeningCamps,
          // Assuming CampManagerRegisterartions is true
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                      // Gradient color
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0, 2), // Shadow positioning
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    // Larger padding for a spacious feel
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note, // Add an icon for a modern touch
                          color: Colors.white,
                          size: 15.0,
                        ),
                        SizedBox(width: 10),
                        // Add space between the icon and text
                        Text(
                          'Camp Registration',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize:
                                15.0, // Increased font size for prominence
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
                    key: _formKey1,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nGONameController,
                          decoration: InputDecoration(
                            labelText: ngoNames.isNotEmpty
                                ? ngoNames
                                : 'Enter NGO name *',
                            // Conditional label
                            hintText: ngoNames.isNotEmpty
                                ? ''
                                : 'Please provide NGO name',
                            // Hint text when label is empty
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            // Ensures the label floats when focused or filled
                            filled: true,
                            // Add a background color
                            fillColor: Colors.grey.shade200,
                            // Light background color to indicate non-editable state
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue.shade300, width: 2),
                              // Border when not focused
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.shade300, width: 2),
                              // Border color when disabled
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              // Border when focused
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                            ),
                            labelStyle: TextStyle(
                              color: Colors.blue
                                  .shade700, // Label color when the field is focused
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey, // Hint text color
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.red, // Set the text color to red
                          ),
                          enabled: false,
                          // Makes the field non-editable
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Ngo name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // Username Field
                        TextFormField(
                          controller: _campNameController, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Camp Name',
                                    style: TextStyle(
                                      color:
                                          Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors
                                          .red, // Color of the '*' to indicate it's mandatory
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              // Adds a border around the TextField
                              borderRadius: BorderRadius.circular(12),
                              // Optional: Makes the border rounded
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width:
                                    1.0, // Optional: Sets the border color and width
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter camp name';
                            }
                            return null;
                          },
                        ),

                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              // Padding around both date containers
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Background color of the entire box
                                borderRadius: BorderRadius.circular(12.0),
                                // Rounded corners
                                border: Border.all(
                                  color: Colors.blue,
                                  // Border color for the entire container
                                  width: 2.0, // Border width
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Space between date pickers
                                children: [
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () async {
                                          // Handle the tap event here
                                          print('@@Add New Record clicked');

                                          // Open the calendar on tap
                                          DateTime pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null) {
                                            // Handle the selected date (e.g., display or save it)
                                            String formattedDate =
                                                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

                                            // Update the state with the selected date
                                            setState(() {
                                              _selectedDateText = formattedDate;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Colors.blue,
                                              // Border color for this date container
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Text(
                                            _selectedDateText.isEmpty
                                                ? 'From Date'
                                                : _selectedDateText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Adds space between both date fields
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          // Handle the tap event here
                                          print('@@Add New Record clicked');

                                          // Open the calendar on tap
                                          DateTime pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null) {
                                            // Handle the selected date (e.g., display or save it)
                                            String formattedDate =
                                                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

                                            // Update the state with the selected date
                                            setState(() {
                                              _selectedDateTextToDate =
                                                  formattedDate;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Colors.blue,
                                              // Border color for this date container
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Text(
                                            _selectedDateTextToDate.isEmpty
                                                ? 'To Date'
                                                : _selectedDateTextToDate,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 5.0),
                        FutureBuilder<List<DataScreeningCampManager>>(
                          future: _manger,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            List<DataScreeningCampManager> list = snapshot.data.toList();

                            // Check if _selectedUser is null or not part of the list anymore
                            if (_mangerUser == null || !list.contains(_mangerUser)) {
                              _mangerUser = list.first; // Set the first item as default
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Remove the label and set hint
                                  SizedBox(height: 10),
                                  DropdownButtonFormField<DataScreeningCampManager>(
                                    value: _mangerUser,
                                    onChanged: (userc) {
                                      setState(() {
                                        _mangerUser = userc;
                                        getMAnagerNAme = userc?.managerName ?? '';
                                        getmanagerSrNO = int.tryParse(userc?.srNo?.toString() ?? '') ?? 0;
                                        print('getMAnagerNAme: $getMAnagerNAme');
                                        print('getmanagerSrNO: $getmanagerSrNO');
                                      });
                                    },
                                    items: list.map((user) {
                                      return DropdownMenuItem<DataScreeningCampManager>(
                                        value: user,
                                        child: Text(user.managerName, style: TextStyle(fontSize: 16)),
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
                                      hintText: 'Select Camp Manager', // The hint text for the dropdown
                                      hintStyle: TextStyle(color: Colors.grey), // Optional: Style the hint text
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

                        // Gender Selection
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                          children: [
                            // Center the Location Type Label
                            Text(
                              'Location Type*',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700, // Label color
                              ),
                            ),
                            SizedBox(height: 10), // Add space between label and options

                            // Use Row to center the radio buttons horizontally
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Center radio buttons horizontally
                              children: [
                                // Urban Radio Button
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: locationTypeValues == 'Urban' ? Colors.blue.shade100 : Colors.transparent, // Highlight selected option
                                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                    border: Border.all(
                                      color: locationTypeValues == 'Urban' ? Colors.blue : Colors.grey, // Border color changes when selected
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Urban',
                                        groupValue: locationTypeValues,
                                        onChanged: (value) {
                                          setState(() {
                                            locationTypeValues = value;
                                            valuetype = 0;
                                          });
                                        },
                                        activeColor: Colors.blue, // Active radio button color
                                      ),
                                      Text(
                                        'Urban',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: locationTypeValues == 'Urban' ? Colors.blue : Colors.black, // Text color based on selection
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20), // Space between options
                                // Rural Radio Button
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: locationTypeValues == 'Rural' ? Colors.blue.shade100 : Colors.transparent, // Highlight selected option
                                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                    border: Border.all(
                                      color: locationTypeValues == 'Rural' ? Colors.blue : Colors.grey, // Border color changes when selected
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Rural',
                                        groupValue: locationTypeValues,
                                        onChanged: (value) {
                                          setState(() {
                                            locationTypeValues = value;
                                            valuetype = 1;
                                          });
                                        },
                                        activeColor: Colors.blue, // Active radio button color
                                      ),
                                      Text(
                                        'Rural',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: locationTypeValues == 'Rural' ? Colors.blue : Colors.black, // Text color based on selection
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),


                        SizedBox(height: 5.0),
                        // Show additional content based on the selected value
                        if (locationTypeValues == 'Urban')
                          // Content to display if "Urban" is selected
                          Column(
                            children: [
                              FutureBuilder<List<DataGetCity>>(
                                future: _getCity(district_code_login),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  // Logging for debugging
                                  developer.log('@@snapshot: ${snapshot.data}');

                                  List<DataGetCity> districtList =
                                      snapshot.data;

                                  // Ensure selected district is in the list, otherwise select the first one
                                  if (_selectedUserCity == null ||
                                      !districtList
                                          .contains(_selectedUserCity)) {
                                    _selectedUserCity = districtList.first;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20.0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Text('Select City:'),
                                        DropdownButtonFormField<DataGetCity>(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueAccent,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.blue[50],
                                          ),
                                          onChanged: (districtUser) =>
                                              setState(() {
                                            _selectedUserCity = districtUser;
                                            distCodeGovtPrivate = int.parse(
                                                districtUser.subdistrictCode
                                                    .toString());
                                            // Update state or further actions here
                                            print(
                                                'Selected District: ${districtUser.subdistrictCode}');
                                          }),
                                          value: _selectedUserCity,
                                          items: districtList
                                              .map((DataGetCity district) {
                                            return DropdownMenuItem<
                                                DataGetCity>(
                                              value: district,
                                              child: Text(district.name),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _Pincodecontroller,
                                // Attach controller
                                decoration: InputDecoration(
                                  labelText: 'Pin Code*',
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
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter PinCode number';
                                  }
                                  return null;
                                },
                              )
                            ],
                          )
                        else if (locationTypeValues == 'Rural')
                          // Content to display if "Urban" is selected

                          Column(
                            children: [
                              Center(
                                child: FutureBuilder<List<DataGetCity>>(
                                  future: _getCity(district_code_login),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    // Logging for debugging
                                    developer
                                        .log('@@snapshot: ${snapshot.data}');

                                    List<DataGetCity> districtList =
                                        snapshot.data;

                                    // Ensure selected district is in the list, otherwise select the first one
                                    if (_selectedUserCity == null ||
                                        !districtList
                                            .contains(_selectedUserCity)) {
                                      _selectedUserCity = districtList.first;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Select City:'),
                                          DropdownButtonFormField<DataGetCity>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.blue[50],
                                            ),
                                            onChanged: (districtUser) =>
                                                setState(() {
                                              _selectedUserCity = districtUser;
                                              distCodeGovtPrivate = int.parse(
                                                  districtUser.subdistrictCode
                                                      .toString());
                                              // Update state or further actions here
                                              print(
                                                  'Selected District: ${districtUser.subdistrictCode}');
                                            }),
                                            value: _selectedUserCity,
                                            items: districtList
                                                .map((DataGetCity district) {
                                              return DropdownMenuItem<
                                                  DataGetCity>(
                                                value: district,
                                                child: Text(district.name),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Center(
                                child: FutureBuilder<List<DataGetVillage>>(
                                  future: _getVillage(district_code_login,
                                      state_code_login, 10011),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    // Logging for debugging
                                    developer
                                        .log('@@snapshot: ${snapshot.data}');

                                    List<DataGetVillage> districtList =
                                        snapshot.data;

                                    // Ensure selected district is in the list, otherwise select the first one
                                    if (_selectedUserVillage == null ||
                                        !districtList
                                            .contains(_selectedUserVillage)) {
                                      _selectedUserVillage = districtList.first;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Select Village:'),
                                          DropdownButtonFormField<
                                              DataGetVillage>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.blue[50],
                                            ),
                                            onChanged: (districtUser) =>
                                                setState(() {
                                              _selectedUserVillage =
                                                  districtUser;
                                              distCodeGovtPrivate = int.parse(
                                                  districtUser.villageCode
                                                      .toString());
                                              // Update state or further actions here
                                              print(
                                                  'Selected District: ${districtUser.villageCode}');
                                            }),
                                            value: _selectedUserVillage,
                                            items: districtList
                                                .map((DataGetVillage district) {
                                              return DropdownMenuItem<
                                                  DataGetVillage>(
                                                value: district,
                                                child: Text(district.name),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              TextFormField(
                                controller: _Pincodecontroller,
                                decoration: InputDecoration(
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Pin Code',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black, // Regular label text color
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' *', // The asterisk for mandatory field
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red, // Color for the asterisk
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding inside the TextFormField
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, // Border color when not focused
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent, // Border color when focused
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red, // Border color when there's an error
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent, // Border color when focused and there's an error
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter PinCode number';
                                  }
                                  return null;
                                },
                              )


                            ],
                          ),

                        // Mobile Number Field
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Mobile No.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black, // Regular label text color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // The asterisk for mandatory field
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red, // Color for the asterisk
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
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

                        SizedBox(height: 10.0),

                        // Email ID Field

                        // Address Field
                        TextFormField(
                          controller: _addresssController, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black, // Regular label text color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // The asterisk for mandatory field
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red, // Color for the asterisk
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding inside the TextFormField
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color when not focused
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent, // Border color when focused
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red, // Border color when there's an error
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent, // Border color when focused and there's an error
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0), // Padding applied directly to the Container
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                            ),
                          ),
                          child: SingleChildScrollView(  // Wrap content in a SingleChildScrollView
                            child: Center(
                              child: FutureBuilder<List<Data>>(
                                future: _futureState, // Future to fetch the data
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  // Logging data for debugging
                                  developer.log('@@snapshot: ${snapshot.data}');

                                  List<Data> stateList = snapshot.data;

                                  // Ensure selected state is in the list, otherwise select the first
                                  if (_selectedUserState == null || !stateList.contains(_selectedUserState)) {
                                    _selectedUserState = stateList.first;
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                                    children: <Widget>[
                                      const Text('Select State:'),
                                      SizedBox(height: 10), // Adds some space between label and dropdown
                                      DropdownButtonFormField<Data>(
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
                                        value: _selectedUserState,
                                        onChanged: (user) => setState(() {
                                          _selectedUserState = user;
                                          stateCodeGovtPrivate = int.parse(user.stateCode.toString());
                                          CodeGovtPrivate = user.code;

                                          if (stateCodeGovtPrivate != null) {
                                            isVisibleDitrictGovt = true;
                                            _getDistrictData(stateCodeGovtPrivate);
                                          } else {
                                            isVisibleDitrictGovt = false;
                                          }
                                        }),
                                        items: stateList.map<DropdownMenuItem<Data>>((Data user) {
                                          return DropdownMenuItem<Data>(
                                            value: user,
                                            child: Text(user.stateName),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),




                        Visibility(
                          visible: isVisibleDitrictGovt,
                          child: Column(
                            children: [
                              Center(
                                child: FutureBuilder<List<DataDsiricst>>(
                                  future:
                                      _getDistrictData(stateCodeGovtPrivate),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    // Logging for debugging
                                    developer
                                        .log('@@snapshot: ${snapshot.data}');

                                    List<DataDsiricst> districtList =
                                        snapshot.data;

                                    // Ensure selected district is in the list, otherwise select the first one
                                    if (_selectedUserDistrict == null ||
                                        !districtList
                                            .contains(_selectedUserDistrict)) {
                                      _selectedUserDistrict =
                                          districtList.first;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20.0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Select District:'),
                                          DropdownButtonFormField<DataDsiricst>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.blue[50],
                                            ),
                                            onChanged: (districtUser) =>
                                                setState(() {
                                              _selectedUserDistrict =
                                                  districtUser;
                                              distCodeGovtPrivate = int.parse(
                                                  districtUser.districtCode
                                                      .toString());
                                              // Update state or further actions here
                                              print(
                                                  'Selected District: ${districtUser.districtName}');
                                            }),
                                            value: _selectedUserDistrict,
                                            items: districtList
                                                .map((DataDsiricst district) {
                                              return DropdownMenuItem<
                                                  DataDsiricst>(
                                                value: district,
                                                child:
                                                    Text(district.districtName),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Designation Field

                        // Submit and Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Process the form data
                                print("@@-----CampRegistration--");
                                _ScreeningCampRegistration();
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
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteCenterRedOptionFields = false;
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
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        satelliteCenterMenuListdisplay = false;
        AddSatelliteCenterRedOptionFields = false;
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }

  Widget ngoScreeningCampList() {
    return Column(
      children: [
        Visibility(
          visible: ngoScreeningCampListss,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        'Screening Camp',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: _addScreeningCampManager,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.red,
                          shadowColor: Colors.redAccent.withOpacity(0.4),
                          elevation: 3.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: Icon(Icons.add, color: Colors.red, size: 20.0),
                        label: Text(
                          'Add Screening Camp',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
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

                        _buildHeaderCell('Camp Name'),
                        // _buildHeaderCell('Start Date'),
                        //_buildHeaderCell('End Date'),
                        _buildHeaderCell('City'),

                        _buildHeaderCellAction('View Details'),
                        //_buildHeaderCellUpdateandBlock('Update/Block'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataScreeningCampList>>(
                      future: ApiController.getCampList(
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
                          List<DataScreeningCampList> ddata = snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.campNo),
                                  /* _buildDataCell(
                                      Utils.formatDateString(offer.startDate)),
                                  _buildDataCell(
                                      Utils.formatDateString(offer.endDate)),*/
                                  _buildDataCell(offer.name),
                                  _buildDataCellViewBlue("View Detail", () {
                                    // Show the dialog with hospital details when the "View Detail" button is pressed
                                    // Call the dialog method when the "View Detail" button is pressed
                                    _showDetailsDialogADDScreeningCamp(
                                        context, offer);
                                  }),
                                  // _buildCAMPMAnageEDITDELETE()
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

// Method to show dialog with camp details
// Method to show dialog with screening camp details
  void _showDetailsDialogADDScreeningCamp(
      BuildContext context, DataScreeningCampList offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dialog Title
                  Text(
                    'Camp Details - ${offer.campNo}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Table for displaying camp details
                  Table(
                    border: TableBorder.all(color: Colors.blue, width: 1.0),
                    columnWidths: const {
                      0: FixedColumnWidth(150.0), // Field Name
                      1: FlexColumnWidth(),
                    },
                    children: [
                      _buildDetailsRow('Camp Name', offer.campNo),
                      _buildDetailsRow('Start Date',
                          Utils.formatDateString(offer.startDate)),
                      _buildDetailsRow(
                          'End Date', Utils.formatDateString(offer.endDate)),
                      _buildDetailsRow('City', offer.name),
                      // Add other fields as necessary
                    ],
                  ),

                  SizedBox(height: 16.0),

                  // Vertical Edit/Delete Buttons (CAMPMAnage)
                  Container(
                    height: 60, // Adjust the height if needed
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // Spaces buttons evenly
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Edit pressed');
                            // Add your edit logic here
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Delete pressed');
                            // Add your delete logic here
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),

                  // Close button
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Close'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Helper method for building each row in the dialog's table
  TableRow _buildDetailsRow(String fieldName, String fieldValue) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            fieldName,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(fieldValue, style: TextStyle(color: Colors.black87)),
        ),
      ],
    );
  }

  Future<List<Data>> _getStatesDAta() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/State'));
      Map<String, dynamic> json = jsonDecode(response.body);
      final DashboardStateModel dashboardStateModel =
          DashboardStateModel.fromJson(json);

      return dashboardStateModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataDsiricst>> _getDistrictData(int stateCode) async {
    DashboardDistrictModel dashboardDistrictModel = DashboardDistrictModel();
    ;
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"state_code": stateCode});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/ListDistrict",
          data: body,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + body.toString());
      print("@@Response--Api=====" + response1.toString());
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
      return null;
    }
  }

  Future<List<DataGetCity>> _getCity(int districtId) async {
    GetCity dashboardDistrictModel = GetCity();

    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode({"districtId": districtId});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetCity",
          data: body,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + body.toString());
      print("@@Response--Api=====" + response1.toString());
      dashboardDistrictModel = GetCity.fromJson(json.decode(response1.data));
      if (dashboardDistrictModel.status) {
        print("@@dashboardDistrictModel----getting of size +++--" +
            dashboardDistrictModel.data.length.toString());
      } else {
        print("@@no data---" + dashboardDistrictModel.data.length.toString());
      }
      return dashboardDistrictModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<List<DataGetVillage>> _getVillage(
      int districtId, int stateId, int blockId) async {
    GetVillage dashboardDistrictModel = GetVillage();

    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      var body = json.encode(
          {"districtId": districtId, "stateId": stateId, "blockId": blockId});
      //Way to send network calls
      Dio dio = new Dio();
      response1 = await dio.post(
          "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetVillage",
          data: body,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print("@@Response--Api" + body.toString());
      print("@@Response--Api=====" + response1.toString());
      dashboardDistrictModel = GetVillage.fromJson(json.decode(response1.data));
      if (dashboardDistrictModel.status) {
        print("@@GetVillage----getting of size +++--" +
            dashboardDistrictModel.data.length.toString());
      } else {
        print("@@no data---" + dashboardDistrictModel.data.length.toString());
      }
      return dashboardDistrictModel.data;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  Future<void> _ScreeningCampRegistration() async {
    Utils.showProgressDialog1(context);
    print("@@-----CampRegistration--inside api");
    var response = await ApiController.campRegistration(
        ngoNames.toString().trim(),
        _campNameController.text.toString().trim(),
        _selectedDateText.toString(),
        _selectedDateTextToDate.toString().trim(),
        getmanagerSrNO,
        _mobileController.text.toString().trim(),
        _addresssController.text.toString().trim(),
        valuetype,
        0,
        0,
        "0",
        0,
        0,
        0,
        0,
        _Pincodecontroller.text.toString().trim(),
        district_code_login,
        state_code_login,
        userId,
        entryby,
        darpan_nos);

    Utils.hideProgressDialog1(context);
    print("@@-----CampRegistration--inside api--2");
    // Check if the response is null before accessing properties
    if (response.message == "Camp Registered Successfully.") {
      Utils.showToast(response.message.toString(), true);
      print("@@Result message----Class: " + response.message);
      setState(() {
        EyeBankApplication = false;
        ngoDashboardclicks = false;
        ManageUSerNGOHospt = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        ngoScreeningCampListss=true;
        AddScreeningCamps = false;
      });
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }

  Widget ngoSATELLITECENTREMANAGERList() {
    return Column(
      children: [
        Visibility(
          visible: ngoSATELLITECENTREMANAGERLists,
          child: Column(
            children: [
              Container(
                color: Colors.blue, // Background color for the container
                padding: const EdgeInsets.all(16.0), // Padding inside the container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text to display the title
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft, // Align text to the left
                        child: Text(
                          'SATELLITE CENTRE MANAGER DETAILS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Increased font size for emphasis
                          ),
                          overflow: TextOverflow.ellipsis, // Ensures text does not overflow
                        ),
                      ),
                    ),

                    // Add Satellite Manager Button
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _addSatelliteCenterManager, // Trigger action on press
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, // Transparent background for the button
                          onPrimary: Colors.red, // Text color when not pressed
                          shadowColor: Colors.red.withOpacity(0.4), // Shadow effect
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                          side: BorderSide(color: Colors.red, width: 2.0), // Red border around the button
                        ),
                        child: Text(
                          'Add Satellite Manager',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.red, // Button text color
                            fontWeight: FontWeight.normal, // Text weight
                          ),
                          overflow: TextOverflow.ellipsis, // Text overflow handling
                        ),
                      ),
                    ),
                  ],
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
                        _buildHeaderCell('Officer Name'),
                        _buildHeaderCell('Hospital'),
                        //_buildHeaderCell('Designation'),
                       // _buildHeaderCell('Mobile Number'),
                       // _buildHeaderCell('Email id'),
                    _buildHeaderCellAction('View Details'),
                       // _buildHeaderCellUpdateandBlock('Update/Block'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetSatelliteCenterList>>(
                      future: ApiController.GetSatelliteManagerList(
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
                          List<DataGetSatelliteCenterList> ddata =
                              snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.name),
                                  _buildDataCell(offer.hName),
                               //   _buildDataCell(offer.designation),
                                 // _buildDataCell(offer.mobile),
                                 // _buildDataCell(offer.emailId),
                                 /* _buildSatelliteManagerEditBlocked(
                                      int.parse(offer.srNo)),*/
                                  _buildDataCellViewBlue("View Detail", () {
                                    // Show the dialog with hospital details when the "View Detail" button is pressed
                                    _showHospitalDetailsDialogSATELLITECENTREMANAGERDETAILS(
                                        offer);
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
// Function to show the dialog with hospital details
  void _showHospitalDetailsDialogSATELLITECENTREMANAGERDETAILS(
      DataGetSatelliteCenterList offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Satellite Center Manager Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vertical List of Details
                _buildVerticalRow('S.No.', '1'), // Static 1 for S.No.
                _buildVerticalRow('Officer Name', offer.name),
                _buildVerticalRow('Hospital', offer.hName),
                _buildVerticalRow('Designation', offer.designation),
                _buildVerticalRow('Mobile Number', offer.mobile),
                _buildVerticalRow('Email id', offer.emailId),
                _buildSatelliteManagerEditBlocked(
                    int.parse(offer.srNo))
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

// Helper function to build each vertical row (label and data)
  Widget _buildVerticalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 8.0), // Spacer between label and value
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis, // Handles long text gracefully
            ),
          ),
        ],
      ),
    );
  }






  Widget AddSatelliteManagerOption() {
    return Column(
      children: [
        Visibility(
          visible: AddSatelliteManagers,
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
                          'Satellite Manager Registration',
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
                    key: _formKeySatelliteManger,
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _userNameControllerStatelliteMangerReg,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'User Name*',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),

                        // Gender Selection
                        Text('Gender*'),
                        Row(
                          children: [
                            Radio<int>(
                              value: 1,
                              groupValue: genderSatelliteManagerApi,
                              onChanged: (value) {
                                setState(() {
                                  genderSatelliteManagerApi = value;
                                });
                              },
                            ),
                            Text('Male'),
                            Radio<int>(
                              value: 2,
                              groupValue: genderSatelliteManagerApi,
                              onChanged: (value) {
                                setState(() {
                                  genderSatelliteManagerApi = value;
                                });
                              },
                            ),
                            Text('Female'),
                            Radio<int>(
                              value: 3,
                              groupValue: genderSatelliteManagerApi,
                              onChanged: (value) {
                                setState(() {
                                  genderSatelliteManagerApi = value;
                                });
                              },
                            ),
                            Text('Transgender'),
                          ],
                        ),
                        SizedBox(height: 10.0),

                        // Mobile Number Field
                        TextFormField(
                          controller:
                              _mobileNumberControllerStatelliteMangerReg,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Mobile No.*',
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
                        SizedBox(height: 10.0),

                        // Email ID Field
                        TextFormField(
                          controller: _emailIdControllerStatelliteMangerReg,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Email ID*',
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
                        SizedBox(height: 10.0),

                        Center(
                          child: FutureBuilder<List<DataGethospitalForDDL>>(
                            future: _futureDataGethospitalForDDL,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              List<DataGethospitalForDDL> list =
                                  snapshot.data.toList();

                              // Check if _selectedUser is null or not part of the list anymore
                              if (_dataGethospitalForDDL == null ||
                                  !list.contains(_dataGethospitalForDDL)) {
                                _dataGethospitalForDDL =
                                    list.first; // Set the first item as default
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select hospital*',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    DropdownButtonFormField<
                                        DataGethospitalForDDL>(
                                      value: _dataGethospitalForDDL,
                                      onChanged: (userc) {
                                        setState(() {
                                          _dataGethospitalForDDL = userc;
                                          gethospitalName = userc?.hName ?? '';
                                          gethospitalNameSrNOReg =
                                              userc?.hRegID ?? '';
                                          print(
                                              'getMAnagerNAme Year: $gethospitalName');
                                          print(
                                              'getmanagerSrNO: $gethospitalNameSrNOReg');
                                        });
                                      },
                                      items: list.map((user) {
                                        return DropdownMenuItem<
                                            DataGethospitalForDDL>(
                                          value: user,
                                          child: Text(user.hName,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                        SizedBox(height: 16.0),
                        // Address Field
                        TextFormField(
                          controller: _addressControllerStatelliteMangerReg,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Address*',
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
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),

                        // Designation Field
                        TextFormField(
                          controller: _designationControllerStatelliteMangerReg,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Designation',
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
                        ),
                        SizedBox(height: 10.0),

                        // Submit and Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKeySatelliteManger.currentState
                                    .validate()) {
                                  // Process the form data
                                  print("@@_SatteliteMAnagerRegistration--");
                                  _satelliteManagersRegistrationRedOption();
                                }
                              },
                              child: Text('Submit'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Reset form fields
                                _resetFormSatelliteManager();
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

  Future<void> _satelliteManagersRegistrationRedOption() async {
    if (_formKeySatelliteManger.currentState.validate()) {
      Utils.showProgressDialog1(context);

      var response = await ApiController.satelliteManagerRegistration(
        _userNameControllerStatelliteMangerReg.text.toString().trim(),
        genderSatelliteManagerApi,
        _mobileNumberControllerStatelliteMangerReg.text.toString().trim(),
        _emailIdControllerStatelliteMangerReg.text.toString().trim(),
        gethospitalNameSrNOReg.toString(),
        _addressControllerStatelliteMangerReg.text.toString().trim(),
        _designationControllerStatelliteMangerReg.text.toString().trim(),
        district_code_login,
        state_code_login,
        userId,
        int.parse(entryby),
        darpan_nos,
        ngoNames,
        stateNames,
        districtNames,
      );

      Utils.hideProgressDialog1(context);

      // Check if the response is null before accessing properties
      if (response.status) {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----satelliteManagerRegistration: " +
            response.message);
        EyeBankApplication = false;
        ngoDashboardclicks = false;

        ManageUSerNGOHospt = false;
        ngoCampManagerLists = false;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;

        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        ngoSATELLITECENTREMANAGERLists = true;
      } else {
        Utils.showToast(response.message.toString(), true);
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }

  Widget EditSatelliteManager() {
    return Column(
      children: [
        Visibility(
          visible: SatelliteManagerRegisterartionsEdit,
          // Change this to your actual condition
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
                          'Satellite Manager Registration',
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
                    key: _formKeySatelliteMangerEditClick,
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _userNameControllerStatelliteMangerReg, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'User Name',
                                    style: TextStyle(
                                      color: Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // Asterisk indicating the field is required
                                    style: TextStyle(
                                      color: Colors.red, // Color of the '*' to indicate it's mandatory
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name'; // Validation message if field is empty
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

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
                        SizedBox(height: 10.0),

                        // Mobile Number Field
                        TextFormField(
                          controller: _mobileNumberControllerStatelliteMangerReg, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Mobile No.',
                                    style: TextStyle(
                                      color: Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // Asterisk indicating the field is required
                                    style: TextStyle(
                                      color: Colors.red, // Color of the '*' to indicate it's mandatory
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter your mobile number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone, // Ensures only numbers can be entered
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number'; // Validation message if field is empty
                            } else if (value.length != 10) {
                              return 'Please enter a valid 10-digit mobile number'; // Validation for 10-digit mobile number
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

                        // Email ID Field
                        TextFormField(
                          controller: _emailIdControllerStatelliteMangerReg, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Email ID',
                                    style: TextStyle(
                                      color: Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // Asterisk indicating the field is required
                                    style: TextStyle(
                                      color: Colors.red, // Color of the '*' to indicate it's mandatory
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter your email address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress, // Ensures keyboard is optimized for email input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'; // Validation for empty field
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address'; // Validation for valid email format
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

                        // Address Field
                        TextFormField(
                          controller: _addressControllerStatelliteMangerReg, // Attach controller
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address',
                                    style: TextStyle(
                                      color: Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // Asterisk indicating the field is required
                                    style: TextStyle(
                                      color: Colors.red, // Color of the '*' to indicate it's mandatory
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter your address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          maxLines: 3, // Allows for multi-line input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address'; // Validation for empty field
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

                        // Designation Field
                        TextFormField(
                          controller: _designationControllerStatelliteMangerReg, // Attach controller
                          decoration: InputDecoration(

                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Designation', // Label text
                                    style: TextStyle(
                                      color: Colors.black, // Default label color
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *', // Asterisk to indicate the field is required
                                    style: TextStyle(
                                      color: Colors.red, // Red color for the asterisk
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Enter your designation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your designation'; // Validation for empty field
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10.0),

                        // Submit and Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKeySatelliteMangerEditClick
                                    .currentState
                                    .validate()) {
                                  // Process the form data
                                  _SatelliteManagerRegistrationEdit();
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

  Future<void> _SatelliteManagerRegistrationEdit() async {
    print('@@Editclick of _SatelliteManagerRegistrationEdit List--');
    if (_formKeySatelliteMangerEditClick.currentState.validate()) {
      Utils.showProgressDialog1(context);

      var response = await ApiController.UpdateSatelliteManager(
          _userNameControllerStatelliteMangerReg.text.toString().trim(),
          gender,
          _mobileNumberControllerStatelliteMangerReg.text.toString().trim(),
          _emailIdControllerStatelliteMangerReg.text.toString().trim(),
          _addressControllerStatelliteMangerReg.text.toString().trim(),
          _designationControllerStatelliteMangerReg.text.toString().trim(),
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
      if (response.status) {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----Class: " + response.message);
        EyeBankApplication = false;
        ngoDashboardclicks = false;

        ManageUSerNGOHospt = false;
        ngoCampManagerLists = true;
        CampManagerRegisterartions = false;
        CampManagerRegisterartionsEdit = false;
        SatelliteManagerRegisterartionsEdit = false;

        ngoScreeningCampListss = false;
        AddScreeningCamps = false;
        ngoSATELLITECENTREMANAGERLists = false;
        AddSatelliteManagers = false;
        AddSatelliteCenterRedOptionFields = false;
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
  }

  Widget satelliteCenterMenuList() {
    return Column(
      children: [
        Visibility(
          visible: satelliteCenterMenuListdisplay,
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
                            'SATELLITE CENTRE MANAGER DETAILS',
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
                          onTap: _addSatelliteCenterRedOtionclick,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Add Satellite Centre',
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
                        _buildHeaderCell('Officer Name'),
                        _buildHeaderCell('Hospital'),
                        _buildHeaderCell('Designation'),
                        _buildHeaderCell('Mobile Number'),
                        _buildHeaderCell('Email id'),
                        _buildHeaderCell('Update/Block'),
                      ],
                    ),
                    Divider(color: Colors.blue, height: 1.0),
                    // Data Rows
                    FutureBuilder<List<DataGetSatelliteCenterList>>(
                      future: ApiController.GetSatelliteManagerList(
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
                          List<DataGetSatelliteCenterList> ddata =
                              snapshot.data;
                          print('@@---ddata' + ddata.length.toString());
                          return Column(
                            children: ddata.map((offer) {
                              return Row(
                                children: [
                                  _buildDataCellSrNo(
                                      (ddata.indexOf(offer) + 1).toString()),
                                  _buildDataCell(offer.name),
                                  _buildDataCell(offer.hName),
                                  _buildDataCell(offer.designation),
                                  _buildDataCell(offer.mobile),
                                  _buildDataCell(offer.emailId),
                                  _buildSatelliteManagerEditBlocked(
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

  void _addSatelliteCenterRedOtionclick() {
    // Handle the tap event here
    print('@@_addSatelliteCenterRedOtion--');
    setState(() {
      ManageUSerNGOHospt = false;
      ngoDashboardclicks = false;
      EyeBankApplication = false;
      ngoCampManagerLists = false;
      CampManagerRegisterartions = false;
      CampManagerRegisterartionsEdit = false;
      SatelliteManagerRegisterartionsEdit = false;

      ngoScreeningCampListss = false;
      AddScreeningCamps = false;
      AddSatelliteCenterRedOptionFields = true;
      _futureState = _getStatesDAta();
      ngoSATELLITECENTREMANAGERLists = false;
      AddSatelliteManagers = false;
      _futureDataGethospitalForDDL =
          GetHospitalForDDL(district_code_login, state_code_login, userId);
      satelliteCenterMenuListdisplay = false;
      _futureCenterOfficerName =
          getSatelliteManager(state_code_login, district_code_login, entryby);
    });
  }

  Widget AddSatelliteCenterRedOptionField() {
    return Column(
      children: [
        Visibility(
          visible: AddSatelliteCenterRedOptionFields,
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
                          'Satellite Center Registration',
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
                    key: _formKeySatelliteCneterO,
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _userSatelliteCentreNameRegCenter,
                          // Attach controller
                          decoration: InputDecoration(
                            labelText: 'Satellite Centre Name*',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Satellite Centre Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),

                        // Gender Selection

                        // Mobile Number Field
                        TextFormField(
                          controller:
                              _mobileNumberControllerStatelliteMangerRegCenter,
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
                          controller:
                              _emailIdControllerStatelliteMangerRegCenter,
                          // Attach controller
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

                        Center(
                          child: FutureBuilder<List<DataGethospitalForDDL>>(
                            future: _futureDataGethospitalForDDL,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              List<DataGethospitalForDDL> list =
                                  snapshot.data.toList();

                              // Check if _selectedUser is null or not part of the list anymore
                              if (_dataGethospitalForDDL == null ||
                                  !list.contains(_dataGethospitalForDDL)) {
                                _dataGethospitalForDDL =
                                    list.first; // Set the first item as default
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hospital Name*',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    DropdownButtonFormField<
                                        DataGethospitalForDDL>(
                                      value: _dataGethospitalForDDL,
                                      onChanged: (userc) {
                                        setState(() {
                                          _dataGethospitalForDDL = userc;
                                          gethospitalNameRegRedOption =
                                              userc?.hName ?? '';
                                          gethospitalNameSrNORegRedOption =
                                              userc?.hRegID ?? '';
                                          print(
                                              'getMAnagerNAme Year: $gethospitalName');
                                          print(
                                              '@@gethospitalNameSrNORegRedOption: $gethospitalNameSrNORegRedOption');
                                        });
                                      },
                                      items: list.map((user) {
                                        return DropdownMenuItem<
                                            DataGethospitalForDDL>(
                                          value: user,
                                          child: Text(user.hName,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                        SizedBox(height: 16.0),
                        Center(
                          child: FutureBuilder<
                              List<DataCenterOfficeNameSatelliteCenter>>(
                            future: _futureCenterOfficerName,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              List<DataCenterOfficeNameSatelliteCenter> list =
                                  snapshot.data;
                              print('@@DataCenterOfficeNameSatelliteCenter' +
                                  list.toString());
                              // Check if list is empty and handle accordingly
                              if (list.isEmpty) {
                                return Text('No managers available.');
                              }

                              // Check if _dataCenterOfficeNameSatelliteCenter is null or not part of the list anymore
                              if (_dataCenterOfficeNameSatelliteCenter ==
                                      null ||
                                  !list.contains(
                                      _dataCenterOfficeNameSatelliteCenter)) {
                                _dataCenterOfficeNameSatelliteCenter =
                                    list.first; // Set the first item as default
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Centre Officer Name*',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    DropdownButtonFormField<
                                        DataCenterOfficeNameSatelliteCenter>(
                                      value:
                                          _dataCenterOfficeNameSatelliteCenter,
                                      onChanged: (userc) {
                                        setState(() {
                                          print('@@DataCenterOfficeNameSatelliteCenter' +
                                              _dataCenterOfficeNameSatelliteCenter
                                                  .toString());
                                          print(
                                              '@@DataCenterOfficeNameSatelliteCenteruserc' +
                                                  userc.srNo.toString());

                                          _dataCenterOfficeNameSatelliteCenter =
                                              userc;
                                          getCenterOfficerName =
                                              userc?.name ?? '';
                                          getCenterOfficerNameSRNo =
                                              userc?.srNo ?? '';

                                          print(
                                              '@@getCenterOfficerName Year: $getCenterOfficerName');
                                          print('@@getCenterOfficerNameSRNo:' +
                                              getCenterOfficerNameSRNo
                                                  .toString());
                                        });
                                      },
                                      items: list.map((user) {
                                        return DropdownMenuItem<
                                            DataCenterOfficeNameSatelliteCenter>(
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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

                        SizedBox(height: 16.0),
                        // Address Field
                        TextFormField(
                          controller:
                              _addressControllerStatelliteMangerRegCenter,
                          // Attach controller
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

                        // Submit and Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKeySatelliteCneterO.currentState
                                    .validate()) {
                                  // Process the form data
                                  print(
                                      "@@satelliteCenterRegistationRed--Pending work here--");
                                  _satelliteCentersRegistrationRedOption();
                                }
                              },
                              child: Text('Submit'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Reset form fields
                                _resetFormSatelliteManager();
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

  Future<void> _satelliteCentersRegistrationRedOption() async {
    print("@@satelliteCenterRegistationRed--Pending work here--11");

    if (_formKeySatelliteCneterO.currentState.validate()) {
      Utils.showProgressDialog1(context);

      print("@@satelliteCenterRegistationRed--Pending work here--33");
      var response = await ApiController.satelliteCenterRegistation(
        _userSatelliteCentreNameRegCenter.text.toString().trim(),
        gethospitalNameSrNORegRedOption,
        getCenterOfficerNameSRNo,
        _mobileNumberControllerStatelliteMangerRegCenter.text.toString().trim(),
        _addressControllerStatelliteMangerRegCenter.text.toString().trim(),
        _emailIdControllerStatelliteMangerRegCenter.text.toString().trim(),
        district_code_login,
        state_code_login,
        userId,
        int.parse(entryby),
        darpan_nos,
      );

      Utils.hideProgressDialog1(context);

      // Check if the response is null before accessing properties
      if (response.status) {
        Utils.showToast(response.message.toString(), true);
        print("@@Result message----Class: " + response.message);
        setState(() {
          // Update any relevant state variables here.
          EyeBankApplication = false;
          ngoDashboardclicks = false;

          ManageUSerNGOHospt = false;
          ngoCampManagerLists = false;
          CampManagerRegisterartions = false;
          CampManagerRegisterartionsEdit = false;
          SatelliteManagerRegisterartionsEdit = false;

          ngoScreeningCampListss = false;
          AddScreeningCamps = false;
          AddSatelliteCenterRedOptionFields = false;
          // ngoSATELLITECENTREMANAGERLists = false;
          AddSatelliteManagers = false;
          ngoSATELLITECENTREMANAGERLists = true;
        });
      } else {
        Utils.showToast(response.message.toString(), true);
      }
    } else {
      // Handle the case where the list is null or empty
      Utils.showToast("Not created succesfully", true);
    }
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
    double size =
        14.0; // You can set a consistent size for both the icon and text

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      // Reduce the vertical padding
      title: Row(
        children: [
          Icon(icon, color: Colors.black, size: size),
          // Set icon size
          SizedBox(
            width: 8.0,
            height: 4.0,
          ),
          // Add space between the icon and the text
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: size,
              fontWeight:
                  FontWeight.normal, // Explicitly set fontWeight to normal
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
    List<Map<String, dynamic>>
        items, // List of maps to hold both item text and icon data
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
          items:
              items.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
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
                    style: TextStyle(
                        color: Colors.black, fontSize: size), // Set text size
                  ),
                ],
              ),
            );
          }).toList(),
          hint: hintIcon != null
              ? Row(
                  children: [
                    hintIcon, // Only add the icon if it's not null
                    SizedBox(
                        width: 8.0), // Add space between the icon and hint text
                    Text(
                      hint,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Text(
                  hint,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class GetChangeAPsswordFieldss {
  String userid;
  String oldPassword;
  String newPassword;
  String confirmPassword;
}
