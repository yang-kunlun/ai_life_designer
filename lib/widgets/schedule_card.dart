import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final isOngoing = schedule.status == ScheduleStatus.ongoing;
    final isCompleted = schedule.status == ScheduleStatus.completed;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: isOngoing ? 4.0 : 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: isOngoing 
          ? Theme.of(context).colorScheme.primaryContainer
          : isCompleted
              ? Colors.grey[200]
              : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () => onEdit(schedule),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isOngoing 
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : null,
                    ),
                  ),
                  if (isCompleted)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                '${DateFormat('HH:mm').format(schedule.startTime)} - ${DateFormat('HH:mm').format(schedule.endTime)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isOngoing
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null,
                ),
              ),
              if (schedule.location.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  schedule.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isOngoing
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : null,
                  ),
                ),
              ],
              if (schedule.attendees != null && schedule.attendees!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 4.0,
                  children: schedule.attendees!.map((attendee) => Chip(
                    label: Text(attendee),
                    backgroundColor: isOngoing
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    labelStyle: TextStyle(
                      color: isOngoing
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
                  )).toList(),
                ),
              ],
              if (schedule.notes?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8.0),
                Text(
                  schedule.notes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: isOngoing
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : null,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
