import 'package:email_app/screens/change_password_screen.dart';
import 'package:email_app/screens/compose_email_screen.dart';
import 'package:email_app/screens/inbox_screen.dart';
import 'package:email_app/screens/reset_password_screen.dart';
import 'package:email_app/screens/settings_screen.dart';
import 'package:email_app/screens/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_app/screens/profile_screen.dart';  // Import Profile Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const EmailApp());
}

class EmailApp extends StatelessWidget {
  const EmailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/inbox': (context) => const InboxScreen(),
        '/compose': (context) => ComposeEmailScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/verify-code': (context) {
          final String verificationId =
          ModalRoute.of(context)!.settings.arguments as String;
          return VerifyCodeScreen(verificationId: verificationId);
        },
        '/profile': (context) => const ProfileScreen(),  // Added the Profile route
      },
    );
  }
}


