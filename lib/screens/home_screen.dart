import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginassessment/auth/authpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "HOMEPAGE",
            style: TextStyle(letterSpacing: 2),
          ),
          centerTitle: true),
      body: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 12,
                          offset: const Offset(
                            5,
                            5,
                          ),
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          blurRadius: 12,
                          offset: Offset(
                            -5,
                            -5,
                          ),
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      "You have been signed with:\n ${FirebaseAuth.instance.currentUser!.email.toString()}",
                      style:
                          const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  label: const Text(
                    "Sign-Out",
                    style: TextStyle(color: Colors.white),
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
