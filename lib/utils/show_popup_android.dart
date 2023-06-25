import 'package:flutter/material.dart';

void showPopup(BuildContext context, Widget obj) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Popup Title'),
        content: obj,
        actions: [
          TextButton(
            onPressed: () {
              // Perform action when the button is pressed
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
