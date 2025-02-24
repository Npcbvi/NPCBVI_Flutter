import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetStateWiseNGOForDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDashboardHopsital/MoreClickGetStateWiseHospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDonationCentrers/DonationCentersMoreClick.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickMedicalColleges/MoreClickGetStateWiseMedicalColleges.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickSatelliteCenters/MoreClickGetStateWiseSatelliteCenters.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/StateWiseCamp.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickSpo/SpoDataListclickMore.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreclickEyeBank/EyBank.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreclickPrivatePractitioner/MoreClickGetStateWisePrivatePrectioiries.dart';
import 'package:mohfw_npcbvi/src/model/contactus/ContactUS.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/distictNgODashboard/NGODashboards.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickDpm/StateWiseDpm.dart';
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
import 'moreClickdpm/StateWisedpm.dart';

class MainDashboard extends StatefulWidget {
  _MainDashboard createState() => _MainDashboard(); // connect using createState
}

class _MainDashboard extends State<MainDashboard> {
  bool isLoadingApi = true;
  String ngoCount, gH_CHC_Count, ppCount, campCount, satellitecentreCount, patientCount, dpm, pmcCount, totalEB, totalEd, spo;
  String _chosenValue, districtNames, userId, stateNames, fullnameController, _chosenValueRegistrationType, _chosenEyeBank;
  double imageTopPositionNGOs = 0; // Default position
  double imageTopPositionGovt = 0; // Default position

  double imageTopPositionMedicalCollege = 0; // Default position
  double imageTopPositionPrivatePractionries = 0; // Default position
  double imageTopPositionPatient = 0; // Default position
  double imageTopPositionSatelliteCenter = 0; // Default position
  double imageTopPositionScreeningCamps = 0; // Default position
  double imageTopPositionDpms = 0; // Default position
  double imageTopPositionSpos = 0; // Default position
  double imageTopPositionEyeBank = 0; // Default position
  double imageTopPositionDonationCenters = 0; // Default position

  bool isTapped = false;

