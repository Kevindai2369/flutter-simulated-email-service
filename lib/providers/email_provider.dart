import 'package:flutter/material.dart';
import '../models/email_model.dart';

class EmailProvider with ChangeNotifier {
  List<EmailModel> _emails = [];

  List<EmailModel> get emails => _emails;

  void fetchEmails() {
    // Simulate fetching emails
    _emails = [
      EmailModel(
        id: '1',
        sender: 'john@example.com',
        recipient: 'you@example.com',
        subject: 'Meeting',
        body: 'Let’s discuss the project tomorrow.',
        timestamp: DateTime.now(),
      ),
    ];
    notifyListeners();
  }

  void markAsRead(String emailId) {
    _emails = _emails.map((email) {
      if (email.id == emailId) {
        return EmailModel(
          id: email.id,
          sender: email.sender,
          recipient: email.recipient,
          subject: email.subject,
          body: email.body,
          timestamp: email.timestamp,
          isRead: true,
        );
      }
      return email;
    }).toList();
    notifyListeners();
  }
}
