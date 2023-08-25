import 'package:chalk/pages/login-form.dart';
import 'package:chalk/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('User Information'),
            onTap: () {
              // Navigate to User Information page
            },
          ),
          ListTile(
            title: Text('Account Settings'),
            onTap: () {
              // Navigate to Account Settings page
            },
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              // Navigate to Notifications page
            },
          ),
          ListTile(
            title: Text('Privacy'),
            onTap: () {
              // Navigate to Privacy page
            },
          ),
          ListTile(
            title: Text('Display & Accessibility'),
            onTap: () {
              // Navigate to Display & Accessibility page
            },
          ),
          ListTile(
            title: Text('Language & Region'),
            onTap: () {
              // Navigate to Language & Region page
            },
          ),
          ListTile(
            title: Text('Help & Support'),
            onTap: () {
              // Navigate to Help & Support page
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              // Navigate to About page
            },
          ),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              // Log out the user
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(User(email: 'guest'));

              // Optionally navigate to the login page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
