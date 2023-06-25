import 'package:chalk/utils/logs_handler.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getLogsWithPermission(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Waiting");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
