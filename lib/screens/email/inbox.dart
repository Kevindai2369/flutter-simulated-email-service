import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InboxScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> _getInboxStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.empty();

    return FirebaseFirestore.instance
        .collection('emails')
        .where('to', isEqualTo: user.email)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getInboxStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final emails = snapshot.data?.docs ?? [];

          if (emails.isEmpty) {
            return Center(child: Text('No emails found.'));
          }

          return ListView.builder(
            itemCount: emails.length,
            itemBuilder: (context, index) {
              final email = emails[index];
              return ListTile(
                title: Text(email['subject']),
                subtitle: Text(email['from']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/email_detail',
                    arguments: email,
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
