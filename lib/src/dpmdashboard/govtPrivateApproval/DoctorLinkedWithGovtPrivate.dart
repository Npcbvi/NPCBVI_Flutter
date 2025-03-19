import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DpmApprovalStatus/GetAllNgoServicesDetailApproveScreen.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/govtPrivateApproval/GovtPrivatelNGOrvicesApproveScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/DoctorlinkHospitals.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/govtPrivatehospitalApproval/DoctorlinkwithGovtPrivate.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';


class DoctorLinkedWithGovtPrivate extends StatefulWidget {
  final String darpanNo;
  final String userId;
  final String hName; // Add hospital name
  final String hRegID;
  final int selectedOrganisationTypesValue;// Add hospital name

  DoctorLinkedWithGovtPrivate({ this.darpanNo,  this.userId, this.hName,this.hRegID, this.selectedOrganisationTypesValue,});

  @override
  _DoctorLinkedWithGovtPrivate createState() => _DoctorLinkedWithGovtPrivate();
}

class _DoctorLinkedWithGovtPrivate extends State<DoctorLinkedWithGovtPrivate> {
  List<DataDoctorlinkwithGovtPrivate> doctorList = [];
  bool isLoading = true;
  String npcbNo;
  String districtNames, userId, stateNames, fullnameController, roleId, darpanNos;
  int status, districtCodeLogin, stateCodeLogin;
  String currentFinancialYear;
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
        status = user.status;
        roleId = user.roleId;
        stateCodeLogin = user.state_code;
        districtCodeLogin = user.district_code;

        getnpcbNo();
        // Call fetchHospitalDetails() after user data is fetched
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  Future<void> getnpcbNo() async {
  /*  npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    print('@@HospitalScreeen npcbNo'+npcbNo);
    if (npcbNo != null) {*/
      fetchDoctors();
   // }
  }
  Future<void> fetchDoctors() async {
    List<DataDoctorlinkwithGovtPrivate> fetchedList =
    await ApiController.getDPM_DoctorList(districtCodeLogin,stateCodeLogin,widget.selectedOrganisationTypesValue,widget.hRegID);

    setState(() {
      doctorList = fetchedList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor(s) linked with Hospital ${widget.hName}",
      maxLines: 2,)),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader
          : doctorList.isEmpty
          ? Center(child: Text("No Data Found")) // Show empty state
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Table Headers

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: doctorList.length,
                itemBuilder: (context, index) {
                  var doctor = doctorList[index];
                  return Column(
                    children: [
                      _buildTableRow("S.No", doctor.srNo.toString()),
                      _buildTableRow("MCI ID", doctor.mcIID),
                      _buildTableRow("Hospital Name", doctor.hName),
                      _buildTableRow("Doctor Name", doctor.dName),
                      _buildTableRow("Mobile No.", doctor.mobile.toString()),
                      _buildTableRow("Email ID", doctor.emailId),
                      _buildTableRow("State", doctor.stateName),
                      _buildTableRow("District", doctor.districtName),
                      _buildTableRow("DOB", Utils.formatDateString(doctor.dob)),
                      _buildTableRow("Gender", doctor.gender == 1 ? "Male" : "Female"),
                      _buildTableRow("PinCode", doctor.pincode),
                      SizedBox(height: 5),

                      // Action Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures buttons are at opposite ends
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Navigates back to the previous screen
                            },
                            child: Text("Previous"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              SharedPrefs.storeSharedValues(AppConstant.npcbNo,
                                  doctor.npcbNo.toString());// here we are saving NPcbNo and
                              Navigator.push(

                                context,
                                MaterialPageRoute(
                                  builder: (context) => GovtPrivatelNGOrvicesApproveScreen(
                                      orgaTypeNAme:widget.hName,
                                      organisationTypeValue:widget.selectedOrganisationTypesValue,


                                  ),
                                ),
                              );
                            },
                            child: Text("Next"),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey, thickness: 1), // Grey divider

                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTableRow(String title, String value, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

}
