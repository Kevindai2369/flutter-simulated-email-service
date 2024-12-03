import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../models/email_model.dart';
import '../../services/email_service.dart';

class ComposeEmailScreen extends StatefulWidget {
  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  final TextEditingController toController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  quill.QuillController _quillController = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compose Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: toController,
              decoration: InputDecoration(labelText: 'To'),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            Expanded(
              child: quill.QuillEditor.basic(
                controller: _quillController,
                readOnly: false,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final body = _quillController.document.toPlainText();
                final email = EmailModel(
                  id: '', // Firestore will generate the ID
                  sender: 'you@example.com', // Replace with user's email
                  recipient: toController.text,
                  subject: subjectController.text,
                  body: body,
                  timestamp: DateTime.now(),
                );
                await EmailService().sendEmail(email);
                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
