import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/ContactusHtmlDisplayScreen.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/DarpanWebview.dart';

class MainDashboard extends StatefulWidget {
  _MainDashboard createState() => _MainDashboard(); // connect using createState
}

class _MainDashboard extends State<MainDashboard> {
  bool isLoadingApi = true;

  String ngoCount,
      gH_CHC_Count,
      ppCount,
      campCount,
      satellitecentreCount,
      patientCount,
      dpm,
      pmcCount,
      totalEB,
      totalEd,
      spo;

/*  Future<void> initState() {
    super.initState();
    Future<bool> isNetworkAvailable = Utils.isNetworkAvailable();
    if (isNetworkAvailable != null) {
      ApiController.getDashbaord().then((value) {
        setState(() {
          isLoadingApi = false;
          print('@@MainDashboard--' + value.message);
          if (value.status) {
            setState(() {
              print('@@MainDashboard--' + value.status.toString());
              ngoCount = value.data.ngoCount;
              gH_CHC_Count = value.data.gHCHCCount;
              ppCount = value.data.ppCount;
              campCount = value.data.campCount;
              satellitecentreCount = value.data.satellitecentreCount;
              patientCount = value.data.patientCount;
              dpm = value.data.dpm;
              pmcCount = value.data.pmcCount;
              totalEB = value.data.totalEB;
              totalEd = value.data.totalEd;
              spo = value.data.spo;
              print('@@ngoCount--' + ngoCount);
              print('@@spo--' + spo);
            });


          }
        });
      });
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }*/
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
            ngoCount = value.data.ngoCount;
            gH_CHC_Count = value.data.gHCHCCount;
            ppCount = value.data.ppCount;
            campCount = value.data.campCount;
            satellitecentreCount = value.data.satellitecentreCount;
            patientCount = value.data.patientCount;
            dpm = value.data.dpm;
            pmcCount = value.data.pmcCount;
            totalEB = value.data.totalEB;
            totalEd = value.data.totalEd;
            spo = value.data.spo;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context,
                false); //is used to removed the top-most route off the navigator.
            // To go to a new screen, use the Navigator.push()
          },
        ),
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
                                          '${ngoCount}',
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
                                          '${gH_CHC_Count}',
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
                                          '${pmcCount}',
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
                                          '${ppCount}',
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
                                          '${patientCount}',
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
                                          '${satellitecentreCount}',
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
                                          '${campCount}',
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
                                          '${dpm}',
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
                                          '${spo}',
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
                                          '${totalEB}',
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
                                          '${totalEd}',
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
}
