import 'package:flutter/material.dart';
import '../../models/schedule.dart';

class CreateScheduleEditPage extends StatefulWidget {
  final Schedule? schedule;

  const CreateScheduleEditPage({this.schedule, Key? key}) : super(key: key);

  @override
  _CreateScheduleEditPageState createState() => _CreateScheduleEditPageState();
}

class _CreateScheduleEditPageState extends State<CreateScheduleEditPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startTime;
  late Duration _duration;
  late String _location;
  late bool _notify;
  late String _repeat;
  late String _remarks;

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _startTime = widget.schedule!.startTime;
      _duration = widget.schedule!.endTime.difference(widget.schedule!.startTime);
      _location = widget.schedule!.location;
      _notify = widget.schedule!.notify;
      _repeat = widget.schedule!.repeat;
      _remarks = widget.schedule!.remarks;
    } else {
      _startTime = DateTime.now();
      _duration = const Duration(hours: 1);
      _location = '';
      _notify = true;
      _repeat = '不重复';
      _remarks = '';
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startTime),
    );
    if (picked != null) {
      setState(() {
        _startTime = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _selectDuration() async {
    double hours = _duration.inMinutes / 60.0;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("选择日程时长（小时）"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                value: hours,
                min: 0.5,
                max: 12.0,
                divisions: 24,
                label: hours.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    hours = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _duration = Duration(minutes: (hours * 60).toInt());
                });
                Navigator.of(context).pop();
              },
              child: const Text("确定"),
            ),
          ],
        );
      },
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newSchedule = Schedule(
        id: widget.schedule?.id ?? DateTime.now().toIso8601String(),
        title: widget.schedule?.title ?? '新日程',
        startTime: _startTime,
        endTime: _startTime.add(_duration),
        location: _location,
        notify: _notify,
        repeat: _repeat,
        remarks: _remarks,
      );
      Navigator.of(context).pop(newSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule != null ? '编辑日程' : '新建日程'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: const Text("开始时间"),
                subtitle: Text(
                  '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: _selectStartTime,
              ),
              ListTile(
                title: const Text("日程时长"),
                subtitle: Text(
                  '${_duration.inHours} 小时 ${_duration.inMinutes % 60} 分钟',
                ),
                trailing: const Icon(Icons.timer),
                onTap: _selectDuration,
              ),
              TextFormField(
                initialValue: _location,
                decoration: const InputDecoration(labelText: '地点'),
                onSaved: (value) => _location = value ?? '',
              ),
              SwitchListTile(
                title: const Text("通知"),
                value: _notify,
                onChanged: (value) => setState(() => _notify = value),
              ),
              DropdownButtonFormField<String>(
                value: _repeat,
                decoration: const InputDecoration(labelText: '重复'),
                items: ['不重复', '每天', '每周', '每月', '每年']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _repeat = value ?? '不重复'),
              ),
              TextFormField(
                initialValue: _remarks,
                decoration: const InputDecoration(labelText: '备注'),
                onSaved: (value) => _remarks = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSchedule,
                child: const Text("保存"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
