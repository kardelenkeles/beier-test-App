import 'package:auto_route/auto_route.dart';
import 'package:beier_app2/config/router/auto_router.gr.dart';
import 'package:beier_app2/model/user_model.dart';
import 'package:beier_app2/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isAnonymous = false;

  UserModel? get user => _user;

  bool get isAnonymous => _isAnonymous;

  AuthViewModel() {
    _checkAuthStatus();
  }

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserModel user = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = user;
      _isAnonymous = false;
      notifyListeners();
      context.router.replace(const HomePage());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserModel user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = user;
      _isAnonymous = false;
      notifyListeners();
      context.router.replace(const HomePage());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInAnonymously(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      _user = UserModel(uid: userCredential.user!.uid, email: "anonymous");
      _isAnonymous = true;
      notifyListeners();
      context.router.replace(const HomePage());
    } catch (e) {
      print("Anonim giriş başarısız: $e");
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _isAnonymous = false;
    notifyListeners();
  }

  Future<void> _checkAuthStatus() async {
    User? user = _authService.currentUser();
    if (user != null) {
      _user = UserModel(uid: user.uid, email: user.email ?? "anonymous");
      _isAnonymous = user.isAnonymous;
      notifyListeners();
    }
  }
}
