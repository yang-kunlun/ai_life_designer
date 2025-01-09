import 'package:flutter/material.dart';
import '../schedule/schedule_page.dart';
import '../schedule/create_schedule_edit.dart';
import '../../widgets/timeline_card.dart';
import '../../models/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Schedule> schedules = [
    Schedule(
      id: '1',
      title: '团队会议',
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      location: '会议室A',
      remarks: '讨论Q2产品规划',
      notify: true,
      repeat: '不重复',
    ),
    Schedule(
      id: '2',
      title: '产品演示',
      startTime: DateTime.now().add(Duration(days: 1)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
      location: '线上会议',
      remarks: '准备演示材料',
      notify: true,
      repeat: '每周重复',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日日程'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return TimelineCard(
            schedule: schedules[index],
            onEdit: (schedule) async {
              final updatedSchedule = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScheduleEdit(
                    initialSchedule: schedule,
                  ),
                ),
              );
              if (updatedSchedule != null) {
                setState(() {
                  final index = schedules.indexWhere((s) => s.id == schedule.id);
                  if (index != -1) {
                    schedules[index] = updatedSchedule;
                  }
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newSchedule = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateScheduleEdit(),
            ),
          );
          if (newSchedule != null) {
            setState(() {
              schedules.add(newSchedule);
            });
          }
        },
      ),
    );
  }
}
