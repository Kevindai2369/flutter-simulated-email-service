import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String verificationId;

  VerifyCodeScreen({super.key, required this.verificationId});

  final TextEditingController codeController = TextEditingController();

  void verifyCode(BuildContext context) async {
    try {
      String smsCode = codeController.text.trim();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Sign in or link the user with the phone number
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

      // If successful, update the 2FA status in Firestore
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isTwoStepVerificationEnabled': true});

      // Navigate back to settings
      Navigator.pushReplacementNamed(context, '/settings');
    } catch (e) {
      print("Error verifying code: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid verification code. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter the verification code sent to your phone:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => verifyCode(context),
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
