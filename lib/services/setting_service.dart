import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save user settings
  Future<void> saveSettings(
      String userId, Map<String, dynamic> settings) async {
    try {
      await _firestore
          .collection('settings')
          .doc(userId)
          .set(settings, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch user settings
  Future<Map<String, dynamic>> fetchSettings(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('settings').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        // Return default settings if no settings are saved
        return {
          'notificationsEnabled': true,
          'darkMode': false,
          'autoAnswerEnabled': false,
          'autoAnswerMessage': '',
        };
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Enable or disable auto-answer
  Future<void> toggleAutoAnswer(String userId, bool isEnabled) async {
    try {
      await _firestore
          .collection('settings')
          .doc(userId)
          .update({'autoAnswerEnabled': isEnabled});
    } catch (e) {
      rethrow;
    }
  }

  /// Update the auto-answer message
  Future<void> updateAutoAnswerMessage(String userId, String message) async {
    try {
      await _firestore
          .collection('settings')
          .doc(userId)
          .update({'autoAnswerMessage': message});
    } catch (e) {
      rethrow;
    }
  }
}
