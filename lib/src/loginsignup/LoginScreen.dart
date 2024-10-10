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
            nextScreen = HospitalDashboard();
            break;
          case '3':
            nextScreen = DPMDashboard();
            break;
          case '5':
            nextScreen = NgoDashboard();
            break;
          case '2':
            nextScreen = SpoDashboard();
            break;
          default:
            nextScreen = MainDashboard();
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
        title: Text("Full-Description", style: TextStyle(fontSize: 24.0)),
        content: Container(
          height: 400,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'In order to login for the first time into the new web application it is necessary to register and upload certain documents and information as detailed below. Hence keep the scanned copy of these documents handy before starting the process of registration.\n\n'
              'CHECKLIST FOR REGISTRATION\n\nFor NGOs:\nDarpan Number is a must for registration. If you haven\'t registered on the Darpan portal, Click here.\n\n'
              'Equipment details of your hospital need to be filled once you log in.\nDocuments Checklist:\n- Society/Charitable public trust registration certificate\n- Minimum 3 years of experience certificate\n- Bank Details like Account No., Bank IFSC Code, and Bank Name.\n\n'
              'For Private Practitioners/Private Medical Colleges/Others:\nEquipment details of your hospital need to be filled.\nDocuments Checklist:\n- MS Ophthalmology Degree\n- Two years of Experience post PG\n\n'
              'If there is any problem in the registration, please contact: helpdesk[dot]npcb[at]nic[dot]in.',
              style: TextStyle(fontSize: 12),
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
              height: 50, // Set a height that makes sense for your use case
              child: Marquee(
                text: 'NGO Darpan number is mandatory for registration.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16),
                children: [
                  TextSpan(
                    text:
                        'In order to login for the first time into the new web application it is necessary to'
                        ' register and upload certain documents and information as detailed below. Hence keep'
                        ' the scanned copy of these documents handy before starting the process of registration.\n\n'
                        'CHECKLIST FOR REGISTRATION\n\nFor NGOs\nDarpan Number is must for registration. If you haven\'t registered on Darpan portal.',
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
                    text: '\nRead more.',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = showDataAlert,
                  ),
                ],
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.red)),
                  child: Text(
                    randomString,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: buildCaptcha,
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                isVerified = _captchaController.text == randomString;
                if (isVerified) {
                  _submitForm();
                } else {
                  Utils.showToast("Captcha does not match!", false);
                }
              },
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
            SizedBox(height: 10),
            InkWell(
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
            ),
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
