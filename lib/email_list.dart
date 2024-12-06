import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailListScreen extends StatelessWidget {
  final String folder; // e.g., "Inbox", "Sent", "Trash"

  EmailListScreen({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(folder)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emails')
            .where('status',
                isEqualTo: folder.toLowerCase()) // Filter emails by folder
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final emails = snapshot.data!.docs;

          if (emails.isEmpty) {
            return Center(child: Text('No emails in $folder'));
          }

          return ListView.builder(
            itemCount: emails.length,
            itemBuilder: (context, index) {
              final email = emails[index].data() as Map<String, dynamic>;
              return ListTile(
                leading:
                    Icon(email['starred'] ? Icons.star : Icons.star_border),
                title: Text(email['subject']),
                subtitle: Text(email['body']),
                trailing:
                    Text(email['timestamp'].toDate().toString().split(' ')[0]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EmailDetailScreen(emailId: emails[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
