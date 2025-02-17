import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> completeTest(String testId, List<String> answers) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('user_answers').doc(user.email).set({
        'answers': answers,
        'completedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Test tamamlanırken hata oluştu: $e");
      throw e;
    }
  }
}
