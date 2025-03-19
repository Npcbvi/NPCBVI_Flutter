import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetAllNgoService.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/NGoAPPlicationApprovedFinalScreen.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

class GovtPrivatelNGOrvicesApproveScreen extends StatefulWidget {
  final String redId;
  final String darpanNumber;
  final String orgaTypeNAme;
  final int organisationTypeValue;


  const GovtPrivatelNGOrvicesApproveScreen({Key key, this.redId, this.darpanNumber, this. orgaTypeNAme, this.organisationTypeValue}) : super(key: key);

  @override
  _GovtPrivatelNGOrvicesApproveScreen createState() =>
      _GovtPrivatelNGOrvicesApproveScreen();
}

class _GovtPrivatelNGOrvicesApproveScreen extends State<GovtPrivatelNGOrvicesApproveScreen> {
  Future<List<DataGetAllNgoService>> _ngoServicesFuture;
  String npcbNo, ngonumber;
  String  darpan_newVariables;
  String districtNames, userId, stateNames, fullnameController, role_id;
  int status, district_code_login, state_code_login;
  Map<int, String> selectedActions = {};
  String organisationNAme;

  String selectedAction;
  final TextEditingController reasonController = TextEditingController();

  final List<String> actions = ["--Select--", "Approved", "Rejected", "Hold"];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      var user = await SharedPrefs.getUser();
      setState(() {
        fullnameController = user.name;
        districtNames = user.districtName;
        stateNames = user.stateName;
        userId = user.userId;
        status = user.status;
        role_id = user.roleId;
        state_code_login = user.state_code;
        district_code_login = user.district_code;
        if (widget.organisationTypeValue == 10) {
          organisationNAme = "Govt. District Hospital/Govt. Medical College";
        } else if (widget.organisationTypeValue == 11) {
          organisationNAme = "CHC/Govt. Sub-Dist. Hospital"; // Provide a value here
        }
        else if (widget.organisationTypeValue == 12) {
          organisationNAme = "Private Practitioner"; // Provide a value here
        }
        else if (widget.organisationTypeValue == 13) {
          organisationNAme = "Private Medical College"; // Provide a value here
        }
        else if (widget.organisationTypeValue == 14) {
          organisationNAme = "Other(Institution not claiming fund from NPCBVI"; // Provide a value here
        }else {
          organisationNAme = "Other"; // Optional: Default value
        }
       fetchNpcbNo();
      //  getDarpanNo();
      });
    } catch (e) {
      print(e);
    }
  }

/*
  Future<void> getDarpanNo() async {
    darpan_newVariables = await SharedPrefs.getStoreSharedValue(AppConstant.darpan_no) as String;
    if (darpan_newVariables != null) {
      print("Darpan Number: $darpan_newVariables");
    }
  }
*/

  Future<void> fetchNpcbNo() async {
    npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    print("@@Npcbbumber Stored here"+npcbNo);
    if (npcbNo != null) {
      setState(() {
        _ngoServicesFuture = ApiController.getAllNgoService(npcbNo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NGO Services")),
      body: _ngoServicesFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<DataGetAllNgoService>>(
        future: _ngoServicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(child: Text("No NGO Services found."));
          }

          List<DataGetAllNgoService> services = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildTableHeader(),
                Expanded(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return _buildTableRow(index + 1, services[index].name ?? "Unknown Service");
                    },
                  ),
                ),
                _buildActionSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey.shade300,
      child: Row(
        children: const [
          Expanded(child: Text("S.No.", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("Service Name", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildTableRow(int serialNo, String serviceName) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(serialNo.toString())),
          Expanded(flex: 3, child: Text(serviceName)),
        ],
      ),
    );
  }



  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action Label
          const Text(
            "Action:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Dropdown for Action Selection
          DropdownButtonFormField<String>(
            value: selectedAction,
            hint: const Text("--Select--"),
            items: actions.map((String action) {
              return DropdownMenuItem<String>(
                value: action,
                child: Text(action),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                selectedAction = newValue;
                reasonController.clear(); // Clear reason when action changes
              });
            },
          ),

          // Show Reason Section if "Hold" or "Rejected" is selected
          if (selectedAction == "Hold" || selectedAction == "Rejected") ...[
            const SizedBox(height: 10),
            const Text(
              "Reason:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // Predefined reasons for "Hold" or "Rejected"
            Column(
              children: [
                _buildReasonOption("Certificate for at least 15 Bed IPD facility is not uploaded"),
                _buildReasonOption("Invalid registration documents"),
                _buildReasonOption("NGO does not meet eligibility criteria"),
                _buildReasonOption("Other (Specify Below)"),
              ],
            ),

            // TextField for Custom Reason (Only shown if "Other" is selected)
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: "Enter reason",
                border: OutlineInputBorder(),
              ),
            ),
          ],

          // Submit Button
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitAction,
            child: const Text("Submit Actions"),
          ),
        ],
      ),
    );
  }

// Helper Widget to Display Reason Options
  Widget _buildReasonOption(String reason) {
    return GestureDetector(
      onTap: () {
        setState(() {
          reasonController.text = reason;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
          color: reasonController.text == reason ? Colors.blue.shade100 : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              reasonController.text == reason ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.blue,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(reason)),
          ],
        ),
      ),
    );
  }

// Function to Handle Submit Action
  void _submitAction() async {
    if (selectedAction == null || selectedAction == "--Select--") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an action")),
      );
      return;
    }

    if ((selectedAction == "Hold" || selectedAction == "Rejected") &&
        reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select or enter a reason")),
      );
      return;
    }

    int applicationStatus;

    if (selectedAction == "Approved") {
      applicationStatus = 1;
      ngonumber ="";

      print('@@darpan_newVariables'+ngonumber);
    } else {
      applicationStatus = (selectedAction == "Hold") ? 2 : 3;
      ngonumber = npcbNo;
    }
    try {
      await ApiController.get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold(
        applicationStatus,
        reasonController.text.trim(),
        state_code_login,
        district_code_login,
        userId,
        ngonumber,
        npcbNo,
          organisationNAme,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Action submitted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

}
