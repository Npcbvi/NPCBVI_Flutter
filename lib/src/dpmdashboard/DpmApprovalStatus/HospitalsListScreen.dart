import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitalDetailsView.dart';
import 'dart:convert';

import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitallinkedwithNGO.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/MouDetails.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/dpm_approval_status/NgoAppliations/EquipemntDetails.dart';

class HospitalsListScreen extends StatefulWidget {
  @override
  _HospitalsListScreenState createState() => _HospitalsListScreenState();
}

class _HospitalsListScreenState extends State<HospitalsListScreen> {
  List<DataHospitallinkedwithNGO> hospitalList = [];
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
      fetchHospitals();
    }
  }

  Future<void> fetchHospitals() async {
    List<DataHospitallinkedwithNGO> fetchedData =
    await ApiController.getHospitalsLinkedWithNGO(npcbNo);
    setState(() {
      hospitalList = fetchedData;
      isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hospitals Linked with NGO")),
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
                  _buildTableRow("Hospital ID", hospital.hRegID),
                  _buildTableRow("Hospital Name", hospital.hName),
                  _buildTableRow("Mobile No.", hospital.mobile.toString()),
                  _buildTableRow("Email ID", hospital.emailId ?? "N/A"),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HospitalDetailScreen(
                              hRegID: hospital.hRegID,
                              nDarpanNo: hospital.nDarpanNo,

                            ),
                          ),
                        );
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
}

// Screen to View Hospital Details
class HospitalListScreen extends StatefulWidget {
  final String hospitalId;

  HospitalListScreen({ this.hospitalId});

  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
   Future<List<DataHospitalDetailsView>> futureHospitalDetails;

  @override
  void initState() {
    super.initState();
    futureHospitalDetails = ApiController.get_DPM_ViewHospitalDetails(widget.hospitalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hospital Details")),
      body: FutureBuilder<List<DataHospitalDetailsView>>(
        future: futureHospitalDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load hospital details"));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text("No hospital details found"));
          }

          // Use first hospital from the API response
          final hospital = snapshot.data.first;

          return HospitalDetailScreen();
        },
      ),
    );
  }
}




class HospitalDetailScreen extends StatefulWidget {
  final String hRegID,nDarpanNo;

  HospitalDetailScreen({ this.hRegID, this.nDarpanNo});

  @override
  _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  bool isLoading = true;
  DataHospitalDetailsView hospital;
  List<DataEquipemntDetails> equipmentList = [];
  List<DataMouDetails> mouList = [];

  String districtNames,userId, stateNames, fullnameController,role_id,darpan_nos;
  int status, district_code_login, state_code_login;

  @override
  void initState() {
    super.initState();

    fetchHospitalDetails();
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
          getDarpanNo();
          print('@@2' + user.name);
          print('@@3' + user.stateName);
          print('@@4' + user.roleId);
          print('@@5' + user.userId);
          print('@@6' + user.districtName);
          print('@@7' + state_code_login.toString());
          print('@@8' + district_code_login.toString());

        });
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> getDarpanNo() async {
    // Use await to get the actual value from SharedPrefs
    darpan_nos =
    await SharedPrefs.getStoreSharedValue(AppConstant.darpan_no) as String;

    if (darpan_nos != null) {
      print("Darpan Number: $darpan_nos");
    } else {
      print("No Darpan Number found in shared preferences.");
    }
  }

  Future<void> fetchHospitalDetails() async {
    try {

      List<DataHospitalDetailsView> response =
      await ApiController.get_DPM_ViewHospitalDetails(widget.hRegID);

      if (response.isNotEmpty) {
        hospital = response.first;
      }

      // Fetch Equipment Details
      List<DataEquipemntDetails> equipmentResponse =
      await ApiController.get_DPM_ViewHospitalequipmentDetails(widget.hRegID);

      // Fetch MOU Details
      mouList = await ApiController.get_DPM_ViewMOU(widget.nDarpanNo,widget.hRegID);

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
              value ?? "N/A",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hospital?.hName ?? "Hospital Details")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hospital == null
          ? Center(child: Text("No data found"))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableRow("NGO Darpan Number", hospital?.nDarpanNo),
            _buildTableRow("Hospital Name", hospital?.hName),
            _buildTableRow("Officer Name", hospital?.nodalOfficerName),
            _buildTableRow("Mobile No.", hospital?.mobile?.toString()),
            _buildTableRow("Email ID", hospital?.emailId),
            _buildTableRow("State", hospital?.stateName),
            _buildTableRow("District", hospital?.districtName),
            _buildTableRow("Address", hospital?.address),
            _buildTableRow("Pin Code", hospital?.pincode?.toString()),
            _buildTableRow("Fax No.", hospital?.fax?.toString()),
            SizedBox(height: 20),
            Text("Equipment Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            _buildEquipmentList(),
            SizedBox(height: 20),
            _buildMouList(),
          ],
        ),
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

}




