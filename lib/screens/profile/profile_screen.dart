import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadProfilePicture() async {
    if (_image == null) return;

    final userId = FirebaseAuth.instance.currentUser?.uid;
    final storageRef = FirebaseStorage.instance.ref().child("profiles/$userId.jpg");

    await storageRef.putFile(_image!);
    final downloadUrl = await storageRef.getDownloadURL();

    // Update the user's profile (you could also save it in Firestore)
    FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoURL = FirebaseAuth.instance.currentUser?.photoURL;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          if (photoURL != null) CircleAvatar(radius: 50, backgroundImage: NetworkImage(photoURL)),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Profile Picture'),
          ),
          ElevatedButton(
            onPressed: _uploadProfilePicture,
            child: Text('Upload Picture'),
          ),
        ],
      ),
    );
  }
}