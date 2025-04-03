import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class ListNGOPendingWidget extends StatefulWidget {
  final String districtName;

  // Constructor to accept districtName
  ListNGOPendingWidget({Key key,  this.districtName}) : super(key: key);
  @override
  _ListNGOPendingWidget createState() => _ListNGOPendingWidget();
}

class _ListNGOPendingWidget extends State<ListNGOPendingWidget> {
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

  Widget build(BuildContext context) {
    currentFinancialYear = getCurrentFinancialYear();

    return Scaffold(
      appBar: AppBar(title: Text('NGO(s) (Pending)', maxLines: 2, // Limits text to 2 lines
        style: TextStyle(color: Colors.white, fontSize: 14.0),)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Info Bar
            SingleChildScrollView(
              child: Row(
                children: [
                  // Login Type and District in a Row
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // Margin for spacing
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          // Space between Login Type and District
                          child: Column(
                            children: [
                              Text(
                                'Login ID:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${userId}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${stateNames}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Space between Row and State Column
                  const SizedBox(width: 10),

                  // State in a Column with margin
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    // Right margin for spacing
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login Type:',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'SPO',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                /*  const SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    // Right margin for spacing
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'District',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${districtNames.isNotEmpty ? districtNames : null}',

                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),


            // Data Table (Header and Rows in Single ScrollView)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<NGOAPPRovedClickListDetailData>>(
                future: ApiController.getSPO_DistrictNgoApproval_lists(
                    district_code_login, state_code_login, currentFinancialYear, statusPending),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
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
                    List<NGOAPPRovedClickListDetailData> ddata = snapshot.data;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment
                      children: [
                        // Header Row (Only displayed when data is available)
                        Row(
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('NGO Name'),
                            _buildHeaderCellDashboardsAction('Action'),
                          ],
                        ),

                        // Data Rows
                        ...ddata.map((offer) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start, // Ensure items align to the left
                            children: [
                              _buildDataCellSrNo((ddata.indexOf(offer) + 1).toString()),
                              _buildDataCell(offer.name),
                              _buildDataCellViewBlueDashboard("View", () {
                                _showDetailsDialog(context, offer);
                              }),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _showDetailsDialog(BuildContext context, NGOAPPRovedClickListDetailData offer) {
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
                _buildTableRow('NGO Name', offer.name),
                _buildTableRow('Member Name', offer.memberName),
                _buildTableRow('Hospital Name', offer.hName),
                _buildTableRow('Address', offer.address),
                _buildTableRow('Nodal Officer Name', offer.nodalOfficerName),
                _buildTableRow('Mobile No', offer.mobile.toString()),
                _buildTableRow('Email Id', offer.emailid.toString()),
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
}
