import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class NGORegistrationScreen extends StatefulWidget {
  @override
  _NGORegistrationScreenState createState() => _NGORegistrationScreenState();
}

class _NGORegistrationScreenState extends State<NGORegistrationScreen> {
  final TextEditingController _ngoDarpanNumberController = TextEditingController();
  final TextEditingController _ngoPANNumberController = TextEditingController();
  bool showNGOResgistration = true;
  NGODDataFields ngodDataFields = new NGODDataFields();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NGO Registration"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Visibility(
            visible: showNGOResgistration,
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: TextField(
                        controller: _ngoDarpanNumberController,
                        decoration: InputDecoration(
                          label: Text('NGO Darpan Number'),
                          hintText: 'Enter NGO Darpan Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                      child: TextField(
                        controller: _ngoPANNumberController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('NGO PAN Number'),
                          hintText: 'Enter NGO PAN Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                      child: ElevatedButton(
                        child: Text('Verify'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                       // onPressed: _NGORegistrationSubmit,
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

  /// pending woirk hjere due to api
  /*Future<void> _NGORegistrationSubmit() async {
    ngodDataFields.ngoDarpanNumber =
        _ngoDarpanNumberController.text.toString().trim();
    ;
    ngodDataFields.ngoPANNumber =
        _ngoPANNumberController.text.toString().trim();

    if (ngodDataFields.ngoDarpanNumber.isEmpty) {
      Utils.showToast("Please enter Name !", false);
      return;
    }
    if (ngodDataFields.ngoPANNumber.isEmpty) {
      Utils.showToast("Please enter Mobile number !", false);
      return;
    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.ngoRegistrationAPiRquest(ngodDataFields)
              .then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@spoAPiRquest ---' + response.toString());
            if (response != null && response.status) {

              Navigator.pop(context);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }*/

}
class NGODDataFields {
  String ngoDarpanNumber;
  String ngoPANNumber;
}
