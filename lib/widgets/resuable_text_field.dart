import 'package:flutter/material.dart';

class ResuableTextField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ResuableTextField({
    Key? key,
    required this.controller,
    required this.lableText,
    required this.hintText,
    required this.obsecure,
  });
  final TextEditingController controller;
  final String lableText;
  final String hintText;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.deepPurple,
          ),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        border: InputBorder.none,
        hintText: hintText,
        label: Text(
          lableText,
        ),
      ),
    );
  }
}
