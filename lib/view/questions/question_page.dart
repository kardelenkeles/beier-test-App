import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:beier_app2/view/answer/answer_viewmodel.dart';
import 'package:beier_app2/view/download/download_page.dart';
import 'package:beier_app2/view/questions/viewmodel/question_viewmodel.dart';
import 'package:beier_app2/widget/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isTestCompleted = false;
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isTextFieldFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionViewModel = context.watch<QuestionViewModel>();
    final answerViewModel = context.watch<AnswerViewModel>();

    bool isFirstQuestion = questionViewModel.currentQuestionIndex == 0;
    bool isLastQuestion = questionViewModel.currentQuestionIndex ==
        questionViewModel.questions.length - 1;

    if (_textController.text.isEmpty) {
      final currentQuestion = questionViewModel.currentQuestion;
      final userAnswer = answerViewModel.answers.firstWhere(
            (answer) => answer['question'] == currentQuestion,
        orElse: () => {},
      );
      if (userAnswer.isNotEmpty) {
        _textController.text = userAnswer['answer']!;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Soru Cevap")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Notebook_BlankPages_Page_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_isTextFieldFocused)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    switchInCurve: Curves.elasticOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      questionViewModel.currentQuestion.isNotEmpty
                          ? questionViewModel.currentQuestion
                          : "Yükleniyor...",
                      key: ValueKey(questionViewModel.currentQuestion),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),



                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: _isTextFieldFocused
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          labelText: "Cevabınızı yazın",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          answerViewModel.addOrUpdateAnswer(
                            questionViewModel.currentQuestion,
                            value,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SpeechToTextWidget(
                    onResult: (String recognizedText) {
                      _textController.text = recognizedText;
                      answerViewModel.addOrUpdateAnswer(
                        questionViewModel.currentQuestion,
                        recognizedText,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!isFirstQuestion)
                        ElevatedButton(
                          onPressed: () {
                            answerViewModel.addOrUpdateAnswer(
                              questionViewModel.currentQuestion,
                              _textController.text,
                            );
                            questionViewModel.previousQuestion();
                            _textController.clear();
                          },
                          child: Text("Önceki Soru"),
                        ),
                      if (!isLastQuestion)
                        ElevatedButton(
                          onPressed: () {
                            answerViewModel.addOrUpdateAnswer(
                              questionViewModel.currentQuestion,
                              _textController.text,
                            );
                            questionViewModel.nextQuestion();
                            _textController.clear();
                          },
                          child: Text("Sonraki Soru"),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (_isTestCompleted)
                    Text(
                      "Cevaplar gönderildi!",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  else if (isLastQuestion)
                    ElevatedButton(
                      onPressed: () async {
                        answerViewModel.addOrUpdateAnswer(
                          questionViewModel.currentQuestion,
                          _textController.text,
                        );
                        await answerViewModel.completeTest('test1');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DownloadPage()),
                        );
                        setState(() {
                          _isTestCompleted = true;
                        });
                      },
                      child: Text("Testi Bitir"),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
