import 'package:flutter/material.dart';
import '../../models/schedule.dart';
import '../../widgets/timeline_card.dart';
import 'create_schedule_recommend.dart';
import 'create_schedule_edit.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Schedule> schedules = [
    Schedule(
      id: '1',
      title: '上午会议',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      location: '会议室A',
      notify: true,
      repeat: '不重复',
      remarks: '讨论项目进度',
    ),
    Schedule(
      id: '2',
      title: '午餐时间',
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      location: '食堂',
      notify: true,
      repeat: '不重复',
      remarks: '',
    ),
  ];

  void _addSchedule(Schedule newSchedule) {
    setState(() {
      schedules.add(newSchedule);
      schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
    });
  }

  void _editSchedule(Schedule editedSchedule) {
    setState(() {
      final index = schedules.indexWhere((s) => s.id == editedSchedule.id);
      if (index != -1) {
        schedules[index] = editedSchedule;
        schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
      }
    });
  }

  void _openCreateSchedule(String theme) async {
    final newSchedule = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateScheduleRecommendPage(
          theme: theme,
          onScheduleSelected: (schedule) async {
            final editedSchedule = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateScheduleEditPage(schedule: schedule),
              ),
            );
            return editedSchedule;
          },
        ),
      ),
    );

    if (newSchedule != null) {
      _addSchedule(newSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('卡片计划'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return TimelineCard(
            schedule: schedule,
            onEdit: (schedule) {
              _editSchedule(schedule);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateSchedule('新日程'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
