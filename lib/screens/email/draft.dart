import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DraftsScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> _getDraftsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.empty();

    return FirebaseFirestore.instance
        .collection('drafts')
        .where('owner', isEqualTo: user.email)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drafts')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getDraftsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final drafts = snapshot.data?.docs ?? [];

          if (drafts.isEmpty) {
            return Center(child: Text('No drafts found.'));
          }

          return ListView.builder(
            itemCount: drafts.length,
            itemBuilder: (context, index) {
              final draft = drafts[index];
              return ListTile(
                title: Text(draft['subject'] ?? 'No Subject'),
                subtitle: Text(draft['owner']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/compose',
                    arguments: draft,
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
