import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LabelManagementScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<void> _addLabel(BuildContext context) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final TextEditingController labelController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Label'),
        content: TextField(
          controller: labelController,
          decoration: InputDecoration(hintText: 'Enter label name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (labelController.text.trim().isNotEmpty) {
                await FirebaseFirestore.instance.collection('labels').add(
                    {'name': labelController.text.trim(), 'user': user.email});
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteLabel(String labelId) async {
    await FirebaseFirestore.instance.collection('labels').doc(labelId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Labels'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addLabel(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('labels')
            .where('user', isEqualTo: user?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final labels = snapshot.data?.docs ?? [];

          if (labels.isEmpty) {
            return Center(child: Text('No labels found.'));
          }

          return ListView.builder(
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final label = labels[index];
              return ListTile(
                title: Text(label['name']),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteLabel(label.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
