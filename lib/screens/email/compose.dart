import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComposeEmailScreen extends StatefulWidget {
  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _sendEmail() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in!");

      await FirebaseFirestore.instance.collection('emails').add({
        'from': user.email,
        'to': _recipientController.text.trim(),
        'subject': _subjectController.text.trim(),
        'body': _bodyController.text.trim(),
        'timestamp': Timestamp.now(),
        'isRead': false,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email sent!')));
      Navigator.pop(context); // Go back to the inbox screen
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compose Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(labelText: 'To'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            Expanded(
              child: TextField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: _sendEmail,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
