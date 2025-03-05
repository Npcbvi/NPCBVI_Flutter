import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetDistrictWiseNGOForDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/DistrictWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/sendTODPM/SendTODPMCataract.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/StateWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickSpo/SpoListwise.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GetStateWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickStateWise.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';


class UpcomingHomeGuidlines extends StatefulWidget {


  @override
  _UpcomingHomeGuidlines createState() => _UpcomingHomeGuidlines();
}

class _UpcomingHomeGuidlines extends State<UpcomingHomeGuidlines> {

  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidliness',
          maxLines: 2,
          style: TextStyle(fontSize: 12.0),
        ),
      ),
      body: Container(
        color: Colors.white, // Full-screen white background
        child: Center(
          child: Text(
            "Upcoming Screen",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Adjust color as needed
            ),
          ),
        ),
      ),
    );
  }


}

