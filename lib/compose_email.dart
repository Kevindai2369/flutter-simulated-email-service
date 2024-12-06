import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComposeEmailScreen extends StatelessWidget {
  final TextEditingController toController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Compose Email")),
      body: Column(
        children: [
          TextField(
              controller: toController,
              decoration: InputDecoration(labelText: "To")),
          TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: "Subject")),
          TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: "Body")),
          ElevatedButton(
            onPressed: () async {
              final email = {
                "to": toController.text.trim(),
                "subject": subjectController.text.trim(),
                "body": bodyController.text.trim(),
                "timestamp": FieldValue.serverTimestamp(),
              };
              await FirebaseFirestore.instance.collection('emails').add(email);
              Navigator.pop(context);
            },
            child: Text("Send"),
          ),
        ],
      ),
    );
  }
}
