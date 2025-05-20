import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/ViewClickCatractPdfType.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:dio/dio.dart';

class DPMPatientDiesesParticularView extends StatefulWidget {
  final String id;
  final String orgNAme;

  const DPMPatientDiesesParticularView({Key key, this.id,this.orgNAme}) : super(key: key);

  @override
  _DPMPatientDiesesParticularViewState createState() =>
      _DPMPatientDiesesParticularViewState();
}

class _DPMPatientDiesesParticularViewState
    extends State<DPMPatientDiesesParticularView> {
  bool isLoading = true;
  List<ViewClickCatractPdfTypeData> cataractDataList = [];
  TextEditingController fullnameController_ = new TextEditingController();
  String fullnameController,orgNames,npcbNogetfromprviousScreen;
  String  districtNames, userId, stateNames;
  int status, district_code_login, state_code_login,lowVisionDataValue = 0;
  String role_id,bindOrganisationNAme,npcbNo,lowVisionDatas,lowVisionDatasStatusType;
  String orgNAme;
  @override
  void initState() {
    super.initState();
    getUserData();
    orgNAme = widget.orgNAme ?? "";// Set related type value
    fetchCataractDetails();
  }
  void getUserData() {
    try {
      SharedPrefs.getUser().then((user) {
        setState(() {
          fullnameController = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          print('@@-0----2' + user.name);
          print('@@-0----3' + fullnameController);
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          status = user.status;
          role_id = user.roleId;
          state_code_login = user.state_code;
          district_code_login = user.district_code;
          //   orgNames=widget.orgNAme.toString();
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
  Future<void> fetchCataractDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Call your API controller method, pass the parameters accordingly
      // For demo, I used mode = "view", diseaseId = widget.id (or any ID you want),
      // npcbNo = some user id, vStatus = "", orgType = 0
      List<ViewClickCatractPdfTypeData> data =
      await ApiController.getCataractPdfType(
        "string",
        widget.id ?? "",
        userId, // Replace with actual user id
        orgNAme,
        int.parse(orgNAme),
      );

      setState(() {
        cataractDataList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils.showToast("Failed to load data: $e", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Detailed View (Cataract Patient)',
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            Navigator.of(context).pop();
          },
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cataractDataList.isEmpty
          ? const Center(child: Text('No data found'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'National Programme for Control of Blindness & Visual Impairment (NPCBVI)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Directorate General of Health Services, Ministry of Health & Family Welfare, Government of India',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Your existing detail card
            buildDetailCard(cataractDataList[0]),
          ],
        ),
      ));

  }

  Widget buildDetailCard(ViewClickCatractPdfTypeData item) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Registration Date', Utils.formatDateString(item.regdate.toString()),),
            buildRow('Registration No.', item.pUniqueID),         // guessing pUniqueID as registration no.
            buildRow('Registration Type', item.registrationtype.toString()),
            buildRow('Registered for', item.registeredfor),
            buildRow('Screening Date', item.screeningDate),
            const SizedBox(height: 10),
            buildRow('Patient Name', item.name),
            buildRow('Date of Birth', item.dob),
            buildRow('Gender', item.gender),
            buildRow('Address',
                '${item.addressLine1 ?? ''} ${item.addressLine2 ?? ''} ${item.addressLine3 ?? ''}'),
            buildRow('City', item.subDistrictName),
            buildRow('District', item.districtname),
            buildRow('State', item.statenae),
            buildRow('Pin Code', item.pincode?.toString()),
            buildRow('Mobile No', item.mobile?.toString()),
            buildRow('Communication language', item.languagename),
            const SizedBox(height: 10),
            buildRow('Hospital', item.hName),
            buildRow('Doctor Name', item.dName),
            buildRow('Date Of Operation', item.operatedOn),
            buildRow('Place Of Operation', item.operatedAt),
            buildRow("Operated Eye", item.eyeOperatedUpon?.toString() == "1" ? "Left" : "Right"),

            buildRow('Laser/Surgery', item.operationTypeVal?.toString()),
            buildRow('Medication', item.disMedicineVal?.toString()),
            buildRow('Medication on Discharge', item.disMedicine?.toString()),
            buildRow('MCF', item.immediateComplicationVal?.toString()),
            buildRow('MAF', item.immediateComplication?.toString()),

          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value ?? '-'),
          ),
        ],
      ),
    );
  }
}
