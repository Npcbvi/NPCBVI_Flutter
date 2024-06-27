import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../model/contactus/ContactUS.dart';
import 'package:http/http.dart' as http;

class ContactusHtmlDisplayScreen extends StatefulWidget {
  ContactusHtmlDisplayScreen();

  @override
  State<StatefulWidget> createState() {
    return _ContactusHtmlDisplayScreen();
  }
}

class _ContactusHtmlDisplayScreen extends State<ContactusHtmlDisplayScreen> {
  String htmlData = '';
  String htmlDatalink = '';
  ContactUsData contactUSs;
  List<ContactUsData> ordersList = [];
  bool isLoadingApi = true;

  @override
  void initState() {
    super.initState();
    ApiController.getHtmlForOptions().then((value) {
      Utils.showProgressDialog(context);
      setState(() {
        Utils.hideProgressDialog(context);
        isLoadingApi = false;
        print('@@htmlDatya--' + value.message);
        if (value.status) {
          print('@@status--' + value.status.toString());
          for (var element in value.data) {
            htmlDatalink = (element.link);
            htmlData = (element.detail);
            print('@@htmlDatya--' + htmlData);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SafeArea(
        child: new Scaffold(
            appBar: AppBar(
              title: new Text('Contact Us'),
              centerTitle: true,
            ),
            body: isLoadingApi
                ? Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()))
                : htmlData.isEmpty
                    ? Center(
                        child: Text("No Data Found",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                            )),
                      )
                    : Container(
                        child: SingleChildScrollView(
                          child: Html(
                            data: htmlDatalink + '\n' + htmlData,
                          ),
                        ),
                      )),
      );
    } catch (e, s) {
      print(s);
      return Utils.getEmptyView2("No Data  Found!");
    }
  }
}
