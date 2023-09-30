import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectedPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: textEditingController,
              onSaved: (phoneNumber) {
                textEditingController.text = phoneNumber!;
              },
            ),
          ),
          ElevatedButton(
            child: Text("_launchPhoneURL"),
            onPressed: () {
              launchPhoneURL(textEditingController.text);
            },
          ),
          ElevatedButton(
            child: Text("_callNumber"),
            onPressed: () {
              callNumber(textEditingController.text);
            },
          )
        ],
      ),
    );
  }
}

callNumber(String phoneNumber) async {
  String number = phoneNumber;
  print("calling $number");
  await FlutterPhoneDirectCaller.callNumber(number);
}

launchPhoneURL(String phoneNumber) async {
  String url = 'tel:' + phoneNumber;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}