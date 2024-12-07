import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComposeEmailScreen extends StatefulWidget {
  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _toController.dispose();
    _titleController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String recipient = _toController.text.trim();
      String title = _titleController.text.trim();
      String subject = _subjectController.text.trim();
      String body = _bodyController.text.trim();
      String? sender = FirebaseAuth.instance.currentUser?.email;

      try {
        // Add email to Firestore
        await FirebaseFirestore.instance.collection('emails').add({
          'sender': sender,
          'recipient': recipient,
          'title': title,
          'subject': subject,
          'body': body,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Navigate back and show success message
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sent successfully')),
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compose Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _toController,
                decoration: const InputDecoration(labelText: 'To'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a recipient email' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a subject' : null,
              ),
              Expanded(
                child: TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(labelText: 'Body'),
                  maxLines: null,
                  expands: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter the email body' : null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _sendEmail(context),
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


