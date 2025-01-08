import 'package:flutter/material.dart';
import 'models/schedule.dart';
import 'features/schedule/schedule_page.dart';

void main() {
  runApp(const SchedlyApp());
}

class SchedlyApp extends StatelessWidget {
  const SchedlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      home: const SchedulePage(),
    );
  }
}
