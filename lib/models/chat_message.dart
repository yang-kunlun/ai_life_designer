enum MessageType {
  text,
  image,
  schedule,
}

enum MessageRole {
  user,
  assistant,
  system,
}

class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final MessageRole role;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.role,
    required this.timestamp,
    this.metadata,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type']}',
      ),
      role: MessageRole.values.firstWhere(
        (e) => e.toString() == 'MessageRole.${json['role']}',
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type.toString().split('.').last,
      'role': role.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }

  ChatMessage copyWith({
    String? id,
    String? content,
    MessageType? type,
    MessageRole? role,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }
}
