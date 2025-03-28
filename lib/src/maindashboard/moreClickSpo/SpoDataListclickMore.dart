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


class SpoDataListclickMore extends StatefulWidget {


  @override
  _SpoDataListclickMore createState() => _SpoDataListclickMore();
}

class _SpoDataListclickMore extends State<SpoDataListclickMore> {
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
        'LIST OF STATE PROGRAMME OFFICERS (NPCBVI)',
        maxLines:2,
        style: TextStyle(fontSize: 14.0),
      ),

      ),      body: Container(
      color: Colors.white, // Set full-screen background to white
      child: SingleChildScrollView(
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
                  FutureBuilder<List<SpoListwiseData>>(
                    future: ApiController.getSPOListForDashboard(),
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
                        List<SpoListwiseData> data = snapshot.data;
                        return Column(
                          children: [
                            // 🟢 Show Header Row only when data is available
                            Row(
                              children: [
                                _buildHeaderCellSrNo('S.No.'),
                                _buildHeaderCell('SPO Name'),
                              //  _buildHeaderCellTOTalNGO('Total DPMs'),
                                _buildHeaderCellDashboardsAction('Action'),
                              ],
                            ),
                            ...data.map((entry) {
                              return Row(
                                children: [
                                  _buildDataCellCellSrNo((data.indexOf(entry) + 1).toString()),
                                  _buildDataCell(entry.name),
                                  _buildDataCellViewBlueDashboard("More", () {
                                    _showDetailsDialog(context, entry);
                                  }),
                                ],
                              );
                            }).toList(),
                          ],
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
    ),
    );
  }
  void _showDetailsDialog(
      BuildContext context, SpoListwiseData offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "LIST OF STATE PROGRAMME OFFICERS (NPCBVI)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.black, width: 1),
              columnWidths: {
                0: FixedColumnWidth(120), // Adjust column width
                1: FlexColumnWidth(),
              },
              children: [
                _buildTableRow("SPO Name", offer.name),
                _buildTableRow("State name", offer.stateName),
                _buildTableRow("Address", offer.officeAddress),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId.toString()),
                _buildTableRow("Entry Date", offer.entry_date ?? "null"),

              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value ?? 'N/A',
          ),
        ),
      ],
    );
  }


  Widget _buildHeaderCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white),   // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellTOTalNGO(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.18, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white),   // Top border
          // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellDashboardsAction(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.3, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white),   // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellSrNo(String text ) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.14, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white),   // Top border
          // Top border
          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black),   // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(
            text,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.04, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDataCellTotalNGo(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.18, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black),   // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align( // Aligns text to the left
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(

            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.03, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildDataCellCellSrNo(String text) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
      height: 35,
      width: screenWidth * 0.14, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align( // Aligns text to the left
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

          child: Text(

            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.03, // Scales with screen width
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlueDashboard(
      String text, VoidCallback onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0), // Left & Right Margin
        height: 35,
        width: screenWidth * 0.3, // 30% of screen width for adaptability
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.1, color: Colors.black),   // Top border

            bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3.0), // Left & Right Margin

            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.blue,
                fontSize: screenWidth * 0.04, // Scales with screen width
              ),
            ),
          ),
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

