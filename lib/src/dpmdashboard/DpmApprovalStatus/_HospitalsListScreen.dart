import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'dart:convert';

import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitallinkedwithNGO.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

class HospitalsListScreen extends StatefulWidget {
  @override
  _HospitalsListScreenState createState() => _HospitalsListScreenState();
}

class _HospitalsListScreenState extends State<HospitalsListScreen> {
  List<DataHospitallinkedwithNGO> hospitalList = [];
  bool isLoading = true;
  String npcbNo = "";

  @override
  void initState() {
    super.initState();
    getnpcbNo();
  }

  Future<void> getnpcbNo() async {
    npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    if (npcbNo != null) {
      fetchHospitals();
    }
  }

  Future<void> fetchHospitals() async {
    List<DataHospitallinkedwithNGO> fetchedData = await ApiController.getHospitalsLinkedWithNGO(npcbNo);
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
                            builder: (context) => HospitalDetailScreen(hospital),
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
class HospitalDetailScreen extends StatelessWidget {
  final DataHospitallinkedwithNGO hospital;

  HospitalDetailScreen(this.hospital);

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
      appBar: AppBar(title: Text("Hospital Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableRow("Hospital ID", hospital.hRegID),
            _buildTableRow("Hospital Name", hospital.hName),
            _buildTableRow("Mobile", hospital.mobile.toString()),
            _buildTableRow("Email", hospital.emailId ?? "N/A"),
            _buildTableRow("Address", hospital.address),
            _buildTableRow("State", hospital.stateName),
            _buildTableRow("District", hospital.districtName),
          ],
        ),
      ),
    );
  }
}
