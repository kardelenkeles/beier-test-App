import 'package:auto_route/annotations.dart';
import 'package:beier_app2/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:beier_app2/view/questions/question_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthViewModel>().signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionPage()),
              );
            },
            child: Text("Testi Başlat"),
          ),
        ],
      ),
    );
  }
}
