import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class DPMDashboard extends StatefulWidget {
  @override
  _DPMDashboard createState() => _DPMDashboard();
}

class _DPMDashboard extends State<DPMDashboard> {
  //TextEditingController fullnameController = new TextEditingController();
  String _chosenValue,
      districtNames,
      userId,
      stateNames,
      fullnameController,
      _chosenValueLOWVision,
      _chosenEyeBank,
      _chosenValueLgoutOption;
  int status;
  String role_id;
  bool isLoadingApi = true;
  DPMDashboardParamsData dpmDashboardParamsDatass =
      new DPMDashboardParamsData();
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
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          print('@@2' + user.name);
          //print('@@fullnameController_1' + fullnameController.text);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _getDPMDashbnoardData() {
    getUserData();
    dpmDashboardParamsDatass.districtidDPM = 547;
    dpmDashboardParamsDatass.stateidDPM = 29;
    dpmDashboardParamsDatass.old_districtidDPM = 569;
    dpmDashboardParamsDatass.useridDPM = userId;
    dpmDashboardParamsDatass.roleidDPM = role_id;
    dpmDashboardParamsDatass.statusDPM = status;
    dpmDashboardParamsDatass.financialYearDPM = "2024-2025";

    Utils.isNetworkAvailable().then((isNetworkAvailable) async {
      if (isNetworkAvailable) {
        Utils.showProgressDialog(context);
        try {
          final response =
              await ApiController.getDPM_Dashboard(dpmDashboardParamsDatass);
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Utils.hideKeyboard(context);
              Navigator.of(context).pop(context);
            }),
        actions: [

          PopupMenuButton<int>(

            itemBuilder: (context) => [
              // PopupMenuItem 1
               PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Change Password")
                  ],
                ),
              ),
              // PopupMenuItem 2
               PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("User Manual")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                print('@@value is 1----');
                // if value 2 show dialog

              } else if (value == 2) {
                print('@@value is 2----');
              }
              else if (value == 3) {
                print('@@value is 3----');
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
                      Container(
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
                              'Approve Application',
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
                                if (_chosenValue == "Approve Application") {
                                  print('@@NGO--1' + _chosenValue);
                                } else if (_chosenValue == "New Hospital") {
                                } else if (_chosenValue ==
                                    "Govt/private/Other") {}
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
                                    "Diabetic") {
                                } else if (_chosenValueLOWVision ==
                                    "Glaucoma") {}
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(width: 8.0),
                      Container(
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
                                } else if (_chosenEyeBank == "Eye Donation") {
                                } else if (_chosenEyeBank ==
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
                                child: Text('Patient(s) (2024-2025)',
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
                                      child: new Text('Approved',
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
                                          20, 30, 20.0, 0),
                                      child: new Text('Pending',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
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
                                      child: new Text('${totalPatientPending}',
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
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
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
                                                '${ngoCountApproved}',
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
                                                '${ngoCountPending}',
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
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
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
                                            child: new Text('${gH_CHC_Count}',
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
                                                '${gH_CHC_Count_Pending}',
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
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
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
                                            child: new Text('${ppCount}',
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
                                                '${ppCount_pending}',
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
                                      child: Text('Private Medical College(s)',
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
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
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
                                            child: new Text('${pmcCount}',
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
                                                '${ppCount_pending}',
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
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Completed',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Ongoing',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Coming',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
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
                                                '${campCompletedCount}',
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
                                                '${campongoingCount}',
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
                                                '${campCommingCount}',
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
                                    /* Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),*/
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text(
                                                '${satellitecentreCount}',
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
                                            child: new Text('more..',
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
                                    /* Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20.0, 0),
                                            child: new Text('Approved',
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
                                                20, 30, 20.0, 0),
                                            child: new Text('Pending',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),*/
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20.0, 0),
                                            child: new Text('${patientCount}',
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
                                            child: new Text('more..',
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
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new Text(
                                'Disease-wise Patient Statistics( Since FY: 2024-2025 )',
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
                            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                            child: new Text(
                                'Disease-wise Registered Patient(Since FY: 2024-2025',
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
          ],
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
//{
//   "districtid": 547,
//   "stateid": 29,
//   "old_districtid": 569,
//   "userid": "string",
//   "roleid": "string",
//   "status": 5,
//   "financialYear": "2024-2025"
// }
