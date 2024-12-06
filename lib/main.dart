import 'package:email_application/screens/email/draft.dart';
import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/verify_phone.dart';
import 'screens/email/compose.dart';
import 'screens/email/inbox.dart';
import 'screens/email/sent.dart';
import 'screens/email/email_detail.dart';
import 'screens/email/search.dart';
import 'screens/email/label_management.dart';
import 'screens/settings/preferences.dart';
import 'screens/settings/auto_answer.dart';
import 'screens/settings/dark_mode.dart';
import 'screens/profile/profile.dart';
import 'screens/profile/profile_picture.dart';
import 'screens/notifications/new_email_notification.dart';
import 'screens/email/draft.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email Client App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/verify_phone': (context) => VerifyPhoneScreen(),
        '/compose': (context) => ComposeEmailScreen(),
        '/inbox': (context) => InboxScreen(),
        '/sent': (context) => SentEmailsScreen(),
        '/draft': (context) => DraftsScreen(),
        '/email_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return EmailDetailScreen(email: args);
          }
          // Fallback for missing or incorrect arguments
          return Scaffold(
            body: Center(child: Text('No email details provided!')),
          );
        },
        '/search': (context) => SearchScreen(),
        '/label_management': (context) => LabelManagementScreen(),
        '/preferences': (context) => PreferencesScreen(),
        '/auto_answer': (context) => AutoAnswerScreen(),
        '/dark_mode': (context) => DarkModeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/profile_picture': (context) => ProfilePictureScreen(),
        '/new_email_notification': (context) => NewEmailNotificationScreen(
              sender: 'Kevin Dai',
              subject: 'Welcome to our service',
            ),
      },
    );
  }
}
