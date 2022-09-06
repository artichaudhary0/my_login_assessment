// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginassessment/widgets/resuable_button.dart';
import '../widgets/resuable_text_field.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.showLoginScreen})
      : super(key: key);
  final VoidCallback showLoginScreen;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<void> signUp() async {
    //Create user with email and password

    bool passwordConfirm() {
      if (cpasswordController.text.trim() == passwordController.text.trim()) {
        return true;
      } else {
        return false;
      }
    }

    if (passwordConfirm() && emailController != "" && ageController != "") {
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final firestore = FirebaseFirestore.instance;
        firestore.collection("users").doc(user.user!.uid).set(
          {
            "first name": emailController.text,
            "last name": lastNameController.text,
            "age": ageController.text,
            "email": emailController.text,
            "password": passwordController,
          },
        );

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(showRegister: () {})));
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
  }

  // When controllers are not in use

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    ageController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                // Main Heading means Sign Up heading

                const Text(
                  "Hello There",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Sign Up sub heading

                const Text(
                  "Register below with your details!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                // First Name Text Field
                ResuableTextField(
                  obsecure: false,
                  controller: firstNameController,
                  lableText: "First name",
                  hintText: "Enter your first name",
                ),

                const SizedBox(
                  height: 10,
                ),

                // Last Name Text Field

                ResuableTextField(
                  obsecure: false,
                  controller: lastNameController,
                  lableText: "Last name",
                  hintText: "Enter your last name",
                ),

                const SizedBox(
                  height: 10,
                ),

                // Age Text Field

                ResuableTextField(
                    obsecure: false,
                    controller: ageController,
                    lableText: "Age",
                    hintText: "Enter your age"),
                const SizedBox(
                  height: 10,
                ),

                // E-mail Text Field

                ResuableTextField(
                  obsecure: false,
                  controller: emailController,
                  lableText: "E-mail",
                  hintText: "Enter your e-mail",
                ),

                const SizedBox(
                  height: 10,
                ),

                // Password Text Field
                ResuableTextField(
                  obsecure: true,
                  controller: passwordController,
                  lableText: "Password",
                  hintText: "Enter your Password",
                ),

                const SizedBox(
                  height: 10,
                ),

                // Confirm Password Text Field
                ResuableTextField(
                  obsecure: true,
                  controller: cpasswordController,
                  lableText: "Confirm password",
                  hintText: "Password",
                ),

                const SizedBox(
                  height: 25,
                ),
                ResuableButton(
                    text: "Sign Up",
                    onTap: () {
                      signUp();
                    }),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I am a member!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginScreen,
                      child: const Text(
                        " Login now",
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
