class Draft {
  final String id;
  final String subject;
  final String body;
  final List<String> recipients;

  Draft({
    required this.id,
    required this.subject,
    required this.body,
    required this.recipients,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'body': body,
      'recipients': recipients,
    };
  }

  factory Draft.fromJson(Map<String, dynamic> json) {
    return Draft(
      id: json['id'],
      subject: json['subject'],
      body: json['body'],
      recipients: List<String>.from(json['recipients']),
    );
  }
}
