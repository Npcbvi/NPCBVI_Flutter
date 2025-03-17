import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitalDetailsView.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/dpm_approval_status/NgoAppliations/EquipemntDetails.dart';
import '../../model/dpm_approval_status/NgoAppliations/MouDetails.dart';
import '../../model/dpm_approval_status/govtPrivatehospitalApproval/GovtPrivateDetails.dart';

class GovtPrivateDetailEqipment extends StatefulWidget {
  final String selectedOrganisation;
  final int selectedOrganisationType;
  final String hospitalID;


  const GovtPrivateDetailEqipment({Key key,  this.selectedOrganisation,  this.selectedOrganisationType, this.hospitalID}) : super(key: key);

  @override
  _GovtPrivateDetailEqipment createState() => _GovtPrivateDetailEqipment();
}

class _GovtPrivateDetailEqipment extends State<GovtPrivateDetailEqipment> {
  List<DataGovtPrivateDetails> hospitalList = [];
  bool isLoading = true;
  String npcbNo;
  String districtNames, userId, stateNames, fullnameController, roleId, darpanNos;
  int status, districtCodeLogin, stateCodeLogin;
  String currentFinancialYear;
  // ✅ Declare the `hospital` variable
  DataHospitalDetailsView hospital;
  List<DataEquipemntDetails> equipmentList = [];
  List<DataMouDetails> mouList = [];
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getnpcbNo() async {
   /* npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    print('@@HospitalScreen npcbNo: $npcbNo');
    if (npcbNo != null) {*/
      fetchHospitals();
   // }
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
        fetchHospitalDetails();
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }


  /// Modify `getUserData()` to call `fetchHospitalDetails()`

  /// Modify `fetchHospitalDetails()` to use required parameters
  Future<void> fetchHospitalDetails() async {
    try {
    /*  if (widget.hospitalID == null || darpanNos == null) {
        print("Missing hospitalID or darpanNos");
        return;
      }*/

      List<DataHospitalDetailsView> response =
      await ApiController.get_DPM_ViewHospitalDetails(widget.hospitalID);

      if (response.isNotEmpty) {
        hospital = response.first;
      }

      // Fetch Equipment Details
      List<DataEquipemntDetails> equipmentResponse =
      await ApiController.get_DPM_ViewHospitalequipmentDetails(widget.hospitalID);

      // Fetch MOU Details
      mouList = await ApiController.get_DPM_ViewMOU(darpanNos, widget.hospitalID);
      setState(() {
        equipmentList = equipmentResponse;
        isLoading = false;

      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String getCurrentFinancialYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int nextYear = currentYear + 1;

    return now.month >= 4
        ? '$currentYear-${nextYear.toString().substring(2)}'
        : '${currentYear - 1}-${currentYear.toString().substring(2)}';
  }

  Future<void> fetchHospitals() async {
    if (districtCodeLogin == null || stateCodeLogin == null) {
      print("District or State codes are null!");
      return;
    }

    try {
      List<DataGovtPrivateDetails> fetchedData = await ApiController.get_DPM_Government_District_Hospital_list_Approval(
        districtCodeLogin, stateCodeLogin, widget.hospitalID, currentFinancialYear, widget.selectedOrganisationType,
      );
      setState(() {
        hospitalList = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching hospital list: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentFinancialYear = getCurrentFinancialYear();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hospitals Linked with NGO - ${widget.selectedOrganisation}",
            maxLines: 2),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: hospitalList.length,
        itemBuilder: (context, index) {
          final hospital = hospitalList[index];

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTableRow("S.No.", "${index + 1}"),
                  _buildTableRow("Organisation Type.",
                      widget.selectedOrganisation),
                  if (widget.selectedOrganisationType == 10)
                    _buildTableRow("Hospital NIN No.", hospital.niNNo.toString()?? "N/A"),

                  _buildTableRow("Member Name", hospital.nodalOfficerName ?? "N/A"),
                  _buildTableRow(
                      "Organisation Name", hospital.oName ?? "N/A"),

                  _buildTableRow(
                      "NPCB Number.", hospital.npcbNo?.toString() ?? "N/A"),
                  _buildTableRow("Email ID", hospital.emailId ?? "N/A"),
                  _buildTableRow("Address", hospital.address ?? "N/A"),
                  _buildTableRow("District", hospital.districtName ?? "N/A"),
                  _buildTableRow("State", hospital.stateName ?? "N/A"),
                  _buildTableRow(
                      "Pin Code", hospital.pincode.toString() ?? "N/A"),

                  SizedBox(height: 10),

                  // Equipment Details Table
                  Text(
                    "Equipment Details",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildEquipmentList(),
                  SizedBox(height: 20),
                  _buildMouList(),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to details page if needed
                      },
                      child: Text("View Details"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEquipmentList() {
    return equipmentList.isEmpty
        ? Text("No equipment details found", style: TextStyle(fontSize: 16))
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: equipmentList.length,
      itemBuilder: (context, index) {
        var equipment = equipmentList[index];
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Text("${index + 1}.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            title: Text(equipment.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text("Number of Equipment: ${equipment.noOfEuipment}",
                style: TextStyle(fontSize: 14)),
          ),
        );
      },
    );
  }


  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _buildTableRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMouList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("MOU Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(),
        if (mouList.isEmpty)
          Text("No MOU Found")
        else
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: mouList.length,
            itemBuilder: (context, index) {
              final mou = mouList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTableRow_new("MOU File", mou.file, isLink: true),
                  _buildTableRow("From Date", Utils.formatDateString(mou.fromDate)),
                  _buildTableRow("To Date", Utils.formatDateString(mou.toDate)),
                  Divider(),
                ],
              );
            },
          ),
      ],
    );
  }
  Widget _buildTableRow_new(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: isLink && value != null
                ? GestureDetector(
              onTap: () {
                if (value.isNotEmpty) {
                  launchURL(value); // Open the link
                }
              },
              child: Text(
                value, // Display the file name
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
                : Text(
              value ?? "N/A",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }
}


