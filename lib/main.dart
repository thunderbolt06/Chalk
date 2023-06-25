import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Chalk',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  Map<String, Color> color = {
    'one': Color(0xFFF2DDDC),
    'two': Color(0xFFDA5556),
    'three': Color(0xFFE66345),
    'four': Color(0xFFF27235),
    'five': Color(0xFFFF8025),
    'six': Color(0xFF0E5194),
    'seven': Color(0xFF09722B),
  };

  List<String> quickPicks = List.empty(growable: true);
}
