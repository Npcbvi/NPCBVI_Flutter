import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class LoginScreen extends StatefulWidget {
//no build method
  _LoginScreen createState() => _LoginScreen(); // connect using createState
}

class _LoginScreen extends State<LoginScreen> {
  // present buld method
  //create two class
  UserData userData = new UserData();

  TextEditingController _loginIdController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Login',
            style: new TextStyle(color: Colors.white),
          )),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                controller: _loginIdController,
                decoration: InputDecoration(
                    label: Text('Login ID'),
                    hintText: 'Enter Login Id',
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    label: Text('Password'),
                    hintText: 'Enter Password',
                    icon: Icon(Icons.password),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  print('@@text Button');
                  _submitForm();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _submitForm() async {



    userData.loginId = _loginIdController.text.trim();
    userData.password = _passwordController.text.trim();
    print('@@text Button'+ userData.loginId);
    print('@@text Button'+ userData.password);

    if(userData.loginId.isEmpty){
      Utils.showToast("Please enter name", false);
      return;
    }
    if(userData.password.isEmpty){
      Utils.showToast("Please enter password", false);
      return;
    }


   else{
        Utils.isNetworkAvailable().then((isNetworkAvailable) async {
          if (isNetworkAvailable) {
            Utils.showProgressDialog1(context);
           /* ApiController.registerApiRequest(userData,referralCode)
                .then((response) async {
              Utils.hideProgressDialog(context);
              if (response != null && response.success) {
                Navigator.pop(context);
              }
            });*/)
          } else {
            Utils.showToast(AppConstant.noInternet, true);
          }
        });
      }
    }
}
class UserData {
  late String loginId;
  late String password;

}