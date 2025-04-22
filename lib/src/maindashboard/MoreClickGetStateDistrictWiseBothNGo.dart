import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreStateDistrictBoth.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class MoreClickGetStateDistrictWiseBothNGo extends StatefulWidget {
  @override
  _MoreClickGetStateDistrictWiseBothNGo createState() =>
      _MoreClickGetStateDistrictWiseBothNGo();
}

class _MoreClickGetStateDistrictWiseBothNGo
    extends State<MoreClickGetStateDistrictWiseBothNGo> {
  String moreclickNgoStateCode;
  int moreclickNgoStateCodeInt;

  String moreclickNgoDistrictCode;
  int moreclickNgoDistrictCodeInt;

  @override
  void initState() {
    super.initState();
    fetchStateAndDistrictCodes();
  }

  Future<void> fetchStateAndDistrictCodes() async {
    try {
      // Fetch state code
      moreclickNgoStateCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickNgoStatedCode,
      ) as String;
      moreclickNgoStateCodeInt = int.tryParse(moreclickNgoStateCode ?? '');

      // Fetch district code
      moreclickNgoDistrictCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickdistrictCodeNGO,
      ) as String;
      moreclickNgoDistrictCodeInt = int.tryParse(moreclickNgoDistrictCode ?? '');

      if (moreclickNgoStateCodeInt == null) {
        debugPrint("Error: Invalid or missing state code.");
      }
      if (moreclickNgoDistrictCodeInt == null) {
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
          'State & District-wise NGOs',
          style: TextStyle(
            fontSize: 14.0, // Adjust the size as needed
          ),
        ),
      ),
      body: (moreclickNgoStateCodeInt == null || moreclickNgoDistrictCodeInt == null)
          ? const Center(
        child: Text(
          "No valid state or district code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<nGOmoreStateDistrictBothData>>(
        future: ApiController.GetStateDistrictWiseNGOForDashboard(
          moreclickNgoStateCodeInt,
          moreclickNgoDistrictCodeInt,
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
                      _buildHeaderCell("Darpan No."),
                      // _buildHeaderCell("Nodal Officer Name", 150),
                      _buildHeaderCellDashboardsAction("Action"),
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
                          _buildDataCell(entry.darpanNo ?? '-'),
                          //_buildDataCell(entry.memberName ?? '-', 150),
                          _buildDataCellViewBlueDashboard("View", () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Details for ${entry.darpanNo}'),
                                  content: SingleChildScrollView(
                                    child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      children: [
                                        _buildTableRow("Organization", "Detail", isHeader: true),

                                        _buildTableRow("Darpan No",(entry.darpanNo?.trim().isEmpty ?? true) ? "N/A" : entry.darpanNo),
                                        _buildTableRow("Nodal Officer Name", (entry.memberName?.trim().isEmpty ?? true) ? "N/A" : entry.memberName),
                                        _buildTableRow("Ngo Name", (entry.name?.trim().isEmpty ?? true) ? "N/A" : entry.name),
                                        _buildTableRow("Address",(entry.address?.trim().isEmpty ?? true) ? "N/A" : entry.address),
                                        _buildTableRow("Entry Date", (entry.entry_date?.trim().isEmpty ?? true) ? "N/A" : entry.entry_date),
                                        _buildTableRow("District Name",(entry.districtName?.trim().isEmpty ?? true) ? "N/A" : entry.districtName),
                                        _buildTableRow("State Name", (entry.stateName?.trim().isEmpty ?? true) ? "N/A" : entry.stateName)
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
