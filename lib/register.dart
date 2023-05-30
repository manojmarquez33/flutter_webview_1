import 'package:flutter/material.dart';
import 'package:logykinfotech_webview/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
  runApp(Register());
}
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://logykinfotech.com/register.php',
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
