import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetDistrictWiseNGOForDashboard.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickMedicalColleges/GetDistrictWiseMedicalCollegs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickSatelliteCenters/GetDistrictWiseSatelliteCenters.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreclickPrivatePractitioner/GetDistrictWisePrivatePractiories.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/sendTODPM/SendTODPMCataract.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickMEdicalColleges/stateWiseMedicalCollegs.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickSatelliteCenters/stateWiseSatelliteCenterss.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickprivatepractiories/stateWisePrivatePractiories.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GetStateWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickStateWise.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';


class MoreClickGetStateWiseSatelliteCenters extends StatefulWidget {


  @override
  _MoreClickGetStateWiseSatelliteCenters createState() => _MoreClickGetStateWiseSatelliteCenters();
}

class _MoreClickGetStateWiseSatelliteCenters extends State<MoreClickGetStateWiseSatelliteCenters> {
  String districtNames = '';
  String stateNames = '';
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  String role_id, userId, currentFinancialYear;
  int district_code_login, state_code_login;
  String Gender;
String   moreclickNgoStatedCodess;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(
        'State-wise Private Practitioners',
        style: TextStyle(
          fontSize: 12.0, // Adjust the size as needed
        ),
      ),

      ),      body: SingleChildScrollView(
      child: Column(
        children: [
          // Info Bar
          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    _buildHeaderCellSrNo('S.No.'),
                    _buildHeaderCell('State'),
                    _buildHeaderCellTOTalNGO('Total Hospital'),
                    _buildHeaderCellDashboardsAction('Action'),
                  ],
                ),
                Divider(color: Colors.blue, height: 1.0),
                // Data Rows
                FutureBuilder<List<stateWiseSatelliteCenterssData>>(
                  future: ApiController.getStateWiseSatteliteForDashboard(),
                  //  future: ApiController.getGovtPvtOther_Cataract(484, 27, "H201944681641"),

                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Utils.getEmptyView("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No data found",
                          style: TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      List<stateWiseSatelliteCenterssData> data = snapshot.data;
                      return Column(
                        children: data.map((entry) {
                          return Row(
                            children: [
                              _buildDataCellCellSrNo((data.indexOf(entry) + 1).toString()),
                              _buildDataCell(entry.stateName),
                              _buildDataCellTotalNGo(entry.countState.toString()),
                              _buildDataCellViewBlueDashboard("More", () {
                                SharedPrefs.storeSharedValues(AppConstant.moreclickSatelliteCentersStateCode,
                                    entry.stateCode.toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetDistrictWiseSatelliteCenters(),


                                  ),
                                );
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
    );
  }
  TableRow _buildTableRowcall(String title, VoidCallback onTap) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,  // Trigger the onTap callback when clicked
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue,  // Background color of the button
                borderRadius: BorderRadius.circular(8.0),  // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                "View",  // Customize the "View" text as needed
                style: TextStyle(
                  color: Colors.white,  // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  TableRow _buildTableRow(String label, String value) {
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

  Widget _buildHeaderCell(String title) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(title, style: _infoTextStyle())),
    );
  }

  Widget _buildHeaderCellTOTalNGO(String title) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(title, style: _infoTextStyle())),
    );
  }

  Widget _buildHeaderCellDashboardsAction(String title) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildHeaderCellSrNo(String title) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(title, style: _infoTextStyle())),
    );
  }

  Widget _buildDataCell(String value) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(value,
          maxLines:2,style: TextStyle(color: Colors.black))),
    );
  }

  Widget _buildDataCellTotalNGo(String value) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(value,
          maxLines:2,style: TextStyle(color: Colors.black))),
    );
  }
  Widget _buildDataCellCellSrNo(String value) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(value, style: TextStyle(color: Colors.black))),
    );
  }

  Widget _buildDataCellViewBlueDashboard(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.1)),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  TextStyle _infoTextStyle() => TextStyle(color: Colors.black, fontWeight: FontWeight.w500);

  TextStyle _highlightTextStyle() => TextStyle(color: Colors.red, fontWeight: FontWeight.w500);

  String getCurrentFinancialYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int nextYear = currentYear + 1;
    if (now.month >= 4) {
      return '$currentYear-${nextYear.toString().substring(2)}';
    } else {
      return '${currentYear - 1}-${currentYear.toString().substring(2)}';
    }
  }
}
