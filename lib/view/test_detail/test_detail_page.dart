import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TestDetailPage extends StatelessWidget {
  final String testName;

  TestDetailPage({required this.testName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(testName)),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Soru $index"),
            subtitle: Text("Cevap $index"),
          );
        },
      ),
    );
  }
}
