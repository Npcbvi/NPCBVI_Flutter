import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/DoctorlinkHospitals.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';


class DoctorLinkedWithHospitalScreen extends StatefulWidget {
  final String darpanNo;
  final String userId;
  final String hName; // Add hospital name
  final String hRegID; // Add hospital name

  DoctorLinkedWithHospitalScreen({ this.darpanNo,  this.userId, this.hName,this.hRegID,});

  @override
  _DoctorLinkedWithHospitalScreenState createState() => _DoctorLinkedWithHospitalScreenState();
}

class _DoctorLinkedWithHospitalScreenState extends State<DoctorLinkedWithHospitalScreen> {
  List<DataDoctorlinkHospitals> doctorList = [];
  bool isLoading = true;
  String npcbNo;

  @override
  void initState() {
    super.initState();
    getnpcbNo();
  }
  Future<void> getnpcbNo() async {
    npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    print('@@HospitalScreeen npcbNo'+npcbNo);
    if (npcbNo != null) {
      fetchDoctors();
    }
  }
  Future<void> fetchDoctors() async {
    List<DataDoctorlinkHospitals> fetchedList =
    await ApiController.get_DPM_DoctorLinkedWithHospital(widget.hRegID);

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
                      _buildTableRow("Doctor ID", doctor.mcIID),
                      _buildTableRow("Doctor Name", doctor.dName),
                      _buildTableRow("Mobile No.", doctor.mobile.toString()),
                      _buildTableRow("Email ID", doctor.emailId),
                      SizedBox(height: 10),

                      // Action Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            print("View details of: ${doctor.dName}");
                          },
                          child: Text("View"),
                        ),
                      ),
                      Divider(), // Add separator
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
