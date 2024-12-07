import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  ChangePasswordScreen({super.key});

  void changePassword(BuildContext context) async {
    String newPassword = newPasswordController.text.trim();

    if (newPassword.isNotEmpty) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await user.updatePassword(newPassword);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully.')),
          );

          Navigator.pushReplacementNamed(context, '/settings');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a new password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => changePassword(context),
                child: const Text('Update Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
