import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/email.dart';

class EmailService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendEmail(Email email) async {
    try {
      await _firestore.collection('emails').doc(email.id).set(email.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Email>> fetchInbox(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('emails')
          .where('recipients', arrayContains: userId)
          .get();

      return snapshot.docs
          .map((doc) => Email.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
