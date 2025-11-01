import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/sugar_level_screen.dart'; // make sure path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sugar Level Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xFFDEDEDE),
      ),
      home: const SugarLevelScreen(), // 👈 directly loads your screen
    );
  }
}
