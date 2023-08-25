import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void handleWebhookNotification(Map<String, dynamic> data) {
  // Process the received data and take appropriate actions
  // Update the UI, display a notification, trigger actions, etc.
}

void startWebhookServer() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  print('Webhook server started on port 8080');

  await for (HttpRequest request in server) {
    if (request.method == 'GET') {
      final payload = await request.transform(utf8.decoder).join();
      final data = json.decode(payload);

      handleWebhookNotification(data);

      request.response.statusCode = HttpStatus.ok;
      request.response.close();
    } else {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.close();
    }
  }
}
