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
        maxLines: 2,
        // Assuming fullnameController has .text
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),

      ),      body: SingleChildScrollView(
        child: Column(
          children: [
            // Info Bar
            _buildUserInfo(),
            Container(
              width: double.infinity, // Full width
              color: Colors.blue, // Background color
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for spacing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and button
                children: [
                  Expanded(
                    child: Text(
                      'Cataract patient records for DPM approval',
                      maxLines: 2,
                      textAlign: TextAlign.center, // Align text to the left
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),




                ],
              ),
            ),
            // Data Table
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        _buildHeaderCellSrNoDiseaseData('S.No.',context),
                        _buildHeaderCellPatientView('Patient ID'),
                        _buildHeaderCellDashboardsAction('Action'),
                      ],
                    ),
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

                                  _buildDataCellPatientView(entry.pUniqueID),
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
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUserInfo() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [

              _buildUserInfoGrid(
                  'Login Type:', 'Hospital', Colors.black, Colors.red),
              _buildUserInfoGrid('Login Id', userId?.toString() ?? 'N/A',
                  Colors.black, Colors.red),
              _buildUserInfoGrid('State', stateNames?.toString() ?? 'N/A',
                  Colors.black, Colors.red),
              _buildUserInfoGrid('District',
                  districtNames?.toString() ?? 'N/A', Colors.black, Colors.red),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildUserInfoGrid(
      String label, String value, Color labelColor, Color valueColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: valueColor, fontWeight: FontWeight.w500),
          ),
        ],
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
              border: TableBorder.all(color: Colors.black, width: 1), // Table border color and width
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

  Widget _buildHeaderCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
    );
  }
  Widget _buildHeaderCellPatientView(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.6, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white),   // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
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
    );
  }


  Widget _buildHeaderCellDashboardsAction(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
        alignment: Alignment.center,
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
    );
  }

  Widget _buildHeaderCellSrNoDiseaseData(String text, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
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
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.035, // Scales with screen width
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

  Widget _buildDataCellPatientView(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.6, // 30% of screen width for adaptability
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

  Widget _buildDataCellCellSrNo(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black),   // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align( // Aligns text to the left
        alignment: Alignment.centerLeft,
        child: Text(

          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenWidth * 0.03, // Scales with screen width
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
          alignment: Alignment.center,
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
