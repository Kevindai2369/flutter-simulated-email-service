import 'package:flutter/material.dart';

class EmailDetailScreen extends StatelessWidget {
  final Map<String, dynamic> email;

  const EmailDetailScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email['subject'] ?? 'Email Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${email['sender']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Subject: ${email['subject']}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(email['body'] ?? 'No content', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
