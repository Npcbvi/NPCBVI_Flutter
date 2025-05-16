import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/bindorg/BindOrgan.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_ScreeningYear.dart';

import '../../utils/AppConstants.dart';
import '../../utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DiseaseCatracReportScreen extends StatefulWidget {
  @override
  _DiseaseCataractReportScreenState createState() =>
      _DiseaseCataractReportScreenState();
}

class _DiseaseCataractReportScreenState
    extends State<DiseaseCatracReportScreen> {
  bool showSubCategoryDropdown = false;
  String selectedDisease;
  bool GetDPM_GH_APPorovedClickShowData = false;

  List<String> diseases = ['Disease(s)', 'Screening', 'Eye Bank','PNJA Cataract'];
  Map<String, List<String>> subCategories = {
    'Disease(s)': ['Cataract', 'Diabetic', 'Glaucoma','Corneal blindness','VR Surgery',''],
    'Screening': ['Eye Screening'],
    'Eye Bank': ['Eye Bank Collection', 'Eye Donation Collection'],
  };
  String  oganisationTypeGovtPrivateDRopDown;

  String _selectedDateText = 'Start Date *'; // Initially set to "From Date"

  String _selectedDateTextToDate = 'End Date*';
  Future<List<DataGetDPM_ScreeningYear>> _future;
  DataGetDPM_ScreeningYear _selectedUser;
  String getfyid;
  int dropDownvalueOrgnbaistaionType = 0;
  Future<List<DataBindOrgan>> _futureBindOrgan;
  int status, district_code_login, state_code_login,lowVisionDataValue = 0;
  String role_id,bindOrganisationNAme,npcbNo,lowVisionDatas;
  DataBindOrgan _selectBindOrgniasation;
  bool dpmReportDataList = false;
  String getYearNgoHopital, getfyidNgoHospital;
  String districtNames,userId, stateNames, fullnameController,darpan_nos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    _future = getDPM_ScreeningYear();
    _futureBindOrgan = GetDPM_Bindorg();
    // _futureAddSchoolEyeScreening = fetchScreeningYearData();  // API call happens once here
    // _futureMonthAddSchoolEyeScreening = fetchScreeningMonthData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Disease Report'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disease Selection Box
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Disease",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Choose a disease'),
                        value: selectedDisease,
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            selectedDisease = value;
                            showSubCategoryDropdown = true;
                          });

                        },
                        items: diseases.map((disease) {
                          return DropdownMenuItem(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 5),

            // Animated Subcategory Selection Box
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: showSubCategoryDropdown && selectedDisease != null
                  ? 1.0
                  : 0.0,
              child: Visibility(
                visible: showSubCategoryDropdown && selectedDisease != null,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Subcategory",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text('Choose a subcategory'),
                            isExpanded: true,
                            onChanged: (value) {
                              // Navigate to Cataract screen if selected
                              setState(() {
                                GetDPM_GH_APPorovedClickShowData =
                                    value == 'Cataract';
                              });
                            },
                            items: (selectedDisease != null &&
                                subCategories[selectedDisease] != null)
                                ? subCategories[selectedDisease]
                                .map((sub) {
                              return DropdownMenuItem(
                                value: sub,
                                child: Text(sub),
                              );
                            }).toList()
                                : [],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display additional data when 'Disease(s)' is selected
            DPMGetDPM_GHA_Click_prrovalDisplayDatas(),
          ],
        ),
      ),

    );
  }
  Widget DPMGetDPM_GHA_Click_prrovalDisplayDatas() {
    return Column(
      children: [
        Visibility(
          visible: GetDPM_GH_APPorovedClickShowData,
          child: Center(
            child: Column(
              children: [
                // Header Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white70,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 160.0,
                          child: Text(
                            'Cataract Data Report',
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5), // Corrected placement
                FutureBuilder<List<DataGetDPM_ScreeningYear>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<DataGetDPM_ScreeningYear> list = snapshot.data.toList();

                    // ✅ Set default first value when opening the screen
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_selectedUser == null || !list.contains(_selectedUser)) {
                        setState(() {
                          _selectedUser = list.first;
                          getYearNgoHopital = _selectedUser.name;
                          getfyidNgoHospital = _selectedUser.fyid;
                        });
                      }
                    });


                    // Show "No data found" if the list is empty
                    if (list.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Container(
                          width: 300,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'No data found',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                      child: SizedBox(
                        width: 300, // Set width using SizedBox
                        child: DropdownButtonFormField2<DataGetDPM_ScreeningYear>(
                          value: _selectedUser,
                          onChanged: (userc) {
                            setState(() {
                              _selectedUser = userc;
                              getYearNgoHopital = userc?.name ?? '';
                              getfyidNgoHospital = userc?.fyid ?? '';
                              print('@@Selected Year: $getYearNgoHopital');
                              print('@@FYID: $getfyidNgoHospital');
                            });
                          },
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
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                            hintText: null, // Remove the hint text
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          buttonStyleData: ButtonStyleData(
                            height: 21, // Adjust button height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                            iconSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),



                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    _selectedDateText =
                                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
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

                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    _selectedDateTextToDate =
                                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                  child: DropdownButtonFormField2<String>(
                    value: oganisationTypeGovtPrivateDRopDown,
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor:    Colors.blue[50],
                    ),
                    hint: Text(
                      "Select",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      iconSize: 24,
                    ),
                    items: [
                      'NGO District',
                      'District Hospital/government Medical College',
                      'CHC/Sub-Dist. Hospital',
                      'Private Practitioner',
                      'Private Institute',
                      'Other',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        oganisationTypeGovtPrivateDRopDown = newValue;
                        print('@@oganisationTypeGovtPrivateDRopDown-- $oganisationTypeGovtPrivateDRopDown');

                        switch (oganisationTypeGovtPrivateDRopDown) {
                          case "NGO District":
                            dropDownvalueOrgnbaistaionType = 5;
                            _futureBindOrgan = GetDPM_Bindorg();
                            break;
                          case "District Hospital/government Medical College":
                            dropDownvalueOrgnbaistaionType = 10;
                            break;
                          case "CHC/Sub-Dist. Hospital":
                            dropDownvalueOrgnbaistaionType = 11;
                            break;
                          case "Private Practitioner":
                            dropDownvalueOrgnbaistaionType = 12;
                            break;
                          case "Private Institute":
                            dropDownvalueOrgnbaistaionType = 13;
                            break;
                          case "Other":
                            dropDownvalueOrgnbaistaionType = 14;
                            break;
                          default:
                            dropDownvalueOrgnbaistaionType = 0;
                        }
                        print('@@dropDownvalueOrgnbaistaionType: $dropDownvalueOrgnbaistaionType');
                      });
                    },
                  ),
                ),

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
                      print('@@snapshot___5: $dropDownvalueOrgnbaistaionType');

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
                                'Organisation Name',
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
                                    npcbNo = userbindOrgan?.npcbNo ?? '';
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
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 1.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                  child: DropdownButtonFormField2<String>(
                    value: lowVisionDatas,
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    hint: Text(
                      "Select Type",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      iconSize: 24,
                    ),
                    items: ['Approved', 'Pending', 'Rejected']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        lowVisionDatas = newValue;
                        print('@@lowVisionDatas-- $lowVisionDatas');

                        switch (lowVisionDatas) {
                          case "Approved":
                            lowVisionDataValue = 5;
                            break;
                          case "Pending":
                            lowVisionDataValue = 4;
                            break;
                          case "Rejected":
                            lowVisionDataValue = 6;
                            break;
                          default:
                            lowVisionDataValue = 0;
                        }
                        print('@@lowVisionDataValue: $lowVisionDataValue');
                      });
                    },
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
                          dpmReportDataList=true;
                          setState(() {
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
