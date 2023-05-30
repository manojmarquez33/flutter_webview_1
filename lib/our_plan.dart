import 'package:flutter/material.dart';
import 'package:logykinfotech_webview/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
  runApp(Our_Plan());
}
class Our_Plan extends StatefulWidget {
  const Our_Plan({Key? key}) : super(key: key);

  @override
  State<Our_Plan> createState() => _Our_PlanState();
}

class _Our_PlanState extends State<Our_Plan> {

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://logykinfotech.com/plans.php',
        onWebViewCreated: (controller){
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
        },
      ),
    );
  }
}
