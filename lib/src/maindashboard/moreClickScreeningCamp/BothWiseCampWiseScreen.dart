import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/BothWiseCampWise.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/BothWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/BothDataForHospital.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreStateDistrictBoth.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class BothWiseCampWiseScreen extends StatefulWidget {
  @override
  _BothWiseCampWiseScreen createState() =>
      _BothWiseCampWiseScreen();
}

class _BothWiseCampWiseScreen
    extends State<BothWiseCampWiseScreen> {
  String moreclickCampStateCode;
  int moreclickCampStateCodeInt;

  String moreclickCampDistrictCode;
  int moreclickCampDistrictCodeInt;
  String srNo;

  @override
  void initState() {
    super.initState();
    fetchStateAndDistrictCodes();
  }

  Future<void> fetchStateAndDistrictCodes() async {
    try {
      srNo = await SharedPrefs.getStoreSharedValue(
        AppConstant.srNo,
      ) as String;
      // Fetch state code
      moreclickCampStateCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickCamptsateCode,
      ) as String;
      moreclickCampStateCodeInt = int.tryParse(moreclickCampStateCode ?? '');

      // Fetch district code
      moreclickCampDistrictCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickdistrictCodeCamp,
      ) as String;
      moreclickCampDistrictCodeInt = int.tryParse(moreclickCampDistrictCode ?? '');

      if (moreclickCampDistrictCodeInt == null) {
        debugPrint("Error: Invalid or missing state code.");
      }
      if (moreclickCampDistrictCodeInt == null) {
        debugPrint("Error: Invalid or missing district code.");
      }
    } catch (e) {
      debugPrint("Error fetching codes: $e");
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'State & District-Camp wise Detail',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: (moreclickCampDistrictCodeInt == null || moreclickCampDistrictCodeInt == null)
          ? const Center(
        child: Text(
          "No valid state or district code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<DataBothWiseCampWise>>(
        future: ApiController.getStateDistrictCampWiseDataForDashboard(
          moreclickCampStateCodeInt,
            502,
            srNo,
            ""

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
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHeaderCellSrNo("S.No."),
                      _buildHeaderCell("NGO Name"),
                      // _buildHeaderCell("Nodal Officer Name", 150),
                      _buildHeaderCellDashboardsAction("Action",),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: data.map((entry) {
                      final index = data.indexOf(entry) + 1;
                      return Row(
                        children: [
                          _buildDataCellCellSrNo(index.toString()),
                          _buildDataCell(entry.ngoName ?? '-'),
                          //_buildDataCell(entry.memberName ?? '-', 150),
                          _buildDataCellViewBlueDashboard("View", () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Details for ${entry.ngoName}'),
                                  content: SingleChildScrollView(
                                    child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      children: [
                                        _buildTableRow("Organization", "Detail", isHeader: true),

                                        _buildTableRow("NGO Name", entry.ngoName ?? "-"),
                                        _buildTableRow("Cam Name", entry.campname.toString() ?? "-"),
                                        _buildTableRow("Cam Manager", entry.campmanagername.toString() ?? "-"),

                                        _buildTableRow("Entry Date", entry.entryDate ?? "-"),
                                        _buildTableRow("District Name", entry.districtName ?? "-"),
                                        _buildTableRow("State Name", entry.stateName ?? "-"),
                                        _buildTableRow("Start Date", entry.startDate ?? "-"),
                                        _buildTableRow("End  Date", entry.endDate ?? "-"),

                                        // Add more fields as necessary

                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }),

                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

  /*TableRow _buildTableRow(String label, String value) {
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
  }*/


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


  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16.0 : 14.0,
        ),
      ),
    );
  }
  TableRow _buildTableRow(String field, String value, {bool isHeader = false}) {
    return TableRow(
      children: [
        _buildTableCell(field, isHeader: isHeader),
        _buildTableCell(value, isHeader: isHeader),
      ],
    );
  }

}
