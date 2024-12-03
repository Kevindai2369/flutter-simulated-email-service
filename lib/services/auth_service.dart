import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginWithPhone(String phone, String otp) async {
    // Implement OTP verification here
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
