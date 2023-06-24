import 'package:flutter/material.dart';

class ChalkButton extends StatelessWidget {
  final Widget next;

  const ChalkButton({
    super.key,
    required this.color,
    required this.text,
    required this.next,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => next,
            ),
          );
          // Handle "More" button tap
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          primary: color,
          textStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
