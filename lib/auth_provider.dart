import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> loginWithPhone(String phoneNumber, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? 'Login failed.'),
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, '/otp', arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    if (_user != null) {
      await _user!.updateDisplayName(displayName);
      await _user!.updatePhotoURL(photoUrl);
      await _user!.reload();
      _user = _auth.currentUser;
      notifyListeners();
    }
  }
}
