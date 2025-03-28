import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetStateDistrictWiseBothNGo.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDashboardHopsital/BothStateDistrictwiseHospital.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/BothWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/DistrictWiseCamps.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GeDistrictWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickDistrictWise.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class DistrictWiseCamp extends StatefulWidget {
  @override
  _DistrictWiseCamp createState() =>
      _DistrictWiseCamp();
}

class _DistrictWiseCamp
    extends State<DistrictWiseCamp> {
  String moreclickCampStatedCodess;
  int moreclickCampStatedCodesss;

  @override
  void initState() {
    super.initState();
    fetchMoreclickNgoStateCode();
  }

  Future<void> fetchMoreclickNgoStateCode() async {
    try {
      moreclickCampStatedCodess = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickCamptsateCode,
      ) as String;
      if (moreclickCampStatedCodess != null) {
        moreclickCampStatedCodesss = int.tryParse(moreclickCampStatedCodess);
        if (moreclickCampStatedCodess == null) {
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
          'District-wise Camps',
          maxLines:2,
          style: TextStyle(fontSize: 14.0),
        ),
      ),

      body: moreclickCampStatedCodesss == null
          ? const Center(
        child: Text(
          "No state code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<DistrictWiseCampsData>>(
        future: ApiController.getDistrictWiseCampForDashboard(
          moreclickCampStatedCodesss,
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
                Row(

                  children: [
                    _buildHeaderCellSrNo("S.No."),
                    _buildHeaderCell("District"),
                    _buildHeaderCellTOTalNGO("Total"),
                    _buildHeaderCellDashboardsAction("More"),
                  ],
                ),
                Column(
                  children: data.map((entry) {
                    final index = data.indexOf(entry) + 1;
                    return Row(
                      children: [
                        _buildDataCellCellSrNo(index.toString()),
                        _buildDataCell(entry.districtName),
                        _buildDataCellTotalNGo(entry.countState.toString()),
                        _buildDataCellViewBlueDashboard("More", () {
                          SharedPrefs.storeSharedValues(AppConstant.moreclickdistrictCodeCamp,
                              entry.districtCode.toString());
                          SharedPrefs.storeSharedValues(AppConstant.moreclickCamptsateCode,
                              entry.stateCode.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BothWiseCamp(),


                            ),
                          );
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
      width: screenWidth * 0.15, // 10% of screen width for responsiveness
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
      width: screenWidth * 0.2, // 30% of screen width for adaptability
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
      width: screenWidth * 0.15,
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
        width: screenWidth * 0.2, // 30% of screen width for adaptability
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
