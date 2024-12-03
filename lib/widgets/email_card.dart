import 'package:flutter/material.dart';

class EmailCard extends StatelessWidget {
  final String subject;
  final String sender;

  EmailCard({required this.subject, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(subject),
        subtitle: Text(sender),
        trailing: Icon(Icons.star_border),
      ),
    );
  }
}
