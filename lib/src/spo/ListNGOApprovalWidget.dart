import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class ListNGOApprovalWidget extends StatefulWidget {
  final String districtName;

  // Constructor to accept districtName
  ListNGOApprovalWidget({Key key,  this.districtName}) : super(key: key);
  @override
  _ListNGOApprovalWidget createState() => _ListNGOApprovalWidget();
}

class _ListNGOApprovalWidget extends State<ListNGOApprovalWidget> {
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
      appBar: AppBar(title: Text('NGO(s) (Approved)',
        maxLines: 2, // Limits text to 2 lines
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
                    const SizedBox(width: 10),
                    Text('${widget.districtName}', style: _highlightTextStyle()),
                    const SizedBox(width: 10),
                    Text('State:', style: _infoTextStyle()),
                    const SizedBox(width: 10),
                    Text(stateNames, style: _highlightTextStyle()),
                    const SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: 150.0,
                      child: Text('NGO(s) (Approved)', style: _highlightTextStyle()),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => onBackPressed(),
                      child: Container(
                        width: 80.0,
                        child: Text('Back', overflow: TextOverflow.ellipsis, style: _highlightTextStyle()),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            // Data Table (Header and Rows in Single ScrollView)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero, // Remove any horizontal padding
              child: FutureBuilder<List<NGOAPPRovedClickListDetailData>>(
                future: ApiController.getSPO_DistrictNgoApproval_lists(district_code_login, state_code_login, currentFinancialYear, statusApproved),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Utils.getEmptyView("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    // No data found, so display only "No data found" message
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
                      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                      children: [
                        // Header Row (Displayed only when data is available)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Ensure items align to the left
                          children: [
                            _buildHeaderCellSrNo('S.No.'),
                            _buildHeaderCell('NGO Name'),
                            _buildHeaderCellDashboardsAction('Action'),
                          ],
                        ),
                        Divider(color: Colors.blue, height: 1.0),

                        // Data Rows
                        Column(
                          children: ddata.map((offer) {
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
                        ),
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

// Helper method to build each row in the table
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

}
