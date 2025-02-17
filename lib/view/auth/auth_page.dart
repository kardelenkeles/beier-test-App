import 'package:auto_route/annotations.dart';
import 'package:beier_app2/constants/app_constants.dart';
import 'package:beier_app2/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Lottie Animasyonu
                Lottie.asset(
                  _isLogin
                      ? AppConstants.loginAnimation
                      : AppConstants.registerAnimation,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  _isLogin
                      ? AppConstants.welcomeText
                      : AppConstants.registerText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppConstants.emailHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.emailEmptyError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppConstants.passwordHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.passwordEmptyError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_isLogin) {
                        context.read<AuthViewModel>().loginWithEmail(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                      } else {
                        context.read<AuthViewModel>().signUpWithEmail(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isLogin
                        ? AppConstants.loginButtonText
                        : AppConstants.registerButtonText,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? AppConstants.noAccountText
                        : AppConstants.haveAccountText,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.read<AuthViewModel>().signInAnonymously(context);
                  },
                  child: Text(
                    AppConstants.continueWithoutLogin,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
