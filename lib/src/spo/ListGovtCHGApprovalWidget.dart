import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GHC_approvalList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_GHCHCOtherApprovals.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class ListGovtCHGApprovalWidget extends StatefulWidget {
  final String districtName;

  // Constructor to accept districtName
  ListGovtCHGApprovalWidget({Key key,  this.districtName}) : super(key: key);
  @override
  _ListGovtCHGApprovalWidget createState() => _ListGovtCHGApprovalWidget();
}

class _ListGovtCHGApprovalWidget extends State<ListGovtCHGApprovalWidget> {
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
    currentFinancialYear=getCurrentFinancialYear();
    return Scaffold(
      appBar: AppBar(title: Text('Gove. / CHC / Other Hospitals (Approved)')),
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
              color: Colors.white70,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: 150.0,
                      child: Text('Gove. / CHC / Other Hospitals (Approved)',
                          maxLines:3,style: _highlightTextStyle()),
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
            Divider(color: Colors.blue, height: 1.0),

            // Data Table (Header and Rows in Single ScrollView)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero, // Remove any horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Ensure items align to the left
                    children: [
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('Organisation Name'),
                       _buildHeaderCell('	Nodal Officer Name'),
                      /* _buildHeaderCell('Hospital Name'),
          _buildHeaderCell('Address'),
          _buildHeaderCell('Nodal Officer Name'),
          _buildHeaderCell('Mobile No'),
          _buildHeaderCell('Email Id'), */
                      _buildHeaderCellDashboardsAction('Action'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),

                  // Data Rows
                  FutureBuilder<List<GHC_approvalListData>>(
                    future: ApiController.getSPO_GHCHCOtherApproval_list(district_code_login, state_code_login, currentFinancialYear, 2),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        // No data found aligned with header
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
                        List<GHC_approvalListData> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Ensure items align to the left
                              children: [
                                _buildDataCellCellSrNo((ddata.indexOf(offer) + 1).toString()),
                                _buildDataCell(offer.oName),
                                 _buildDataCell(offer.nodalOfficerName),
                                /* _buildDataCell(offer.hName),
                    _buildDataCell(offer.address),
                    _buildDataCell(offer.nodalOfficerName),
                    _buildDataCell(offer.mobile.toString()),
                    _buildDataCell(offer.emailid.toString()), */
                                _buildDataCellViewBlueDashboard("View", () {
                                  // Pass the offer object to the function that shows the details in a dialog
                                  _showDetailsDialogGovtCHCList(context, offer);
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

  void _showDetailsDialogGovtCHCList(BuildContext context, GHC_approvalListData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details for ${offer.oName}'), // Title showing the NGO Name or relevant field
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Allow vertical scrolling
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1), // Table border color and width
              columnWidths: {
                0: FlexColumnWidth(2), // First column (labels) takes more space
                1: FlexColumnWidth(3), // Second column (values) takes more space
              },
              children: [
                _buildTableRow('Organisation Name', offer.ngoname),
                _buildTableRow('Nodal Officer Name', offer.nodalOfficerName),
                _buildTableRow('Organisation Type', offer.type),
                _buildTableRow('Hospital Address', offer.address),
                _buildTableRow('Mobile No', offer.mobile.toString()),
                _buildTableRow('Email Id', offer.emailId.toString()),
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
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the cell is clicked
      child: Container(
        height: 50,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
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
  Widget _buildHeaderCellDashboardsAction(String text) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      //   padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Center(child: Text(title,
          maxLines:3,style: _infoTextStyle(), textAlign: TextAlign.center)),
    );
  }


  Widget _buildDataCell(String value) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Center(child: Text(value,
          maxLines:3,style: const TextStyle(color: Colors.black), textAlign: TextAlign.center)),
    );
  }
  Widget _buildDataCellCellSrNo(String value) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Center(child: Text(value,
          maxLines:3,style: const TextStyle(color: Colors.black), textAlign: TextAlign.center)),
    );
  }
  Widget _buildHeaderCellSrNo(String title) {
    return Container(
      height: 50,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for header cells
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Center(child: Text(title,
          maxLines:3,style: _infoTextStyle(), textAlign: TextAlign.center)),
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
