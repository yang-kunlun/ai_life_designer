class Schedule {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final String location;
  final List<String> participants;
  final String status; // 'pending', 'confirmed', 'cancelled'
  final DateTime createdAt;
  final DateTime updatedAt;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.location = '',
    this.participants = const [],
    this.status = 'pending',
    required this.createdAt,
    required this.updatedAt,
  });

  // 从JSON创建Schedule对象
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isAllDay: json['isAllDay'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // 将Schedule对象转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isAllDay': isAllDay,
      'location': location,
      'participants': participants,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // 复制Schedule对象并修改部分属性
  Schedule copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
    String? location,
    List<String>? participants,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Schedule(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
      location: location ?? this.location,
      participants: participants ?? this.participants,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
