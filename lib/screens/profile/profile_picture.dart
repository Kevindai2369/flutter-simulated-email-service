import 'package:flutter/material.dart';

class ProfilePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile Picture')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder for selecting a new picture
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Profile picture update coming soon!')),
                );
              },
              child: Text('Choose New Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
