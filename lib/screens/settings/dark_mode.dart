import 'package:flutter/material.dart';

class DarkModeScreen extends StatefulWidget {
  @override
  _DarkModeScreenState createState() => _DarkModeScreenState();
}

class _DarkModeScreenState extends State<DarkModeScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dark Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SwitchListTile(
          title: Text('Enable Dark Mode'),
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
              // Apply dark mode theme (placeholder logic)
            });
          },
        ),
      ),
    );
  }
}
