import 'package:flutter/material.dart';

class NewEmailNotificationScreen extends StatelessWidget {
  final String sender;
  final String subject;

  const NewEmailNotificationScreen({
    required this.sender,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Email Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Email Received!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('From: $sender', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Subject: $subject', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('View Email'),
            ),
          ],
        ),
      ),
    );
  }
}
