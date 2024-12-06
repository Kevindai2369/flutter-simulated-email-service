import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isTwoStepEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Handle case where 'twoStepEnabled' field might not be present or is null
      setState(() {
        isTwoStepEnabled = doc.exists && doc.data() != null
            ? doc['twoStepEnabled'] ?? false
            : false;
      });
    } catch (e) {
      print("Error loading settings: $e");
      // In case of error, default to false
      setState(() {
        isTwoStepEnabled = false;
      });
    }
  }

  Future<void> _toggleTwoStep(bool value) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'twoStepEnabled': value});

      setState(() {
        isTwoStepEnabled = value;
      });
    } catch (e) {
      print("Error updating settings: $e");
      // Handle error (show a Snackbar, or revert the switch)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Two-Step Verification'),
              trailing: Switch(
                value: isTwoStepEnabled,
                onChanged: _toggleTwoStep,
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to ProfileManagementScreen or create it
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileManagementScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is just a placeholder for Profile Management screen.
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Center(
        child: Text('Profile management screen coming soon!'),
      ),
    );
  }
}
