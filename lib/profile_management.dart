import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String? _profilePictureUrl;
  bool _isLoading = false; // To track the loading state

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  // Fetch profile picture from Firestore
  Future<void> _loadProfilePicture() async {
    setState(() {
      _isLoading = true; // Show loading indicator while fetching data
    });
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc['profilePicture'] != null) {
        setState(() {
          _profilePictureUrl = doc['profilePicture'];
        });
      }
    } catch (e) {
      print("Error loading profile picture: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Failed to load profile picture. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator after data is fetched
      });
    }
  }

  // Pick and upload image to Firebase Storage
  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true; // Show loading indicator while uploading image
    });
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        // Upload to Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
        await ref.putFile(_image!);
        final url = await ref.getDownloadURL();

        // Update Firestore with new profile picture URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': url});

        setState(() {
          _profilePictureUrl = url; // Update state with new profile picture URL
        });
      }
    } catch (e) {
      print("Error picking image or uploading: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading =
            false; // Hide loading indicator after the upload is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          // Display loading indicator while loading profile picture
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else
            CircleAvatar(
              radius: 50,
              backgroundImage: _profilePictureUrl != null
                  ? NetworkImage(
                      _profilePictureUrl!) // Show image from URL if available
                  : _image != null
                      ? FileImage(_image!) // Show image from picker
                      : AssetImage('assets/default_profile.png')
                          as ImageProvider, // Default image if no profile picture
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Change Profile Picture"),
          ),
        ],
      ),
    );
  }
}
