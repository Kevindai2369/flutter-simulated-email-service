class EmailModel {
  final String id;
  final String sender;
  final String recipient;
  final String subject;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  EmailModel({
    required this.id,
    required this.sender,
    required this.recipient,
    required this.subject,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      id: json['id'],
      sender: json['sender'],
      recipient: json['recipient'],
      subject: json['subject'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'recipient': recipient,
        'subject': subject,
        'body': body,
        'timestamp': timestamp.toIso8601String(),
        'isRead': isRead,
      };
}
