
class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      id: data['id'] as String,
      senderId: data['sender_id'] as String,
      receiverId: data['receiver_id'] as String,
      content: data['content'] as String,
      timestamp: DateTime.parse(data['timestamp'] as String),
      isRead: data['is_read'] as bool,
    );
  }
}