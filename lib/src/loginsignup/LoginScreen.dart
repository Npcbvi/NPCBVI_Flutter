import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/campdashboard/CampDashboard.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/ForgotPasswordScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/RegisterScreen.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MainDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:flutter/gestures.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/DarpanWebview.dart';
class LoginScreen extends StatefulWidget {
//no build method
  _LoginScreen createState() => _LoginScreen(); // connect using createState
}

class _LoginScreen extends State<LoginScreen> {
  String menu;
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 16.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue,fontSize: 14.0);
  // present buld method
  //create two class
  UserData userData = new UserData(); // dat aget in  edittext and send apis

  String randomString = "";
  bool isVerified = false;
 // TextEditingController controllers = TextEditingController();
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
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainDashboard()),
              );
              // do something
            },
          )
        ],
      ),


      body:SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Marquee(
                    text: 'NGO Darpan number is mandatory for registration.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:20,color: Colors.red),
                    velocity: 50.0, //speed
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: 220,
                  child: RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(text:    'In order to login for the first time into the new web application it is necessary to'
                              ' register and upload certain documents and information as detailed below. Hence keep'
                              ' the scanned copy of these documents handy before starting the process of registration.'
                              +'\n'+ ' CHECKLIST FOR REGISTRATION'
                              +'\n'+ ' For NGOs'
                              +'\n'+  ' Darpan Number is must for registration. If you havent registered on Darpan portal'

                             ),
                          TextSpan(
                              text: '  Click here.',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                print("@@Darpan link webview here");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DarpanWebview()),
                                );
                                }),

                          TextSpan(
                              text: '\n Read more.',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                 showDataAlert();
                                }),
                        ],
                      ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: new TextField(
                  controller: _loginIdController,
                  decoration: InputDecoration(
                      label: Text('Login ID'),
                      hintText: 'Enter Login Id',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      //prefixIcon
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: new TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter Password',
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                      //prefixIcon

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Shown Captcha value to user
                    Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: red1)),
                        child: Text(
                          randomString,
                          style: TextStyle(
                              color: red1, fontWeight: FontWeight.w500),
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
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
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
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
                child: ElevatedButton(
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    isVerified = _captchaController.text == randomString;
                    print('@@isVerified' + isVerified.toString());
                    print('@@controller.text' + _captchaController.text.toString());
                    print('@@randomString' + randomString.toString());
                    setState(() {

                    });
                    _submitForm();
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  );
                },
                child: addSignUpButton(),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  );
                },
                textColor: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14,
                      color: appThemeSecondary,
                    ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget addSignUpButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            text: 'Don\'t have an account?',
            style: const TextStyle(
                fontFamily: 'Medium', fontSize: 16, color: Colors.black),
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
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
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
    userData.enterCptcha = _captchaController.text.toString().trim();

    if (userData.loginId.isEmpty) {
      Utils.showToast("Please enter loginId !", false);
      return;
    }
    if (userData.password.isEmpty) {
      Utils.showToast("Please enter password !", false);
      return;
    }
    if (userData.enterCptcha.isEmpty) {
      Utils.showToast("Please enter Matched Captcha !", false);
      return;

    } else {
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog1(context);
          ApiController.loginAPiRequest(userData).then((response) async {
            Utils.hideProgressDialog1(context);

            print('@@response_loginScreen ---' + response.toString());
            if (response != null && response.result.status) {
              if(response.result.data.roleId=='9'){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CampDashboard()),
                );
              }else if(response.result.data.roleId=='6'){
                Navigator.push(
                  context,
                 /* MaterialPageRoute(
                      builder: (context) => HospitalDashboard()),*/
                  MaterialPageRoute(
                      builder: (context) => DPMDashboard()),
                );
              }
              else if(response.result.data.roleId=='3'){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DPMDashboard()),
                );
              }
              //Navigator.pop(context);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }
  }
  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Text(
              "Full-Description",
              style: TextStyle(fontSize: 24.0),
            ),
            content: Container(
              height: 400,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'In order to login for the first time into the new web application it is necessary to'
                            ' register and upload certain documents and information as detailed below. Hence keep'
                            ' the scanned copy of these documents handy before starting the process of registration.'
                            +'\n'+
                            ' CHECKLIST FOR REGISTRATION'
                            +'\n'+
                            ' For NGOs'
                            ' Darpan Number is must for registration. If you havent registered on Darpan portal'
                            +'\n'+
                            'Click here.'
                            +'\n'+
                            ' Equipment details of your hospital is to be filled once you login.'
                            ' Documents Check list : Scanned copies of following documents needs to be uploaded:'
                            ' Society/Charitable public trust registration certificate'
                            ' Minimum 3 years of experience certificate'
                            ' Bank Details like Account No. , Bank IFSC Code and Bank Name.'
                            +'\n'+


                            ' For Private Prac./ Private Medical Colleges/ Others:'
                            ' Equipment details of your hospital is to be filled.'
                            ' Documents Check list : Scanned copies of following documents needs to be uploaded:'
                            ' MS Opthalmology Degree'
                            ' Two years Experience post PG'
                            +'\n'+
                            ' If there is any problem in the registration please contact :helpdesk[dot]npcb[at]nic[dot]in.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}


class UserData {
  String loginId;
  String password;
  String enterCptcha;
}
//Note for generate CapchtaCode
//https://www.geeksforgeeks.org/flutter-implement-captcha-verification/
//Api{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImNhbXA5OTcxODUzNDc5IiwibmJmIjoxNzE5ODk1MDE4LCJleHAiOjE3MTk4OTg2MTgsImlhdCI6MTcxOTg5NTAxOH0.rCgA8HPiXzOy2OQT0uataWwQ2gxBvNUdE2fFQVDyBkI","result":{"message":"Login Successfully.","status":true,"data":{"new_pwd":"EBF8338E23213132F5CCAC6B6D6F1A4F9AC2FDE3CF5EF4934A8B2AFA51FCF929C11674A0C0EEDB3B7AA0D5CCFB7AB6A55037B6C053870280AA84B08AD44253D3","status":2,"user_id":"Camp9971853479","role_id":"9","name":"fgfhs","email_id":"reshmahayat991@gmail.com","district_name":"TEST1","state_name":"TEST"},"list":null}}