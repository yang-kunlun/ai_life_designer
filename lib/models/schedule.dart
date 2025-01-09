enum ScheduleStatus { pending, ongoing, completed }

class Schedule {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final bool notify;
  final String repeat;
  final String remarks;
  final ScheduleStatus status;
  final List<String>? attendees;
  final String? notes;

  Schedule({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.location = '',
    this.notify = true,
    this.repeat = '不重复',
    this.remarks = '',
    this.status = ScheduleStatus.pending,
    this.attendees,
    this.notes,
  });

  Schedule copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    bool? notify,
    String? repeat,
    String? remarks,
    ScheduleStatus? status,
    List<String>? attendees,
    String? notes,
  }) {
    return Schedule(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      notify: notify ?? this.notify,
      repeat: repeat ?? this.repeat,
      remarks: remarks ?? this.remarks,
      status: status ?? this.status,
      attendees: attendees ?? this.attendees,
      notes: notes ?? this.notes,
    );
  }

  // 从JSON创建Schedule对象
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String,
      notify: json['notify'] as bool,
      repeat: json['repeat'] as String,
      remarks: json['remarks'] as String,
      status: ScheduleStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => ScheduleStatus.pending,
      ),
      attendees: json['attendees'] != null 
          ? List<String>.from(json['attendees'])
          : null,
      notes: json['notes'],
    );
  }

  // 将Schedule对象转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'notify': notify,
      'repeat': repeat,
      'remarks': remarks,
      'status': status.toString(),
      'attendees': attendees,
      'notes': notes,
    };
  }

}
