import 'package:flutter/material.dart';
import '../services/email_service.dart';
import '../models/email_model.dart';

class EmailProvider with ChangeNotifier {
  final EmailService _emailService = EmailService();
  List<EmailModel> _emails = [];

  List<EmailModel> get emails => _emails;

  Future<void> fetchEmails() async {
    _emails = await _emailService.fetchEmails();
    notifyListeners();
  }

  Future<void> deleteEmail(String emailId) async {
    await _emailService.deleteEmail(emailId);
    _emails.removeWhere((email) => email.id == emailId);
    notifyListeners();
  }
}