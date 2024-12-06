import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/label.dart';

class LabelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createLabel(Label label) async {
    await _firestore.collection('labels').doc(label.id).set(label.toJson());
  }

  Future<List<Label>> fetchLabels(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('labels')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => Label.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
