import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/email_model.dart';

class EmailService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<EmailModel>> fetchEmails() async {
    final snapshot = await _db.collection('emails').get();
    return snapshot.docs.map((doc) => EmailModel.fromJson(doc.data())).toList();
  }

  Future<void> sendEmail(EmailModel email) async {
    await _db.collection('emails').add(email.toJson());
  }

  Future<void> deleteEmail(String emailId) async {
    await _db.collection('emails').doc(emailId).delete();
  }
}
