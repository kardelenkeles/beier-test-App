import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getQuestions() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('beier-test').doc('test').get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          List<dynamic> questionList = data['questions'];
          return questionList.cast<String>();
        }
      }
      return [];
    } catch (e) {
      print("Sorular getirilirken bir hata oluştu: $e");
      return [];
    }
  }
}
