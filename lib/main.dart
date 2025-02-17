
import 'package:beier_app2/view/answer/answer_viewmodel.dart';
import 'package:beier_app2/view/auth/auth_page.dart';
import 'package:beier_app2/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:beier_app2/view/download/viewmodel/download_viewmodel.dart';
import 'package:beier_app2/view/home/home_page.dart';
import 'package:beier_app2/view/questions/viewmodel/question_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => QuestionViewModel()),
        ChangeNotifierProvider(create: (context) => AnswerViewModel()),
        ChangeNotifierProvider(create: (context) => DownloadViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beier App',
      home: AuthListener(),
    );
  }
}

class AuthListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthViewModel>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null ? HomePage() : AuthPage();
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
