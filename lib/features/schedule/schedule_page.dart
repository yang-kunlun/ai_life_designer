import 'package:flutter/material.dart';
import '../../models/schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final List<DateTime> _weekDays = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  DateTime _selectedDate = DateTime.now();

  final List<Schedule> _schedules = [
    Schedule(
      id: '1',
      title: '晨跑',
      description: '在公园跑步30分钟',
      startTime: DateTime.now().add(const Duration(hours: 7)),
      endTime: DateTime.now().add(const Duration(hours: 7, minutes: 30)),
      status: 'Confirmed',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Schedule(
      id: '2',
      title: '工作会议',
      description: '与客户讨论项目进展',
      startTime: DateTime.now().add(const Duration(hours: 10)),
      endTime: DateTime.now().add(const Duration(hours: 11, minutes: 30)),
      status: 'Confirmed',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Schedule(
      id: '3',
      title: '午餐',
      description: '与同事共进午餐',
      startTime: DateTime.now().add(const Duration(hours: 12)),
      endTime: DateTime.now().add(const Duration(hours: 13)),
      status: 'Pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          _buildDateNav(),
          Expanded(
            child: _buildTimelineView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 添加新日程
        },
        backgroundColor: const Color(0xFF636AE8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDateNav() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${_selectedDate.year}年${_selectedDate.month}月',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  // TODO: 显示日历视图
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _weekDays.length,
              itemBuilder: (context, index) {
                final date = _weekDays[index];
                final isSelected = date.day == _selectedDate.day;
                return _buildDateCard(date, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard(DateTime date, bool isSelected) {
    const weekDays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    return GestureDetector(
      onTap: () => setState(() => _selectedDate = date),
      child: Container(
        width: 60,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF636AE8) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekDays[date.weekday % 7],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${date.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _schedules.length,
      itemBuilder: (context, index) {
        final schedule = _schedules[index];
        return _buildScheduleCard(schedule);
      },
    );
  }

  Widget _buildScheduleCard(Schedule schedule) {
    // Calculate card height based on duration
    final duration = schedule.endTime.difference(schedule.startTime);
    final baseHeight = 100.0;
    final heightPerHour = 30.0;
    final cardHeight = baseHeight + (duration.inMinutes / 60.0 * heightPerHour);

    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(schedule),
          const SizedBox(width: 12),
          Expanded(
            child: _buildScheduleContent(schedule),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(Schedule schedule) {
    return Column(
      children: [
        Text(
          _formatTime(schedule.startTime),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Container(
          width: 2,
          height: 40,
          color: const Color(0xFF636AE8),
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
      ],
    );
  }

  Widget _buildScheduleContent(Schedule schedule) {
    final isConfirmed = schedule.status == 'Confirmed';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isConfirmed
                      ? const Color(0xFF636AE8).withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isConfirmed ? '已确认' : '待定',
                  style: TextStyle(
                    color: isConfirmed
                        ? const Color(0xFF636AE8)
                        : Colors.orange,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            schedule.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            schedule.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}