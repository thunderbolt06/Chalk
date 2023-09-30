import 'package:http/http.dart' as http;

Future<String> fetchHelloWorld() async {
  final response =
      await http.get(Uri.parse('https://chalkapi.azurewebsites.net/api/hello'));

  if (response.statusCode == 200) {
    // Request successful, parse the response data
    final responseData = response.body;
    return responseData;
    // print('sucess');
    // Process the responseData as needed
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
  return "Error";
}
