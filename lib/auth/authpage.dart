import 'package:flutter/material.dart';
import 'package:loginassessment/screens/login_page.dart';
import 'package:loginassessment/screens/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // initially show login screen
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return RegisterScreen(
        showLoginScreen: toggleScreen,
      );
    } else {
      return LoginScreen(
        showRegister: toggleScreen,
      );
    }
  }
}
