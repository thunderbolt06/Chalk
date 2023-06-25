import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Replace with your logo image
              width: 48.0,
              height: 48.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Chalk', // Replace with your app title
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.person_2,
            color: Colors.black,
          ),
          onPressed: () {
            // Handle profile icon tap
          },
        ),
      ],
    );
  }
}
