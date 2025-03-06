import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/Documentlist.dart';
import '../../model/dpm_approval_status/NgoAppliations/Get_DPM_NGOApplicationDetails.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart'; // To open the file after download
class NGODetailsScreen extends StatefulWidget {
  final DataGet_DPM_NGOApplicationDetails data;

  NGODetailsScreen({ this.data});

  @override
  _NGODetailsScreenState createState() => _NGODetailsScreenState();
}

class _NGODetailsScreenState extends State<NGODetailsScreen> {
  List<DataDocumentlist> documentList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDocumentList();
  }

  Future<void> fetchDocumentList() async {
    try {
      var url = "https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/DpmDashboard/api/Get_DPM_ListOfDocumentverified";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = {
        "npcbNo": widget.data.darpanNo, // Pass NGO's Darpan Number
      };

      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final documentResponse = Documentlist.fromJson(response.data);
        setState(() {
          documentList = documentResponse.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching documents: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NGO Application Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                _buildTableRow("Darpan Number", widget.data.darpanNo),
                _buildTableRow("PAN Number", widget.data.panNo),
                _buildTableRow("NGO Name", widget.data.ngoName),
                _buildTableRow("Member Name", widget.data.name),
                _buildTableRow("Email", widget.data.emailid),
                _buildTableRow("Mobile", widget.data.mobile),
                _buildTableRow("Address", widget.data.address),
                _buildTableRow("District", widget.data.districtName),
                _buildTableRow("State", widget.data.stateName),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "List of Documents to be Verified",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : documentList.isEmpty
                ? Text("No documents available.")
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documentList.length,
              itemBuilder: (context, index) {
                final doc = documentList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (doc.filE1 != null)
                      _buildDocumentTile(
                          "Minimum 3 years of experience certificate",
                          doc.filE1),
                    if (doc.filE2 != null)
                      _buildDocumentTile(
                          "Society/Charitable public trust registration certificate",
                          doc.filE2),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the next screen
         /*   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NextScreen(), // Replace with your next screen
              ),
            );*/
          },
          child: Text("Next"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildDocumentTile(String title, String fileName) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(fileName),
      trailing: Icon(Icons.file_download, color: Colors.blue),
      onTap: () {
        _downloadFile(fileName);
      },
    );
  }


  void _downloadFile(String fileName) async {
    try {
      // Construct the full URL of the file
      String fileUrl = "https://yourserver.com/uploads/$fileName"; // Update with your actual base URL

      // Request permission (for Android)
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          print("Storage permission denied");
          return;
        }
      }

      // Get the application directory (for iOS) or external storage (for Android)
      Directory directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory(); // Android: /storage/emulated/0/Android/data/{package}/files
      } else {
        directory = await getApplicationDocumentsDirectory(); // iOS
      }

      if (directory == null) {
        print("Could not find a directory to save the file.");
        return;
      }

      String filePath = "${directory.path}/$fileName";

      // Download the file
      Dio dio = Dio();
      await dio.download(fileUrl, filePath);

      print("File downloaded to: $filePath");

      // Open the file (Optional)
      OpenFile.open(filePath);
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

}
