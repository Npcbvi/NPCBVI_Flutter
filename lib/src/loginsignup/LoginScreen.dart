import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
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
  String randomString = "";
  bool isVerified = false;
  TextEditingController controller = TextEditingController();
  TextEditingController _loginIdController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _captchaController = new TextEditingController();
  void buildCaptcha() {

    const letters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    // Length of Captcha to be generated
    final random = Random();
    // Select random letters from above list
    randomString = String.fromCharCodes(List.generate(
        length, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
    setState(() {});
    print("t@@he random string is $randomString");
  }
  // Primary Marquee text

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To generate number on loading of page
    buildCaptcha();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Login',
            style: new TextStyle(color: Colors.white),
          )),


      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20.0,0),
                child: new TextField(
                  controller: _loginIdController,
                  decoration: InputDecoration(
                      label: Text('Login ID'),
                      hintText: 'Enter Login Id',
                      prefixIcon: Icon(Icons.person, color: Colors.black,), //prefixIcon
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),

                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20.0,0),

                child: new TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.password, color: Colors.black,), //prefixIcon

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              /*Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,5,20.0,0),

                  child: const Text(
                    "Enter Captacha Value",
                    style: TextStyle(color:Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20.0,0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Shown Captcha value to user
                    Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          randomString,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      width: 10,
                    ),

                    // Regenerate captcha value
                    IconButton(
                        onPressed: () {
                          buildCaptcha();
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // TextFormField to enter captcha value
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,10,20.0,0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      isVerified = false;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Captcha Value",
                      labelText: "Enter Captcha Value"),
                  controller: _captchaController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,10,20.0,0),
                child: ElevatedButton(
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    isVerified = controller.text == randomString;
                    print('@@isVerified'+isVerified.toString());
                    print('@@controller.text'+controller.text.toString());
                    print('@@randomString'+randomString.toString());
                    setState(() {});
                    _submitForm();

                  },
                ),
              ),
              InkWell(
                onTap: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterUser()),*/
                 // );
                },
                child: addSignUpButton(),

              ),
              MaterialButton(
                onPressed: () {
                  print('@@ForgotPassword--clcik');
                 /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen(menu)),*/
                  //);
                },
                textColor: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Forgot password?',
                    style: TextStyle(
                      fontFamily: 'Medium',fontSize: 14,color: appThemeSecondary,),

                  ),
                ),
              ),
              if (isVerified)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.verified), Text("Verified")],
                  ),
                )
             /* else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Please enter value you see on screen"),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
  Widget addSignUpButton() {
    return Padding(
      padding: const EdgeInsets.only(top:20 ,bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            text: 'Don\'t have an account?',
            style: const TextStyle(
                fontFamily: 'Medium', fontSize: 16, color:Colors.black),
            children: [
              TextSpan(
                  text: ' Sign Up',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appThemeSecondary),
                  recognizer: (TapGestureRecognizer()
                    ..onTap = () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUser()),
                      );*/
                    })),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {



    userData.loginId = _loginIdController.text.toString().trim();
    userData.password = _passwordController.text.toString().trim();
    userData.enterCptcha=_captchaController.text.toString().trim();

    if(userData.loginId.isEmpty){
      Utils.showToast("Please enter loginId !", false);
      return;
    }
    if(userData.password.isEmpty){
      Utils.showToast("Please enter password !", false);
      return;
    }
    if(userData.enterCptcha.isEmpty){
      Utils.showToast("Please enter Matched Captcha !", false);
      return;
    }

   else{
        Utils.isNetworkAvailable().then((isNetworkAvailable) async {
          if (isNetworkAvailable) {
            Utils.showProgressDialog1(context);
            ApiController.loginAPiRequest(userData)
                .then((response) async {
              Utils.hideProgressDialog1(context);

              print('@@response_loginScreen ---'+response.toString());
              if (response != null && response.result.status) {
                Navigator.pop(context);
              }
            }
           );
          } else {
            Utils.showToast(AppConstant.noInternet, true);
          }
        });
      }
    }

}
class UserData {
   String  loginId;
   String password;
   String enterCptcha;

}
//Note for generate CapchtaCode
//https://www.geeksforgeeks.org/flutter-implement-captcha-verification/