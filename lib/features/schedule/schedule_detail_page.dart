import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDetailPage extends StatefulWidget {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _selectedCategory;
  bool _isAllDay = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        _titleController.text = args['title'] ?? '';
      }
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑日程'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveSchedule,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTitleField(),
            const SizedBox(height: 20),
            _buildDateTimeSection(),
            const SizedBox(height: 20),
            _buildCategoryDropdown(),
            const SizedBox(height: 20),
            _buildAISuggestionButton(),
            const SizedBox(height: 20),
            _buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: '日程标题',
        hintText: '给日程一个名字~',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入日程标题';
        }
        return null;
      },
    );
  }

  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isAllDay,
              onChanged: (value) {
                setState(() {
                  _isAllDay = value ?? false;
                });
              },
            ),
            const Text('全天'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildDateTimePicker(
                label: '开始时间',
                initialDate: _startDateTime,
                onDateTimeSelected: (dateTime) {
                  setState(() {
                    _startDateTime = dateTime;
                    if (_endDateTime != null && _endDateTime!.isBefore(dateTime)) {
                      _endDateTime = dateTime.add(Duration(hours: 1));
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateTimePicker(
                label: '结束时间',
                initialDate: _endDateTime,
                onDateTimeSelected: (dateTime) {
                  setState(() {
                    _endDateTime = dateTime;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime? initialDate,
    required Function(DateTime) onDateTimeSelected,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
          );
          if (time != null) {
            onDateTimeSelected(DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          initialDate != null
              ? DateFormat('yyyy/MM/dd HH:mm').format(initialDate)
              : '选择$label',
          style: TextStyle(
            color: initialDate != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: '分类',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: const [
        DropdownMenuItem(value: '工作', child: Text('工作')),
        DropdownMenuItem(value: '学习', child: Text('学习')),
        DropdownMenuItem(value: '生活', child: Text('生活')),
        DropdownMenuItem(value: '娱乐', child: Text('娱乐')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请选择分类';
        }
        return null;
      },
    );
  }

  Widget _buildAISuggestionButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.lightbulb_outline),
      label: const Text('获取AI建议'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('正在分析您的日程...')),
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: '备注',
        hintText: '可以写下更详细的信息…',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      // TODO: 保存逻辑
      Navigator.pop(context);
    }
  }
}
