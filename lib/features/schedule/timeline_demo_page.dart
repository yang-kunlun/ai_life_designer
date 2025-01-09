import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/schedule.dart';
import '../../core/theme/design_system.dart';

enum ScheduleStatus { completed, ongoing, pending }

class ScheduleCardData {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final ScheduleStatus status;
  final List<String>? attendees;
  final String? notes;

  ScheduleCardData({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.location,
    required this.status,
    this.attendees,
    this.notes,
  });
}

class TimelineDemoPage extends StatefulWidget {
  const TimelineDemoPage({Key? key}) : super(key: key);

  @override
  State<TimelineDemoPage> createState() => _TimelineDemoPageState();
}

class _TimelineDemoPageState extends State<TimelineDemoPage> {
  final TextEditingController _instructionController = TextEditingController();
  List<ScheduleCardData> _scheduleCards = [
    ScheduleCardData(
      id: '1',
      title: '部门会议',
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(minutes: 30)),
      location: '公司会议室',
      status: ScheduleStatus.completed,
    ),
    ScheduleCardData(
      id: '2',
      title: '项目讨论',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      location: '线上会议',
      status: ScheduleStatus.ongoing,
      attendees: ['张三', '李四'],
      notes: '讨论项目进展和下一步计划',
    ),
    ScheduleCardData(
      id: '3',
      title: '准备演示文稿',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      status: ScheduleStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _scheduleCards.sort((a, b) => a.startTime.compareTo(b.startTime));
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 日程演示', style: DesignSystem.heading2),
        backgroundColor: DesignSystem.backgroundLight,
        elevation: 0,
        foregroundColor: DesignSystem.textPrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(DesignSystem.spacingM),
            child: TextField(
              controller: _instructionController,
              decoration: DesignSystem.inputDecoration('告诉我你的计划...').copyWith(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // TODO: Implement voice input
                  },
                ),
              ),
              onSubmitted: (value) {
                // TODO: Send instruction to AI and update schedule
                print('User instruction: $value');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _scheduleCards.length,
              itemBuilder: (context, index) {
                final cardData = _scheduleCards[index];
                bool isOngoing = cardData.status == ScheduleStatus.ongoing;
                bool isCompleted = cardData.status == ScheduleStatus.completed;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isOngoing 
                        ? DesignSystem.primaryColor
                        : isCompleted
                            ? DesignSystem.backgroundDark.withOpacity(0.05)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(DesignSystem.borderRadiusM),
                    boxShadow: DesignSystem.cardShadow,
                    ),
                    child: ExpansionTile(
                        title: Text(
                        cardData.title,
                        style: DesignSystem.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isOngoing ? Colors.white : DesignSystem.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('HH:mm').format(cardData.startTime),
                        style: DesignSystem.caption.copyWith(
                          color: isOngoing ? Colors.white70 : DesignSystem.textSecondary,
                        ),
                      ),
                      trailing: isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (cardData.location != null)
                                _buildDetailRow(
                                  Icons.location_on,
                                  cardData.location!,
                                  isOngoing,
                                ),
                              if (cardData.attendees != null)
                                _buildDetailRow(
                                  Icons.people,
                                  cardData.attendees!.join(', '),
                                  isOngoing,
                                ),
                              if (cardData.notes != null)
                                _buildDetailRow(
                                  Icons.note,
                                  cardData.notes!,
                                  isOngoing,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                          Icon(icon, size: 16.0, color: isOngoing ? Colors.white70 : DesignSystem.textSecondary),
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
