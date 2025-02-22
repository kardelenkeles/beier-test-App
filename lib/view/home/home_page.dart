import 'package:auto_route/annotations.dart';
import 'package:beier_app2/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:beier_app2/view/questions/question_page.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Color(0xFFF6F7EB),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF393E41),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFF6F7EB)),
            onPressed: () {
              context.read<AuthViewModel>().signOut();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Color(0xFFF6F7EB),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionPage()),
                  );
                },
                buttonText: "Testi Başlat",
              ),
              SizedBox(height: 20),
              Text(
                "Hoş Geldiniz!",
                style: TextStyle(
                  color: Color(0xFF393E41),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Teste başlamak için lütfen butona tıklayın.",
                style: TextStyle(
                  color: Color(0xFF393E41),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const AnimatedButton({
    required this.onPressed,
    required this.buttonText,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _isPressed = true;
          _scale = 0.90;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _isPressed = false;
          _scale = 1.0;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
          _scale = 1.0;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          decoration: BoxDecoration(
            color: _isPressed ? Color(0xFFC23A22) : Color(0xFFE94F37), // Darker shade when pressed
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: Color(0xFFF6F7EB),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}