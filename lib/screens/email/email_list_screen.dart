import 'package:flutter/material.dart';

class EmailListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emails")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Email Subject $index"),
            subtitle: Text("Sender $index"),
            onTap: () {
              // Navigate to email details
            },
          );
        },
      ),
    );
  }
}
