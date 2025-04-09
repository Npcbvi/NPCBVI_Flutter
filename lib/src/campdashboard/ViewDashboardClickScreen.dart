import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/camp/CampDashboard.dart';
import '../apihandler/ApiController.dart';
import '../model/camp/ViewDashboardclick.dart';
import '../utils/AppConstants.dart';

class ViewDashboardClickScreen extends StatefulWidget {
  final CampDashboardData offer;
  final String year;

  const ViewDashboardClickScreen({Key key, this.offer, this.year}) : super(key: key);

  @override
  _ViewDashboardClickScreen createState() => _ViewDashboardClickScreen();
}

class _ViewDashboardClickScreen extends State<ViewDashboardClickScreen> {
  String districtNames, userId, stateNames, fullnameController, role_id;
  int status, district_code_login, state_code_login;

  Future<List<ViewDashboardclickData>> _dashboardClickDataFuture;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final storedNgoId = await SharedPrefs.getStoreSharedValue(AppConstant.ngoid);
      SharedPrefs.getUser().then((user) {
        if (user != null) {
          setState(() {
            fullnameController = user.name;
            districtNames = user.districtName;
            stateNames = user.stateName;
            userId = user.userId;
            status = user.status;
            role_id = user.roleId;
            state_code_login = user.state_code;
            district_code_login = user.district_code;
print('@@campManagerId'+widget.offer.campManagerId .toString());
            // 👇 Trigger API after user data is loaded
            _dashboardClickDataFuture = ApiController.viewCampForDashboard(

              state_code_login,
              district_code_login,
              widget.offer.campManagerId,
              storedNgoId,
              widget.offer.srNo ?? "",
              widget.offer.campNo ?? "",
              widget.year ?? "",
            );
          });
        }
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome ${fullnameController ?? ''}',
          maxLines: 2,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (offer != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildInfoColumn("Camp Name", offer.campName ?? 'N/A'),
                        SizedBox(width: 10),
                        _buildInfoColumn("Type", "Camp"),
                        SizedBox(width: 10),
                        _buildInfoColumn("Year", widget.year ?? 'N/A'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _buildInfoColumn("Start Date", offer.startDate ?? 'N/A'),
                        SizedBox(width: 10),

                        _buildInfoColumn("End Date", offer.endDate ?? 'N/A'),
                        SizedBox(width: 10),
                        _buildInfoColumn("", ""),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _buildInfoColumn("Address", offer.address ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("No data received."),
              ),
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Center(
                child: Text(
                  'Total number of patients',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            /// 🔄 FutureBuilder for Dynamic API Data
            if (_dashboardClickDataFuture != null)
              FutureBuilder<List<ViewDashboardclickData>>(
                future: _dashboardClickDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Text("No dashboard data found");
                  } else {
                    final data = snapshot.data;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ✅ Header row
                            Row(
                              children: [
                                _buildHeaderCellCampName('Disease Type'),
                                _buildHeaderCellSrNoDiseaseDataTotal('Registerd', context),
                                _buildHeaderCellDiseaseDataAction('Operated'),
                              ],
                            ),

                            // ✅ Data rows with alternate colors
                            ...data.asMap().entries.map((entry) {
                              final item = entry.value;

                              return Container(
                                child: Row(
                                  children: [
                                    _buildDataCellCampName(item.status ?? "N/A"),
                                    _buildDataCellTotal(item.registered ?? "0"),
                                    _buildDataCellTotal(item.operated ?? "0"),
                                  ],
                                ),
                              );
                            }),

                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildHeaderCellCampName(String text) {
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



  Widget _buildDataCellCampName(String text) {
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

  Widget _buildDataCellTotal(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.2, // 30% of screen width for adaptability
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

  // Define the callback function that takes the ID
  Widget _buildHeaderCellSrNoDiseaseDataTotal(String text, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.2, // 10% of screen width for responsiveness
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
            fontSize: screenWidth * 0.035,
            // Scales with screen width
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellDiseaseDataAction(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 35,
      width: screenWidth * 0.2, // 30% of screen width for adaptability
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

  Widget _buildDataCellViewBlueDiseaseDataAction(
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

  Widget _buildButtonNew(String text, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent, // Let the Container handle background
      borderRadius: BorderRadius.circular(10.0),
      elevation: 3, // Shadow
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.blue, // 🔵 Background color
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue, width: 1), // 🔵 Border
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 12), // ⚪ White icon
              const SizedBox(width: 4),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // ⚪ White text
                ),
              ),
            ],
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


}
