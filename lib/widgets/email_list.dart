import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_app/widgets/email_list_items.dart';
import 'package:email_app/screens/email_details_screen.dart';

class EmailList extends StatelessWidget {
  final String userId;

  const EmailList({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('emails')
          .where('recipient', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No emails found.'));
        }

        final emails = snapshot.data!.docs;

        return ListView.builder(
          itemCount: emails.length,
          itemBuilder: (context, index) {
            final email = emails[index].data() as Map<String, dynamic>;

            return EmailListItem(
              title: email['subject'] ?? 'No Subject',
              sender: email['sender'] ?? 'Unknown Sender',
              snippet: email['body']?.substring(0, 50) ?? 'No Content',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailDetailsScreen(
                      title: email['subject'] ?? 'No Subject',
                      sender: email['sender'] ?? 'Unknown Sender',
                      body: email['body'] ?? 'No Content',
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

