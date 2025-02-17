import 'package:beier_app2/service/question/question_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class QuestionViewModel with ChangeNotifier {
  final QuestionService _questionService = QuestionService();
  List<String> _questions = [];
  int _currentQuestionIndex = 0;
  String _userAnswer = "";

  List<String> get questions => _questions;

  String get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : "";

  String get userAnswer => _userAnswer;

  int get currentQuestionIndex => _currentQuestionIndex;

  QuestionViewModel() {
    loadQuestions();
    listenForPermissions();
  }

  Future<void> loadQuestions() async {
    try {
      _questions = await _questionService.getQuestions();
      notifyListeners();
    } catch (e) {
      print("Sorular yüklenirken hata oluştu: $e");
    }
  }

  void updateUserAnswer(String answer) {
    _userAnswer = answer;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _userAnswer = "";
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _userAnswer = "";
      notifyListeners();
    }
  }

  Future<void> listenForPermissions() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      await Permission.microphone.request();
    }
  }
}
