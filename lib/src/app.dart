import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/src/pages/home/home_screen.dart';
import 'package:flutter_expense_tracker/src/pages/pin/pin_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'CustomFontIBMPlexSansThai',
      ),
      home: PinEntryScreen(),
    );
  }
}