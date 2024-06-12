
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

import '../utils/AppColor.dart';


class ForgotPasswordScreen extends StatefulWidget {

  String menu;
  ForgotPasswordScreen(this.menu);

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  ForgotPasswordData forgotPwddData = new ForgotPasswordData(); // dat aget in  edittext and send apis
  final emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: whiteColor,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Forgot Password',style: new TextStyle(
          color: Colors.white,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context, false); //is used to removed the top-most route off the navigator.
           // To go to a new screen, use the Navigator.push()
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: <Widget>[

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction
,
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
                          decoration: const InputDecoration(
                            hintText: 'Enter Email',
                            labelText: 'Enter Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                          val.isEmpty ? AppConstant.enterEmailAddress : null,
                          onSaved: (val) {
                            forgotPwddData.email = val.trim();
                          },
                        ),
                        GestureDetector(
                          child: new Container(
                            padding: const EdgeInsets.all(10.0,),
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
                                          padding: const EdgeInsets.only(bottom: 20,
                                              left: 10.0, top: 10.0, right: 40.0),
                                          child: new ElevatedButton(
                                            style: Utils.getButtonDecoration(
                                              color: appThemeSecondary,
                                              border: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                            ),


                                            child: Text(AppConstant.txtSendEmail,style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            ),
                                       //     onPressed: _forgotPassword,
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
          )
      ),
    );
  }




  /*void _forgotPassword() {
    print('@@_forgotPassword');

    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save(); //This invokes each onSaved event
      Utils.isNetworkAvailable().then((isNetworkAvailable) async {
        if (isNetworkAvailable) {
          Utils.showProgressDialog(context);
          ApiController.forgotPasswordApiRequest(forgotPwddData)
              .then((response) {
            Utils.hideProgressDialog(context);
            GetForgotPwdData userResponse = response;
            if (response != null && response.success) {
              print('@@----forgotPasswordApiRequest+'+response.success.toString());
             // Utils.showToast(response.message, true);
              sowDialogForForgot(response.message);
            }else{
              Utils.showToast(userResponse.message, true);
            }
          });
        } else {
          Utils.showToast(AppConstant.noInternet, true);
        }
      });
    }else {
      Utils.showToast("Please enter a valid email", true);
    }
  }*/

  void sowDialogForForgot(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Text(message),
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
    );
  }
}

class ForgotPasswordData {
  String email;
}

