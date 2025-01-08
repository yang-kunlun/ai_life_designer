import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final Function(Schedule) onEdit;

  const ScheduleCard({
    required this.schedule,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          schedule.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
            ),
            Text('地点: ${schedule.location}'),
            if (schedule.remarks.isNotEmpty)
              Text('备注: ${schedule.remarks}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onEdit(schedule),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
