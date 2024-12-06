import 'package:flutter/material.dart';

class EmailCard extends StatelessWidget {
  final String sender;
  final String subject;
  final String snippet;
  final VoidCallback onTap;

  const EmailCard({
    required this.sender,
    required this.subject,
    required this.snippet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(subject, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(snippet, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: CircleAvatar(child: Text(sender[0])),
        onTap: onTap,
      ),
    );
  }
}
