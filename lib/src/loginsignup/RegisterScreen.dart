import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Registeration',
            style: new TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        leading: IconButton( icon: Icon(Icons.arrow_back_ios),
            onPressed:(){
          Utils.hideKeyboard(context);
          Navigator.of(context).pop(context);
            }
        )

      ),
    );
  }
}
