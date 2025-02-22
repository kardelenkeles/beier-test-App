import 'package:auto_route/annotations.dart';
import 'package:beier_app2/constants/app_constants.dart';
import 'package:beier_app2/view/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isLoading = false;

  // Renk paleti
  static const Color primaryColor = Color(0xFFE94F37); // Turuncu-kırmızı
  static const Color backgroundColor = Color(0xFFF6F7EB); // Açık renk
  static const Color textColor = Color(0xFF393E41); // Koyu gri

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor, // Arka plan rengi
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor, // AppBar arka plan rengi
        middle: Text(
          _isLogin ? AppConstants.welcomeText : AppConstants.registerText,
          style: TextStyle(color: backgroundColor), // Metin rengi
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (widget, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: widget,
                        ),
                      );
                    },
                    child: Column(
                      key: ValueKey(_isLogin),
                      children: [
                        CupertinoTextField(
                          controller: _emailController,
                          placeholder: AppConstants.emailHint,
                          placeholderStyle: TextStyle(color: textColor.withOpacity(0.5)),
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(CupertinoIcons.mail, color: textColor),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: textColor.withOpacity(0.3)),
                          ),
                          style: TextStyle(color: textColor),
                        ),
                        SizedBox(height: 20),
                        CupertinoTextField(
                          controller: _passwordController,
                          placeholder: AppConstants.passwordHint,
                          placeholderStyle: TextStyle(color: textColor.withOpacity(0.5)),
                          obscureText: true,
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(CupertinoIcons.lock, color: textColor),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: textColor.withOpacity(0.3)),
                          ),
                          style: TextStyle(color: textColor),
                        ),
                        SizedBox(height: 20),
                        _isLoading
                            ? Lottie.asset(
                          _isLogin
                              ? AppConstants.loginAnimation
                              : AppConstants.registerAnimation,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : CupertinoButton(
                          color: primaryColor, // Buton rengi
                          borderRadius: BorderRadius.circular(10),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              await Future.delayed(Duration(seconds: 2));

                              if (_isLogin) {
                                await context.read<AuthViewModel>().loginWithEmail(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context,
                                );
                              } else {
                                await context.read<AuthViewModel>().signUpWithEmail(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context,
                                );
                              }

                              await Future.delayed(Duration(seconds: 1));

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Text(
                            _isLogin
                                ? AppConstants.loginButtonText
                                : AppConstants.registerButtonText,
                            style: TextStyle(
                              fontSize: 18,
                              color: backgroundColor, // Buton metin rengi
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? AppConstants.noAccountText
                          : AppConstants.haveAccountText,
                      style: TextStyle(color: primaryColor), // Metin rengi
                    ),
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: () {
                      context.read<AuthViewModel>().signInAnonymously(context);
                    },
                    child: Text(
                      AppConstants.continueWithoutLogin,
                      style: TextStyle(color: textColor), // Metin rengi
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}