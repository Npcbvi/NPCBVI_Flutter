import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/campdashboard/CampDashboard.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/ForgotPasswordScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/RegisterScreen.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MainDashboard.dart';
import 'package:mohfw_npcbvi/src/model/guidlines/GuilinessPage.dart';
import 'package:url_launcher/url_launcher.dart';


class OuterDashboardHomeClicks extends StatefulWidget {
  @override
  _OuterDashboardHomeClicks createState() => _OuterDashboardHomeClicks();
}

class _OuterDashboardHomeClicks extends State<OuterDashboardHomeClicks> {
  List<LstGuidelineFileName> guidelinesFiles = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<LstGuidelineFileName> data = await ApiController.guidelinesForHomePage();
    setState(() {
      guidelinesFiles = data;
      isLoading = false;
    });
  }
  void showDataAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "About NPCBVI",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold, // Makes text bold
              ),
            ),
            Divider( // Divider below the title
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
        content: Container(
          height: 400,
          width: double.maxFinite,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(6.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'National Programme for Control of Blindness & Visual Impairment (NPCBVI) was launched in the year 1976 as a 100% Centrally '
                        'Sponsored scheme with the goal to reduce the prevalence of blindness from 1.4% to 0.3%. As per Survey in 2001-02, prevalence of '
                        'blindness is estimated to be 1.1%. Rapid Survey on Avoidable Blindness conducted under NPCBVI during 2006-07 showed reduction '
                        'in the prevalence of blindness from 1.1% (2001-02) to 1% (2006-07). Various activities/initiatives undertaken during the Five '
                        'Year Plans under NPCBVI are targeted towards achieving the goal of reducing the prevalence of blindness to 0.3% by the year 2020.\n\n',
                  ),



                  // NGO Section
                  TextSpan(
                    text: 'Goals & Objectives of NPCBVI in the XII Plan \n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),

                  ),
                  TextSpan(
                    text: 'To reduce the backlog of blindness through identification and treatment of blind at primary, secondary, and tertiary levels '
                        'based on assessment of the overall burden of visual impairment in the country.\n\n',
                  ),

                  //    TextSpan(text: '   • Equipment details of your hospital need to be filled once you log in.\n'),
                  TextSpan(
                    text: 'Develop and strengthen the strategy of NPCBVI for “Eye Health” and prevention of visual impairment; through provision of comprehensive Eye Care services and quality service delivery.\n\n',
                  ),
                  TextSpan(
                    text: 'Strengthening and upgradation of RIOs to become centre of excellence in various sub-specialities of ophthalmology\n\n',
                  ),
                  TextSpan(text: 'Strengthening the existing and developing additional human resources and infrastructure facilities for providing high quality comprehensive Eye Care in all Districts of the country; \n\n'),
                  TextSpan(text: 'To enhance community awareness on eye care and lay stress on preventive measures; \n\n'),
                  TextSpan(text: ' Increase and expand research for prevention of blindness and visual impairment\n \n\n'),

                  // Private Practitioners Section
                  TextSpan(
                    text: 'To secure participation of Voluntary Organizations/Private Practitioners in eye Care. \n\n',

                  ),


                  // Contact Info


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
 /* Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // or Colors.blueGrey[50]
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disables the back button
        centerTitle: true,
        title: Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainDashboard()));
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity, // Ensures full height
        width: double.infinity, // Ensures full width
        child: Stack(

          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                *//*  SizedBox(
                    height: 28,
                    child: Marquee(
                      text: 'NGO Darpan number is mandatory for registration.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      velocity: 50.0,
                      pauseAfterRound: Duration(seconds: 1),
                      startPadding: 10.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),*//*
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 350, // Set the desired width
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15),
                        children: [
                          TextSpan(
                            text:
                            'National Programme for Control of Blindness & Visual Impairment (NPCBVI) was launched in the year 1976 as a 100% Centrally'
                              'Sponsored scheme with the goal to reduce the prevalence of blindness from 1.4% to 0.3%',
                          ),

                          TextSpan(
                            text: '\nRead more',
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = showDataAlert,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home', style: TextStyle(color: Colors.white)),
       /* actions: [
          IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainDashboard()),
              );
            },
          )
        ],*/
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5), // Internal padding for spacing
              alignment: Alignment.centerLeft, // Aligns text to the left
              child: RichText(
                text: TextSpan(
                  text: 'About NPCBVI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, // Text color
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 350,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'National Programme for Control of Blindness & Visual Impairment (NPCBVI) was launched in the year 1976 as a 100% Centrally'
                          ' Sponsored scheme with the goal to reduce the prevalence of blindness from 1.4% to 0.3%',
                    ),
                    TextSpan(
                      text: '\nRead more',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = showDataAlert,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3, // Adds shadow for depth
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Space around the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2), // Rounded corners
              ),
              color: Colors.blue, // Sets background color to white
              child: Container(
                padding: EdgeInsets.all(10), // Internal padding for spacing
                alignment: Alignment.centerLeft, // Aligns text to the left
                child: RichText(
                  text: TextSpan(
                    text: 'Guidelines',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 5),
            isLoading
                ? CircularProgressIndicator() // Show loading indicator
                : guidelinesFiles.isEmpty
                ? Text("No guidelines available", style: TextStyle(fontSize: 16))
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: guidelinesFiles.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: ListTile(
                    visualDensity: VisualDensity(vertical: -4), // Further decreases height
                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10), // Adjust padding
                    title: Text(
                      guidelinesFiles[index].filename,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Change this to any color you prefer
                      ),
                    ),

                    /*subtitle: Text(
                      guidelinesFiles[index].link,
                      style: TextStyle(color: Colors.blue),
                    ),*/
                    onTap: () async {
                      final url = guidelinesFiles[index].link;
                      print("@@url--url Response: ${url.toString()}");
                      if (await canLaunch(url)) {
                      await launch(
                      url,
                      forceSafariVC: false, // iOS: Opens in external app
                      forceWebView: false, // Android: Opens in browser or PDF reader
                      );
                      } else {
                      throw 'Could not launch $url';

                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
