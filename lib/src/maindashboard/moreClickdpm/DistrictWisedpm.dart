import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetStateDistrictWiseBothNGo.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDashboardHopsital/BothStateDistrictwiseHospital.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/BothWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/DistrictWiseCamps.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickDpm/DistrictWiseDpm.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GeDistrictWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickDistrictWise.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class DistrictWisedpm extends StatefulWidget {
  @override
  _DistrictWisedpm createState() =>
      _DistrictWisedpm();
}

class _DistrictWisedpm
    extends State<DistrictWisedpm> {
  String moreclickDPmStatedCodess;
  int moreclickDpmStatedCodesss;

  @override
  void initState() {
    super.initState();
    fetchMoreclickNgoStateCode();
  }

  Future<void> fetchMoreclickNgoStateCode() async {
    try {
      moreclickDPmStatedCodess = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickDpmtsateCode,
      ) as String;
      if (moreclickDPmStatedCodess != null) {
        moreclickDpmStatedCodesss = int.tryParse(moreclickDPmStatedCodess);
        if (moreclickDPmStatedCodess == null) {
          debugPrint("Error: Invalid integer value for state code.");
        }
      } else {
        debugPrint("Error: No value found for 'moreclickNgoStatedCode'.");
      }
    } catch (e) {
      debugPrint("Error fetching 'moreclickNgoStatedCode': $e");
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List of District Programme Officers (DPMs) under NPCBVI',
          maxLines: 2,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: moreclickDpmStatedCodesss == null
          ? const Center(
        child: Text(
          "No state code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<DistrictWiseDpmData>>(
        future: ApiController.getDPMListForDashboard(
          moreclickDpmStatedCodesss,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Utils.getEmptyView("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "No data found",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          final data = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                // ✅ Show the header only if data is available
                if (data.isNotEmpty) ...[
                  Row(
                    children: [
                      _buildHeaderCellSrNo("S.No."),
                      _buildHeaderCell("District"),
                      _buildHeaderCellDashboardsAction("More",),
                    ],
                  ),
                ],
                Column(
                  children: data.map((entry) {
                    final index = data.indexOf(entry) + 1;
                    return Row(
                      children: [
                        _buildDataCellCellSrNo(index.toString()),
                        _buildDataCell(entry.districtName),
                        _buildDataCellViewBlueDashboard("More", () {
                          _showDetailsDialog(context, entry);
                        }),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  void _showDetailsDialog(
      BuildContext context, DistrictWiseDpmData offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "List of District Programme Officers (DPMs) under NPCBVI",
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
                _buildTableRow("DPM Name", offer.name),
                _buildTableRow("District Name", offer.districtName),
                _buildTableRow("Address", offer.officeAddress),
                _buildTableRow("Mobile", offer.mobile.toString()),
                _buildTableRow("Email", offer.emailId.toString()),
                _buildTableRow("District Name", offer.districtName.toString()),
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
  Widget _buildDataCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
        child: Text(
          text,
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.04, // Scales with screen width
          ),
        ),
      ),
    );
  }



  Widget _buildViewButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.1), // Thick border
        ),
        child: const Center(
          child: Text(
            "View",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
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

}
