import 'package:flutter/material.dart';

class BottmNavBar extends StatelessWidget {
  const BottmNavBar({
    super.key,
    required void Function(int index) this.onItemTapped,
  });
  final Function(int index) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Logs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_page),
          label: 'Contact',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
