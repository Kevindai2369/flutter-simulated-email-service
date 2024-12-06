import 'package:flutter/material.dart';

class AutoAnswerScreen extends StatefulWidget {
  @override
  _AutoAnswerScreenState createState() => _AutoAnswerScreenState();
}

class _AutoAnswerScreenState extends State<AutoAnswerScreen> {
  bool _autoAnswerEnabled = false;
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto Answer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Enable Auto Answer'),
              value: _autoAnswerEnabled,
              onChanged: (value) {
                setState(() {
                  _autoAnswerEnabled = value;
                });
              },
            ),
            if (_autoAnswerEnabled)
              TextField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Auto Reply Message'),
                maxLines: 4,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save auto-answer settings (placeholder)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Auto-answer settings saved!')),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
