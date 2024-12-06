import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: John Doe', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: john.doe@example.com', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile_picture');
              },
              child: Text('Update Profile Picture'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Placeholder for editing profile
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Edit Profile functionality coming soon!')),
                );
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
