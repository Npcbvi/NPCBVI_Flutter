import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/campdashboard/CampDashboard.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/hospitaldashboard/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/ForgotPasswordScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/RegisterScreen.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MainDashboard.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/ngo/NgoDashboard.dart';
import 'package:mohfw_npcbvi/src/spo/SpoDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/DarpanWebview.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String randomString = "";
  bool isVerified = false;
  TextEditingController _loginIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _captchaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buildCaptcha();
  }

  void buildCaptcha() {
    const letters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    final random = Random();
    randomString = String.fromCharCodes(
      List.generate(length,
          (index) => letters.codeUnitAt(random.nextInt(letters.length))),
    );
    setState(() {});
  }

  Future<void> _submitForm() async {
    final loginId = _loginIdController.text.trim();
    final password = _passwordController.text.trim();
    final captcha = _captchaController.text.trim();

    if (loginId.isEmpty) {
      Utils.showToast("Please enter login ID!", false);
      return;
    }
    if (password.isEmpty) {
      Utils.showToast("Please enter password!", false);
      return;
    }
    if (captcha.isEmpty) {
      Utils.showToast("Please enter Captcha!", false);
      return;
    }
    if (captcha != randomString) {
      Utils.showToast("Captcha does not match!", false);
      return;
    }

    final isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      Utils.showProgressDialog1(context);
      final response = await ApiController.loginAPiRequest(UserData(
        loginId: loginId,
        password: password,
        enterCptcha: captcha,
      ));
      Utils.hideProgressDialog1(context);

      if (response != null && response.result.status) {

        SharedPrefs.storeSharedValues(AppConstant.distritcCode,
            response.result.data.district_code.toString());
        SharedPrefs.storeSharedValues(
            AppConstant.state_code, response.result.data.state_code.toString());
        // Assuming `response.result.list` is a List<DataList>
        // Check if the list is null or empty
        if (response.result.list != null && response.result.list.isNotEmpty) {
          // Since the list is not null or empty, you can safely assign it
          List<DataList> dataList = response.result.list;

          // Now, you can loop through the list or access individual items
          for (var data in dataList) {
            // Access individual DataList object fields
            print("@@@darpanNo-----" + data.darpanNo);
            SharedPrefs.storeSharedValues(AppConstant.darpan_no,
                data.darpanNo.toString());
            SharedPrefs.storeSharedValues(AppConstant.entryBy,
                data.entryBy.toString());
            SharedPrefs.storeSharedValues(AppConstant.status,
                data.status.toString());
            SharedPrefs.storeSharedValues(AppConstant.ngoName,
                data.ngoName.toString());
            print("@@@status-----" + data.entryBy.toString());
            print("@@@status-----" + data.status.toString());

          }
        } else {
          // Handle the case where the list is null or empty
          print("The list is either null or empty.");
        }

        final roleId = response.result.data.roleId;
        Widget nextScreen;
        switch (roleId) {
          case '9':
            nextScreen = CampDashboard();
            break;
          case '6':
            nextScreen = HospitalDashboard();// login and menu detaiuls
            break;
          case '3':
            nextScreen = DPMDashboard(); //working full
            break;
          case '5':
            nextScreen = NgoDashboard();// working full
            break;
          case '2':
            nextScreen = SpoDashboard();
           // nextScreen = CampDashboard///Only Dashboardview
            break;
          default:
            nextScreen = MainDashboard();// working full
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nextScreen));
      } else {
        Utils.showToast(response.result.message, true);
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
    }
  }

  void showDataAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Full Description",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold, // Makes text bold
              ),
            ),
            Divider( // Divider below the title
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
        content: Container(
          height: 400,
          width: double.maxFinite,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                    text:
                    'In order to login for the first time into the new web application, it is necessary to register and upload certain documents and information as detailed below. Hence, keep the scanned copy of these documents handy before starting the process of registration.\n\n',
                  ),
                  TextSpan(
                    text: 'CHECKLIST FOR REGISTRATION\n\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  // NGO Section
                  TextSpan(
                    text: '• For NGOs:\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '   • Darpan Number is a must \n'
                                 '     for registration.\n',
                  ),
              //    TextSpan(text: '   • Equipment details of your hospital need to be filled once you log in.\n'),
                  TextSpan(
                    text: '   • Equipment details of your hospital\n'
                          '      need to be filled once you log in.\n',
                  ),
                  TextSpan(
                    text: '   • Documents Checklist:\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '       i. Society/Charitable public trust \n'
                                 '          registration certificate \n '),
                  TextSpan(text: '       ii. Minimum 3 years of experience \n'
                                  '          certificate \n'),
                  TextSpan(text: '   • Bank Details like Account No.\n'
                                  '     Bank IFSC Code, and Bank Name.\n \n'),

                  // Private Practitioners Section
                  TextSpan(
                    text: '• For Private Practitioners/Private \n'
                           '  Medical Colleges/Others: \n',
                    style: TextStyle(fontWeight: FontWeight.bold),

                  ),
                  TextSpan(text: '   • Equipment details of your hospital \n'
                                  '     need to be filled.\n'),
                  TextSpan(
                    text: '   • Documents Checklist:\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '       i. MS Ophthalmology Degree\n'),
                  TextSpan(text: '       ii. Two years of experience post PG\n\n'),

                  // Contact Info
                  TextSpan(
                    text: 'If there is any problem in the registration, please contact: ',
                  ),
                  TextSpan(
                    text: 'helpdesk[dot]npcb[at]nic[dot]in.',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disables the back button
        centerTitle: true,
        title: Text('Login', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainDashboard()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30, // Set a height that makes sense for your use case
              child: Marquee(
                text: 'NGO Darpan number is mandatory for registration.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
                velocity: 50.0,
                pauseAfterRound: Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: 350, // Set the desired width
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15),
                  children: [
                    TextSpan(
                      text:
                          'In order to login for the first time into the new web application it is necessary to'
                          ' register and upload certain documents and information as detailed below. Hence keep'
                          ' the scanned copy of these documents handy before starting the process of registration.\n\n'
                          'CHECKLIST FOR REGISTRATION\n\n • For NGOs\nDarpan Number is must for registration. If you haven\'t registered on Darpan portal.',
                    ),
                    TextSpan(
                      text: ' Click here.',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DarpanWebview()));
                        },
                    ),
                    TextSpan(
                      text: '\nRead more',
                      style: TextStyle(color: Colors.blue,
                        fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = showDataAlert,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _loginIdController,
              decoration: InputDecoration(
                labelText: 'Login ID',
                hintText: 'Enter Login ID',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 10),
            Row(
             // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                  controller: _captchaController,
                  decoration: InputDecoration(
                    labelText: 'Enter Captcha Value',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      isVerified = false;
                    });
                  },
                ),),

                Expanded(
                  flex: 2,
                  child: Container(

                    height: 56,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(

                      color: Colors.white, // Background color
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                    child: Center( // Center widget to center the text
                      child: Text(
                        randomString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),


                Expanded(
                  flex: 1,
                  child: IconButton(
                  onPressed: buildCaptcha,
                  icon: Icon(Icons.refresh),
                ),),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 50), // Set width & height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                ),
              ),
              onPressed: () {
                // Step 1: Check if the username is entered and valid
                if (_loginIdController.text.isEmpty) {
                  Utils.showToast("Username cannot be empty !", false);
                  return;  // Exit if username is not entered
                }

                // Step 2: Check if the password is entered and valid
                if (_passwordController.text.isEmpty) {
                  Utils.showToast("Password cannot be empty !", false);
                  return;  // Exit if password is not entered
                }

                // Step 3: Check if captcha is correct
                isVerified = _captchaController.text == randomString;
                if (!isVerified) {
                  Utils.showToast("Captcha does not match!", false);
                  return;  // Exit if captcha is incorrect
                }

                // If all checks pass, submit the form
                _submitForm();
              },
              child: Text('Sign In'),
            ),

            // SizedBox(height: 10),
          //comment code for next sprint
          /*  InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appThemeSecondary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
            //comment code for next sprint
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
              },
              textColor: Colors.blue,
              child: Text('Forgot password?', style: TextStyle(fontSize: 14)),
            ),
            if (isVerified)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.verified), Text("Verified")],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserData {
  String loginId;
  String password;
  String enterCptcha;

  UserData({this.loginId, this.password, this.enterCptcha});
}
