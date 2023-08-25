import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String jitsiWebPage = '''
<!DOCTYPE html>
<html>
  <head>
    <script src='https://8x8.vc/vpaas-magic-cookie-276eae561d5746b7958b59974e6b033b/external_api.js' async></script>
    <style>html, body, #jaas-container { height: 100%; }</style>
    <script type="text/javascript">
      window.onload = () => {
        const api = new JitsiMeetExternalAPI("8x8.vc", {
          roomName: "vpaas-magic-cookie-276eae561d5746b7958b59974e6b033b/SampleAppOrganizedDebatesNameMerrily",
          parentNode: document.querySelector('#jaas-container'),
          // Make sure to include a JWT if you intend to record,
          // make outbound calls or use any other premium features!
          // jwt: "eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtMjc2ZWFlNTYxZDU3NDZiNzk1OGI1OTk3NGU2YjAzM2IvOTI0MDdkLVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE2ODkwMDQ2NzYsImV4cCI6MTY4OTAxMTg3NiwibmJmIjoxNjg5MDA0NjcxLCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtMjc2ZWFlNTYxZDU3NDZiNzk1OGI1OTk3NGU2YjAzM2IiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOmZhbHNlLCJvdXRib3VuZC1jYWxsIjpmYWxzZSwic2lwLW91dGJvdW5kLWNhbGwiOmZhbHNlLCJ0cmFuc2NyaXB0aW9uIjpmYWxzZSwicmVjb3JkaW5nIjpmYWxzZX0sInVzZXIiOnsiaGlkZGVuLWZyb20tcmVjb3JkZXIiOmZhbHNlLCJtb2RlcmF0b3IiOnRydWUsIm5hbWUiOiJUZXN0IFVzZXIiLCJpZCI6Imdvb2dsZS1vYXV0aDJ8MTA0NDI2OTMwOTcwMDQyOTQyNzM3IiwiYXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LnVzZXJAY29tcGFueS5jb20ifX0sInJvb20iOiIqIn0.M8uH_hC4V_0x6vEqY85Ta0v5Yowuxebgnw_63y9Nmv1Hq9UpaUmVBADb53U7IteRirfRVypii2E2EVOjKLFrnF0ZNbU8A2aCAA46vHyx0z1WBitUyi-eUqUxE7QK_-ZNHqLvfAqhbO7OBqV6cGufP0Z4byE6TxH2Fc4thPe5LVO5u6qfruRSDooVJWVnqaPOwQTBcxy4ELYL0mzX9eEMGCPXkOt-Ex1p-qLgA8lDWu00ndxVe47j6CsOWkTwbx9rnDnSuNF9GJyI_3Bn0T6_Wm-mQMqMKIIGFbTki3bps_QQPYO5M5abQBP968dV0835DMxCasivT6UBYQ7wjHlasg"
        });
      }
    </script>
  </head>
  <body><div id="jaas-container" /></body>
</html>
''';

class JitsiWebPage extends StatelessWidget {
  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  JitsiWebPage() {
    controller.loadRequest(
      Uri.parse('data:text/html;base64,$jitsiWebPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WebView Example')),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
