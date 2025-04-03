import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GHC_approvalList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_SatelliteCentreApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/PrivateMedicalCollgeAPProvalList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/PrivatePractionries.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/SatelliteCenterListData.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ScreeningCampCompletedList.dart';
import 'package:mohfw_npcbvi/src/spo/SpoDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class SatelliteCentresList extends StatefulWidget {
  final String districtName;

  // Constructor to accept districtName
  SatelliteCentresList({Key key,  this.districtName}) : super(key: key);
  @override
  _SatelliteCentresList createState() => _SatelliteCentresList();
}

class _SatelliteCentresList extends State<SatelliteCentresList> {
  String districtNames = '';
  String stateNames = '';
  Function onBackPressed;
  int statusApproved = 2;
  int statusPending = 1;
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  int status, district_code_login, state_code_login;
  String role_id, userId;
  String currentFinancialYear;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    try {
      SharedPrefs.getUser().then((user) {
        setState(() {
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          status = user.status;
          role_id = user.roleId;
          state_code_login = user.state_code;
          district_code_login = user.district_code;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    currentFinancialYear = getCurrentFinancialYear();
    return Scaffold(
      appBar: AppBar(title: Text('Satellite Centres' ,maxLines: 2, // Limits text to 2 lines
        style: TextStyle(color: Colors.white, fontSize: 14.0),)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Info Bar
            Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text('District:', style: _infoTextStyle()),
                    const SizedBox(width: 5),
                    Text('${widget.districtName}', style: _highlightTextStyle()),
                    const SizedBox(width: 5),
                    Text('State:', style: _infoTextStyle()),
                    const SizedBox(width: 5),
                    Text(stateNames, style: _highlightTextStyle()),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity, // Full width
              color: Colors.blue, // Background color
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for spacing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and button
                children: [
                  Expanded(
                    child: Text(
                      'District-wise Satellite Centres', // Added spacing between words
                      maxLines: 2,
                      textAlign: TextAlign.left, // Align text to the left
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpoDashboard()),
                      );
                    },
                    child: Container(
                      width: 80.0,
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Back',

                            overflow: TextOverflow.ellipsis, style: TextStyle( color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),




                ],
              ),
            ),


            // Data Table (Header and Rows in Single ScrollView)
            FutureBuilder<List<SatelliteCenterListDataData>>(
              future: ApiController.getSPO_SatelliteCentreApproval_list(
                district_code_login,
                state_code_login,
                statusApproved,
                currentFinancialYear,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Utils.getEmptyView("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  // Show "No data found" when there is no data
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Ensure left alignment
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
                } else {
                  List<SatelliteCenterListDataData> ddata = snapshot.data;
                  print('@@---Satellite Centre Approval Data Count: ${ddata.length}');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Show header row **ONLY IF** data exists
                      Row(
                        children: [
                          _buildHeaderCellSrNo('S.No.'),
                          _buildHeaderCell('Satellite Centre Name'),
                          _buildHeaderCellDashboardsAction('Action'),
                        ],
                      ),

                      // ✅ Show data rows
                      Column(
                        children: ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start, // Ensure items align to the left
                            children: [
                              _buildDataCellSrNo((ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.sname),
                              _buildDataCellViewBlueDashboard("View", () {
                                // Pass the offer object to the function that shows the details in a dialog
                                _showDetailsDialogprivatePractioneries(context, offer);
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
  void _showDetailsDialogprivatePractioneries(BuildContext context, SatelliteCenterListDataData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details for ${offer.ngoName}'), // Title showing the NGO Name or relevant field
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Allow vertical scrolling
            child: Table(
              border: TableBorder.all(color: Colors.black, width: 1), // Table border color and width
              columnWidths: {
                0: FlexColumnWidth(2), // First column (labels) takes more space
                1: FlexColumnWidth(3), // Second column (values) takes more space
              },
              children: [
                _buildTableRow('Ngo', offer.ngoName),

                _buildTableRow('Satellite Centre Name', offer.name),
                _buildTableRow('	Satellite Centre Name', offer.sname),
                _buildTableRow('Hospital Name', offer.hospitalname),
                _buildTableRow('	Manager Name', offer.smanagername),
                _buildTableRow('Address', offer.address),
                _buildTableRow('Contact No', offer.mobile.toString()),
                _buildTableRow('Manager Email Id', offer.emailId.toString()),
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

  Widget _buildDataCellViewBlueDashboard(String text, VoidCallback onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 35,
        width: screenWidth * 0.3, // 30% of screen width for adaptability
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.1, color: Colors.black), // Top border

            bottom:
            BorderSide(width: 0.1, color: Colors.black), // Bottom border
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
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


  TextStyle _infoTextStyle() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  }

  TextStyle _highlightTextStyle() {
    return const TextStyle(color: Colors.red, fontWeight: FontWeight.w500);
  }

  Widget _buildDataCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

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
  Widget _buildDataCellSrNo(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.black), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        // Aligns text to the left
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
  Widget _buildHeaderCellSrNo(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.1, // 10% of screen width for responsiveness
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
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
          top: BorderSide(width: 0.1, color: Colors.white), // Top border
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
  Widget _buildHeaderCell(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.5, // 30% of screen width for adaptability
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.white), // Top border

          bottom: BorderSide(width: 0.1, color: Colors.black), // Bottom border
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
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
  String getCurrentFinancialYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int nextYear = currentYear + 1;
    String financialYear;

    if (now.month >= 4) {
      // Financial year starts in April
      financialYear = '$currentYear-${nextYear.toString().substring(2)}';
    } else {
      financialYear =
      '${currentYear - 1}-${currentYear.toString().substring(2)}';
    }

    return financialYear;
  }
}
