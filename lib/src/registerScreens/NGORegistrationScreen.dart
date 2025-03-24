import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class NGORegistrationScreen extends StatefulWidget {
  @override
  _NGORegistrationScreenState createState() => _NGORegistrationScreenState();
}

class _NGORegistrationScreenState extends State<NGORegistrationScreen> {
  final TextEditingController _ngoDarpanNumberController = TextEditingController();
  final TextEditingController _ngoPANNumberController = TextEditingController();
  bool showNGORegistration = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NGO Registration")),
      body: Column(
        children: [
          SizedBox(
            height: 28,
            child: Marquee(
              text: 'NGO Darpan number is mandatory for registration. ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
              velocity: 50.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          Expanded(
            child: Visibility(
              visible: showNGORegistration,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _ngoDarpanNumberController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'NGO Darpan number ',
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter NGO Darpan number',
                          prefixIcon: Icon(Icons.business, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _ngoPANNumberController,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'NGO PAN number ',
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter NGO PAN number',
                          prefixIcon: Icon(Icons.credit_card, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(130, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black,
                        ),
                        onPressed: () {
                          print('@@NGO Button click__work pending');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
