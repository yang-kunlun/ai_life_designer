import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'features/home/home_page.dart';
import 'features/schedule/schedule_detail_page.dart';

void main() {
  runApp(const SchedlyApp());
}

class SchedlyApp extends StatefulWidget {
  const SchedlyApp({Key? key}) : super(key: key);

  @override
  State<SchedlyApp> createState() => _SchedlyAppState();
}

class _SchedlyAppState extends State<SchedlyApp> {
  bool _isMorandiTheme = true;

  void _toggleTheme() {
    setState(() {
      _isMorandiTheme = !_isMorandiTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '卡片计划 Schedly',
      theme: _isMorandiTheme ? AppTheme.morandiTheme : AppTheme.macaronTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
              toggleTheme: _toggleTheme,
              isMorandiTheme: _isMorandiTheme,
            ),
        '/scheduleDetail': (context) => const ScheduleDetailPage(),
      },
    );
  }
}
