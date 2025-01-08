class Schedule {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final bool notify;
  final String repeat;
  final String remarks;

  Schedule({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notify,
    required this.repeat,
    required this.remarks,
  });

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
    };
  }

  // 复制Schedule对象并修改部分属性
  Schedule copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    bool? notify,
    String? repeat,
    String? remarks,
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
    );
  }
}
