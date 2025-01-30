import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetStateWiseNGOForDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDashboardHopsital/MoreClickGetStateWiseHospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickMedicalColleges/MoreClickGetStateWiseMedicalColleges.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickSatelliteCenters/MoreClickGetStateWiseSatelliteCenters.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreclickPrivatePractitioner/MoreClickGetStateWisePrivatePrectioiries.dart';
import 'package:mohfw_npcbvi/src/model/contactus/ContactUS.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/distictNgODashboard/NGODashboards.dart';
import 'package:mohfw_npcbvi/src/ngo/NgoDashboard.dart';
import 'package:mohfw_npcbvi/src/spo/SpoDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/ContactusHtmlDisplayScreen.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/DarpanWebview.dart';

import '../hospitaldashboard/HospitalDashboard.dart';
import '../loginsignup/RegisterScreen.dart';
import '../registerScreens/NGORegistrationScreen.dart';

class MainDashboard extends StatefulWidget {
  _MainDashboard createState() => _MainDashboard(); // connect using createState
}

class _MainDashboard extends State<MainDashboard> {
  bool isLoadingApi = true;
  String ngoCount, gH_CHC_Count, ppCount, campCount, satellitecentreCount, patientCount, dpm, pmcCount, totalEB, totalEd, spo;
  String _chosenValue, districtNames, userId, stateNames, fullnameController, _chosenValueRegistrationType, _chosenEyeBank;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      Utils.showProgressDialog1(context);
      try {
        final value = await ApiController.getDashbaord();
        Utils.hideProgressDialog1(context);
        if (value.status) {
          setState(() {
            ngoCount = value.data.ngoCount ?? '0';
            gH_CHC_Count = value.data.gHCHCCount ?? 'null';
            ppCount = value.data.ppCount ?? 'null';
            campCount = value.data.campCount ?? 'null';
            satellitecentreCount = value.data.satellitecentreCount ?? 'null';
            patientCount = value.data.patientCount ?? 'null';
            dpm = value.data.dpm ?? 'null';
            pmcCount = value.data.pmcCount ?? 'null';
            totalEB = value.data.totalEB ?? 'null';
            totalEd = value.data.totalEd ?? 'null';
            spo = value.data.spo ?? 'null';
          });
        }
        //    Utils.showToast(value.message, !value.status);
      } catch (e) {
        Utils.showToast(e.toString(), true);
      } finally {
        setState(() {
          isLoadingApi = false;
        });
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          'Dashboard',
          style: new TextStyle(color: Colors.white),
        ),
      /*  leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context,
                false); //is used to removed the top-most route off the navigator.
            // To go to a new screen, use the Navigator.push()
          },
        ),*/
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.contact_page,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactusHtmlDisplayScreen()),
              );
              // do something
            },
          )
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
            margin: EdgeInsets.all(8.0),
            // Reduce the margin to decrease space// Set the margin here
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    setState(() {
                        Navigator.pop(context);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainDashboard()));*/
                    });
                  //  Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.contact_page,
                  title: 'Contact Us',
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactusHtmlDisplayScreen()));
                    });
                   // Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.contact_page,
                  title: 'Registration',
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    });
                    // Navigator.pop(context);
                  },
                ),
                /*_buildDropdownItem(
                  value: _chosenValueRegistrationType,
                  hint: 'Registration',
                  hintIcon: Icon(Icons.local_hospital, color: Colors.black),
                  // Add an icon to the hint
                  items: [
                    {'value': 'NGO', 'icon': Icons.group}, // Example of valid Flutter icon
                    {'value': 'Govt/Private/Other', 'icon': Icons.healing},
                    {'value': 'SPO', 'icon': Icons.supervised_user_circle},
                    {'value': 'DPM', 'icon': Icons.person_pin},
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueRegistrationType = value;
                      //  print('@@spinnerChooseValue--' + _chosenValue);
                      if (_chosenValueRegistrationType == "NGO") {
                        print('@@NGO--1' + _chosenValueRegistrationType);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NGORegistrationScreen()));
                      //  Navigator.pop(context);
                      } else if (_chosenValueRegistrationType ==
                          "Govt/Private/Other") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      } else if (_chosenValueRegistrationType ==
                          "SPO") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      } else if (_chosenValueRegistrationType ==
                          "DPM") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      }
                    });
                  },
                ),*/
                _buildMenuItem(
                  icon: Icons.login,
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
                  //  Navigator.pop(context);
                  },
                ),

              ],
            ),
          ),
        ),
      ),


      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'NGO(s)',
                                          style: TextStyle(
                                              color: green2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          ngoCount != null ? '${ngoCount}' : '0',  // If ngoCount is null, show '0'
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
                                        //  Utils.showToast("Complete in next Sprint!", true);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MoreClickGetStateWiseNGOForDashboard(),


                                            ),
                                          );
                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Goverment / CHC /RIO',
                                          style: TextStyle(
                                              color: govtgch,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          gH_CHC_Count != null ? '${gH_CHC_Count}' : '0',  // If ngoCount is null, show '0'
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                             builder: (context) => MoreClickGetStateWiseHospitalDashboard(),


                                            ),
                                          );
                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Medical College(s)',
                                          style: TextStyle(
                                              color: medicalcollege,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          pmcCount != null ? '${pmcCount}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MoreClickGetStateWiseMedicalColleges(),


                                            ),
                                          );
                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Private Practitioner(s)',
                                          style: TextStyle(
                                              color: privatepractitioner,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          ppCount != null ? '${ppCount}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MoreClickGetStateWisePrivatePrectioiries(),


                                            ),
                                          );

                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Patient(s)',
                                          style: TextStyle(
                                              color: patient,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          patientCount != null ? '${patientCount}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
                                        Utils.showToast("work is pending from chnadha due to large data and crash app", true);

                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Satellite Centre(s)',
                                          style: TextStyle(
                                              color: satellitecentre,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          satellitecentreCount != null ? '${satellitecentreCount}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          // Action when 'more..' is clicked
                                          // _handleMoreClick();
      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder: (context) => MoreClickGetStateWiseSatelliteCenters(),


                                          ),
                                          );
                                        },
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                            color: Colors.black, // Changed to blue to indicate it's clickable
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Screening Camp(s)',
                                          style: TextStyle(
                                              color: screeningcamp,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          campCount != null ? '${campCount}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'DPM(s)',
                                          style: TextStyle(
                                              color: dpms,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          dpm != null ? '${dpm}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'SPO(s)',
                                          style: TextStyle(
                                              color: spos,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          spo != null ? '${spo}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Eye Banks(s)',
                                          style: TextStyle(
                                              color: eybanks,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          totalEB != null ? '${totalEB}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          'Donation Centres(s)',
                                          style: TextStyle(
                                              color: donationcentres,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Text(
                                          totalEd != null ? '${totalEd}' : '0',  // If ngoCount is null, show '0'

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        child: Text(
                                          'more..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
              ],
            ),
          ),
        ),
      ),
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
