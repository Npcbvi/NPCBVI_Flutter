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


class DonationCentersMoreClick extends StatefulWidget {


  @override
  _DonationCentersMoreClick createState() => _DonationCentersMoreClick();
}

class _DonationCentersMoreClick extends State<DonationCentersMoreClick> {

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
          'Donation Centers',
          maxLines:2,
          style: TextStyle(fontSize: 14.0),
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

