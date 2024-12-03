import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/email_provider.dart';
import '../../widgets/email_card.dart';

class EmailListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmailSearchScreen(
                  emails: emailProvider.emails.map((e) => e.subject).toList(),
                ),
              );
            },
          ),
        ],
      ),
      body: emailProvider.emails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: emailProvider.emails.length,
              itemBuilder: (context, index) {
                final email = emailProvider.emails[index];
                return EmailCard(email: email);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/compose');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
