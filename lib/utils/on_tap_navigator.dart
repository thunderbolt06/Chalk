import 'package:flutter/material.dart';

class OnTapNavigator extends StatelessWidget {
  final Widget child;
  final Widget next;

  const OnTapNavigator({
    super.key,
    required this.child,
    required this.next,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => next,
          ),
        );
      },
      child: child,
    );
  }
}
