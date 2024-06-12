import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String _chosenValue;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Registeration',
              style: new TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Utils.hideKeyboard(context);
                Navigator.of(context).pop(context);
              })),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Shown Captcha value to user
                    Container(

                        child: Text(
                          'Home',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'Android',
                        'IOS',
                        'Flutter',
                        'Node',
                        'Java',
                        'Python',
                        'PHP',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Please choose a langauage",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                    Container(

                        child: Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        )),
                    const SizedBox(
                      width: 10,
                    ),

                    // Regenerate captcha value
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // TextFormField to enter captcha value
          ],
        ),
      ),
    );
  }
}
//https://medium.flutterdevs.com/dropdown-in-flutter-324ae9caa743
//https://flutterexperts.com/dropdown-in-flutter/
