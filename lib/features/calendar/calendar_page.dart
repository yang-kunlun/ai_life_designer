import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日历'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
          ),
          PopupMenuButton<CalendarFormat>(
            onSelected: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: CalendarFormat.month,
                child: Text('月视图'),
              ),
              const PopupMenuItem(
                value: CalendarFormat.week,
                child: Text('周视图'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'zh_CN',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            // 日历样式配置
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(color: Colors.red),
            ),
            // 头部样式配置
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 0, // 这里后续会显示选中日期的日程
              itemBuilder: (context, index) {
                return const Card(
                  child: ListTile(
                    title: Text('示例日程'),
                    subtitle: Text('09:00 - 10:00'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现添加日程功能
          Get.snackbar(
            '提示',
            '添加日程功能即将推出',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
