class Email {
  final String id;
  final String sender;
  final List<String> recipients;
  final String subject;
  final String body;
  final DateTime timestamp;
  final bool isRead;
  final List<String> attachments;

  Email({
    required this.id,
    required this.sender,
    required this.recipients,
    required this.subject,
    required this.body,
    required this.timestamp,
    required this.isRead,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'recipients': recipients,
      'subject': subject,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'attachments': attachments,
    };
  }

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      sender: json['sender'],
      recipients: List<String>.from(json['recipients']),
      subject: json['subject'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
      attachments: List<String>.from(json['attachments']),
    );
  }
}
