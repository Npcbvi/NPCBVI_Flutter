import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetAllNgoService.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/NGoAPPlicationApprovedFinalScreen.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';

class GetAllNgoServicesDetailApproveScreen extends StatefulWidget {
  const GetAllNgoServicesDetailApproveScreen({Key key}) : super(key: key);

  @override
  _GetAllNgoServicesDetailApproveScreen createState() =>
      _GetAllNgoServicesDetailApproveScreen();
}

class _GetAllNgoServicesDetailApproveScreen
    extends State<GetAllNgoServicesDetailApproveScreen> {
  Future<List<DataGetAllNgoService>> _ngoServicesFuture;
  String npcbNo;

  // Map to store selected dropdown values for each row
  Map<int, String> selectedActions = {};
  String selectedAction; // Stores selected action

  final List<String> actions = [
    "--Select--",
    "Approved",
    "Rejected",
    "Hold",
  ]; // Add your options here

  final TextEditingController reasonController = TextEditingController(); // Initialize controller
  String districtNames,userId, stateNames, fullnameController,role_id,darpan_nos;
  int status, district_code_login, state_code_login;

  @override
  void initState() {
    super.initState();
    getUserData(); // Call this to fetch required data
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
          fetchNpcbNo();
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

  Future<void> fetchNpcbNo() async {
    npcbNo = await SharedPrefs.getStoreSharedValue(AppConstant.npcbNo) as String;
    print('@@HospitalScreen npcbNo: $npcbNo');

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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildTableHeader(), // ✅ Table Header
                  const SizedBox(height: 8), // Spacing

                  // ✅ Info Section
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Please review and take action for each NGO service.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),

                  const SizedBox(height: 8), // Spacing

                  Expanded(
                    child: ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return _buildTableRow(
                          index + 1,
                          services[index].name ?? "Unknown Service",
                          index, // Pass index to track dropdown selection
                        );
                      },
                    ),
                  ),

                  // ✅ Action Selection Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose one option from action taken",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
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
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Show reason text field if action is "Hold" or "Rejected"
                        if (selectedAction == "Hold" || selectedAction == "Rejected") ...[
                          Text(
                            "Enter Reason:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: reasonController,
                            decoration: InputDecoration(
                              hintText: "Enter reason",
                              border: OutlineInputBorder(),

                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // ✅ Submit Button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (selectedAction == null || selectedAction == "--Select--") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please select an action")),
                                );
                                return;
                              }

                              // Check if reason is required and empty
                              if ((selectedAction == "Hold" || selectedAction == "Rejected") &&
                                  reasonController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please enter a reason")),
                                );
                                return;
                              }

                              // Mapping actions to status codes (Assumption)
                              int applicationStatus;
                              if (selectedAction == "Approved") {
                                applicationStatus = 1;
                              } else if (selectedAction == "Hold") {
                                applicationStatus = 2;
                              } else if (selectedAction == "Rejected") {
                                applicationStatus = 3;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Invalid action selected")),
                                );
                                return;
                              }

                              // Show loading indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(child: CircularProgressIndicator());
                                },
                              );

                              try {
                                // Call API function
                                List<DataNGoAPPlicationApprovedFinalScreen> response = await ApiController.get_DPM_Ngo_Application_Approve_Reject_Hold(
                                  applicationStatus,
                                  reasonController.text.trim(),
                                  state_code_login,  // Replace with actual state ID
                                  district_code_login,
                                  // Replace with actual district ID

                                  userId,  // Replace with actual user ID
                                  darpan_nos,  // Replace with actual NGO number
                                  npcbNo,  // Replace with actual NPCB number
                                );

                                // Close loading dialog
                                Navigator.pop(context);

                                // Handle API response
                                if (response.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Action submitted successfully!")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed to process action")),
                                  );
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            },

                            child: const Text(
                              "Submit Actions",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
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

  // Header Row
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

  // Data Row
  Widget _buildTableRow(int serialNo, String serviceName, int index) {
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
}
