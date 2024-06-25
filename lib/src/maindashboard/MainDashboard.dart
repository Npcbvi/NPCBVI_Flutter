import 'package:flutter/material.dart';

class MainDashboard extends StatefulWidget {
  
  _MainDashboard createState() => _MainDashboard(); // connect using createState
}
class _MainDashboard extends State<MainDashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Dashboard',
            style: new TextStyle(color: Colors.white),
          )),


    );
  }
  
}