  void _animateImageNGOs() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionNGOs = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionNGOs = -10; // Move image back to original position
      });
    });
  }
  void _animateImageGovt() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionGovt = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionGovt = -10; // Move image back to original position
      });
    });
  }
  void _animateImageMedicalCollege() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionMedicalCollege = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionMedicalCollege = -10; // Move image back to original position
      });
    });
  }
  void _animateImagePrivatePractionries() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionPrivatePractionries = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionPrivatePractionries = -10; // Move image back to original position
      });
    });
  }
  void _animateImagePatient() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionPatient = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionPatient = -10; // Move image back to original position
      });
    });
  }
  void _animateImageSatelliteCenters() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionSatelliteCenter = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionSatelliteCenter = -10; // Move image back to original position
      });
    });
  }
  void _animateImageScreeningCamps() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionScreeningCamps = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionScreeningCamps = -10; // Move image back to original position
      });
    });
  }
  void _animateImageDpms() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionDpms = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionDpms = -10; // Move image back to original position
      });
    });
  }
  void _animateImageSpos() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionSpos = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionSpos = -10; // Move image back to original position
      });
    });
  }
  void _animateImageEyeBank() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionEyeBank = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionEyeBank = -10; // Move image back to original position
      });
    });
  }
  void _animateImagDonationCenters() {
    setState(() {
      isTapped = !isTapped;
      imageTopPositionDonationCenters = isTapped ? -25 : -10; // Move image up when tapped
    });

    // Reset animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isTapped = false;
        imageTopPositionDonationCenters = -10; // Move image back to original position
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return;
    }

    Utils.showProgressDialog1(context);
    int maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
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
            isLoadingApi = false;
          });
          return; // Exit loop if successful
        } else {
          Utils.showToast(value.message, true);
        }
      } catch (e) {
        attempt++;
        if (attempt >= maxRetries) {
          Utils.showToast("Failed to fetch data. Please try again.", true);
        }
      }
    }

    Utils.hideProgressDialog1(context);
    setState(() {
      isLoadingApi = false;
    });
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

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()),
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
              /*  _buildMenuItem(
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
*/
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
      body: Container(
        height: double.infinity, // Ensures full height
        width: double.infinity, // Ensures full width
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "images/doctorpatientimage.jpg",
                fit: BoxFit.cover, // Ensures it covers the full screen
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: SingleChildScrollView(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreClickGetStateWiseNGOForDashboard(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'NGO(s)',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          ngoCount != null ? '$ngoCount' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0,
                              left: 30,

                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),

                                  child: Image.asset(
                                    'images/ngo_new.png',

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreClickGetStateWiseHospitalDashboard(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Goverment / CHC /RIO',
                                            style: TextStyle(
                                              color: govtgch,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          gH_CHC_Count   != null ? '$gH_CHC_Count  ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/govt.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreClickGetStateWiseMedicalColleges(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Medical College(s)',
                                            style: TextStyle(
                                              color: medicalcollege,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          pmcCount      != null ? '$pmcCount     ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/medicalclg.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreClickGetStateWisePrivatePrectioiries(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Private Practitioner(s)',
                                            style: TextStyle(
                                              color: privatepractitioner,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          ppCount          != null ? '$ppCount         ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'images/privatepractionarie.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();
                          Utils.showToast("work is pending from chnadha due to large data and crash app", true);
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Patient(s)',
                                            style: TextStyle(
                                              color: patient,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          patientCount != null ? '$patientCount  ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/paptient.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreClickGetStateWiseSatelliteCenters(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Satellite Centre(s)',
                                            style: TextStyle(
                                              color: satellitecentre,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          satellitecentreCount != null ? '$satellitecentreCount  ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/satellite.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StateWiseCamp(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Screening Camp(s)',
                                            style: TextStyle(
                                              color: screeningcamp,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          campCount != null ? '$campCount  ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/eye.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();

                          // Action when 'more..' is clicked
                          // _handleMoreClick();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StateWisedpm(),
                            ),
                          );

                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'DPM(s)',
                                            style: TextStyle(
                                              color: dpms,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          dpm   != null ? '$dpm    ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/dpm.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpoDataListclickMore(),
                            ),
                          );


                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'SPO(s)',
                                            style: TextStyle(
                                              color: dpms,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          spo    != null ? '$spo     ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'images/dpm.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // _handleMoreClick();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EyBank(),
                            ),
                          );


                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Eye Banks(s)',
                                            style: TextStyle(
                                              color:eybanks,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          totalEB != null ? '$totalEB  ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'images/eyebank.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonationCentersMoreClick(),
                            ),
                          );


                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                              child: SizedBox(
                                width: double.infinity, // Full width inside the margin
                                height: 100, // Set your desired height
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Donation Centres(s)',
                                            style: TextStyle(
                                              color:donationcentres,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          totalEd  != null ? '$totalEd   ' : '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🟢 Animated Positioned Image (Moves Up on Tap)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0 ,
                              left: 25,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'images/donationcenters.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

     /* body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreClickGetStateWiseNGOForDashboard(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'NGO(s)',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ngoCount != null ? '$ngoCount' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionNGOs,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreClickGetStateWiseHospitalDashboard(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Goverment / CHC /RIO',
                                      style: TextStyle(
                                        color: govtgch,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    gH_CHC_Count   != null ? '$gH_CHC_Count  ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionGovt ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreClickGetStateWiseMedicalColleges(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Medical College(s)',
                                      style: TextStyle(
                                        color: medicalcollege,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    pmcCount      != null ? '$pmcCount     ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionMedicalCollege  ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreClickGetStateWisePrivatePrectioiries(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Private Practitioner(s)',
                                      style: TextStyle(
                                        color: privatepractitioner,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ppCount          != null ? '$ppCount         ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionPrivatePractionries   ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();
                    Utils.showToast("work is pending from chnadha due to large data and crash app", true);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Patient(s)',
                                      style: TextStyle(
                                        color: patient,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    patientCount != null ? '$patientCount  ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionPatient    ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreClickGetStateWiseSatelliteCenters(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Satellite Centre(s)',
                                      style: TextStyle(
                                        color: satellitecentre,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    satellitecentreCount != null ? '$satellitecentreCount  ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionSatelliteCenter     ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StateWiseCamp(),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Screening Camp(s)',
                                      style: TextStyle(
                                        color: screeningcamp,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    campCount != null ? '$campCount  ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionScreeningCamps      ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();

                    // Action when 'more..' is clicked
                    // _handleMoreClick();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StateWisedpm(),
                      ),
                    );

                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'DPM(s)',
                                      style: TextStyle(
                                        color: dpms,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    dpm   != null ? '$dpm    ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionDpms      ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpoDataListclickMore(),
                      ),
                    );


                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'SPO(s)',
                                      style: TextStyle(
                                        color: dpms,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    spo    != null ? '$spo     ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionSpos      ,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // _handleMoreClick();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EyBank(),
                      ),
                    );


                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Eye Banks(s)',
                                      style: TextStyle(
                                        color:eybanks,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    totalEB != null ? '$totalEB  ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionEyeBank,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationCentersMoreClick(),
                      ),
                    );


                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right margin
                        child: SizedBox(
                          width: double.infinity, // Full width inside the margin
                          height: 100, // Set your desired height
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Donation Centres(s)',
                                      style: TextStyle(
                                        color:donationcentres,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    totalEd  != null ? '$totalEd   ' : '0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 🟢 Animated Positioned Image (Moves Up on Tap)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: imageTopPositionDonationCenters,// Animated position
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/ngo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                ),
              ],
            ),
          ),
        ),
      ),*/
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
