import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'email_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulated Email App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthProvider(),
        '/home': (context) => HomeScreen(),
        '/compose': (context) => ComposeEmailScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class AuthProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return RegisterScreen();
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/compose');
            },
            child: Text('Compose Email'),
          ),
          Expanded(
            child: EmailListScreen(folder: 'Inbox'),
          ),
        ],
      ),
    );
  }
}

class ComposeEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compose Email')),
      body: ComposeEmailForm(),
    );
  }
}

class ComposeEmailForm extends StatefulWidget {
  @override
  _ComposeEmailFormState createState() => _ComposeEmailFormState();
}

class _ComposeEmailFormState extends State<ComposeEmailForm> {
  final TextEditingController toController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  String? attachmentUrl;

  Future<void> _sendEmail() async {
    final emailData = {
      'to': toController.text,
      'subject': subjectController.text,
      'body': bodyController.text,
      'attachment': attachmentUrl,
      'timestamp': Timestamp.now(),
      'status': 'inbox', // Default status: inbox
    };

    await FirebaseFirestore.instance.collection('emails').add(emailData);
    Navigator.pop(context); // Close the compose screen after sending
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
              controller: toController,
              decoration: InputDecoration(labelText: 'To')),
          TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject')),
          TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body')),
          ElevatedButton(
            onPressed: _sendEmail,
            child: Text('Send Email'),
          ),
        ],
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call your phone authentication or registration method
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Text('Register'),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Perform logout
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
