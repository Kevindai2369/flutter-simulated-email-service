import 'package:flutter/material.dart';
import '../models/email_model.dart';

class EmailCard extends StatelessWidget {
  final EmailModel email;

  const EmailCard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(email.subject),
        subtitle: Text(email.sender),
        trailing: email.isRead ? null : Icon(Icons.mark_email_unread),
        onTap: () {
          // Navigate to email details
        },
      ),
    );
  }
}

