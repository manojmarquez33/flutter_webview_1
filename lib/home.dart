import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logykinfotech_webview/contact.dart';
import 'package:logykinfotech_webview/our_plan.dart';
import 'package:logykinfotech_webview/payment.dart';
import 'package:logykinfotech_webview/register.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main(){
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://logykinfotech.com/',
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            onPageFinished: (String url) {
              controller
                  .evaluateJavascript("javascript:(function() { " +
                  "var head = document.getElementsByTagName('header')[0];" +
                  "head.parentNode.removeChild(head);" +
                  "var footer = document.getElementsByTagName('footer')[0];" +
                  "footer.parentNode.removeChild(footer);" +
                  "})()")
                  .then((value) =>
                  debugPrint('Page finished loading Javascript'))
                  .catchError((onError) => debugPrint('$onError'));

              setState(() {
                isLoading = false; // Set isLoading to false when the page finishes loading
              });
            },
          ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80.0),
                  Padding(
                    padding: EdgeInsets.only(left: 56.0),
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}