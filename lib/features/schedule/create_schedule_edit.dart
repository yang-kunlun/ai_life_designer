import 'package:flutter/material.dart';
import '../../models/schedule.dart';

class CreateScheduleEdit extends StatefulWidget {
  final Schedule? initialSchedule;

  const CreateScheduleEdit({Key? key, this.initialSchedule}) : super(key: key);

  @override
  _CreateScheduleEditState createState() => _CreateScheduleEditState();
}

class _CreateScheduleEditState extends State<CreateScheduleEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _remarksController;
  late DateTime _startTime;
  late DateTime _endTime;
  bool _notify = true;
  String _repeat = '不重复';

  @override
  void initState() {
    super.initState();
    final schedule = widget.initialSchedule;
    _titleController = TextEditingController(text: schedule?.title ?? '');
    _locationController = TextEditingController(text: schedule?.location ?? '');
    _remarksController = TextEditingController(text: schedule?.remarks ?? '');
    _startTime = schedule?.startTime ?? DateTime.now();
    _endTime = schedule?.endTime ?? DateTime.now().add(Duration(hours: 1));
    _notify = schedule?.notify ?? true;
    _repeat = schedule?.repeat ?? '不重复';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialSchedule == null ? '新建日程' : '编辑日程'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSchedule,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '标题',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入标题';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildDateTimePicker('开始时间', _startTime, (newTime) {
                setState(() {
                  _startTime = newTime;
                  if (_endTime.isBefore(newTime)) {
                    _endTime = newTime.add(Duration(hours: 1));
                  }
                });
              }),
              SizedBox(height: 16),
              _buildDateTimePicker('结束时间', _endTime, (newTime) {
                setState(() {
                  _endTime = newTime;
                });
              }),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: '地点',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  labelText: '备注',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              SwitchListTile(
                title: Text('提醒'),
                value: _notify,
                onChanged: (value) {
                  setState(() {
                    _notify = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _repeat,
                decoration: InputDecoration(
                  labelText: '重复',
                  border: OutlineInputBorder(),
                ),
                items: ['不重复', '每天重复', '每周重复', '每月重复']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _repeat = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(String label, DateTime initialTime, Function(DateTime) onChanged) {
    return InkWell(
      onTap: () async {
        final time = await showDatePicker(
          context: context,
          initialDate: initialTime,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (time != null) {
          final picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(initialTime),
          );
          if (picked != null) {
            final newTime = DateTime(
              time.year,
              time.month,
              time.day,
              picked.hour,
              picked.minute,
            );
            onChanged(newTime);
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${initialTime.year}-${initialTime.month.toString().padLeft(2, '0')}-${initialTime.day.toString().padLeft(2, '0')}',
            ),
            Text(
              '${initialTime.hour.toString().padLeft(2, '0')}:${initialTime.minute.toString().padLeft(2, '0')}',
            ),
          ],
        ),
      ),
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      final schedule = Schedule(
        id: widget.initialSchedule?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        startTime: _startTime,
        endTime: _endTime,
        location: _locationController.text,
        remarks: _remarksController.text,
        notify: _notify,
        repeat: _repeat,
      );
      Navigator.pop(context, schedule);
    }
  }
}
