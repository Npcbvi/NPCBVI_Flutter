import 'package:flutter/material.dart';

class UpdateUserDPMMenu extends StatefulWidget {
  @override
  _UpdateUserDetailsScreenState createState() => _UpdateUserDetailsScreenState();
}

class _UpdateUserDetailsScreenState extends State<UpdateUserDPMMenu> {
  TextEditingController userIdController = TextEditingController();

  void updateUser() {
    String userId = userIdController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a User ID")),
      );
      return;
    }

    // TODO: Implement update user API call
    print("Updating user with ID: $userId");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User details updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update User Details")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center Row contents
              children: [
                // Login Type and District in a Row
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5), // Margin for spacing
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20), // Space between Login Type and District
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login Type:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'DPM',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'District:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Your District', // Use actual districtNames variable here
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Space between Row and State Column
                const SizedBox(width: 40),

                // State in a Column with margin
                Container(
                  margin: EdgeInsets.only(right: 10), // Right margin for spacing
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Your State', // Use actual stateNames variable here
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // User ID Field
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User ID",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter User ID",
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: updateUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      child: Text("Get Data"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
