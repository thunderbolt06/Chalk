import 'package:call_log/call_log.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

class LogsList extends StatelessWidget {
  final Iterable<CallLogEntry> logs;

  const LogsList({required this.logs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 1000,
      child: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: 400,
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final contactName = logs.elementAt(index).name ?? "null";
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    contactName.isEmpty ? "N" : contactName.substring(0, 1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  contactName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle contact item tap
                },
              );
            },
          ),
        ),
      ),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        final log = logs.elementAt(index);
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              log.name!.substring(0, 1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            log.name!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Handle contact item tap
          },
        );
      },
    );
  }
}
