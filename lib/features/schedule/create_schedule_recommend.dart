import 'package:flutter/material.dart';
import '../../models/schedule.dart';
import 'create_schedule_edit.dart';

class CreateScheduleRecommendPage extends StatelessWidget {
  final String theme;
  final Function(Schedule) onScheduleSelected;

  const CreateScheduleRecommendPage({
    required this.theme,
    required this.onScheduleSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AI-generated schedule suggestion
    final aiSchedule = Schedule(
      id: 'ai-schedule',
      title: 'AI建议：$theme',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      location: '推荐地点',
      notify: true,
      repeat: '不重复',
      remarks: 'AI自动生成的建议日程',
    );

    // Common schedule templates
    final commonSchedules = [
      Schedule(
        id: 'common-1',
        title: '与朋友聚餐',
        startTime: DateTime.now().add(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(hours: 4)),
        location: '朋友家',
        notify: true,
        repeat: '不重复',
        remarks: '',
      ),
      Schedule(
        id: 'common-2',
        title: '商务午餐',
        startTime: DateTime.now().add(const Duration(hours: 5)),
        endTime: DateTime.now().add(const Duration(hours: 6)),
        location: '公司附近餐厅',
        notify: true,
        repeat: '不重复',
        remarks: '',
      ),
      Schedule(
        id: 'common-3',
        title: '家庭聚餐',
        startTime: DateTime.now().add(const Duration(hours: 7)),
        endTime: DateTime.now().add(const Duration(hours: 8)),
        location: '家中',
        notify: false,
        repeat: '不重复',
        remarks: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("日程推荐"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主题：$theme',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(aiSchedule.title),
                subtitle: Text(
                  '${_formatTime(aiSchedule.startTime)} - ${_formatTime(aiSchedule.endTime)}\n地点: ${aiSchedule.location}',
                ),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => onScheduleSelected(aiSchedule),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '常用日程',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: commonSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = commonSchedules[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(schedule.title),
                      subtitle: Text(
                        '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}\n地点: ${schedule.location}',
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () => onScheduleSelected(schedule),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
