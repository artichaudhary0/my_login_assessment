import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController _resetpasswordController =
      TextEditingController();

  @override
  void dispose() {
    _resetpasswordController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _resetpasswordController.text.trim(),
      );
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                "Password reset link sent! Check your email",
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      log(
        e.code.toString(),
      );
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.code.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        elevation: 0,
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Enter your E-mail and we will send you a password reset link",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _resetpasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Enter your Password",
                      label: const Text(
                        "Password",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: resetPassword,
                  color: Colors.deepPurple.shade200,
                  child: const Text(
                    "Reset Password",
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
