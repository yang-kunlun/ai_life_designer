import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../schedule/schedule_detail_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isMorandiTheme;

  const HomePage({
    Key? key,
    required this.toggleTheme,
    required this.isMorandiTheme,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _schedules = [
    {
      'time': '07:15',
      'title': '起床啦！',
      'icon': Icons.alarm,
      'color': Color(0xFFE2C4C0), // 莫兰迪粉
      'status': '未开始',
    },
    {
      'time': '11:00 - 12:00',
      'title': '去跑步！',
      'icon': Icons.directions_run,
      'color': Color(0xFFA7BBC7), // 莫兰迪蓝
      'status': '进行中',
    },
    {
      'time': '13:00 - 15:00',
      'title': '看电影',
      'icon': Icons.movie,
      'color': Color(0xFFC7DAD4), // 莫兰迪绿
      'status': '已完成',
    },
    {
      'time': '23:00',
      'title': '晚安！',
      'icon': Icons.nightlight_round,
      'color': Color(0xFFE0BBE4), // 淡紫
      'status': '未开始',
    }
  ];

  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildDateSelector(),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _showDatePicker,
          ),
          IconButton(
            icon: Icon(widget.isMorandiTheme 
                ? Icons.color_lens 
                : Icons.color_lens_outlined),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _buildTimeline(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/scheduleDetail');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _previousDay,
        ),
        Text(
          _dateFormat.format(_selectedDate),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: _nextDay,
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      itemCount: _schedules.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final schedule = _schedules[index];
        return _buildScheduleCard(schedule);
      },
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/scheduleDetail', arguments: schedule);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              schedule['time'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: schedule['color'],
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(schedule['icon'], color: schedule['color']),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule['status'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (schedule['status'] == '进行中')
                    Icon(Icons.access_time, color: schedule['color'], size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
