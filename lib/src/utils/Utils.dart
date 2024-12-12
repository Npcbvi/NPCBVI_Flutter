import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:progress_dialog/progress_dialog.dart';



class Utils {
  static ProgressDialog pr ;


  static void showToast(String msg, bool shortLength) {
    try {
      if (shortLength) {
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastbgColor.withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastbgColor.withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  static Widget getEmptyView1(String value) {
    return Container(
      child: Center(
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            )),
      ),
    );
  }


  static Widget showIndicator() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black26)),
      ),
    );
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static getButtonDecoration({EdgeInsets edgeInsets, color, border}) {
    return ButtonStyle(
        shape: MaterialStateProperty.all(border),
        padding: MaterialStateProperty.all(edgeInsets),
        backgroundColor: MaterialStateProperty.all(color));
  }
  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
if (!regex.hasMatch(value))
      return true;
    else
      return false;

    return regex.hasMatch(value);
  }

  static Future<bool> isNetworkAvailable() async {
    bool isNetworkAvailable = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isNetworkAvailable = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isNetworkAvailable = true;
    }
    return isNetworkAvailable;
  }

// Function to format the date string
  static String formatDateString(String dateString) {
    // Convert the string to a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Define the desired format
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  static void showProgressDialog1(BuildContext context) {
    //For normal dialog
    pr=new ProgressDialog(context);
    if (pr != null && pr.isShowing()) {
      pr.hide();
    }
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.show();
  }

  static void hideProgressDialog1(BuildContext context) {
    //For normal dialog
    try {
      if (pr != null && pr.isShowing()) {
        pr.hide();
        pr = null;
      } else {
        if (pr != null) {
          pr.hide();
        }
      }
    } catch (e) {
      print(e);
    }
  }





  static double calculateDistance(lat1, lon1, lat2, lon2) {
    try {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    } catch (e) {
      print(e);
      return 0.0;
    }
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Widget showDivider(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      color: Color(0xFFDBDCDD),
    );
  }

  static Widget getEmptyView(String value) {
    return Container(
      child: Expanded(
        child: Center(
          child: Text(value,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              )),
        ),
      ),
    );
  }
























  static Widget getIndicatorView() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: Colors.black26,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black26)),
    );
  }

  static Widget getEmptyView2(String value) {
    return Container(
      child: Center(
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            )),
      ),
    );
  }








  static Color colorGeneralization(Color passedColor, String colorString) {
    Color returnedColor = passedColor;
    if (colorString != null) {
      try {
        returnedColor = Color(int.parse(colorString.replaceAll("#", "0xff")));
      } catch (e) {
        print(e);
      }
    }
    return returnedColor;
  }


  static void showProgressDialog(BuildContext context) {
    Loader.show(context,
        isAppbarOverlay: true,
        isBottomBarOverlay: true,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Color(0xFFFF7443),
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.black38),
        overlayColor: Color(0x99E8EAF6));
  }

  static void hideProgressDialog(BuildContext context) {
    Loader.hide();
  }


}






