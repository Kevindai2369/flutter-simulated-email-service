//Registration
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone Number"),
          ),
          ElevatedButton(
            onPressed: () async {
              final phone = phoneController.text.trim();
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phone,
                verificationCompleted: (PhoneAuthCredential credential) async {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                },
                verificationFailed: (e) => print(e.message),
                codeSent: (String verificationId, int? resendToken) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OTPVerificationScreen(verificationId),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}

class OTPVerificationScreen extends StatelessWidget {
  final String verificationId;
  final TextEditingController otpController = TextEditingController();

  OTPVerificationScreen(this.verificationId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Column(
        children: [
          TextField(
            controller: otpController,
            decoration: InputDecoration(labelText: "Enter OTP"),
          ),
          ElevatedButton(
            onPressed: () async {
              final smsCode = otpController.text.trim();
              final credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);
              await FirebaseAuth.instance.signInWithCredential(credential);
              Navigator.pop(context);
            },
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }
}
