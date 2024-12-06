import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> _results = [];

  void _searchEmails(String query) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final inbox = await FirebaseFirestore.instance
        .collection('emails')
        .where('to', isEqualTo: user.email)
        .get();

    final matches = inbox.docs
        .where((doc) =>
            (doc['subject']?.toString().toLowerCase() ?? '')
                .contains(query.toLowerCase()) ||
            (doc['body']?.toString().toLowerCase() ?? '')
                .contains(query.toLowerCase()))
        .toList();

    setState(() {
      _results = matches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search emails...',
            border: InputBorder.none,
          ),
          onChanged: _searchEmails,
        ),
      ),
      body: _results.isEmpty
          ? Center(child: Text('No results found.'))
          : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final email = _results[index];
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
            ),
    );
  }
}
