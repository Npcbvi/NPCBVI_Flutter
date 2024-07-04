import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:marquee/marquee.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/maindashboard/MainDashboard.dart';
import 'package:mohfw_npcbvi/src/model/forgot/ForgotPasswordModel.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../utils/AppColor.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String menu;

  ForgotPasswordScreen();

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  bool showGOVTPrivate = true;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  ForgotPasswordDatas forgotPwddData =
      new ForgotPasswordDatas(); // dat aget in  edittext and send apis
  final userIDController = new TextEditingController();
  int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          'Forgot Password',
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context,
                false); //is used to removed the top-most route off the navigator.
            // To go to a new screen, use the Navigator.push()
          },
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
      body: SafeArea(
          child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Expanded(
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
            ),
            Container(
              margin: EdgeInsets.fromLTRB(100, 20, 100, 20),
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Shown Captcha value to user
                      Container(
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w800),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      //widgets that follow the Material Design guidelines display a ripple animation when tapped.
                    ],
                  ),
                ),
              ),
            ),
            GovtRAdioGroups(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: new ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                        child: new Text(
                          AppConstant.entertxForgotPssword,
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        )),
                    TextFormField(
                      controller: userIDController,
                      decoration: const InputDecoration(
                        hintText: 'User Id',
                        labelText: 'User Id',
                      ),

                    ),
                    GestureDetector(
                      child: new Container(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        child: new Row(
                          children: [
                            // First child in the Row for the name and the
                            new Expanded(
                              // Name and Address are in the same column
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Code to create the view for name.
                                  new Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 20,
                                          left: 10.0,
                                          top: 10.0,
                                          right: 40.0),
                                      child: new ElevatedButton(
                                        style: Utils.getButtonDecoration(
                                          color: appThemeSecondary,
                                          border: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),

                                        child: Text(
                                          AppConstant.txtSendEmail,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                            onPressed: _forgotPassword,
                                      )),
                                ],
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
          ],
        ),
      )),
    );
  }

  Widget GovtRAdioGroups() {
    return Column(
      children: [
        Visibility(
          visible: showGOVTPrivate,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10.0),
                Text('Send OTP',style: new TextStyle(color: Colors.black),),
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            print('@@radio--' + _value.toString());
                            print('@@forgotPassword_mobilev value-1----' +
                                _value.toString());
                          });
                        }),
                    SizedBox(width: 10.0),
                    Text('Through mobile SMS'),
                    Radio(
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            print('@@forgotPassword_mobilev value-2----' +
                                _value.toString());
                          });
                        }),
                    SizedBox(width: 10.0),
                    Text('Through email'),
                  ],
                )
              ]),
        ),
      ],
    );
  }
void _forgotPassword() {
forgotPwddData.userID=userIDController.text.toString().trim();
forgotPwddData.RadioOptionSelectMobileEmail=_value.toString();
    print('@@@@_forgotPassword--valuePArams-----'+forgotPwddData.userID+forgotPwddData.RadioOptionSelectMobileEmail.toString());
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      if (forgotPwddData.userID.isEmpty) {
        Utils.showToast("Please enter loginId !", false);
        return;
      }
      form.save(); //This invokes each onSaved event
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog(context);
          ApiController.forgotPasswordApiRequest(forgotPwddData)
              .then((response) {
            Utils.hideProgressDialog(context);
         ///   ForgotPasswordModel userResponse = response;
            if (response != null && response.status) {
              print('@@----forgotPasswordApiRequest+111---'+response.status.toString());
             // Utils.showToast(response.message, true);
              sowDialogForForgot(response.message);
            }else{
              Utils.showToast(response.message, true);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }else {
      Utils.showToast("Please enter a valid email", true);
    }
  }


  void sowDialogForForgot(String message) {
/*    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Html( data:  message,),

          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],

        );
      },
    );*/
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  new Html( data:  message,),
          content: TextField(
            decoration: InputDecoration(hintText: "Enter Otp"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                // Handle the submit action
              },
            ),
          ],
        );
      },
    );
  }

}
class ForgotPasswordDatas {
  String userID;
  String RadioOptionSelectMobileEmail;
}

//"message":"<b>Password Reset Request Confirmation Code (OTP) has been sent to your <br> registered Email address</b>  <b>*************</b><b>tkmr@gmail.com</b>  .<br /> <b><BR> Enter OTP  below. Click on [Send Password]  .","status":true,"data":{"otp":"448481","getUserDetails":{"user_id":"TTTEST11001","email_id":"hementkmr@gmail.com","mobile":"9971436869","sr_no":"31901","name":"test dist","role_id":"3","status":2}},"list":null}