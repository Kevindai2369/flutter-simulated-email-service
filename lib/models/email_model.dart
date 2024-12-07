// email_model.dart
class Email {
  final String id;
  final String sender;
  final String recipient;
  final String subject;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  Email({
    required this.id,
    required this.sender,
    required this.recipient,
    required this.subject,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  factory Email.fromMap(Map<String, dynamic> data, String id) {
    return Email(
      id: id,
      sender: data['sender'] ?? '',
      recipient: data['recipient'] ?? '',
      subject: data['subject'] ?? '',
      body: data['body'] ?? '',
      timestamp: DateTime.parse(data['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'recipient': recipient,
      'subject': subject,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }
}