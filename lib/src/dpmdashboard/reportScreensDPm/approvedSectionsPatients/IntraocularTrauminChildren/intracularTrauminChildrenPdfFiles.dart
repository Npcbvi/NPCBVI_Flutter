import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/DiabeticRetinpathy/DiabeticRatinopathyPdfFile.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/ViewClickCatractPdfType.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/congentalPtosis/CongentialPdfFile.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/squint/SquintPdfFile.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:dio/dio.dart';

import '../../../../model/dpmRegistration/viewClickReportData/RetinopathyofPermaturity/RetinopathyofPermaturityPdf.dart';
import '../../../../model/dpmRegistration/viewClickReportData/TraumainChildren/TauminchildrenPdfFiles.dart';
import '../../../../model/dpmRegistration/viewClickReportData/cornealBlindnessReport/CornealBlindnessPdfFile.dart';

class intracularTrauminChildrenPdfFiles extends StatefulWidget {
  final String id;
  final String orgNAme;

  const intracularTrauminChildrenPdfFiles({Key key, this.id,this.orgNAme}) : super(key: key);

  @override
  _intracularTrauminChildrenPdfFiles createState() =>
      _intracularTrauminChildrenPdfFiles();
}

class _intracularTrauminChildrenPdfFiles
    extends State<intracularTrauminChildrenPdfFiles> {
  bool isLoading = true;
  List<TauminchildrenPdfFilesData> cataractDataList = [];
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
      List<TauminchildrenPdfFilesData> data =
      await ApiController.getDPM_TraumaReportView(
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
            'Detailed View(Trauma in Children Patient)',
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

  Widget buildDetailCard(TauminchildrenPdfFilesData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Registration Details"),
          keyValue("SR No.", data.srNo.toString()),
          keyValue("Camp ID", data.campId),
          keyValue("Registration No.", data.pUniqueID),
          keyValue("Registration Date", Utils.formatDateString(data.regdate)),
          keyValue("Registration Type", data.registrationtype.toString()),
          keyValue("Registered for", data.registrationfor),
          keyValue("Hospital Reg. ID", data.hRegID),
          keyValue("Patient Name", data.name),
          keyValue("Last Name", data.lastName),
          keyValue("Guardian Name", data.guardianName),
          keyValue("Date of Birth", Utils.formatDateString(data.dob)),
          keyValue("Gender", data.gender == "1" ? "Male" : "Female"),
          keyValue("ID Proof Type ID", data.idproofTypeId.toString()),

          sectionTitle("Address Details"),
          keyValue("Address Line 1", data.addressLine1),
          keyValue("Address Line 2", data.addressLine2),
          keyValue("Address Line 3", data.addressLine3),
          keyValue("Pincode", data.pincode.toString()),
          keyValue("Village Code", data.villageCode.toString()),
          keyValue("Town Code", data.townCode.toString()),
          keyValue("Block Code", data.blockCode.toString()),
          keyValue("Sub District", data.subDistrictName),
          keyValue("District", data.districtname),
          keyValue("State", data.statenae),

          sectionTitle("Medical & Screening"),
          keyValue("Screening Date", Utils.formatDateString(data.screeningDate)),
          keyValue("Disease ID", data.diseaseId.toString()),
          keyValue("NPCB No.", data.npcbNo),
          keyValue("Organisation Type", data.orgType.toString()),
          keyValue("Programme ID", data.programmID.toString()),
          keyValue("Hospital Name", data.hName),
          keyValue("Reporting Place", data.reportingplace),

          keyValue("Registration for", data.registrationfor),
          keyValue("Visual Status", data.vstatus.toString()),

          sectionTitle("Other Details"),
          keyValue("Aadhaar No.", data.aadhaarNo),
          keyValue("Language Code", data.language.toString()),
          keyValue("Communication Language", data.languagename),
          keyValue("Doctor Name", data.dName),


          sectionTitle("NGO Details"),
          keyValue("NGO Name", data.ngoname),
          keyValue("NGO Address", data.ngoAddress),
          keyValue("NGO Mobile", data.ngomobile.toString()),
          sectionTitle("Visual Acuity"),
          keyValue("Visual Acuity(Before Surgery)", data.visualAcquityBeforlaser),
          keyValue("Visual Acuity(After  Surgery)", data.visualAcquityAfterlaser),

        ],
      ),
    );
  }
  Widget preOperativeTable({
    String hospital,
    String doctor,
    String visualAcuityLeft,
    String visualAcuityRight,
    String ocularLeft,
    String ocularRight,
  }) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            paddedCell("Hospital", hospital),
            paddedCell("Doctor Name", doctor),
          ],
        ),
        TableRow(
          children: [
            paddedCell("Visual Acuity (LEFT)", visualAcuityLeft),
            paddedCell("Visual Acuity (RIGHT)", visualAcuityRight),
          ],
        ),
        TableRow(
          children: [
            paddedCell("Ocular Diagnosis (LEFT)", ocularLeft),
            paddedCell("Ocular Diagnosis (RIGHT)", ocularRight),
          ],
        ),
      ],
    );
  }

  Widget operativeDetailsTable({
    String operationDate,
    String place,
    String eyeOperated,
    String operationType,
  }) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            paddedCell("Date of Operation", operationDate),
            paddedCell("Place of Operation", place),
          ],
        ),
        TableRow(
          children: [
            paddedCell("Eye to be Operated", eyeOperated),
            paddedCell("Type of Operation", operationType),
          ],
        ),
      ],
    );
  }

  Widget postOperativeTable({
    String medication,
    String complications,
    String vaLeft,
    String vaRight,
  }) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            paddedCell("Medication on Discharge", medication),
            paddedCell("Immediate Complications", complications),
          ],
        ),
        TableRow(
          children: [
            paddedCell("VA at Discharge (LEFT)", vaLeft),
            paddedCell("VA at Discharge (RIGHT)", vaRight),
          ],
        ),
      ],
    );
  }

  Widget paddedCell(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value.isNotEmpty ? value : 'N/A'),
        ],
      ),
    );
  }

  Widget eyeTable(Map<String, dynamic> eyeData) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(7),
      },
      children: [
        for (var entry in eyeData.entries)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(entry.value?.toString() ?? 'N/A'),
              ),
            ],
          ),
      ],
    );
  }

// Supporting Widgets

  Widget sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(2), // space for outer border
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }


  Widget keyValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 6, child: Text(value ?? "N/A")),
        ],
      ),
    );
  }

  Widget keyValueRow(String label, String leftValue, String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text("Left: ${leftValue ?? 'N/A'}")),
          Expanded(flex: 3, child: Text("Right: ${rightValue ?? 'N/A'}")),
        ],
      ),
    );
  }

  Widget followUpTable({
    String followUpPlace,
    String followUpDate,
    String vaLeft,
    String vaRight,
  }) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            paddedCell("Follow Up Place", followUpPlace),
            paddedCell("Follow Up Date", followUpDate),
          ],
        ),
        TableRow(
          children: [
            paddedCell("VA (LEFT)", vaLeft),
            paddedCell("VA (RIGHT)", vaRight),
          ],
        ),
      ],
    );
  }



}
