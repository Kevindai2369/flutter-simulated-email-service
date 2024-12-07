import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isTwoStepVerificationEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchTwoStepVerificationStatus();
  }

  // Fetch the initial status from Firestore
  void fetchTwoStepVerificationStatus() async {
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

  void toggleTwoStepVerification(bool value) async {
    if (value) {
      await enableTwoStepVerification();
    } else {
      await disableTwoStepVerification();
    }

    setState(() {
      isTwoStepVerificationEnabled = value;
    });
  }

  Future<void> enableTwoStepVerification() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: '+11234567890', // Replace with user's actual phone
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically link credential
          await auth.currentUser?.linkWithCredential(credential);
          print("Verification completed automatically");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(
            context,
            '/verify-code',
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto-retrieval timeout");
        },
      );

      // Update Firestore to enable 2FA
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'isTwoStepVerificationEnabled': true});
      }
    } catch (e) {
      print("Error enabling Two-step Verification: $e");
    }
  }

  Future<void> disableTwoStepVerification() async {
    try {
      // Update Firestore to disable 2FA
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'isTwoStepVerificationEnabled': false});
      }
    } catch (e) {
      print("Error disabling Two-step Verification: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Change Password'),
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
            ),
            // New Profile management button
            ListTile(
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');  // Navigate to Profile screen
              },
            ),
            SwitchListTile(
              title: const Text('Two-step Verification'),
              value: isTwoStepVerificationEnabled,
              onChanged: (value) => toggleTwoStepVerification(value),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





