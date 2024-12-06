import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailDetailScreen extends StatelessWidget {
  final String emailId;

  EmailDetailScreen({required this.emailId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Details")),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('emails').doc(emailId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final email = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('From: ${email['from']}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('To: ${email['to']}'),
                if (email['cc'] != null) Text('CC: ${email['cc']}'),
                SizedBox(height: 16),
                Text('Subject: ${email['subject']}',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text(email['body']),
                SizedBox(height: 16),
                if (email['attachment'] != null)
                  TextButton(
                    onPressed: () {
                      // Code to download attachment
                    },
                    child: Text('Download Attachment'),
                  ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.reply),
                      onPressed: () {
                        // Navigate to compose email for reply
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.forward),
                      onPressed: () {
                        // Navigate to compose email for forward
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('emails')
                            .doc(emailId)
                            .update({'status': 'trash'});
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
