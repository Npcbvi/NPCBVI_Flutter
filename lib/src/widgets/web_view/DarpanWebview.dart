import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DarpanWebview extends StatefulWidget {
  @override
  _DarpanWebviewState createState() => _DarpanWebviewState();
}

class _DarpanWebviewState extends State<DarpanWebview> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isUrlLoadFinished = false;

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('DARPAN'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context, false);
          },
        ),
      ),
      body: Stack(  // Add Stack to overlay the loader on top
        children: [
          WebView(
            initialUrl: 'https://ngodarpan.gov.in/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('======Page started loading======: $url');
              setState(() {
                isUrlLoadFinished = false;  // Show loader
              });
            },
            onPageFinished: (String url) {
              print('==2====onLoadStop======: $url');
              setState(() {
                isUrlLoadFinished = true;  // Hide loader
              });
            },
            gestureNavigationEnabled: false,
          ),
          // Loader - only shown when isUrlLoadFinished is false
          if (!isUrlLoadFinished)
            Center(
              child: CircularProgressIndicator(),  // Show circular loader
            ),
        ],
      ),
    );
  }
}
