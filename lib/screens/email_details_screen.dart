import 'package:flutter/material.dart';

class EmailDetailsScreen extends StatelessWidget {
  final String title;
  final String sender;
  final String body;

  const EmailDetailsScreen({super.key,
    required this.title,
    required this.sender,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: $sender', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(body),
          ],
        ),
      ),
    );
  }
}