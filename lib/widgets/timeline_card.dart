import 'package:flutter/material.dart';
import '../models/schedule.dart';

class TimelineCard extends StatelessWidget {
  final Schedule schedule;
  final Function(Schedule) onEdit;

  const TimelineCard({
    Key? key,
    required this.schedule,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  schedule.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => onEdit(schedule),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            if (schedule.location.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    schedule.location,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (schedule.remarks.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                schedule.remarks,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  schedule.notify ? Icons.notifications_active : Icons.notifications_off,
                  size: 16,
                  color: schedule.notify ? Colors.blue : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  schedule.repeat,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
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
