import 'package:flutter/material.dart';

class EmailListItem extends StatelessWidget {
  final String title;
  final String sender;
  final String snippet;
  final VoidCallback onTap;

  const EmailListItem({super.key,
    required this.title,
    required this.sender,
    required this.snippet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$sender - $snippet'),
      onTap: onTap,
    );
  }
}