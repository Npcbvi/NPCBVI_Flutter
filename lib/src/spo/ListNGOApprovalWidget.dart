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
  String fullnameController, getYearNgoHopital, getfyidNgoHospital;
  int status, district_code_login, state_code_login;
  String role_id, userId;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NGO Approval List')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Info Bar
            Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(  // Wrap Row with SingleChildScrollView for horizontal scroll
                scrollDirection: Axis.horizontal,  // Enable horizontal scrolling
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

            Divider(color: Colors.blue, height: 1.0),

            // Data Table (Header and Rows in Single ScrollView)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // Header Row
                  Row(
                    children: [
                      _buildHeaderCellSrNo('S.No.'),
                      _buildHeaderCell('NGO Name'),
                      _buildHeaderCell('Member Name'),
                      _buildHeaderCell('Hospital Name'),
                      _buildHeaderCell('Address'),
                      _buildHeaderCell('Nodal Officer Name'),
                      _buildHeaderCell('Mobile No'),
                      _buildHeaderCell('Email Id'),
                    ],
                  ),
                  Divider(color: Colors.blue, height: 1.0),

                  // Data Rows
                  FutureBuilder<List<NGOAPPRovedClickListDetailData>>(
                    future: ApiController.getSPO_DistrictNgoApproval_lists(568, 33, "2024-2025", statusApproved),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Utils.getEmptyView("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Utils.getEmptyView("No data found");
                      } else {
                        List<NGOAPPRovedClickListDetailData> ddata = snapshot.data;
                        return Column(
                          children: ddata.map((offer) {
                            return Row(

                              children: [
                                _buildDataCellCellSrNo((ddata.indexOf(offer) + 1).toString()),
                                _buildDataCell(offer.name),
                                _buildDataCell(offer.memberName),
                                _buildDataCell(offer.hName),
                                _buildDataCell(offer.address),
                                _buildDataCell(offer.nodalOfficerName),
                                _buildDataCell(offer.mobile.toString()),
                                _buildDataCell(offer.emailid.toString()),
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

  TextStyle _infoTextStyle() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  }

  TextStyle _highlightTextStyle() {
    return const TextStyle(color: Colors.red, fontWeight: FontWeight.w500);
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: _infoTextStyle(), textAlign: TextAlign.center),
    );
  }


  Widget _buildDataCell(String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8.0),
      child: Text(value, style: const TextStyle(color: Colors.black), textAlign: TextAlign.center),
    );
  }
  Widget _buildDataCellCellSrNo(String value) {
    return Container(
      width: 50,
      padding: const EdgeInsets.all(8.0),
      child: Text(value, style: const TextStyle(color: Colors.black), textAlign: TextAlign.center),
    );
  }
  Widget _buildHeaderCellSrNo(String title) {
    return Container(
      width: 50,
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: _infoTextStyle(), textAlign: TextAlign.center),
    );
  }
}
