import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MoreClickGetStateDistrictWiseBothNGo.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickDashboardHopsital/BothStateDistrictwiseHospital.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/BothWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/DistrictWiseCamps.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GeDistrictWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickDistrictWise.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class DistrictWiseCamp extends StatefulWidget {
  @override
  _DistrictWiseCamp createState() =>
      _DistrictWiseCamp();
}

class _DistrictWiseCamp
    extends State<DistrictWiseCamp> {
  String moreclickCampStatedCodess;
  int moreclickCampStatedCodesss;

  @override
  void initState() {
    super.initState();
    fetchMoreclickNgoStateCode();
  }

  Future<void> fetchMoreclickNgoStateCode() async {
    try {
      moreclickCampStatedCodess = await SharedPrefs.getStoreSharedValue(
        AppConstant.moreclickCamptsateCode,
      ) as String;
      if (moreclickCampStatedCodess != null) {
        moreclickCampStatedCodesss = int.tryParse(moreclickCampStatedCodess);
        if (moreclickCampStatedCodess == null) {
          debugPrint("Error: Invalid integer value for state code.");
        }
      } else {
        debugPrint("Error: No value found for 'moreclickNgoStatedCode'.");
      }
    } catch (e) {
      debugPrint("Error fetching 'moreclickNgoStatedCode': $e");
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'District-wise Camps',
          style: TextStyle(fontSize: 16.0),
        ),
      ),

      body: moreclickCampStatedCodesss == null
          ? const Center(
        child: Text(
          "No state code found.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )
          : FutureBuilder<List<DistrictWiseCampsData>>(
        future: ApiController.getDistrictWiseCampForDashboard(
          moreclickCampStatedCodesss,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Utils.getEmptyView("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "No data found",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          final data = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildHeaderCell("S.No.", 50),
                    _buildHeaderCell("District", 150),
                    _buildHeaderCell("Total NGO", 80),
                    _buildHeaderCell("More", 80),
                  ],
                ),
                const Divider(color: Colors.blue, height: 1.0),
                Column(
                  children: data.map((entry) {
                    final index = data.indexOf(entry) + 1;
                    return Row(
                      children: [
                        _buildDataCell(index.toString(), 50),
                        _buildDataCell(entry.districtName, 150),
                        _buildDataCell(entry.countState.toString(), 80),
                        _buildDataCellViewBlueDashboard("More", () {
                          SharedPrefs.storeSharedValues(AppConstant.moreclickdistrictCodeCamp,
                              entry.districtCode.toString());
                          SharedPrefs.storeSharedValues(AppConstant.moreclickCamptsateCode,
                              entry.stateCode.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BothWiseCamp(),


                            ),
                          );
                        }),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCell(String title, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.1), // Thick border
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDataCell(String value, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.1), // Thick border
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(color: Colors.black),
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _buildViewButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.1), // Thick border
        ),
        child: const Center(
          child: Text(
            "View",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildDataCellViewBlueDashboard(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.1), // Thick border
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

}
