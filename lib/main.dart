import 'package:flutter/material.dart';
import 'temperature_screen.dart';

void main() {
  runApp(const SilverCareApp());
}

class SilverCareApp extends StatelessWidget {
  const SilverCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silver Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFDEDEDE),
      ),
      home: const TemperatureScreen(),
    );
  }
}
