import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/CenterOfficeNameSatelliteCenter.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../database/SharedPrefs.dart';
import '../model/GetHospitalForDDL/GethospitalForDDL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
class SatelliteCenterClickAddSatelliteCenter extends StatefulWidget {
  final String entry;

  const SatelliteCenterClickAddSatelliteCenter({Key key,  this.entry}) : super(key: key);
  @override
  _SatelliteCenterClickAddSatelliteCenter createState() => _SatelliteCenterClickAddSatelliteCenter();
}

class _SatelliteCenterClickAddSatelliteCenter extends State<SatelliteCenterClickAddSatelliteCenter> {
  String gethospitalName,
      getCenterOfficerName,
      gethospitalNameSrNORegRedOption,
      gethospitalNameRegRedOption;
  String gethospitalNameSrNOReg;
  String fullnameController;
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      _chosenValueMange,
      _chosenValueMangeTwo;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  bool CampManagerRegisterartions = true; // This should be based on your logic
  String gender = 'Male'; // Default gender
  int status, district_code_login, state_code_login;
  String role_id,
      darpan_nos,
      entryby,
      ngoNames,
      eyeBankById,loggedInNgoId,
      fromlisteyeBankByIds;
  bool AddSatelliteManagers = true;
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
  int genderSatelliteManagerApi=1; // 1 for Male, 2 for Female, 3 for Transgender
  int genderSatelliteCenterApi;
  bool satelliteCenterMenuListdisplay = false;
  Future<List<DataGethospitalForDDL>> _futureDataGethospitalForDDL;
  DataGethospitalForDDL _dataGethospitalForDDL;
  bool AddSatelliteCenterRedOptionFields = true;
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
  Future<List<DataCenterOfficeNameSatelliteCenter>> _futureCenterOfficerName;
  DataCenterOfficeNameSatelliteCenter _dataCenterOfficeNameSatelliteCenter;
  int getCenterOfficerNameSRNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Satellite Center',
          maxLines: 2,
          // Assuming fullnameController has .text
          style: TextStyle(color: Colors.white, fontSize: 14.0),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddSatelliteCenterRedOptionField(), // No condition here
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();

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
          getDarpanNo();
          getloggedInNgoId();
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());
          print('@@9' + darpan_nos.toString());
          print('@@entryby' + widget.entry.toString());
          _futureDataGethospitalForDDL =
              GetHospitalForDDL(district_code_login, state_code_login, userId);
          _futureCenterOfficerName =
              getSatelliteManager(state_code_login, district_code_login, widget.entry);

        });
      });
    } catch (e) {
      print(e);
    }
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Login Type and District in a Row
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        // Margin for spacing
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              // Space between Login Type and District
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login Type:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'District NGO',
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
                                Text(
                                  'State:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${stateNames}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Space between Row and State Column
                      const SizedBox(width: 40),

                      // State in a Column with margin
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        // Right margin for spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'District:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${districtNames}',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      // Username Field
                      SizedBox(height: 5.0),



                      // Designation Field

                      // Submit and Cancel Buttons

                      TextFormField(
                        controller: _userSatelliteCentreNameRegCenter,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Satellite Centre Name',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your Satellite Center Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Satellite Centre Name'; // Validation message if field is empty
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.0),

                      TextFormField(
                        controller: _mobileNumberControllerStatelliteMangerRegCenter,
                        maxLength: 10, // Optional: limit input to 10 digits
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        ],
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mobile No.',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your Mobile No.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.0),

                      TextFormField(
                        controller: _emailIdControllerStatelliteMangerRegCenter,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'EmailId.',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your EmailId',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                          ),
                        ),
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
                      SizedBox(height: 5.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                snapshot.data ?? [];

                            // Ensure _dataGethospitalForDDL is in the list
                            if (_dataGethospitalForDDL == null ||
                                !list.contains(_dataGethospitalForDDL)) {
                              _dataGethospitalForDDL =
                              list.isNotEmpty ? list.first : null;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hospital Name*',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 50, // Same height as email field
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      // 👈 Simulating contentPadding
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<
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
                                                  style:
                                                  TextStyle(fontSize: 16)),
                                            );
                                          }).toList(),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.black),
                                          isExpanded:
                                          true, // Ensures dropdown takes full width
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                            if (_dataCenterOfficeNameSatelliteCenter == null ||
                                !list.contains(
                                    _dataCenterOfficeNameSatelliteCenter)) {
                              _dataCenterOfficeNameSatelliteCenter =
                                  list.first; // Set the first item as default
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Centre Officer Name*',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButtonFormField<
                                      DataCenterOfficeNameSatelliteCenter>(
                                    value: _dataCenterOfficeNameSatelliteCenter,
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
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Colors.black),
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: _addressControllerStatelliteMangerRegCenter,
                        // Attach controller
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Address',
                                  style: TextStyle(
                                    color:
                                    Colors.black, // Default label color
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  // Asterisk indicating the field is required
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Color of the '*' to indicate it's mandatory
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter your Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {

                                print(
                                    "@@satelliteCenterRegistationRed--Pending work here--");
                                _satelliteCentersRegistrationRedOption();
                            },
                            icon: Icon(Icons.check, size: 20),
                            // ✅ Add Check Icon
                            label: Text('Submit'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _resetFormSatelliteManager();
                            },
                            icon: Icon(Icons.refresh, size: 20),
                            // 🔄 Add Reset Icon
                            label: Text('Reset'),
                          ),
                        ],
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




  void _resetForm() {
    _formKey.currentState?.reset();
    _userNameController.clear();
    _mobileNumberController.clear();
    _emailIdController.clear();
    _addressController.clear();
    _designationController.clear();
    setState(() => gender = null);
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

  Future<void> getloggedInNgoId() async {
    // Use await to get the actual value from SharedPrefs
    loggedInNgoId =
    await SharedPrefs.getStoreSharedValue(AppConstant.loggedInNgoId)
    as String;

    if (loggedInNgoId != null) {
      print("loggedInNgoId Number: $loggedInNgoId");
    } else {
      print("No loggedInNgoId found in shared preferences.");
    }
  }
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
      print("@@getSatelliteManager--bodyprint--yy: ${url+body.toString()}");
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
  Future<void> _satelliteCentersRegistrationRedOption() async {
    print("@@satelliteCenterRegistationRed--Pending work here--11");

    // Start validation
    if (_userSatelliteCentreNameRegCenter.text.trim().isEmpty) {
      Utils.showToast("Please enter Satellite Centre Name", true);
      return;
    }

    if (gethospitalNameSrNORegRedOption == null || gethospitalNameSrNORegRedOption.isEmpty) {
      Utils.showToast("Please select a Hospital Name", true);
      return;
    }



    if (_mobileNumberControllerStatelliteMangerRegCenter.text.trim().isEmpty) {
      Utils.showToast("Please enter Mobile Number", true);
      return;
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(_mobileNumberControllerStatelliteMangerRegCenter.text.trim())) {
      Utils.showToast("Please enter a valid 10-digit mobile number", true);
      return;
    }

    if (_addressControllerStatelliteMangerRegCenter.text.trim().isEmpty) {
      Utils.showToast("Please enter Address", true);
      return;
    }

    if (_emailIdControllerStatelliteMangerRegCenter.text.trim().isEmpty) {
      Utils.showToast("Please enter Email ID", true);
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailIdControllerStatelliteMangerRegCenter.text.trim())) {
      Utils.showToast("Please enter a valid Email ID", true);
      return;
    }

    // All validation passed — proceed with API
    Utils.showProgressDialog1(context);
    print("@@satelliteCenterRegistationRed--Calling API--");

    var response = await ApiController.satelliteCenterRegistation(
      _userSatelliteCentreNameRegCenter.text.trim(),
      gethospitalNameSrNORegRedOption,
      getCenterOfficerNameSRNo,
      _mobileNumberControllerStatelliteMangerRegCenter.text.trim(),
      _addressControllerStatelliteMangerRegCenter.text.trim(),
      _emailIdControllerStatelliteMangerRegCenter.text.trim(),
      district_code_login,
      state_code_login,
      userId,
      int.parse(entryby),
      darpan_nos,
    );

    Utils.hideProgressDialog1(context);

    if (response.status) {
      Utils.showToast(response.message.toString(), true);
      print("@@Success message: " + response.message);
    } else {
      Utils.showToast(response.message.toString(), true);
    }
  }

}
