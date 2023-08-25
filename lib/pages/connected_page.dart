import 'dart:convert';

import 'package:chalk/sections/header_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'accepting_page.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

const String jitsiWebPage = '''
<!DOCTYPE html>
<html>
  <head>
    <script src='https://8x8.vc/vpaas-magic-cookie-276eae561d5746b7958b59974e6b033b/external_api.js' async></script>
    <style>html, body, #jaas-container { height: 100%; width: 100%; }</style>
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

class ConnectedPage extends StatefulWidget {
  ConnectedPage() {}

  @override
  State<ConnectedPage> createState() => _ConnectedPageState();
}

class _ConnectedPageState extends State<ConnectedPage> {
  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );
    // ..loadRequest(Uri.parse('https://flutter.dev'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    // controller.loadRequest(
    //   Uri.parse('data:text/html;base64,$jitsiWebPage'),
    // );
    controller.loadHtmlString(jitsiWebPage);
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back button
          title: AppHeader(),
          backgroundColor: MyColors.two,
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
