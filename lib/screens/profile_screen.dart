import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _picker = ImagePicker();
  String? _profileImageUrl;
  String _name = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile from Firestore and Firebase Storage
  void _fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _name = userDoc['name'] ?? user.displayName ?? '';
        _email = user.email ?? '';
        _profileImageUrl = userDoc['profileImageUrl'] ?? user.photoURL;
      });
    }
  }

  // Pick an image from the gallery and upload it to Firebase Storage
  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the selected image to Firebase Storage
      String fileName = 'profile_images/${FirebaseAuth.instance.currentUser?.uid}.jpg';
      try {
        final ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putFile(pickedFile.path as File);

        // Get the URL of the uploaded image
        String imageUrl = await ref.getDownloadURL();

        // Update Firestore with the new profile picture URL
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'profileImageUrl': imageUrl});
          setState(() {
            _profileImageUrl = imageUrl;
          });
        }
      } catch (e) {
        print("Failed to upload image: $e");
      }
    }
  }

  // Update user's name in Firestore
  Future<void> _updateUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Update Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'name': _name});
        // Update Firebase Authentication display name
        await user.updateDisplayName(_name);
        setState(() {});
      } catch (e) {
        print("Error updating name: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: GestureDetector(
                onTap: _pickAndUploadImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name Field
            TextField(
              controller: TextEditingController(text: _name),
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => _name = value,
            ),
            const SizedBox(height: 20),
            // Email Field
            TextField(
              controller: TextEditingController(text: _email),
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: false, // Disable email edit
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserName,
              child: const Text('Update Name'),
            ),
          ],
        ),
      ),
    );
  }
}
