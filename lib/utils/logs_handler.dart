import 'package:call_log/call_log.dart';
import 'package:chalk/sections/logs_list_section.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Widget> getLogsWithPermission() async {
  if (await Permission.phone.request().isGranted) {
    return getCallLogs();
  } else {
    await Permission.phone.request();
    if (await Permission.phone.request().isGranted) {
      return getCallLogs();
    } else {
      return Text("exception");
    }
  }
}

Future<Widget> getCallLogs() async {
  Iterable<CallLogEntry> callLogs = await CallLog.query();

  return LogsList(logs: callLogs);
  // Loop through the call logs and access their properties
  for (CallLogEntry call in callLogs) {
    String number = call.number ?? '';
    String name = call.name ?? '';
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(call.timestamp!) ?? DateTime(0);
    CallType callType = call.callType ?? CallType.unknown;

    // Access other properties as needed

    // Print the call log details
    print('Number: $number');
    print('Name: $name');
    print('Date/Time: $dateTime');
    print('Call Type: $callType');
    print('---');
  }
}
