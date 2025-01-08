import 'package:flutter/material.dart';
import '../../widgets/timeline_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DateTime> _dates = List.generate(7, (index) {
    DateTime today = DateTime.now();
    return today.add(Duration(days: index));
  });

  late DateTime _selectedDate;

  final List<Map<String, dynamic>> _tasks = [
    {
      'time': '07:15',
      'title': '起床啦！',
      'icon': Icons.alarm,
      'duration': '闹钟提醒',
      'color': Color(0xFFFFCAC2),
    },
    {
      'time': '11:00',
      'title': '去跑步！',
      'icon': Icons.directions_run,
      'duration': '1小时 (消耗 6卡路里?)',
      'color': Color(0xFFFFD7AF),
    },
    {
      'time': '12:27',
      'title': '看电影',
      'icon': Icons.movie,
      'duration': '剩余 1小时17分钟',
      'color': Color(0xFFC2D8F5),
    },
    {
      'time': '23:00',
      'title': '晚安',
      'icon': Icons.nightlight_round,
      'duration': '',
      'color': Color(0xFFD9C2F5),
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = _dates.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(child: _buildTimelineList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${_selectedDate.year}年${_selectedDate.month}月',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () {
            // TODO: Show calendar view
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // TODO: Navigate to settings
          },
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFF0EE) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: const Color(0xFFF5C3C2), width: 2)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekdayString(date.weekday),
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.redAccent : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.redAccent : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return TimelineCard(
          time: task['time'],
          title: task['title'],
          icon: task['icon'],
          durationInfo: task['duration'],
          color: task['color'],
          isLast: index == _tasks.length - 1,
        );
      },
    );
  }

  String _weekdayString(int weekday) {
    switch (weekday) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
      default:
        return '周日';
    }
  }
}
