import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/email/email_list_screen.dart';
import 'screens/email/compose_email_screen.dart';
import 'screens/profile/profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginScreen(),
  '/emails': (context) => EmailListScreen(),
  '/compose': (context) => ComposeEmailScreen(),
  '/profile': (context) => ProfileScreen(),
};