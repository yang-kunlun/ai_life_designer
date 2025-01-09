import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/schedule.dart';
import '../core/theme/design_system.dart';

class TimelineCard extends StatelessWidget {
  final Schedule schedule;
  final Function(Schedule) onEdit;
  final bool isExpanded;

  const TimelineCard({
    Key? key,
    required this.schedule,
    required this.onEdit,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOngoing = schedule.status == ScheduleStatus.ongoing;
    final isCompleted = schedule.status == ScheduleStatus.completed;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Stack(
        children: [
          // Timeline visualization
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: isOngoing 
                  ? DesignSystem.primaryColor
                  : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(left: 32),
            decoration: BoxDecoration(
              gradient: isOngoing
                ? LinearGradient(
                    colors: [
                      DesignSystem.primaryColor.withOpacity(0.9),
                      DesignSystem.primaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
              color: isCompleted
                ? Colors.grey[200]
                : Colors.white,
              borderRadius: BorderRadius.circular(DesignSystem.borderRadiusM),
              boxShadow: DesignSystem.cardShadow,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      schedule.title,
                      style: DesignSystem.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isOngoing ? Colors.white : DesignSystem.textPrimary,
                        decoration: isCompleted 
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                      ),
                    ),
                  ),
                  if (!isCompleted)
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        // TODO: Implement complete action
                      },
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start: ${DateFormat('HH:mm').format(schedule.startTime)}',
                    style: DesignSystem.caption.copyWith(
                      color: isOngoing ? Colors.white70 : DesignSystem.textSecondary,
                    ),
                  ),
                  if (schedule.endTime != null)
                    Text(
                      'End: ${DateFormat('HH:mm').format(schedule.endTime!)}',
                      style: DesignSystem.caption.copyWith(
                        color: isOngoing ? Colors.white70 : DesignSystem.textSecondary,
                      ),
                    ),
                ],
              ),
              trailing: isCompleted
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: DesignSystem.iconSizeM,
                        color: isOngoing ? Colors.white : DesignSystem.textSecondary,
                      ),
                      onPressed: () => onEdit(schedule),
                    ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (schedule.location.isNotEmpty)
                        _buildDetailRow(
                          Icons.location_on,
                          schedule.location,
                          isOngoing,
                        ),
                      if (schedule.attendees != null && schedule.attendees!.isNotEmpty)
                        _buildDetailRow(
                          Icons.people,
                          schedule.attendees!.join(', '),
                          isOngoing,
                        ),
                      if (schedule.notes?.isNotEmpty ?? false)
                        _buildDetailRow(
                          Icons.note,
                          schedule.notes!,
                          isOngoing,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isOngoing) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16.0,
            color: isOngoing ? Colors.white70 : DesignSystem.textSecondary,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isOngoing ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
