import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginassessment/screens/forgotpassword_screen.dart';
import 'package:loginassessment/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/resuable_button.dart';
import '../widgets/resuable_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.showRegister}) : super(key: key);
  final VoidCallback showRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // signin controller
    final TextEditingController loginemailController = TextEditingController();
    final TextEditingController loginpasswordController =
        TextEditingController();

// create account and sign in

// login user
    Future<void> signIn() async {
      String email = loginemailController.text.trim();
      String password = loginpasswordController.text.trim();
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (UserCredential != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("userID", user.user!.uid);
        print(user.user!.uid);
        // ignore: use_build_context_synchronously
        Navigator.popUntil(context, (route) => route.isFirst);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {}
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.person_crop_circle_badge_checkmark,
                  size: 100,
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text(
                  "Hello Again!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome back, Please fill following details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                // for email

                ResuableTextField(
                  obsecure: false,
                  controller: loginemailController,
                  lableText: "E-mail",
                  hintText: "Enter your E-mail",
                ),

                const SizedBox(
                  height: 10,
                ),
                ResuableTextField(
                  obsecure: true,
                  controller: loginpasswordController,
                  lableText: "Password",
                  hintText: "Enter your Password",
                ),

                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotpasswordScreen()));
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ResuableButton(
                  onTap: () {
                    signIn();
                  },
                  text: 'Sign In',
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegister,
                      child: const Text(
                        " Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
