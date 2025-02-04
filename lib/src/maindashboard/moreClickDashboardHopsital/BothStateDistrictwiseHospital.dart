import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/BothDataForHospital.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreStateDistrictBoth.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class BothStateDistrictwiseHospital extends StatefulWidget {
  @override
  _BothStateDistrictwiseHospital createState() =>
      _BothStateDistrictwiseHospital();
}

class _BothStateDistrictwiseHospital
    extends State<BothStateDistrictwiseHospital> {
  String moreclickHospitalStateCode;
  int moreclickHospitaStateCodeInt;

  String moreclickHospitalDistrictCode;
  int moreclickHospitalDistrictCodeInt;

  @override
  void initState() {
    super.initState();
    fetchStateAndDistrictCodes();
  }

  Future<void> fetchStateAndDistrictCodes() async {
    try {
      // Fetch state code
      moreclickHospitalStateCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickHospitalStateCode,
      ) as String;
      moreclickHospitaStateCodeInt = int.tryParse(moreclickHospitalStateCode ?? '');

      // Fetch district code
      moreclickHospitalDistrictCode = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickdistrictCodeHospital,
      ) as String;
      moreclickHospitalDistrictCodeInt = int.tryParse(moreclickHospitalDistrictCode ?? '');

      if (moreclickHospitalDistrictCodeInt == null) {
        debugPrint("Error: Invalid or missing state code.");
      }
      if (moreclickHospitalDistrictCodeInt == null) {
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
          'State & District-wise Hospital',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: (moreclickHospitalDistrictCodeInt == null || moreclickHospitalDistrictCodeInt == null)
          ? const Center(
        child: Text(
          "No valid state or district code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<BothDataForHospitalData>>(
        future: ApiController.getStateDistrictWiseHospitalForDashboard(
          moreclickHospitaStateCodeInt,
          moreclickHospitalDistrictCodeInt,
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
                      _buildHeaderCell("S.No.", 50),
                      _buildHeaderCell("Darpan No.", 200),
                     // _buildHeaderCell("Nodal Officer Name", 150),
                      _buildHeaderCell("Action", 100),
                    ],
                  ),
                ),
                const Divider(color: Colors.transparent, height: 1.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: data.map((entry) {
                      final index = data.indexOf(entry) + 1;
                      return Row(
                        children: [
                          _buildDataCell(index.toString(), 50),
                          _buildDataCell(entry.ngoName ?? '-', 200),
                          //_buildDataCell(entry.memberName ?? '-', 150),
                          _buildDataCellViewBlueDashboard("View", () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Details for ${entry.ngoName}'),
                                  content: SingleChildScrollView(
                                    child: Table(
                                      border: TableBorder.all(color: Colors.blue),
                                      children: [
                                        _buildTableRow("Field", "Value", isHeader: true),
                                        _buildTableRow("Organisation Name", entry.ngoName ?? "-"),
                                        _buildTableRow("Nodal Officer Name", entry.nodalOfficerName ?? "-"),
                                        _buildTableRow("Organisation Type", entry.type ?? "-"),
                                        _buildTableRow("Contact No", entry.mobile ?? "-"),
                                        _buildTableRow("Hospital Address", entry.address ?? "-"),
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

  Widget _buildHeaderCell(String title, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.1), // Thick border
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDataCell(String value, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.1), // Thick border
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(color: Colors.black),
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _buildDataCellViewBlueDashboard(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.1), // Thick border
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
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
}
