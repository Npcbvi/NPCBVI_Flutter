import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class CampDashboard extends StatefulWidget {
  @override
  _CampDashboard createState() => _CampDashboard();
}

class _CampDashboard extends State<CampDashboard> {
  TextEditingController fullnameController = TextEditingController();
  String _chosenValue, districtNames, userId, stateNames;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    try {
      SharedPrefs.getUser().then((user) {
        setState(() {
          fullnameController.text = user.name;
          districtNames = user.districtName;
          stateNames = user.stateName;
          userId = user.userId;
          print('@@-0----2' + user.name);
          print('@@-0----3' + fullnameController.text);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome ${fullnameController.text}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu), // Hamburger icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens the drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Dashboard screen
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('DPMs'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to DPMs screen
              },
            ),
            ListTile(
              leading: Icon(Icons.approval),
              title: Text('Eye Bank Approval'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Eye Bank Approval screen
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login Type:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Camp Manager',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Login Id:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        '$userId',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'District:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$districtNames',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'State:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$stateNames',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
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
