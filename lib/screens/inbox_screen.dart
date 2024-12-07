import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_app/widgets/email_list_items.dart';
import 'email_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  bool isTwoStepVerificationEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchTwoStepVerificationForInbox();
  }

  // Fetch Two-step Verification status
  void fetchTwoStepVerificationForInbox() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      setState(() {
        isTwoStepVerificationEnabled =
            userDoc['isTwoStepVerificationEnabled'] ?? false;
      });
    }
  }

  Future<List<Map<String, String>>> fetchEmails() async {
    final List<Map<String, String>> emails = [];
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('emails').get();

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      emails.add({
        'title': data['title'] ?? 'No Title',
        'sender': data['sender'] ?? 'Unknown Sender',
        'snippet': data['snippet'] ?? '',
        'body': data['body'] ?? '',
      });
    }
    return emails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchEmails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching emails.'));
          }

          final emails = snapshot.data ?? [];

          if (emails.isEmpty) {
            return const Center(child: Text('No emails found.'));
          }

          return ListView.builder(
            itemCount: emails.length,
            itemBuilder: (context, index) {
              return EmailListItem(
                title: emails[index]['title']!,
                sender: emails[index]['sender']!,
                snippet: emails[index]['snippet']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailDetailsScreen(
                        title: emails[index]['title']!,
                        sender: emails[index]['sender']!,
                        body: emails[index]['body']!,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/compose');
        },
      ),
    );
  }
}


