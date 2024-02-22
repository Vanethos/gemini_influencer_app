import 'package:flutter/material.dart';
import 'package:gemini_influencer_app/screens/input_screen.dart';

late final String geminiApiKey;

void main() {
  geminiApiKey = const String.fromEnvironment("API-KEY", defaultValue: '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InputScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }
}
