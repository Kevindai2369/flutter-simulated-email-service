import 'package:flutter/material.dart';

class EmailEditor extends StatelessWidget {
  final TextEditingController subjectController;
  final TextEditingController bodyController;

  const EmailEditor({
    required this.subjectController,
    required this.bodyController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: subjectController,
          decoration: InputDecoration(
            labelText: 'Subject',
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TextField(
            controller: bodyController,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Email Body',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
