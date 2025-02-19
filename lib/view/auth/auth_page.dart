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

  static const Color primaryColor = Color(0xffBAE162);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          _isLogin ? AppConstants.welcomeText : AppConstants.registerText,
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
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(CupertinoIcons.mail),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: CupertinoColors.systemGrey),
                          ),
                        ),
                        SizedBox(height: 20),
                        CupertinoTextField(
                          controller: _passwordController,
                          placeholder: AppConstants.passwordHint,
                          obscureText: true,
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(CupertinoIcons.lock),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: CupertinoColors.systemGrey),
                          ),
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
                          color: _isLogin
                              ? CupertinoColors.activeBlue
                              : primaryColor,
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
                              color: CupertinoColors.white,
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
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: () {
                      context.read<AuthViewModel>().signInAnonymously(context);
                    },
                    child: Text(
                      AppConstants.continueWithoutLogin,
                      style: TextStyle(color: CupertinoColors.systemGrey),
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
