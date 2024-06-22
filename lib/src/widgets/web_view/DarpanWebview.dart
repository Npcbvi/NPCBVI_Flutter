import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DarpanWebview extends StatelessWidget {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isUrlLoadFinished = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Used for removing back buttoon.
        title: Text('DARPAN'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context, false); //is used to removed the top-most route off the navigator.
            // To go to a new screen, use the Navigator.push()
          },
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://ngodarpan.gov.in/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            //print('=======NavigationRequest======= $request}');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('======Page started loading======: $url');
          },
          onPageFinished: (String url) {
            print('==2====onLoadStop======: $url');
            //https://devmarketplace.restroapp.com/2/v1/5/phonepe/phonepeResUrl?payment_request_id=TXN_phonepe_456911632473278&TransId=T2109241419501796650551&Status=PAYMENT_SUCCESS


          },
          gestureNavigationEnabled: false,
        );
      }),
    );
  }
}
