import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/sendTODPM/SendTODPMCataract.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class SenTODPMCatractListData extends StatefulWidget {


  @override
  _SenTODPMCatractListData createState() => _SenTODPMCatractListData();
}

class _SenTODPMCatractListData extends State<SenTODPMCatractListData> {
  String districtNames = '';
  String stateNames = '';
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  String role_id, userId, currentFinancialYear;
  int district_code_login, state_code_login;
String Gender;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      final user = await SharedPrefs.getUser();
      setState(() {
        fullnameController = user.name;
        districtNames = user.districtName;
        stateNames = user.stateName;
        userId = user.userId;
        role_id = user.roleId;
        state_code_login = user.state_code;
        district_code_login = user.district_code;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    currentFinancialYear = getCurrentFinancialYear();
    return Scaffold(
      appBar: AppBar( title: Text(
        'Cataract Patient Records for DPM Approval',
        style: TextStyle(
        fontSize: 12.0, // Adjust the size as needed
    ),
      ),

      ),      body: SingleChildScrollView(
        child: Column(
          children: [
            // Info Bar
            Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('District:', style: _infoTextStyle()),
                  SizedBox(width: 5),
                  Text(districtNames, style: _highlightTextStyle()),
                  SizedBox(width: 5),
                  Text('State:', style: _infoTextStyle()),
                  SizedBox(width: 5),
                  Text(stateNames, style: _highlightTextStyle()),
                ],
              ),
            ),
            Divider(color: Colors.grey),
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
                      _buildHeaderCell('Patient ID'),
                      _buildHeaderCellDashboardsAction('Action'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),
                  // Data Rows
                  FutureBuilder<List<SendTODPMCataractData>>(
                    future: ApiController.getGovtPvtOther_Cataract(district_code_login, state_code_login, userId),
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
                        List<SendTODPMCataractData> data = snapshot.data;
                        return Column(
                          children: data.map((entry) {
                            return Row(
                              children: [
                                _buildDataCellCellSrNo((data.indexOf(entry) + 1).toString()),
                                _buildDataCell(entry.pUniqueID),
                                _buildDataCellViewBlueDashboard("View", () {
                                  _showDetailsDialogSentTODPM(context,entry);
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
  void _showDetailsDialogSentTODPM(BuildContext context, SendTODPMCataractData offer) {
    String statusText;

    // Check the vstatus and assign the appropriate statusText
    if (offer.vstatus == "4") {
      statusText = "Send to DPM";
    } else if (offer.vstatus == "5") {
      statusText = "Approved by DPM";
    } else if (offer.vstatus == "3") {
      statusText = "Follow up Done";
    } else if (offer.vstatus == "2") {
      statusText = "Post Operative Done";
    }
    else if (offer.vstatus == "1") {
      statusText = "Operative Done";
    }
    else if (offer.vstatus == "0") {
      statusText = "Pre Operative Done";
    }
    else if (offer.vstatus == "-1") {
      statusText = "SR Pending";
    }

    else {
      statusText = "Rejected ny DPM";  // For any other vstatus values
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details for ${offer.name}'), // Title showing the NGO Name or relevant field
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Allow vertical scrolling
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1), // Table border color and width
              columnWidths: {
                0: FlexColumnWidth(2), // First column (labels) takes more space
                1: FlexColumnWidth(3), // Second column (values) takes more space
              },
              children: [
                _buildTableRow('Patient Id', offer.pUniqueID),

                _buildTableRow('Name of Person', offer.name),
                _buildTableRow('Mobile No', offer.mobile.toString()),
                _buildTableRow('DOB', offer.dob),
              _buildTableRow("Gender", offer.gender == "1" ? "Male" : "Female"),
                _buildTableRow('Address', offer.addressLine1),
                _buildTableRow('Operation Date',
                    Utils.formatDateString(offer.operatedOn).toString()),

                _buildTableRow("Operated Eye", offer.eyetype == "1" ? "Left" : "Right"),

                _buildTableRow('Status', statusText),  // Use the statusText here
                _buildTableRowcall("Action", () {
                  print('@@Pending work here now---for print ');

                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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
      width: 200,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(title, style: _infoTextStyle())),
    );
  }

  Widget _buildHeaderCellDashboardsAction(String title) {
    return Container(
      width: 60,
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
      width: 200,
      height: 50,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5)),
      child: Center(child: Text(value, style: TextStyle(color: Colors.black))),
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
        width: 60,
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
