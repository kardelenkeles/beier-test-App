import 'package:beier_app2/service/answer/answer_service.dart';
import 'package:flutter/material.dart';

class AnswerViewModel with ChangeNotifier {
  final AnswerService _answerService = AnswerService();
  List<Map<String, String>> _answers = [];
  bool _isLoading = false;

  List<Map<String, String>> get answers => _answers;

  bool get isLoading => _isLoading;

  void addOrUpdateAnswer(String question, String answer) {
    int existingIndex = _answers.indexWhere((e) => e['question'] == question);
    if (existingIndex != -1) {
      _answers[existingIndex]['answer'] = answer;
    } else {
      _answers.add({'question': question, 'answer': answer});
    }
    notifyListeners();
  }

  Future<void> completeTest(String testId) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<String> answers = _answers.map((e) => e['answer']!).toList();
      await _answerService.completeTest(testId, answers);

      _answers.clear();
    } catch (e) {
      print("Test tamamlanırken hata oluştu: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
