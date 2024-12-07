import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add email
  Future<void> addEmail(String subject, String body, String sender, String recipient) async {
    try {
      await _firestore.collection('emails').add({
        'subject': subject,
        'body': body,
        'sender': sender,
        'recipient': recipient,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add email: $e');
    }
  }

  // Fetch emails
  Stream<QuerySnapshot> getEmails() {
    return _firestore.collection('emails').orderBy('timestamp', descending: true).snapshots();
  }

  // Update email
  Future<void> updateEmail(String docId, String newSubject) async {
    try {
      await _firestore.collection('emails').doc(docId).update({'subject': newSubject});
    } catch (e) {
      throw Exception('Failed to update email: $e');
    }
  }

  // Delete email
  Future<void> deleteEmail(String docId) async {
    try {
      await _firestore.collection('emails').doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete email: $e');
    }
  }
}
