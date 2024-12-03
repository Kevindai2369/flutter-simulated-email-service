import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoggedIn = false;

  Future<void> loginWithPhone(String phone, Function(String) onCodeSent) async {
    await _authService.loginWithPhone(phone, onCodeSent);
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    await _authService.verifyOtp(verificationId, otp);
    isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}
